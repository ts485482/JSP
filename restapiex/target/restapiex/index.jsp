<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.databind.JsonNode" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<%
    // 1. API 키 설정 (본인의 REST API 키로 교체하세요)
    String apiKey = "fb445c0a80b68c63870873f65f9f5cba"; 
    String query = request.getParameter("query");
    JsonNode documents = null;

    // 2. 검색 요청 처리
    if (query != null && !query.trim().isEmpty()) {
        try {
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);
            String apiURL = "https://dapi.kakao.com/v2/search/web?query=" + encodedQuery;
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", "KakaoAK " + apiKey);
            
            int responseCode = con.getResponseCode();
            if (responseCode == 200) {
                // JSP의 기본 내장 객체인 'response'와 충돌하지 않도록 'apiResponse' 사용
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
                StringBuilder apiResponse = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    apiResponse.append(line);
                }
                br.close();
                
                ObjectMapper mapper = new ObjectMapper();
                documents = mapper.readTree(apiResponse.toString()).get("documents");
            }
        } catch (Exception e) {
            // 서버 로그에 오류 출력
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카카오 웹 검색</title>
    <style>
        body { font-family: sans-serif; padding: 20px; line-height: 1.6; }
        .result-item { margin-bottom: 20px; border-bottom: 1px solid #ddd; padding-bottom: 10px; }
        h3 { margin-bottom: 5px; color: #333; }
        p { color: #666; font-size: 14px; margin-top: 5px; }
        a { text-decoration: none; color: #007bff; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <a href="./index.jsp"><h2>카카오 웹 검색</h2></a>
    <form method="get">
        <input type="text" name="query" value="<%= (query != null) ? query : "" %>" required>
        <button type="submit">검색</button>
    </form>
    <hr>
    
    <% if (documents != null) { %>
        <% if (documents.size() > 0) { %>
            <% for (JsonNode node : documents) { %>
                <div class="result-item">
                    <h3><a href="<%= node.get("url").asText() %>" target="_blank"><%= node.get("title").asText() %></a></h3>
                    <p><%= node.get("contents").asText() %></p>
                </div>
            <% } %>
        <% } else { %>
            <p>검색 결과가 없습니다.</p>
        <% } %>
    <% } else if (query != null) { %>
        <p style="color:red;">검색 중 오류가 발생했거나 API 키를 확인해주세요.</p>
    <% } %>
</body>
</html>