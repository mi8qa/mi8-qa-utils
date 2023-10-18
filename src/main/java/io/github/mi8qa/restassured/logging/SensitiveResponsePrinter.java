package io.github.mi8qa.restassured.logging;

import io.restassured.filter.log.LogDetail;
import io.restassured.http.Cookie;
import io.restassured.http.Cookies;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.internal.support.Prettifier;
import io.restassured.response.ResponseBody;
import io.restassured.response.ResponseOptions;
import org.apache.commons.lang3.StringUtils;

import java.io.PrintStream;
import java.util.Set;

/**
 * A utility class for printing sensitive response details.
 */
public class SensitiveResponsePrinter {

	private static final String BLACKLISTED = "****";

	/**
	 * Private constructor to prevent instantiation.
	 */
	private SensitiveResponsePrinter() {
	}

	/**
	 * Prints response details to the specified output stream.
	 *
	 * @param responseOptions    The response options containing response details.
	 * @param responseBody       The response body.
	 * @param stream             The output stream to print to.
	 * @param logDetail          The level of detail to log (e.g., STATUS, HEADERS, COOKIES, BODY).
	 * @param shouldPrettyPrint  Whether to pretty-print the response body.
	 * @param blacklistedHeaders Set of headers to be blacklisted (masked) in the log.
	 * @param blacklistedCookies Set of cookies to be blacklisted (masked) in the log.
	 */
	@SuppressWarnings("rawtypes")
	public static void print(ResponseOptions responseOptions, ResponseBody responseBody, PrintStream stream, LogDetail logDetail, boolean shouldPrettyPrint, Set<String> blacklistedHeaders, Set<String> blacklistedCookies) {
		StringBuilder builder = new StringBuilder();

		if (logDetail == LogDetail.ALL || logDetail == LogDetail.STATUS) {
			builder.append(responseOptions.statusLine()).append(System.lineSeparator());
		}

		if (logDetail == LogDetail.ALL || logDetail == LogDetail.HEADERS) {
			appendHeaders(responseOptions.headers(), blacklistedHeaders, builder);
		}

		if (logDetail == LogDetail.ALL || logDetail == LogDetail.COOKIES) {
			appendCookies(responseOptions.detailedCookies(), blacklistedCookies, builder);
		}

		if (logDetail == LogDetail.ALL || logDetail == LogDetail.BODY) {
			appendBody(responseOptions, responseBody, shouldPrettyPrint, builder);
		}

		String responseToPrint = builder.toString();
		stream.println(responseToPrint);
	}

	/**
	 * Appends response headers to the StringBuilder.
	 *
	 * @param headers            The response headers.
	 * @param blacklistedHeaders Set of headers to be blacklisted (masked) in the log.
	 * @param builder            The StringBuilder to append headers to.
	 */
	private static void appendHeaders(Headers headers, Set<String> blacklistedHeaders, StringBuilder builder) {
		if (headers.exist()) {
			for (Header header : headers) {
				builder.append(header.getName())
						.append(": ")
						.append(blacklistedHeaders.contains(header.getName()) ? BLACKLISTED : header.getValue())
						.append(System.lineSeparator());
			}
			builder.append(System.lineSeparator());  // Adding extra line separator after headers
		}
	}

	/**
	 * Appends response cookies to the StringBuilder.
	 *
	 * @param cookies            The response cookies.
	 * @param blacklistedCookies Set of cookies to be blacklisted (masked) in the log.
	 * @param builder            The StringBuilder to append cookies to.
	 */
	private static void appendCookies(Cookies cookies, Set<String> blacklistedCookies, StringBuilder builder) {
		if (cookies.exist()) {
			builder.append("Cookies:");  // Adding Cookies label
			for (Cookie cookie : cookies) {
				builder.append(" ")
						.append(cookie.getName())
						.append("=")
						.append(blacklistedCookies.contains(cookie.getName()) ? BLACKLISTED : cookie.getValue());
			}
			builder.append(System.lineSeparator()).append(System.lineSeparator());  // Adding extra line separator after cookies
		}
	}

	/**
	 * Appends the response body to the StringBuilder.
	 *
	 * @param responseOptions   The response options containing response details.
	 * @param responseBody      The response body.
	 * @param shouldPrettyPrint Whether to pretty-print the response body.
	 * @param builder           The StringBuilder to append the body to.
	 */
	@SuppressWarnings("rawtypes")
	private static void appendBody(ResponseOptions responseOptions, ResponseBody responseBody, boolean shouldPrettyPrint, StringBuilder builder) {
		String responseBodyToAppend = shouldPrettyPrint ?
				new Prettifier().getPrettifiedBodyIfPossible(responseOptions, responseBody) :
				responseBody.asString();

		if (!StringUtils.isBlank(responseBodyToAppend)) {
			builder.append(responseBodyToAppend);
		}
	}
}
