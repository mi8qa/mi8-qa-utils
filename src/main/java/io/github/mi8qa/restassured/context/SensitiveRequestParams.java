package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing generic sensitive HTTP request parameters.
 * These are parameters that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive request parameters such as client IDs, access tokens, and authentication codes.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveRequestParams implements SensitiveType {

	/**
	 * Represents the "client_id" request parameter.
	 */
	CLIENT_ID("client_id"),

	/**
	 * Represents the "access_token" request parameter.
	 */
	ACCESS_TOKEN("access_token"),

	/**
	 * Represents the "api_key" request parameter.
	 */
	API_KEY("api_key"),

	/**
	 * Represents the "session_id" request parameter.
	 */
	SESSION_ID("session_id"),

	/**
	 * Represents the "auth_code" request parameter.
	 */
	AUTH_CODE("auth_code"),

	/**
	 * Represents the "redirect_uri" request parameter.
	 */
	REDIRECT_URI("redirect_uri"),

	/**
	 * Represents the "state" request parameter.
	 */
	STATE("state"),

	/**
	 * Represents the "scope" request parameter.
	 */
	SCOPE("scope"),

	/**
	 * Represents the "response_type" request parameter.
	 */
	RESPONSE_TYPE("response_type"),

	/**
	 * Represents the "code" request parameter.
	 */
	CODE("code");

	private final String requestParam;

	/**
	 * Constructs a new SensitiveRequestParams enum with the given request parameter name.
	 *
	 * @param requestParam The name of the sensitive request parameter.
	 */
	SensitiveRequestParams(String requestParam) {
		this.requestParam = requestParam;
	}

	/**
	 * Returns a set of default sensitive request parameter names.
	 *
	 * @return A set containing the names of all default sensitive request parameters.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestParams.class);
	}

	/**
	 * Gets the value (parameter name) of the sensitive request parameter.
	 *
	 * @return The name of the sensitive request parameter.
	 */
	@Override
	public String getValue() {
		return requestParam;
	}
}
