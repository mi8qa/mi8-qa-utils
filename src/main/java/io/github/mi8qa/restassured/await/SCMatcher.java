package io.github.mi8qa.restassured.await;

import lombok.Getter;
import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * Custom matcher class extending BaseMatcher to handle status codes.
 */
public class SCMatcher extends BaseMatcher<Integer> {

	@Getter
	private final Integer expectedStatusCode;
	private final AtomicReference<Integer> actualStatusCode = new AtomicReference<>();
	private final AtomicInteger counter = new AtomicInteger(1);
	private final Set<Integer> ignoringCodes = new HashSet<>();

	/**
	 * Constructs an SCMatcher with an expected status code and a set of ignored codes.
	 * Suppresses type warnings.
	 *
	 * @param expected The expected status code.
	 * @param ignoring The set of status codes to ignore.
	 */
	@SuppressWarnings("unchecked")
	private <T> SCMatcher(int expected, Set<T> ignoring) {
		this.expectedStatusCode = expected;
		Set<Integer> ignorables = (Set<Integer>) new HashSet<>(ignoring);
		ignorables.remove(this.expectedStatusCode);
		this.ignoringCodes.addAll(ignorables);
	}

	/**
	 * Constructs an SCMatcher with an expected status code.
	 *
	 * @param expected The expected status code.
	 */
	private SCMatcher(int expected) {
		this.expectedStatusCode = expected;
	}

	/**
	 * Creates an SCMatcher instance with an expected status code.
	 *
	 * @param expected The expected status code.
	 *
	 * @return New instance of SCMatcher.
	 */
	static SCMatcher of(int expected) {
		return new SCMatcher(expected);
	}

	/**
	 * Creates an SCMatcher instance with an expected status code and a set of ignored codes.
	 *
	 * @param expected The expected status code.
	 * @param ignoring The set of status codes to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */
	static <T> SCMatcher of(int expected, Set<T> ignoring) {
		return new SCMatcher(expected, ignoring);
	}

	/**
	 * Converts the input object to an Integer, handling different types.
	 *
	 * @param obj The object to convert.
	 *
	 * @return Converted Integer.
	 */
	private static Integer convertToInteger(Object obj) {
		if (obj instanceof Integer) {
			return (Integer) obj;
		}
		return (Integer) ((Object[]) obj)[0];
	}

	/**
	 * Shortcut for creating an SCMatcher with a single expected status code.
	 *
	 * @param expected The expected status code.
	 *
	 * @return New instance of SCMatcher.
	 */
	public static SCMatcher match(int expected) {
		return of(expected);
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected and a single ignored status code.
	 *
	 * @param expected The expected status code.
	 * @param ignored  The status code to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */
	public static SCMatcher match(int expected, int ignored) {
		return of(expected, Set.of(ignored));
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected and multiple ignored status codes.
	 *
	 * @param expected The expected status code.
	 * @param ignored  The status code to ignore.
	 * @param ignoring Additional status codes to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */
	public static SCMatcher match(int expected, int ignored, int... ignoring) {
		Set<Integer> ignorables = new HashSet<>();
		for (int i : ignoring) {
			ignorables.add(i);
		}
		ignorables.add(ignored);
		return of(expected, ignorables);
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected HttpStatus.
	 *
	 * @param status The expected HttpStatus.
	 *
	 * @return New instance of SCMatcher.
	 */

	public static SCMatcher match(HttpStatus status) {
		return of(status.getValue());
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected and a single ignored HttpStatus.
	 *
	 * @param status  The expected HttpStatus.
	 * @param ignored The HttpStatus to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */
	public static SCMatcher match(HttpStatus status, HttpStatus ignored) {
		return of(status.getValue(), Set.of(ignored.getValue()));
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected and multiple ignored HttpStatuses.
	 *
	 * @param status   The expected HttpStatus.
	 * @param ignored  The HttpStatus to ignore.
	 * @param ignoring Additional HttpStatuses to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */

	public static SCMatcher match(HttpStatus status, HttpStatus ignored, HttpStatus... ignoring) {
		Set<Integer> httpStatuses = Arrays.stream(ignoring).map(HttpStatus::getValue).collect(Collectors.toSet());
		httpStatuses.add(ignored.getValue());
		return of(status.getValue(), httpStatuses);
	}

	/**
	 * Shortcut for creating an SCMatcher with an expected status code and a set of ignored codes.
	 *
	 * @param expected The expected status code.
	 * @param ignoring The set of status codes to ignore.
	 *
	 * @return New instance of SCMatcher.
	 */
	public static <T> SCMatcher match(int expected, Set<T> ignoring) {
		return of(expected, ignoring);
	}

	/**
	 * Updates the actual status code after an attempt.
	 *
	 * @param value The new status code.
	 */
	public void updateActualCodeAfterAttempt(int value) {
		actualStatusCode.set(value);
	}

	/**
	 * Retrieves the current actual status code.
	 *
	 * @return The actual status code.
	 */
	public int getCurrentActualCodeAfterAttempt() {
		return this.actualStatusCode.get();
	}

	/**
	 * Increments the attempt counter and returns the new value.
	 *
	 * @return The incremented counter value.
	 */
	public int incrementAttemptAndGet() {
		return counter.incrementAndGet();
	}

	/**
	 * Increments the attempt counter and returns the new value.
	 *
	 * @return The incremented counter value.
	 */
	public int getCurrentAttempt() {
		return counter.get();
	}

	/**
	 * Checks if a given status code is in the ignored list.
	 *
	 * @param statusCode The status code to check.
	 *
	 * @return True if ignored, false otherwise.
	 */
	public boolean isIgnored(Object statusCode) {
		return this.ignoringCodes.contains(convertToInteger(statusCode));
	}

	/**
	 * Checks if a given status code is the expected one.
	 *
	 * @param statusCode The status code to check.
	 *
	 * @return True if expected, false otherwise.
	 */
	public boolean isExpected(Object statusCode) {
		return this.expectedStatusCode.equals(convertToInteger(statusCode));
	}

	/**
	 * Describes the expected status code to a description object.
	 *
	 * @param description The description object to append to.
	 */
	@Override
	public void describeTo(Description description) {
		description.appendText("<%d>".formatted(expectedStatusCode));
	}

	/**
	 * Matches the actual status code against the expected and ignored codes.
	 *
	 * @param o The object, expected to be a status code.
	 *
	 * @return True if a match is found, false otherwise.
	 */
	@Override
	public boolean matches(Object o) {
		this.actualStatusCode.set((Integer) o);
		return this.expectedStatusCode.equals(this.actualStatusCode.get()) || this.ignoringCodes.contains(this.actualStatusCode.get());
	}
}
