<html>
<#-- @ftlvariable name="data" type="io.qameta.allure.attachment.http.HttpResponseAttachment" -->
<head>
    <meta http-equiv="content-type" content="text/html; charset = UTF-8">
    <script src="https://yastatic.net/jquery/2.2.3/jquery.min.js" crossorigin="anonymous"></script>

    <link href="https://yastatic.net/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://yastatic.net/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <link type="text/css" href="https://yandex.st/highlightjs/8.0/styles/github.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="https://yandex.st/highlightjs/8.0/highlight.min.js"></script>
    <script type="text/javascript" src="https://yandex.st/highlightjs/8.0/languages/bash.min.js"></script>
    <script type="text/javascript" src="https://yandex.st/highlightjs/8.0/languages/json.min.js"></script>
    <script type="text/javascript" src="https://yandex.st/highlightjs/8.0/languages/xml.min.js"></script>
    <script type="text/javascript">hljs.initHighlightingOnLoad();</script>

    <style>
        pre {
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
<div><h4>Status code</h4> <#if data.responseCode??>
        <pre><code><b>${data.responseCode}</b></code></pre>
    <#else>Unknown</#if></div>
<#if data.url??>

    <div>
    <pre><code>${data.url}</code></pre>
    </div></#if>

<#if data.body?? && data.body?has_content>
    <h4>Response <#if data.body?? && data.body?has_content>
            <button onclick="copyToClipboard()">Copy</button></#if></h4>
    <div id="body">
        <#attempt>
            <#assign m = data.body?eval_json>
            <pre><code>${data.body}</code></pre>
            <#recover>
                <#attempt>
                    <#assign xmlTemplate = data.body?interpret>
                    <pre><#outputformat "XML"><code>${data.body}</code></#outputformat></pre>
                    <#recover>
                        <pre><#outputformat "plainText"><code>${data.body[0..100]}</code></#outputformat></pre>
                </#attempt>
        </#attempt>
    </div>
</#if>

<#if (data.headers)?has_content>
    <h4>Headers</h4>
    <div>
        <#list data.headers as name, value>
            <div>
                <pre><code><b>${name}</b>: ${value}</code></pre>
            </div>
        </#list>
    </div>
</#if>

<#if (data.cookies)?has_content>
    <h4>Cookies</h4>
    <div>
        <#list data.cookies as name, value>
            <div>
                <pre><code><b>${name}</b>: ${value}</code></pre>
            </div>
        </#list>
    </div>
</#if>
</body>
<script>
    function copyToClipboard() {
        var r = document.createRange();
        r.selectNode(document.getElementById("body"));
        window.getSelection().removeAllRanges();
        window.getSelection().addRange(r);
        try {
            document.execCommand('copy');
            window.getSelection().removeAllRanges();
            console.log('Successfully copy text: hello world ' + r);
        } catch (err) {
            console.log('Unable to copy!');
        }
    }
</script>
</html>
