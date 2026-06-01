<%@ page contentType="text/html; charset=utf-8" %>

<%
    String category = request.getParameter("category");

    if(category == null){
        category = "";
    }

    /* 로그인 사용자 확인 (ID와 이름을 모두 가져옴) */
    String userId = (String) session.getAttribute("sessionId");
    String userName = (String) session.getAttribute("userName");
    
    // 혹시라도 이름 세션이 비어있을 경우를 대비한 안전장치 기본값
    if(userName == null || userName.trim().equals("")) {
        userName = userId; 
    }
%>

<header class="border-bottom bg-white">

    <div class="container py-3">

        <!-- 상단 -->
        <div class="d-flex justify-content-between align-items-center">

            <!-- 로고 -->
            <a href="./main.jsp"
               class="text-decoration-none text-dark">

                <h2 class="fw-bold mb-0">
                    Mood Closet
                </h2>

            </a>

            <!-- 로그인 메뉴 -->
            <div>

                <%
                    /* 로그인 안 된 상태 */
                    if(userId == null){
                %>
                    <p>
                    <a href="./login.jsp"
                       class="text-decoration-none text-dark">
                        로그인
                    </a>
                     | 
                    <a href="./join.jsp"
                       class="text-decoration-none text-dark">
                        회원가입
                    </a>
                    </p>
                <%
                    }else if(userId.equals("admin")){ // 관리자 계정
                %>
                    <span class="fw-bold">
                        관리자 모드
                    </span>
                    <p>
                    <a href="./admin.jsp"
                       class="text-decoration-none text-dark">
                        물품관리
                    </a>
                     | 
                    <a href="./logout.jsp"
                       class="text-decoration-none text-dark">
                        로그아웃
                    </a>
                    </p>
                <%
                    }else{
                %>
                    <!-- 로그인 된 상태 -->
                    <span class="fw-bold">
                        어서오세요, <%=userName%>님!
                    </span>
                    <p>
                    <a href="./mypage.jsp"
                       class="text-decoration-none text-dark">
                        마이페이지
                    </a>
                     | 
                    <a href="./cart.jsp"
                       class="text-decoration-none text-dark">
                        장바구니
                    </a>
                     | 
                    <a href="./logout.jsp"
                       class="text-decoration-none text-dark">
                        로그아웃
                    </a>
                    </p>
                <%
                    }
                %>

            </div>

        </div>
    </div>
</header>