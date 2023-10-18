package io.github.mi8qa.restassured.logging;

import io.github.mi8qa.restassured.context.SensitiveRestAssuredContext;
import io.restassured.filter.FilterContext;
import io.restassured.filter.OrderedFilter;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.UrlDecoder;
import io.restassured.internal.print.RequestPrinter;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.FilterableResponseSpecification;

import java.nio.charset.Charset;

/**
 * A custom filter for logging sensitive data in REST Assured requests and responses.
 * Implements the OrderedFilter interface to indicate its order of execution.
 * <p>
 * This filter is responsible for logging sensitive data in REST Assured requests and responses. It uses the provided
 * SensitiveRestAssuredContext to mask sensitive information such as headers and cookies when logging the details.
 *
 * @see io.restassured.filter.log.RequestLoggingFilter
 * @see io.restassured.filter.log.ResponseLoggingFilter
 * @see RequestPrinter
 * @see io.restassured.internal.print.ResponsePrinter
 * @see SensitiveResponsePrinter
 */
public class SensitiveLoggingFilter implements OrderedFilter {

	private final SensitiveRestAssuredContext context;

	/**
	 * Constructs a new SensitiveLoggingFilter with the specified SensitiveRestAssuredContext.
	 *
	 * @param context The SensitiveRestAssuredContext to use for masking sensitive data.
	 */
	public SensitiveLoggingFilter(SensitiveRestAssuredContext context) {
		this.context = context;
	}

	/**
	 * Gets the order in which this filter should be executed.
	 *
	 * @return The order of execution for this filter.
	 */
	@Override
	public int getOrder() {
		return OrderedFilter.LOWEST_PRECEDENCE;
	}

	/**
	 * Filters the REST Assured request and response, logging sensitive data as needed.
	 *
	 * @param initialRequestSpec The initial request specification.
	 * @param responseSpec       The response specification.
	 * @param filter             The filter context.
	 *
	 * @return The filtered response.
	 */
	@Override
	public Response filter(FilterableRequestSpecification initialRequestSpec, FilterableResponseSpecification responseSpec, FilterContext filter) {
		// Set the initial request specification and get the sensitive request specification
		this.context.setInitialRequestSpec(initialRequestSpec);
		FilterableRequestSpecification sensitiveRequestSpec = context.getSensitiveRequestSpec();

		// Decode the URI and print the request details with masked sensitive information
		String uri = sensitiveRequestSpec.getURI();
		uri = UrlDecoder.urlDecode(uri, Charset.forName(sensitiveRequestSpec.getConfig().getEncoderConfig().defaultQueryParameterCharset()), true);
		RequestPrinter.print(sensitiveRequestSpec, initialRequestSpec.getMethod(), uri, LogDetail.ALL,
							 this.context.getSensitiveRequestHeaderNames(), System.out, true);

		// Continue with the filter chain and obtain the response
		Response response = filter.next(initialRequestSpec, responseSpec);

		// Print the response details with masked sensitive information
		SensitiveResponsePrinter.print(response, response.getBody(), System.out, LogDetail.ALL, true, context.getSensitiveResponseHeaderNames(),
									   context.getSensitiveResponseCookieNames());

		return response;
	}
}
