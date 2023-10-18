package io.github.mi8qa.restassured.await;

import io.github.mi8qa.allure.AllureRestAssuredUtil;
import io.github.mi8qa.allure.MultipleFailuresError;
import io.qameta.allure.Allure;
import io.qameta.allure.model.Status;
import io.qameta.allure.model.StepResult;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.awaitility.Awaitility;
import org.awaitility.core.ConditionTimeoutException;

import java.net.URI;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * Provides aspect-oriented features for REST API requests and responses,
 * particularly focused on status code verification and Allure reporting.
 */
@Aspect
public class RestAttempted {

	public static int POLL_DELAY = 200;
	public static int POLL_INTERVAL = 100;
	public static int TIMEOUT = 1000;
	public static int AT_MOST = 5000;
	private FilterableRequestSpecification reqSpec;
	private Response response;

	private String reqParentStepUUID;

	/**
	 * Sets up the initial Allure step and request specification before the request is sent.
	 */
	@Before("execution(* io.github.mi8qa.restassured.allure.RestAttemptedFilter.filter(..))")
	public void beforeReq(JoinPoint joinPoint) {
		reqParentStepUUID = UUID.randomUUID().toString();
		StepResult reqParentStepResult = new StepResult();
		Allure.getLifecycle().startStep(reqParentStepUUID, reqParentStepResult);
		reqSpec = (FilterableRequestSpecification) joinPoint.getArgs()[0];
	}

	/**
	 * Updates Allure steps after response validation.
	 */

	@SuppressWarnings("unused")
	@AfterReturning(pointcut = "execution(* io.github.mi8qa.restassured.allure.RestAttemptedFilter.filter(..))", returning = "o")
	public void afterReq(JoinPoint joinPoint, Response o) {
		response = o;
		Allure.getLifecycle().updateStep(
				reqParentStepUUID,
				stepResult -> stepResult.setName(
						String.format("%s %s", reqSpec.getMethod(),
									  reqSpec.getUserDefinedPath() != null &&
											  !reqSpec.getUserDefinedPath().isEmpty() ?
											  reqSpec.getUserDefinedPath() + reqSpec.getUserDefinedPath() :
											  reqSpec.getBasePath()))
		);
	}


	/**
	 * Checks and handles the status code before the actual test execution.
	 */
	@Before("execution(* io.github.mi8qa.restassured.await.SCMatcher.match(int, int, int...))" +
			" || execution(* io.github.mi8qa.restassured.await.SCMatcher.match(int)) " +
			"|| execution(* io.github.mi8qa.restassured.await.SCMatcher.match(int, int))" +
			"|| execution(* io.github.mi8qa.restassured.await.SCMatcher.match(HttpStatus))" +
			"|| execution(* io.github.mi8qa.restassured.await.SCMatcher.match(HttpStatus, HttpStatus))" +
			"|| execution(* io.github.mi8qa.restassured.await.SCMatcher.match(HttpStatus, HttpStatus, HttpStatus...))")
	public void beforeSCCheck(JoinPoint joinPoint) {
		Object[] args = joinPoint.getArgs();
		Integer firstArg = (Integer) args[0];
		Set<Integer> otherArgs = extractStatusCodes(joinPoint.getArgs());
		SCMatcher matcher = SCMatcher.match(firstArg, otherArgs);
		int actualStatusCode = response.getStatusCode();
		if (matcher.isExpected(actualStatusCode)) {
			AllureRestAssuredUtil.addAttachments(reqSpec, response);
			updateAllureStep(reqParentStepUUID, Status.PASSED);
		} else {
			if (matcher.isIgnored(actualStatusCode)) {
				matcher.updateActualCodeAfterAttempt(actualStatusCode);
				String subStepUUID = UUID.randomUUID().toString();
				StepResult subStepResult = new StepResult();
				Allure.getLifecycle().startStep(subStepUUID, subStepResult);
				AllureRestAssuredUtil.addAttachments(reqSpec, response);
				subStepResult.setName(String.format("Attempt #%s", matcher.getCurrentAttempt()));
				updateAllureStep(subStepUUID, Status.FAILED);
				awaitStatusCodeMatch(matcher, reqSpec, reqParentStepUUID);
			} else {
				AllureRestAssuredUtil.addAttachments(reqSpec, response);
				updateAllureStep(reqParentStepUUID, Status.FAILED);
				throw new AssertionError(String.format("Expected SC %s but was %s", firstArg, actualStatusCode));
			}
		}
	}

