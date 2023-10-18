package io.github.mi8qa.restassured.context;

/**
 * Enumeration representing the context names for different types of Allure parameters.
 * Each enum constant is associated with a specific pattern used for formatting.
 * <p>
 * This enum includes context names for various types of parameters used in Allure reporting, such as form parameters,
 * request parameters, path parameters, query parameters, request cookies, request headers, response cookies, and response headers.
 *
 * @since [Date or Version]
 */
public enum AllureParamContextName {

	/**
	 * Form parameter context name.
	 */
	FORM_PARAM("formParam: "),

	/**
	 * Request parameter context name.
	 */
	REQUEST_PARAM("reqParam: "),

	/**
	 * Path parameter context name.
	 */
	PATH_PARAM("pathParam: "),

	/**
	 * Query parameter context name.
	 */
	QUERY_PARAM("queryParam: "),

	/**
	 * Request cookie context name.
	 */
	REQUEST_COOKIE("reqCookie: "),

	/**
	 * Request header context name.
	 */
	REQUEST_HEADER("reqHeader: "),

	/**
	 * Response cookie context name.
	 */
	RESPONSE_COOKIE("respCookie: "),

	/**
	 * Response header context name.
	 */
	RESPONSE_HEADER("respHeader: ");

	// The pattern used for formatting the context name.
	private final String pattern;

	/**
	 * Constructs a new AllureParamContextName enum constant.
	 *
	 * @param pattern The pattern used for formatting the context name.
	 */
	AllureParamContextName(String pattern) {
		this.pattern = pattern;
	}

	/**
	 * Formats the given key using the associated pattern.
	 *
	 * @param key The key to be formatted.
	 *
	 * @return The formatted string.
	 */
	public String format(String key) {
		return this.pattern + key;
	}
}
