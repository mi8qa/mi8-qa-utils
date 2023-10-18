package io.github.mi8qa.allure;

import io.qameta.allure.Allure;
import io.qameta.allure.model.Status;
import io.qameta.allure.model.StepResult;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Executes and manages Allure steps with soft assertions.
 */
public class SoftAllureExecutor {

	private final List<Throwable> assertionResults = new ArrayList<>();
	private final List<String> assertionDescriptions = new ArrayList<>();

	/**
	 * Executes an Allure step with soft assertion support.
	 *
	 * @param name     Name of the step.
	 * @param runnable Code to run as part of the step.
	 */
	public void step(String name, Runnable runnable) {
		final String softStepUuid = UUID.randomUUID().toString();
		final List<String> localAssertionResults = new ArrayList<>();
		final List<Throwable> localAssertionDescriptions = new ArrayList<>();
		try {
			Allure.getLifecycle().startStep(softStepUuid, new StepResult().setName(name));
			runnable.run();
		} catch (Throwable e) {
			localAssertionResults.add(String.format("Failed step name: %s\n", name));
			localAssertionDescriptions.add(e);
		}

		if (!localAssertionDescriptions.isEmpty()) {
			Allure.getLifecycle().updateStep(softStepUuid, (step) -> step.setStatus(Status.FAILED));
			assertionResults.addAll(localAssertionDescriptions);
			assertionDescriptions.addAll(localAssertionResults);
		} else {
			Allure.getLifecycle().updateStep(softStepUuid, (step) -> step.setStatus(Status.PASSED));
		}

		Allure.getLifecycle()
				.updateStep(
						step -> {
							List<StepResult> stepResults = step.getSteps();
							if (stepResults.stream()
									.anyMatch(stepResult -> stepResult.getStatus().equals(Status.FAILED))) {
								step.setStatus(Status.FAILED);
							} else if (stepResults.stream()
									.anyMatch(stepResult -> stepResult.getStatus().equals(Status.BROKEN))) {
								step.setStatus(Status.BROKEN);
							}
						});

		Allure.getLifecycle().stopStep(softStepUuid);
	}

	/**
	 * Throws an exception if any soft assertions failed.
	 */
	public void verifyFailures() {
		if (!assertionResults.isEmpty()) {
			throw new MultipleFailuresError(assertionDescriptions.toString());
		}
	}
}