	/**
	 * Pointcut for matching specific method signatures related to status code.
	 */
	@Pointcut("execution(* io.restassured.internal.ValidatableResponseOptionsImpl.statusCode(int))")
	public void statusCodePC() {
	}

	/**
	 * Handles the scenario after throwing an exception related to status code.
	 */
	@Before(value = "statusCodePC()")
	public void afterThrowingAdv(JoinPoint joinPoint) {
		this.beforeSCCheck(joinPoint);
	}

	/**
	 * Extracts status codes from given arguments for further usage.
	 */
	private Set<Integer> extractStatusCodes(Object[] args) {
		Set<Integer> otherArgs = new HashSet<>();
		for (int i = 1; i < args.length; i++) {
			if (args[i] instanceof Integer) {
				otherArgs.add((Integer) args[i]);
			} else if (args[i] instanceof HttpStatus) {
				otherArgs.add(((HttpStatus) args[i]).getValue());
			} else if (args[i].getClass().isArray()) {
				for (int val : (int[]) args[i]) {
					otherArgs.add(val);
				}
			}
		}
		return otherArgs;
	}

	/**
	 * Updates the status of an Allure step with the given UUID.
	 */
	private void updateAllureStep(String uuid, Status status) {
		Allure.getLifecycle().updateStep(uuid, stepResult -> stepResult.setStatus(status));
		Allure.getLifecycle().stopStep(uuid);
	}

	/**
	 * Waits until the status code of the response matches the expected one,
	 * updating Allure steps accordingly.
	 */
	private void awaitStatusCodeMatch(SCMatcher matcher, FilterableRequestSpecification reqSpec, String reqParentStepUUID) throws MultipleFailuresError {
		try {
			Awaitility.with()
					.atMost(AT_MOST, TimeUnit.MILLISECONDS)
					.pollDelay(POLL_DELAY, TimeUnit.MILLISECONDS)
					.pollInterval(POLL_INTERVAL, TimeUnit.MILLISECONDS)
					.timeout(TIMEOUT, TimeUnit.MILLISECONDS)
					.await().until(() -> {
						if (matcher.isExpected(matcher.getCurrentActualCodeAfterAttempt())) {
							AllureRestAssuredUtil.addAttachments(reqSpec, response);
							updateAllureStep(reqParentStepUUID, Status.PASSED);
							return true;
						} else {
							String subStepUUID = UUID.randomUUID().toString();
							StepResult subStepResult = new StepResult();
							Allure.getLifecycle().startStep(subStepUUID, subStepResult);
							subStepResult.setName(String.format("Attempt #%s", matcher.incrementAttemptAndGet()));
							if (matcher.isIgnored(matcher.getCurrentActualCodeAfterAttempt())) {
								response = RestAssured.given(reqSpec).request(reqSpec.getMethod(), URI.create(reqSpec.getURI()));
								AllureRestAssuredUtil.addAttachments(reqSpec, response);
								int currentSC = response.getStatusCode();
								matcher.updateActualCodeAfterAttempt(currentSC);
								boolean matches = !matcher.isIgnored(matcher.getCurrentActualCodeAfterAttempt()) && matcher.isExpected(matcher.getCurrentActualCodeAfterAttempt());
								updateAllureStep(subStepUUID, matches ? Status.PASSED : Status.FAILED);
								return matches;
							} else {
								AllureRestAssuredUtil.addAttachments(reqSpec, response);
								updateAllureStep(subStepUUID, Status.FAILED);
								return false;
							}
						}
					});
			updateAllureStep(reqParentStepUUID, Status.PASSED);
		} catch (ConditionTimeoutException e) {
			updateAllureStep(reqParentStepUUID, Status.FAILED);
			throw new MultipleFailuresError(String.format("Expected SC %s but was %s", matcher.getExpectedStatusCode(), matcher.getCurrentActualCodeAfterAttempt()));
		}
	}
}
