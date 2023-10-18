package io.github.mi8qa.allure;

import io.qameta.allure.attachment.DefaultAttachmentProcessor;
import io.qameta.allure.attachment.FreemarkerAttachmentRenderer;
import io.qameta.allure.attachment.http.HttpRequestAttachment;
import io.qameta.allure.attachment.http.HttpRequestAttachment.Builder;
import io.qameta.allure.attachment.http.HttpResponseAttachment;
import io.restassured.internal.NameAndValue;
import io.restassured.internal.support.Prettifier;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

// This is the copy of original AllureRestAssured. Somehow aspect breaks filters until you register a new one :(
public class AllureRestAssuredUtil {

	private static final String requestTemplatePath = "http-request.ftl";
	private static final String responseTemplatePath = "http-response.ftl";
	private static final String requestAttachmentName = "Request";
	private static final String responseAttachmentName = "Response";

	private AllureRestAssuredUtil() {
	}

	private static Map<String, String> toMapConverter(Iterable<? extends NameAndValue> items) {
		Map<String, String> result = new HashMap();
		items.forEach((h) -> {
			result.put(h.getName(), h.getValue());
		});
		return result;
	}

	public static void addAttachments(FilterableRequestSpecification requestSpec, Response response) {
		Prettifier prettifier = new Prettifier();
		String url = requestSpec.getURI();
		HttpRequestAttachment.Builder requestAttachmentBuilder = Builder.create(requestAttachmentName, url).setMethod(requestSpec.getMethod()).setHeaders(toMapConverter(requestSpec.getHeaders())).setCookies(toMapConverter(requestSpec.getCookies()));
		if (Objects.nonNull(requestSpec.getBody())) {
			requestAttachmentBuilder.setBody(prettifier.getPrettifiedBodyIfPossible(requestSpec));
		}

		HttpRequestAttachment requestAttachment = requestAttachmentBuilder.build();
		(new DefaultAttachmentProcessor()).addAttachment(requestAttachment, new FreemarkerAttachmentRenderer(requestTemplatePath));
		String attachmentName = Optional.ofNullable(responseAttachmentName).orElse(response.getStatusLine());
		HttpResponseAttachment responseAttachment = io.qameta.allure.attachment.http.HttpResponseAttachment.Builder.create(attachmentName).setResponseCode(response.getStatusCode()).setHeaders(toMapConverter(response.getHeaders())).setBody(prettifier.getPrettifiedBodyIfPossible(response, response.getBody())).build();
		(new DefaultAttachmentProcessor()).addAttachment(responseAttachment, new FreemarkerAttachmentRenderer(responseTemplatePath));
	}
}
