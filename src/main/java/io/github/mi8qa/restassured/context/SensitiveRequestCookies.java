/**
 * Enumeration representing sensitive request cookies.
 * These are cookies that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive request cookies such as session IDs, tokens, and API keys.
 */
package io.github.mi8qa.restassured.context;

import java.util.Set;

public enum SensitiveRequestCookies implements SensitiveType {

	/**
	 * Represents the JSESSIONID cookie.
	 */
	JSESSIONID("JSESSIONID"),

	/**
	 * Represents the XSRF-TOKEN cookie.
	 */
	XSRF_TOKEN("XSRF-TOKEN"),

	/**
	 * Represents the OAUTH2_AUTH_CODE cookie.
	 */
	OAUTH2_AUTH_CODE("OAUTH2_AUTH_CODE"),

	/**
	 * Represents the OAUTH2_ACCESS_TOKEN cookie.
	 */
	OAUTH2_ACCESS_TOKEN("OAUTH2_ACCESS_TOKEN"),

	/**
	 * Represents the OAUTH2_REFRESH_TOKEN cookie.
	 */
	OAUTH2_REFRESH_TOKEN("OAUTH2_REFRESH_TOKEN"),

	/**
	 * Represents the JWT_TOKEN cookie.
	 */
	JWT_TOKEN("JWT_TOKEN"),

	/**
	 * Represents the SESSION cookie.
	 */
	SESSION("SESSION"),

	/**
	 * Represents the CSRF-TOKEN cookie.
	 */
	CSRF_TOKEN("CSRF-TOKEN"),

	/**
	 * Represents the SSO-TOKEN cookie.
	 */
	SSO_TOKEN("SSO-TOKEN"),

	/**
	 * Represents the API-KEY cookie.
	 */
	API_KEY("API-KEY");

	private final String cookieName;

	/**
	 * Constructs a new SensitiveRequestCookies enum with the given cookie name.
	 *
	 * @param cookieName The name of the sensitive cookie.
	 */
	SensitiveRequestCookies(String cookieName) {
		this.cookieName = cookieName;
	}

	/**
	 * Returns a set of default sensitive request cookie names.
	 *
	 * @return A set containing the names of all default sensitive request cookies.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestCookies.class);
	}

	/**
	 * Gets the value (cookie name) of the sensitive request cookie.
	 *
	 * @return The name of the sensitive cookie.
	 */
	@Override
	public String getValue() {
		return cookieName;
	}
}
