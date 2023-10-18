/**
 * Enumeration representing sensitive response cookies.
 * These are cookies that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive response cookies such as session IDs, tokens, and API keys.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
package io.github.mi8qa.restassured.context;

import java.util.Set;

public enum SensitiveResponseCookies implements SensitiveType {

	/**
	 * Represents the JSESSIONID response cookie.
	 */
	JSESSIONID("JSESSIONID"),

	/**
	 * Represents the XSRF-TOKEN response cookie.
	 */
	XSRF_TOKEN("XSRF-TOKEN"),

	/**
	 * Represents the OAUTH2_AUTH_CODE response cookie.
	 */
	OAUTH2_AUTH_CODE("OAUTH2_AUTH_CODE"),

	/**
	 * Represents the OAUTH2_ACCESS_TOKEN response cookie.
	 */
	OAUTH2_ACCESS_TOKEN("OAUTH2_ACCESS_TOKEN"),

	/**
	 * Represents the OAUTH2_REFRESH_TOKEN response cookie.
	 */
	OAUTH2_REFRESH_TOKEN("OAUTH2_REFRESH_TOKEN"),

	/**
	 * Represents the JWT_TOKEN response cookie.
	 */
	JWT_TOKEN("JWT_TOKEN"),

	/**
	 * Represents the SESSION response cookie.
	 */
	SESSION("SESSION"),

	/**
	 * Represents the CSRF-TOKEN response cookie.
	 */
	CSRF_TOKEN("CSRF-TOKEN"),

	/**
	 * Represents the SSO-TOKEN response cookie.
	 */
	SSO_TOKEN("SSO-TOKEN"),

	/**
	 * Represents the API-KEY response cookie.
	 */
	API_KEY("API-KEY");

	private final String cookieName;

	/**
	 * Constructs a new SensitiveResponseCookies enum with the given cookie name.
	 *
	 * @param cookieName The name of the sensitive cookie.
	 */
	SensitiveResponseCookies(String cookieName) {
		this.cookieName = cookieName;
	}

	/**
	 * Returns a set of default sensitive response cookie names.
	 *
	 * @return A set containing the names of all default sensitive response cookies.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveResponseCookies.class);
	}

	/**
	 * Gets the value (cookie name) of the sensitive response cookie.
	 *
	 * @return The name of the sensitive cookie.
	 */
	@Override
	public String getValue() {
		return cookieName;
	}
}
