<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id"); 
    String password = request.getParameter("password");

    UserDTO user = new UserDTO();
    user.setId(id);
    user.setPassword(password);

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user); 

    if (result == 1) {
        session.setAttribute("sessionId", user.getId());
        session.setAttribute("userName", user.getName()); 
        
        response.sendRedirect("main.jsp"); 
    } else if (result == 0) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
    } else if (result == -1) {
        out.println("<script>alert('존재하지 않는 아이디입니다. 다시 확인해주세요.'); history.back();</script>");
    } else {
        out.println("<script>alert('데이터베이스 오류가 발생했습니다.'); history.back();</script>");
    }
%>