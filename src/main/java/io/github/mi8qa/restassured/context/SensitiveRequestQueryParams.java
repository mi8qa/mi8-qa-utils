package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing sensitive HTTP request query parameters.
 * These are query parameters that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive request query parameters such as client IDs, redirect URIs, and access tokens.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveRequestQueryParams implements SensitiveType {

	/**
	 * Represents the "client_id" query parameter.
	 */
	CLIENT_ID("client_id"),

	/**
	 * Represents the "redirect_uri" query parameter.
	 */
	REDIRECT_URI("redirect_uri"),

	/**
	 * Represents the "response_type" query parameter.
	 */
	RESPONSE_TYPE("response_type"),

	/**
	 * Represents the "scope" query parameter.
	 */
	SCOPE("scope"),

	/**
	 * Represents the "state" query parameter.
	 */
	STATE("state"),

	/**
	 * Represents the "nonce" query parameter.
	 */
	NONCE("nonce"),

	/**
	 * Represents the "prompt" query parameter.
	 */
	PROMPT("prompt"),

	/**
	 * Represents the "access_token" query parameter.
	 */
	ACCESS_TOKEN("access_token"),

	/**
	 * Represents the "code" query parameter.
	 */
	CODE("code"),

	/**
	 * Represents the "api_key" query parameter.
	 */
	API_KEY("api_key");

	private final String queryParam;

	/**
	 * Constructs a new SensitiveRequestQueryParams enum with the given query parameter name.
	 *
	 * @param queryParam The name of the sensitive query parameter.
	 */
	SensitiveRequestQueryParams(String queryParam) {
		this.queryParam = queryParam;
	}

	/**
	 * Returns a set of default sensitive request query parameter names.
	 *
	 * @return A set containing the names of all default sensitive request query parameters.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestQueryParams.class);
	}

	/**
	 * Gets the value (parameter name) of the sensitive request query parameter.
	 *
	 * @return The name of the sensitive query parameter.
	 */
	@Override
	public String getValue() {
		return queryParam;
	}
}
