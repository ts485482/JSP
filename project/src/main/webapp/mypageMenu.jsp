<%@ page contentType="text/html; charset=utf-8" %>

<%
    String userId = get.
%>

<div class="admin-tab-wrapper mb-4">
    <p>
    <a href="adminAdd.jsp" class="admin-tab <%= adminPage.equals("Add") ? "admin-tab-active" : "" %>">
        물품 추가
    </a>
     | 
    <a href="adminUpdate.jsp" class="admin-tab <%= adminPage.equals("Update") ? "admin-tab-active" : "" %>">
        물품 수정
    </a>
     | 
    <a href="adminDelete.jsp" class="admin-tab <%= adminPage.equals("Delete") ? "admin-tab-active" : "" %>">
        물품 제거
    </a>
    </p>
</div>