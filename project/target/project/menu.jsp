<%@ page contentType="text/html; charset=utf-8" %>
<%
    String category = request.getParameter("category");

    if(category == null){
        category = "";
    }
%>
<header class="border-bottom bg-white">
    <div class="container py-3">

        <!-- 상단 -->
        <div class="d-flex justify-content-between align-items-center">

            <!-- 로고 -->
            <a href="./main.jsp" class="text-decoration-none text-dark">
                <h2 class="fw-bold">사이트 이름(미정)</h2>
            </a>

            <!-- 로그인 -->
            <div>
                <a href="./login.jsp" class="text-decoration-none text-dark me-3">
                    로그인
                </a>

                <a href="./join.jsp" class="text-decoration-none text-dark">
                    회원가입
                </a>
            </div>
        </div>

        <!-- 검색창 -->
        <div class="row justify-content-center mt-4">
            <div class="col-md-6">
                <form class="d-flex" method="get" action="main.jsp">
                    <!-- 현재 카테고리 유지 -->
                    <input type="hidden" name="category" value="<%= category %>">
                    <input type="text" name="keyword" class="form-control form-control-lg" placeholder="검색어 입력 (성별, 키워드 등)" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">

                    <button class="btn btn-dark btn-lg ms-2">
                        검색
                    </button>

                </form>
            </div>
        </div>

        <!-- 카테고리 -->
        <div class="row text-center mt-4">
            <div class="col border p-3 category-box <%= category.equals("") ? "bg-dark" : "" %>">
                <a href="./main.jsp" class="text-decoration-none <%= category.equals("") ? "text-white" : "text-dark" %>">
                    신상품
                </a>
            </div>

            <div class="col border p-3 category-box <%= category.equals("남성잠옷") ? "bg-dark" : "" %>">
                <a href="./main.jsp?category=남성잠옷" class="text-decoration-none <%= category.equals("남성잠옷") ? "text-white" : "text-dark" %>">
                    남성잠옷
                </a>
            </div>

            <div class="col border p-3 category-box <%= category.equals("여성잠옷") ? "bg-dark" : "" %>">
                <a href="./main.jsp?category=여성잠옷" class="text-decoration-none <%= category.equals("여성잠옷") ? "text-white" : "text-dark" %>">
                    여성잠옷
                </a>
            </div>

            <div class="col border p-3 category-box <%= category.equals("커플세트") ? "bg-dark" : "" %>">
                <a href="./main.jsp?category=커플세트" class="text-decoration-none <%= category.equals("커플세트") ? "text-white" : "text-dark" %>">
                    커플세트
                </a>
            </div>
        </div>
    </div>
</header>