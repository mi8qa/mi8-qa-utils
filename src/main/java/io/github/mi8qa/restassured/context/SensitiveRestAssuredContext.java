package io.github.mi8qa.restassured.context;

import io.github.mi8qa.utils.CollectionUtils;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.Cookie;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.ProxySpecification;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
// FIXME: this is a quick workaround for sensitive request logging. It'll be replaced in the future with a correct implementation.

/**
 * Manages sensitive context for RestAssured API.
 * Provides functionalities to set sensitive headers, cookies, and parameters for REST API calls.
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class SensitiveRestAssuredContext {

	private static final String DEFAULT_HIDDEN_TEXT = "****";

	@Getter(AccessLevel.PUBLIC)
	private FilterableRequestSpecification sensitiveRequestSpec;
	@Getter(AccessLevel.PUBLIC)
	private Set<String> sensitiveResponseHeaderNames;
	@Getter(AccessLevel.PUBLIC)
	private Set<String> sensitiveRequestHeaderNames;
	private Set<String> sensitiveRequestCookieNames;
	private Set<String> sensitiveRequestPathParamNames;
	private Set<String> sensitiveRequestQueryParamNames;
	private Set<String> sensitiveRequestFormParamNames;
	private Set<String> sensitiveRequestParamNames;
	@Getter(AccessLevel.PUBLIC)
	private Set<String> sensitiveResponseCookieNames;
	private boolean sensitiveProxySpecification;

	/**
	 * Constructor for setting all sensitive elements for request and response.
	 *
	 * @param sensitiveHeadersNames        Set of sensitive header names for request.
	 * @param sensitiveCookieNames         Set of sensitive cookie names for request.
	 * @param sensitivePathParamNames      Set of sensitive path parameter names for request.
	 * @param sensitiveQueryParamNames     Set of sensitive query parameter names for request.
	 * @param sensitiveFormParamNames      Set of sensitive form parameter names for request.
	 * @param sensitiveRequestParamNames   Set of sensitive request parameter names for request.
	 * @param sensitiveProxySpecification  Boolean value to specify if proxy information is sensitive.
	 * @param sensitiveResponseHeaderNames Set of sensitive header names for response.
	 * @param sensitiveResponseCookieNames Set of sensitive cookie names for response.
	 */
	public SensitiveRestAssuredContext(
			Set<String> sensitiveHeadersNames,
			Set<String> sensitiveCookieNames,
			Set<String> sensitivePathParamNames,
			Set<String> sensitiveQueryParamNames,
			Set<String> sensitiveFormParamNames,
			Set<String> sensitiveRequestParamNames,
			boolean sensitiveProxySpecification,
			Set<String> sensitiveResponseHeaderNames,
			Set<String> sensitiveResponseCookieNames) {

		this.sensitiveRequestHeaderNames = sensitiveHeadersNames;
		this.sensitiveRequestCookieNames = sensitiveCookieNames;
		this.sensitiveRequestQueryParamNames = sensitiveQueryParamNames;
		this.sensitiveRequestPathParamNames = sensitivePathParamNames;
		this.sensitiveRequestFormParamNames = sensitiveFormParamNames;
		this.sensitiveRequestParamNames = sensitiveRequestParamNames;

		this.sensitiveProxySpecification = sensitiveProxySpecification;
		this.sensitiveResponseHeaderNames = sensitiveResponseHeaderNames;
		this.sensitiveResponseCookieNames = sensitiveResponseCookieNames;
	}

	/**
	 * Sets initial request specification and applies sensitive context.
	 *
	 * @param initialRequestSpec Initial request specification
	 */
	public void setInitialRequestSpec(FilterableRequestSpecification initialRequestSpec) {
		this.sensitiveRequestSpec = (FilterableRequestSpecification) new RequestSpecBuilder()
				.addRequestSpecification(initialRequestSpec).build();
		setSensitiveHeaders();
		setSensitiveCookies();
		setQueryParams();
		setPathParams();
		setFormParams();
		setRequestParams();
		setProxySpec();
	}

	/**
	 * Sets sensitive headers in the request.
	 */
	private void setSensitiveHeaders() {
		List<String> initialHeaderNames = sensitiveRequestSpec.getHeaders().asList()
				.stream().map(Header::getName).toList();
		if (CollectionUtils.hasElements(sensitiveRequestHeaderNames) &&
				CollectionUtils.containsAnyOriginal(initialHeaderNames, sensitiveRequestHeaderNames)) {
			List<Header> sensitiveRequestHeaders = CollectionUtils
					.transformList(sensitiveRequestSpec
										   .getHeaders().asList(),
								   header -> this.sensitiveRequestHeaderNames.contains(header.getName()),
								   header -> new Header(header.getName(), DEFAULT_HIDDEN_TEXT));
			this.sensitiveRequestSpec.replaceHeaders(new Headers(sensitiveRequestHeaders));
		}
	}

	/**
	 * Sets sensitive cookies in the request.
	 */
	private void setSensitiveCookies() {
		List<String> initialCookiesNames = this.sensitiveRequestSpec.getCookies().asList()
				.stream().map(Cookie::getName).toList();
		if (CollectionUtils.hasElements(sensitiveRequestCookieNames) &&
				CollectionUtils.containsAnyOriginal(initialCookiesNames, sensitiveRequestCookieNames)) {
			List<Cookie> sensitiveCookies = CollectionUtils
					.transformList(this.sensitiveRequestSpec.getCookies().asList(),
								   it -> this.sensitiveRequestCookieNames.contains(it.getName()),
								   it -> new Cookie.Builder(it.getName(), DEFAULT_HIDDEN_TEXT).build()
					);
			this.sensitiveRequestSpec.removeCookies();
			sensitiveCookies.forEach(it -> this.sensitiveRequestSpec.cookie(it));
		}
	}

	/**
	 * Sets sensitive query parameters in the request.
	 */

	private void setQueryParams() {
		if (CollectionUtils.containsAnyOriginalKeys(sensitiveRequestSpec.getQueryParams(), this.sensitiveRequestQueryParamNames)) {
			Map<String, String> sensitiveRequestQueryParams = CollectionUtils
					.transformMap(sensitiveRequestSpec.getQueryParams(),
								  it -> this.sensitiveRequestQueryParamNames.contains(it.getKey()),
								  it -> {
									  this.sensitiveRequestSpec.removeQueryParam(it.getKey());
									  return Map.entry(it.getKey(), DEFAULT_HIDDEN_TEXT);
								  }
					);
			this.sensitiveRequestSpec.queryParams(sensitiveRequestQueryParams);
		}
	}

	/**
	 * Sets sensitive path parameters in the request.
	 */
	private void setPathParams() {
		if (CollectionUtils.containsAnyOriginalKeys(sensitiveRequestSpec.getPathParams(), this.sensitiveRequestPathParamNames)) {

			Map<String, String> sensitiveRequestPathParams = CollectionUtils
					.transformMap(sensitiveRequestSpec.getPathParams(),
								  it -> this.sensitiveRequestPathParamNames.contains(it.getKey()),
								  it -> {
									  this.sensitiveRequestSpec.removePathParam(it.getKey());
									  return Map.entry(it.getKey(), DEFAULT_HIDDEN_TEXT);
								  });
			this.sensitiveRequestSpec.pathParams(sensitiveRequestPathParams);
		}
	}

	/**
	 * Sets sensitive form parameters in the request.
	 */
	private void setFormParams() {
		if (CollectionUtils.containsAnyOriginalKeys(sensitiveRequestSpec.getFormParams(), sensitiveRequestFormParamNames)) {
			Map<String, String> sensitiveFormParams = CollectionUtils.transformMap(sensitiveRequestSpec.getFormParams(),
																				   it -> this.sensitiveRequestFormParamNames.contains(it.getKey()),
																				   it -> {
																					   this.sensitiveRequestSpec.removeFormParam(it.getKey());
																					   return Map.entry(it.getKey(), DEFAULT_HIDDEN_TEXT);
																				   });
			this.sensitiveRequestSpec.formParams(sensitiveFormParams);
		}
	}

	/**
	 * Sets sensitive request parameters in the request.
	 */

	private void setRequestParams() {
		if (CollectionUtils.containsAnyOriginalKeys(sensitiveRequestSpec.getRequestParams(), sensitiveRequestParamNames)) {
			Map<String, String> sensitiveRequestParams = CollectionUtils
					.transformMap(sensitiveRequestSpec.getRequestParams(),
								  it -> this.sensitiveRequestParamNames.contains(it.getKey()),
								  it -> {
									  this.sensitiveRequestSpec.removeParam(it.getKey());
									  return Map.entry(it.getKey(), DEFAULT_HIDDEN_TEXT);
								  });
			this.sensitiveRequestSpec.params(sensitiveRequestParams);
		}
	}

	/**
	 * Sets sensitive proxy specification in the request.
	 */
	private void setProxySpec() {
		if (sensitiveProxySpecification && Objects.nonNull(this.sensitiveRequestSpec.getProxySpecification())) {
			ProxySpecification initialProxySpec = this.sensitiveRequestSpec.getProxySpecification();
			this.sensitiveRequestSpec.proxy(ProxySpecification.host(initialProxySpec.getHost()).withPort(initialProxySpec.getPort())
													.withScheme(initialProxySpec.getScheme()).withAuth(DEFAULT_HIDDEN_TEXT, DEFAULT_HIDDEN_TEXT));
		}
	}
}
