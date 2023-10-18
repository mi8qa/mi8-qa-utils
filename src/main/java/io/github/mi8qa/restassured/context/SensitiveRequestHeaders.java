package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing sensitive HTTP request headers.
 * These are headers that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive request headers such as authorization headers, cookies, and security-related headers.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveRequestHeaders implements SensitiveType {

	/**
	 * Represents the "Authorization" request header.
	 */
	AUTHORIZATION("Authorization"),

	/**
	 * Represents the "Proxy-Authorization" request header.
	 */
	PROXY_AUTHORIZATION("Proxy-Authorize"),

	/**
	 * Represents the "WWW-Authenticate" request header.
	 */
	WWW_AUTHENTICATE("WWW-Authenticate"),

	/**
	 * Represents the "X-Requested-With" request header.
	 */
	X_REQUESTED_WITH("X-Requested-With"),

	/**
	 * Represents the "X-XSRF-TOKEN" request header.
	 */
	X_XSRF_TOKEN("X-XSRF-TOKEN"),

	/**
	 * Represents the "X-CSRF-TOKEN" request header.
	 */
	X_CSRF_TOKEN("X-CSRF-TOKEN"),

	/**
	 * Represents the "X-Api-Key" request header.
	 */
	X_API_KEY("X-Api-Key"),

	/**
	 * Represents the "Cookie" request header.
	 */
	COOKIE("Cookie"),

	/**
	 * Represents the "Set-Cookie" response header.
	 */
	SET_COOKIE("Set-Cookie"),

	/**
	 * Represents the "Origin" request header.
	 */
	ORIGIN("Origin");

	private final String headerName;

	/**
	 * Constructs a new SensitiveRequestHeaders enum with the given header name.
	 *
	 * @param headerName The name of the sensitive header.
	 */
	SensitiveRequestHeaders(String headerName) {
		this.headerName = headerName;
	}

	/**
	 * Returns a set of default sensitive request header names.
	 *
	 * @return A set containing the names of all default sensitive request headers.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestHeaders.class);
	}

	/**
	 * Gets the value (header name) of the sensitive request header.
	 *
	 * @return The name of the sensitive header.
	 */
	@Override
	public String getValue() {
		return headerName;
	}
}
