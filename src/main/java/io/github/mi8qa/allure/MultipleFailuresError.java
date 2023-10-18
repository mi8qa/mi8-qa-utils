package io.github.mi8qa.allure;

public class MultipleFailuresError extends AssertionError {

	public MultipleFailuresError(String message) {
		super(message);
	}
}
