package io.github.mi8qa.tests;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.ResponseDefinitionBuilder;
import com.github.tomakehurst.wiremock.core.WireMockConfiguration;
import com.github.tomakehurst.wiremock.extension.ResponseDefinitionTransformerV2;
import com.github.tomakehurst.wiremock.http.ResponseDefinition;
import com.github.tomakehurst.wiremock.stubbing.ServeEvent;
import io.github.mi8qa.Providers;
import io.github.mi8qa.allure.SoftAllureExecutor;
import io.github.mi8qa.restassured.allure.RestAttemptedFilter;
import io.github.mi8qa.restassured.await.SCMatcher;
import io.qameta.allure.Allure;
import io.qameta.allure.junit5.AllureJunit5;
import io.restassured.RestAssured;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.Map;
import java.util.UUID;

import static com.github.tomakehurst.wiremock.client.WireMock.*;

@ExtendWith(AllureJunit5.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@DisplayName("Rest assured and Allure feature test examples.")
public class FeatureTests {

	protected WireMockServer wireMockServer;

	private RequestSpecification requestSpect() {
		return RestAssured.given().port(8080).basePath("/foo/bar/v1/base/path");
	}

	@BeforeAll
	protected void configure() {
		RestAssured.filters(new RestAttemptedFilter(), Providers.AllureWrapperFilter.defaults(), Providers.Logger.defaults());
		wireMockServer = new WireMockServer(
				WireMockConfiguration
						.wireMockConfig()
						.extensions(new SomeStrangeTransformer())
						.port(8080));
		wireMockServer.start();
		stubFor(get(urlPathMatching("/foo/bar/v1/base/([a-zA-Z0-9]+)")).willReturn(
				aResponse()
						.withStatus(200)
						.withHeader("Set-Cookie", "JSESSIONID=someId")
						.withHeader("Content-Type", "text/plain")
						.withTransformers("uuid-header-transformer")));
	}

	@Test
	@DisplayName("Test example FAILED without retries if actual code is not equal to Expected")
	void testExampleIsFailedWithoutRetriesIfActualCodeIsNotEqualToExpected() {
		Allure.description("This is a simplified example of the library usage. All steps and test should be red.");
		SoftAllureExecutor executor = new SoftAllureExecutor();
		executor.step("This step should fail without retries because of StatusCodeMatcher is not used.",
					  () -> requestSpect().get("users").then().statusCode(201));
		executor.step("This step should fail without retries because of StatusCodeMatcher is used without ignoring codes.",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(201)));
		executor.step("This step should fail without retries because of actual code is not ignored.",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(201, 203)));
		executor.step("This step should fail without retries because of actual code is not ignored (not in array).",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(201, 203, 201, 199)));
		executor.verifyFailures();
	}

	@Test
	@DisplayName("Test example PASSED without retries if actual code is equal to Expected")
	void testExampleIsPassedWithoutRetriesIfActualCodeIsEqualToExpected() {
		Allure.description("This is a simplified example of the library usage. All steps and test should be green.");
		SoftAllureExecutor executor = new SoftAllureExecutor();
		executor.step("This step should pass without retries because expected code is equal to actual",
					  () -> requestSpect().queryParam("client_id", "thisValueShouldBeHidden").get().then().statusCode(200));
		executor.step("This step should pass without retries using StatusCodeMatcher",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(200)));
		executor.step("This step should pass without retries using StatusCodeMatcher with matching and ignoring the same code.",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(200, 200)));
		executor.step("This step should pass without retries using StatusCodeMatcher with matching and ignoring the same code (in array).",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(200, 203, 200, 199)));
		executor.verifyFailures();
	}

	@Test
	@DisplayName("Test example FAILED with retries if actual code is not equal to expected and expected code is in ignored list")
	void testExampleIsFailedWithRetriesIfActualCodeIsNotEqualToExpectedAndExpectedCodeIsInIgnoredList() {
		Allure.description("This is a simplified example of the library usage. All steps and test should be red.");
		SoftAllureExecutor executor = new SoftAllureExecutor();
		executor.step("This step should fail with retries because actual status code equal to ignored provided and not equal to expected.",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(201, 200)));
		executor.step("This step should fail with retries because actual status code equal to ignored provided (in array) and not equal to expected.",
					  () -> requestSpect().get().then().statusCode(SCMatcher.match(201, 203, 200, 199)));
		executor.verifyFailures();
	}

	@Test
	@DisplayName("Test example FAILED if some of soft steps are failed.")
	void testExampleFailedIfSomeOfSofStepsAreFailed() {
		Allure.description("This is a simplified example of the library usage. If any of the soft steps failed, test is failed.");
		SoftAllureExecutor executor = new SoftAllureExecutor();
		Map.of("1", "1",
			   "2", "3",
			   "3", "3"
		).forEach((k, v) -> executor.step(String.format("%s is equal to %s", k, v), () -> Assertions.assertEquals(k, v)));
		executor.verifyFailures();
	}

	@Test
	@DisplayName("Test example PASSED if the final response code is equal to expected")
	void testExampleFailedIfSomeOfSo3fStepsAreFailed() {
		Allure.description("This is a simplified example of the library usage. If the final response code matched, all is green.");
		requestSpect().header("shouldReturnOK", "yep").get()
				.then()
				.statusCode(SCMatcher.match(200, 400));
	}

	public static class SomeStrangeTransformer implements ResponseDefinitionTransformerV2 {

		private int currentAttempt = 0;


		@Override
		public ResponseDefinition transform(ServeEvent serveEvent) {
			ResponseDefinition responseDefinition = serveEvent.getResponseDefinition();
			if (currentAttempt == 0 && serveEvent.getRequest().containsHeader("shouldReturnOK")) {
				currentAttempt = 1;
				return ResponseDefinitionBuilder.responseDefinition()
						.withStatus(400)
						.withHeader("x-correlation-id", UUID.randomUUID().toString())
						.withBody(responseDefinition.getBody())
						.build();
			} else if (currentAttempt == 1 && serveEvent.getRequest().containsHeader("shouldReturnOK")) {
				currentAttempt = 2;
				return ResponseDefinitionBuilder.responseDefinition()
						.withStatus(400)
						.withHeader("x-correlation-id", UUID.randomUUID().toString())
						.withBody(responseDefinition.getBody())
						.build();
			} else if (currentAttempt == 2 && serveEvent.getRequest().containsHeader("shouldReturnOK")) {
				return ResponseDefinitionBuilder.responseDefinition()
						.withStatus(200)
						.withHeader("x-correlation-id", UUID.randomUUID().toString())
						.withBody(responseDefinition.getBody())
						.build();
			} else if (!serveEvent.getRequest().containsHeader("shouldReturnOK")) {
				return ResponseDefinitionBuilder.responseDefinition()
						.withStatus(responseDefinition.getStatus())
						.withHeader("x-correlation-id", UUID.randomUUID().toString())
						.withBody(responseDefinition.getBody())
						.build();
			}
			return null;
		}

		@Override
		public String getName() {
			return "uuid-header-transformer";
		}

		@Override
		public boolean applyGlobally() {
			return true;
		}
	}
}
