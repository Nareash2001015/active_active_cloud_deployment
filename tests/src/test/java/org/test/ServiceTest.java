package org.test;


import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.Base64;
import java.util.HashMap;
import java.util.stream.Stream;

import javax.net.ssl.*;

public class ServiceTest {
    private static final TrustManager[] MOCK_TRUST_MANAGER = new TrustManager[]{
            new X509TrustManager() {
                public X509Certificate[] getAcceptedIssuers() {
                    return new X509Certificate[0];
                }

                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                }

                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                }
            }
    };



    @Test
    public void givenDisableUsingJVMProperty_whenByPassCertificationVerification_thenSuccessHttpResponse() {
        try {
            SSLContext sslContext = SSLContext.getInstance("TLS"); // or "SSL" as per your requirement
            sslContext.init(null, MOCK_TRUST_MANAGER, new SecureRandom());

            // Set JVM property to disable hostname verification
            System.setProperty("jdk.internal.httpclient.disableHostnameVerification", "true");

            HttpClient httpClient = HttpClient.newBuilder()
                    .sslContext(sslContext)
                    .build();

            HashMap<String, String> headers = new HashMap<String, String>();
            String authValue = Base64.getEncoder().encodeToString("admin:admin".getBytes());
            headers.put("Content-Type", "application/json");
            headers.put("Authorization", "Basic " + authValue);

            // Create payload
            String payload = "{\n" +
                    "  \"callbackUrl\":\"www.example.com\",\n" +
                    "  \"clientName\":\"rest_api_admin\",\n" +
                    "  \"owner\":\"admin\",\n" +
                    "  \"grantType\":\"client_credentials password refresh_token\",\n" +
                    "  \"saasApp\":true\n" +
                    "}";

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://am.wso2.com/client-registration/v0.17/register"))
                    .headers(headers.entrySet().stream()
                            .flatMap(entry -> {
                                return entry.getValue() == null ? null : Stream.of(entry.getKey(), entry.getValue());
                            })
                            .toArray(String[]::new))
                    .POST(HttpRequest.BodyPublishers.ofString(payload))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("Response Body: " + response.body());

            // Reset JVM property
            System.setProperty("jdk.internal.httpclient.disableHostnameVerification", "false");

            Assert.assertEquals(200, response.statusCode());
        } catch (IOException | InterruptedException | NoSuchAlgorithmException | KeyManagementException e) {
            // Handle exceptions
            e.printStackTrace();
            Assert.fail("Exception occurred: " + e.getMessage());
        }
    }
}