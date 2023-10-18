package io.github.mi8qa;

import io.github.mi8qa.restassured.allure.RestAssuredAllureParamsFilter;
import io.github.mi8qa.restassured.context.*;
import io.github.mi8qa.restassured.logging.SensitiveLoggingFilter;

import java.util.Collections;

/**
 * This interface provides utility methods for creating RestAssured filters.
 */
public interface Providers {

	/**
	 * Provides methods for creating RestAssured context filters.
	 */
	interface Context {

		/**
		 * Creates an empty sensitive RestAssured context.
		 *
		 * @return An empty sensitive RestAssured context.
		 */
		static SensitiveRestAssuredContext empty() {
			return new SensitiveRestAssuredContext(
					Collections.emptySet(),
					Collections.emptySet(),
					Collections.emptySet(),
					Collections.emptySet(),
					Collections.emptySet(),
					Collections.emptySet(),
					false,
					Collections.emptySet(),
					Collections.emptySet()
			);
		}

		/**
		 * Creates a sensitive RestAssured context with default values.
		 *
		 * @return A sensitive RestAssured context with default values.
		 */
		static SensitiveRestAssuredContext defaults() {
			return new SensitiveRestAssuredContext(SensitiveRequestHeaders.defaults(),
												   SensitiveRequestCookies.defaults(),
												   SensitiveRequestPathParams.defaults(),
												   SensitiveRequestQueryParams.defaults(),
												   SensitiveRequestFormParams.defaults(),
												   SensitiveRequestParams.defaults(),
												   true,
												   SensitiveResponseHeaders.defaults(),
												   SensitiveResponseCookies.defaults());
		}
	}

	/**
	 * Provides methods for creating sensitive logging filters.
	 */

	interface Logger {

		/**
		 * Creates an empty sensitive logging filter.
		 *
		 * @return An empty sensitive logging filter.
		 */

		static SensitiveLoggingFilter empty() {
			return new SensitiveLoggingFilter(Context.empty());
		}

		/**
		 * Creates a sensitive logging filter with default context values.
		 *
		 * @return A sensitive logging filter with default context values.
		 */
		static SensitiveLoggingFilter defaults() {
			return new SensitiveLoggingFilter(Context.defaults());
		}

		/**
		 * Creates a sensitive logging filter with a custom context.
		 *
		 * @param context The custom sensitive RestAssured context.
		 *
		 * @return A sensitive logging filter with the custom context.
		 */
		static SensitiveLoggingFilter with(SensitiveRestAssuredContext context) {
			return new SensitiveLoggingFilter(context);
		}
	}

	/**
	 * Provides methods for creating RestAssured Allure step filters.
	 */
	interface AllureWrapperFilter {

		/**
		 * Creates an empty RestAssured Allure step filter.
		 *
		 * @return An empty RestAssured Allure step filter.
		 */
		static RestAssuredAllureParamsFilter empty() {
			return new RestAssuredAllureParamsFilter(Context.empty());
		}

		/**
		 * Creates a RestAssured Allure step filter with default context values.
		 *
		 * @return A RestAssured Allure step filter with default context values.
		 */
		static RestAssuredAllureParamsFilter defaults() {
			return new RestAssuredAllureParamsFilter(Context.defaults());
		}

		/**
		 * Creates a RestAssured Allure step filter with a custom context.
		 *
		 * @param context The custom sensitive RestAssured context.
		 *
		 * @return A RestAssured Allure step filter with the custom context.
		 */
		static RestAssuredAllureParamsFilter with(SensitiveRestAssuredContext context) {
			return new RestAssuredAllureParamsFilter(context);
		}
	}
}
