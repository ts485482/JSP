<%@ page contentType="text/html; charset=utf-8" %>

<%@ include file="menu.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 추가</title>
    <script src="./resources/js/validation.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/style.css">
</head>

<body>

<div class="container mt-5">

    <div class="admin-box shadow-soft p-5">

        <!-- 관리자 탭 -->
        <%@ include file="adminMenu.jsp" %>

        <!-- 제목 -->
        <h2 class="fw-bold mb-4">
            물품 추가
        </h2>

        <!-- 상품 등록 폼 -->
        <form name="addCloth" action="processAddProduct.jsp" method="post" enctype="multipart/form-data">
            <div class="admin-form-box mx-auto">
                <table class="table table-borderless align-middle">
                    <!-- 상품 이름 -->
                    <tr>
                        <td width="180">상품 이름</td>
                        <td>
                            <input type="text" id="c_name" name="c_name" class="form-control">
                        </td>
                    </tr>

                    <!-- 상품 번호 -->
                    <tr>
                        <td>상품 번호</td>
                        <td>
                            <input type="text" id="c_id" name="c_id" class="form-control">
                        </td>
                    </tr>

                    <!-- 가격 -->
                    <tr>
                        <td>상품 가격</td>
                        <td>
                            <input type="number" id="c_price" name="c_price" class="form-control">
                        </td>
                    </tr>

                    <!-- 제조사 -->
                    <tr>
                        <td>제조사</td>
                        <td>
                            <input type="text" id="c_manufacturer" name="c_manufacturer" class="form-control">
                        </td>
                    </tr>

                    <!-- 브랜드 -->
                    <tr>
                        <td>브랜드</td>
                        <td>
                            <input type="text" id="c_brand" name="c_brand" class="form-control">
                        </td>
                    </tr>

                    <!-- 원산지 -->
                    <tr>
                        <td>원산지</td>
                        <td>
                            <input type="text" id="c_country" name="c_country" class="form-control">
                        </td>
                    </tr>

                    <!-- 상의 길이 -->
                    <tr>
                        <td>상의 길이</td>
                        <td>
                            <input type="text" id="c_topLength" name="c_topLength" class="form-control">
                        </td>
                    </tr>

                    <!-- 패턴 -->
                    <tr>
                        <td>패턴</td>
                        <td>
                            <input type="text" id="c_pattern" name="c_pattern" class="form-control">
                        </td>
                    </tr>

                    <!-- 하의 길이 -->
                    <tr>
                        <td>하의 길이</td>
                        <td>
                            <input type="text" id="c_pantsLength" name="c_pantsLength" class="form-control">
                        </td>
                    </tr>

                    <!-- 계절 -->
                    <tr>
                        <td>계절</td>
                        <td>
                            <input type="text" id="c_season" name="c_season" class="form-control">
                        </td>
                    </tr>

                    <!-- 카테고리 -->
                    <tr>
                        <td>카테고리</td>
                        <td>
                            <select name="c_category" class="form-select">
                                <option value="남성잠옷">남성잠옷</option>
                                <option value="여성잠옷">여성잠옷</option>
                                <option value="커플세트">커플세트</option>
                            </select>
                        </td>
                    </tr>

                    <!-- 재고 -->
                    <tr>
                        <td>재고 수량</td>
                        <td>
                            <input type="number" id="c_stock" name="c_stock" class="form-control">
                        </td>
                    </tr>

                    <!-- 상품 설명 -->
                    <tr>
                        <td>상품 설명</td>
                        <td>
                            <textarea id="c_description" name="c_description" rows="5" class="form-control"></textarea>
                        </td>
                    </tr>

                    <!-- 이미지 -->
                    <tr>
                        <td>상품 이미지</td>
                        <td>
                            <input type="file" name="productImage" class="form-control">
                        </td>
                    </tr>

                </table>

                <!-- 버튼 -->
                <div class="text-end mt-4">
                    <button type="button" class="btn btn-success px-4 py-2" onclick="CheckAddCloth()">
                        상품 등록하기
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>