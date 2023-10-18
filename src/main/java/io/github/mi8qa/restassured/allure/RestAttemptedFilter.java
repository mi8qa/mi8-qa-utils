package io.github.mi8qa.restassured.allure;


import io.restassured.filter.FilterContext;
import io.restassured.filter.OrderedFilter;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.FilterableResponseSpecification;

//this class represents an enabler to work with RestAssured and Allure using aspects.
//The reason to use a separate filter implementation is:
// using aspects on RestAssured implementation can break it due to its integration complexity.
// For example, if you intercept given(), then(), etc., logging and AllureRestAssured can break.
// using a separate filter is truly safe I think and should not break anything.
public class RestAttemptedFilter implements OrderedFilter {

	@Override
	public int getOrder() {
		return OrderedFilter.LOWEST_PRECEDENCE;
	}

	@Override
	public Response filter(FilterableRequestSpecification filterableRequestSpecification, FilterableResponseSpecification filterableResponseSpecification, FilterContext filterContext) {
		return filterContext.next(filterableRequestSpecification, filterableResponseSpecification);
	}
}
