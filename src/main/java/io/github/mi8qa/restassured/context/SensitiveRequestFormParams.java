package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing sensitive HTTP request form parameters.
 * These are form parameters that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive form parameters such as usernames, passwords, and OAuth-related parameters.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveRequestFormParams implements SensitiveType {

	/**
	 * Represents the "username" form parameter.
	 */
	USERNAME("username"),

	/**
	 * Represents the "password" form parameter.
	 */
	PASSWORD("password"),

	/**
	 * Represents the "client_id" form parameter.
	 */
	CLIENT_ID("client_id"),

	/**
	 * Represents the "client_secret" form parameter.
	 */
	CLIENT_SECRET("client_secret"),

	/**
	 * Represents the "grant_type" form parameter.
	 */
	GRANT_TYPE("grant_type"),

	/**
	 * Represents the "scope" form parameter.
	 */
	SCOPE("scope"),

	/**
	 * Represents the "refresh_token" form parameter.
	 */
	REFRESH_TOKEN("refresh_token"),

	/**
	 * Represents the "code" form parameter.
	 */
	CODE("code"),

	/**
	 * Represents the "redirect_uri" form parameter.
	 */
	REDIRECT_URI("redirect_uri"),

	/**
	 * Represents the "state" form parameter.
	 */
	STATE("state");

	private final String formParam;

	/**
	 * Constructs a new SensitiveRequestFormParams enum with the given form parameter name.
	 *
	 * @param formParam The name of the sensitive form parameter.
	 */
	SensitiveRequestFormParams(String formParam) {
		this.formParam = formParam;
	}

	/**
	 * Returns a set of default sensitive form parameter names.
	 *
	 * @return A set containing the names of all default sensitive form parameters.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestFormParams.class);
	}

	/**
	 * Gets the value (form parameter name) of the sensitive form parameter.
	 *
	 * @return The name of the sensitive form parameter.
	 */
	@Override
	public String getValue() {
		return formParam;
	}
}
