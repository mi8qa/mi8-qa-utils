package io.github.mi8qa.restassured.await;

/**
 * * Some status codes to use in SCMatcher.
 */
public enum HttpStatus {
	// Client Authentication Errors
	UNAUTHORIZED(401),
	NEED_AUTH(407),
	// Client Permission Errors
	FORBIDDEN(403),
	// Client Request Errors
	BAD_REQUEST(400),
	NOT_FOUND(404),
	METHOD_NOT_ALLOWED(405),
	NOT_ACCEPTABLE(406),
	CONFLICT(409),
	REQUEST_TIMEOUT(408),
	GONE(410),
	// Client Data Errors
	UNSUPPORTED_MEDIA_TYPE(415),
	UNPROCESSABLE_ENTITY(422),
	// Server General Errors
	INTERNAL_SERVER_ERROR(500),
	NOT_IMPLEMENTED(501),
	BAD_GATEWAY(502),
	SERVICE_UNAVAILABLE(503),
	GATEWAY_TIMEOUT(504),
	HTTP_VERSION_NOT_SUPPORTED(505),
	// Server Execution Errors
	FAILED_DEPENDENCY(424),
	INSUFFICIENT_STORAGE(507),
	// Redirecting Errors
	MOVED_PERMANENTLY(301),
	FOUND(302),
	SEE_OTHER(303),
	TEMP_REDIRECT(307),
	PERM_REDIRECT(308),
	// Informational Responses
	CONTINUE(100),
	SWITCHING_PROTOCOL(101),
	PROCESSING(102),
	// Successful Responses
	OK(200),
	CREATED(201),
	ACCEPTED(202),
	NO_CONTENT(204),
	RESET_CONTENT(205),
	PARTIAL_CONTENT(206),
	MULTI_STATUS(207),
	ALREADY_REPORTED(208),
	IM_USED(226),
	// Cache Related Responses
	NOT_MODIFIED(304),
	USE_PROXY(305),
	TOO_MANY_REDIRECTS(310);

	private final int value;

	HttpStatus(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}
}
