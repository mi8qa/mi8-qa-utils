package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing sensitive HTTP response headers.
 * These are headers that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive response headers such as WWW-Authenticate, Set-Cookie, and security-related headers.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveResponseHeaders implements SensitiveType {

	/**
	 * Represents the "WWW-Authenticate" response header.
	 */
	WWW_AUTHENTICATE("WWW-Authenticate"),

	/**
	 * Represents the "Set-Cookie" response header.
	 */
	SET_COOKIE("Set-Cookie"),

	/**
	 * Represents the "Strict-Transport-Security" response header.
	 */
	STRICT_TRANSPORT_SECURITY("Strict-Transport-Security"),

	/**
	 * Represents the "X-Frame-Options" response header.
	 */
	X_FRAME_OPTIONS("X-Frame-Options"),

	/**
	 * Represents the "X-Content-Type-Options" response header.
	 */
	X_CONTENT_TYPE_OPTIONS("X-Content-Type-Options"),

	/**
	 * Represents the "X-XSS-Protection" response header.
	 */
	X_XSS_PROTECTION("X-XSS-Protection"),

	/**
	 * Represents the "Refresh" response header.
	 */
	REFRESH("Refresh"),

	/**
	 * Represents the "Location" response header.
	 */
	LOCATION("Location"),

	/**
	 * Represents the "Content-Disposition" response header.
	 */
	CONTENT_DISPOSITION("Content-Disposition"),

	/**
	 * Represents the "Age" response header.
	 */
	AGE("Age");

	private final String headerName;

	/**
	 * Constructs a new SensitiveResponseHeaders enum with the given header name.
	 *
	 * @param headerName The name of the sensitive response header.
	 */
	SensitiveResponseHeaders(String headerName) {
		this.headerName = headerName;
	}

	/**
	 * Returns a set of default sensitive response header names.
	 *
	 * @return A set containing the names of all default sensitive response headers.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveResponseHeaders.class);
	}

	/**
	 * Gets the value (header name) of the sensitive response header.
	 *
	 * @return The name of the sensitive header.
	 */
	@Override
	public String getValue() {
		return headerName;
	}
}
