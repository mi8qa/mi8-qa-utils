package io.github.mi8qa.restassured.allure;

import io.restassured.filter.OrderedFilter;

/**
 * Abstract filter for RestAssured requests and responses with Allure reporting integration.
 * This filter is designed to save request and response information in Allure context.
 *
 * @see io.qameta.allure.restassured.AllureRestAssured
 * TODO: there's a known problem with array[object] comparison in diff.tpl of Allure.
 * @since [Date or Version]
 */
public abstract class RestAssuredAllureAttachmentFilter implements OrderedFilter {

	//TODO: Replace AllureRestAssured to save request and response in allure context as .rest
	// for Intellij IDEA and VS Code.

	//TODO: This implementation should consider sensitive context.

	//TODO: This implementation should consider related aspects.
}
