package io.github.mi8qa.restassured.context;

import java.util.Set;

/**
 * Enumeration representing sensitive HTTP request path parameters.
 * These are path parameters that should be treated as sensitive data and handled with care.
 * <p>
 * This enum includes common sensitive request path parameters such as user IDs, client IDs, and transaction IDs.
 *
 * @author [Your Name]
 * @since [Date or Version]
 */
public enum SensitiveRequestPathParams implements SensitiveType {

	/**
	 * Represents the "userId" path parameter.
	 */
	USER_ID("userId"),

	/**
	 * Represents the "clientId" path parameter.
	 */
	CLIENT_ID("clientId"),

	/**
	 * Represents the "transactionId" path parameter.
	 */
	TRANSACTION_ID("transactionId"),

	/**
	 * Represents the "orderId" path parameter.
	 */
	ORDER_ID("orderId"),

	/**
	 * Represents the "apiVersion" path parameter.
	 */
	API_VERSION("apiVersion"),

	/**
	 * Represents the "resourceId" path parameter.
	 */
	RESOURCE_ID("resourceId"),

	/**
	 * Represents the "sessionId" path parameter.
	 */
	SESSION_ID("sessionId"),

	/**
	 * Represents the "authCode" path parameter.
	 */
	AUTH_CODE("authCode"),

	/**
	 * Represents the "token" path parameter.
	 */
	TOKEN("token"),

	/**
	 * Represents the "paymentId" path parameter.
	 */
	PAYMENT_ID("paymentId");

	private final String pathParam;

	/**
	 * Constructs a new SensitiveRequestPathParams enum with the given path parameter name.
	 *
	 * @param pathParam The name of the sensitive path parameter.
	 */
	SensitiveRequestPathParams(String pathParam) {
		this.pathParam = pathParam;
	}

	/**
	 * Returns a set of default sensitive request path parameter names.
	 *
	 * @return A set containing the names of all default sensitive request path parameters.
	 */
	public static Set<String> defaults() {
		return SensitiveType.collectEnumValues(SensitiveRequestPathParams.class);
	}

	/**
	 * Gets the value (parameter name) of the sensitive request path parameter.
	 *
	 * @return The name of the sensitive path parameter.
	 */
	@Override
	public String getValue() {
		return pathParam;
	}
}
