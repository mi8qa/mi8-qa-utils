package io.github.mi8qa.restassured.allure;

import io.github.mi8qa.restassured.context.AllureParamContextName;
import io.github.mi8qa.restassured.context.CustomRequestHeaders;
import io.github.mi8qa.restassured.context.SensitiveRestAssuredContext;
import io.github.mi8qa.utils.CollectionUtils;
import io.qameta.allure.Allure;
import io.qameta.allure.model.Parameter;
import io.restassured.filter.FilterContext;
import io.restassured.filter.OrderedFilter;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.FilterableResponseSpecification;

import java.util.*;

/**
 * This class provides a filter implementation for RestAssured and Allure integration.
 * <p>
 * The filter is designed to capture request and response information and integrate it with Allure reporting.
 * It handles custom request headers, sensitive context, and related aspects.
 *
 * @since [Date or Version]
 */

public class RestAssuredAllureParamsFilter implements OrderedFilter {

	private final SensitiveRestAssuredContext sensitiveRestAssuredContext;
	private Response response;

	/**
	 * Constructs a RestAssuredAllureStepFilter with a sensitive context.
	 *
	 * @param sensitiveRestAssuredContext The sensitive context configuration.
	 */
	public RestAssuredAllureParamsFilter(SensitiveRestAssuredContext sensitiveRestAssuredContext) {
		this.sensitiveRestAssuredContext = sensitiveRestAssuredContext;
	}

	/**
	 * Executes the filter logic.
	 *
	 * @param requestSpec  The request specification.
	 * @param responseSpec The response specification.
	 * @param filter       The filter context.
	 *
	 * @return A Response object after applying the filter.
	 */
	@Override
	public Response filter(FilterableRequestSpecification requestSpec, FilterableResponseSpecification responseSpec, FilterContext filter) {
		setCustomHeaders(requestSpec);
		this.sensitiveRestAssuredContext.setInitialRequestSpec(requestSpec);
		response = filter.next(requestSpec, responseSpec);
		List<Parameter> parameters = collectAllureParameters();
		Allure.getLifecycle().updateStep(stepResult -> stepResult.setParameters(parameters));
		return response;
	}

	/**
	 * Gets the order of this filter.
	 *
	 * @return The order value.
	 */
	@Override
	public int getOrder() {
		return OrderedFilter.LOWEST_PRECEDENCE;
	}

	/**
	 * Collects parameters for Allure reporting.
	 *
	 * @return A list of Allure parameters.
	 */
	private List<Parameter> collectAllureParameters() {
		List<Parameter> parameters = new ArrayList<>();
		List<Parameter> requestParameters = new ArrayList<>();
		collectMapToParams(sensitiveRestAssuredContext.getSensitiveRequestSpec().getQueryParams(), requestParameters, AllureParamContextName.QUERY_PARAM);
		collectMapToParams(sensitiveRestAssuredContext.getSensitiveRequestSpec().getPathParams(), requestParameters, AllureParamContextName.PATH_PARAM);
		collectMapToParams(sensitiveRestAssuredContext.getSensitiveRequestSpec().getFormParams(), requestParameters, AllureParamContextName.FORM_PARAM);
		collectMapToParams(sensitiveRestAssuredContext.getSensitiveRequestSpec().getRequestParams(), requestParameters, AllureParamContextName.REQUEST_PARAM);
		sensitiveRestAssuredContext.getSensitiveRequestSpec().getCookies()
				.forEach((cookie) -> requestParameters.add(createParameter(AllureParamContextName.REQUEST_COOKIE, cookie.getName(), cookie.getValue())));
		sensitiveRestAssuredContext.getSensitiveRequestSpec().getHeaders()
				.forEach((header) -> requestParameters.add(createParameter(AllureParamContextName.REQUEST_HEADER, header.getName(), header.getValue())));
		List<Parameter> responseParameters = new ArrayList<>();
		response.getHeaders().forEach((header) -> responseParameters.add(createParameter(AllureParamContextName.RESPONSE_HEADER, header.getName(), header.getValue())));
		collectMapToParams(response.getCookies(), responseParameters, AllureParamContextName.RESPONSE_COOKIE);
		parameters.addAll(CollectionUtils.sortByComparator(requestParameters, Comparator.comparing(Parameter::getName)));
		parameters.addAll(CollectionUtils.sortByComparator(responseParameters, Comparator.comparing(Parameter::getName)));
		return parameters;
	}

	/**
	 * Collects and converts key-value pairs from a map into Allure parameters.
	 *
	 * @param sensitiveRestAssuredContext The map containing key-value pairs to be converted.
	 * @param parameters                  The list to which the Allure parameters will be added.
	 * @param queryParam                  The context name for the parameters (e.g., QUERY_PARAM, PATH_PARAM, FORM_PARAM).
	 */

	private void collectMapToParams(Map<String, String> sensitiveRestAssuredContext, List<Parameter> parameters, AllureParamContextName queryParam) {
		sensitiveRestAssuredContext.forEach((k, v) -> parameters.add(createParameter(queryParam, k, v)));
	}

	/**
	 * Sets custom headers in the request specification.
	 *
	 * @param requestSpec The request specification.
	 */

	private void setCustomHeaders(FilterableRequestSpecification requestSpec) {
		Map<String, String> headers = new HashMap<>();
		for (CustomRequestHeaders value : CustomRequestHeaders.values()) {
			headers.put(value.name().toLowerCase(Locale.ROOT), value.value());
		}
		requestSpec.headers(headers);
	}

	/**
	 * Creates an Allure parameter.
	 *
	 * @param contextName The context name for the parameter.
	 * @param key         The parameter key.
	 * @param value       The parameter value.
	 *
	 * @return An Allure Parameter object.
	 */

	private Parameter createParameter(AllureParamContextName contextName, String key, String value) {
		return new Parameter()
				.setName(contextName.format(key))
				.setMode(Parameter.Mode.DEFAULT)
				.setExcluded(false)
				.setValue(value);
	}
}
