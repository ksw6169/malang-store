<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="./res/css/main.css" rel="stylesheet">

        <style>
            .custom-modal-content { text-align: center; font-family: 'NanumsquareR'; font-weight: 600; font-size: 18px; padding: 30px 15px 30px 15px; margin: 0px; }
            .custom-modal-button { text-align: center; font-family: 'NanumsquareR'; font-weight: 600; font-size: 15px; background-color: white; border: 0.1px solid #e72e71; color: #e72e71; padding: 20px; margin: 0px 0px 30px 0px; width: 200px; line-height: 0px; cursor: pointer; }
        </style>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>
        <div class="container">

            <h1 class="text-header-custom sub-category-name"></h1>
            <div style="margin: 20px 0px 50px 0px;"><hr>
                <label class="col-md-push-11 col-md-1 item-name"><a href="#">최신순</a></label>
            </div>

            <div class="row">
                <div class="col-md-12 product-board">
                    <!--
                        append Data
                    -->
                </div>
            </div>

            <div class="row">
                <div class="text-center" style="margin: 30px 0px 100px 0px;">
                  <ul class="pagination">
                    <li id="pre-button" class="page-item"><a class="page-link" href="#">◀</a></li>
                    <li id="next-button" class="page-item"><a class="page-link" href="#">▶</a></li>
                  </ul>
                </div>
            </div>

            <div class="modal" id="cart-modal" tabindex="-1" role="dialog" style="top: 30%;">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="custom-modal-content">상품이 장바구니에 담겼습니다.</div>
                            <div class="custom-modal-button center-block" onclick="cartView()" data-dismiss="modal">장바구니 바로가기</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>

    <script>
        var subcategoryNo = "${param.subcategory}";
        var previousPage;       // 이전 페이지
        var currentPage = 1;    // 현재 페이지
        var maxPage;            // 해당 카테고리의 게시글 개수에 따른 최대 페이지


        $(document).ready(function() {
            $.ajax({
                type : "get",
                url : "./productList",
                data : {
                    subcategory_no : subcategoryNo,
                    page : 0
                },
                dataType : "json",
                success : function(data) {
                    var count = data.productListCount;

                    if(count != 0 && count % 20 == 0) {
                        maxPage = parseInt(count/20);
                    } else {
                        maxPage = parseInt(count/20)+1;
                    }

					appendSubCategoryName(data.subCategoryName);
                    appendProductList(data);
                    appendPagingButton(currentPage);

                    $("#pre-button").addClass("disabled");      // 진입했을 때, 이전 페이지 버튼 비활성화

                    if(maxPage == 1) {                          // 최대 페이지가 1페이지일 경우, 다음 페이지 버튼은 비활성화
                        $("#next-button").addClass("disabled");
                    }
                },
                error : function(error) {
                    console.log(error);
                }
            });
        });


		/* 카테고리 이름 추가 */
		function appendSubCategoryName(subCategoryName) {
			$(".sub-category-name").append(subCategoryName);
		}


        /* 상품 리스트 추가 */
        function appendProductList(data) {
            var list = data.productList;
            var photoList = data.photoList;
            var str = "";

            for(var i=0; i<list.length; i++) {
                if(i != 0 && i%4 == 0) {
                    str += "<div class='col-md-12 interval-div' style='margin-top: 50px;'></div>";
                }

                str += "<div class='col-md-3' style='padding-left: 0px;'>";
                str += "<div class='thumbnail'>";
                str += "<div class='img-div'>";
                str += "<a href='./products?product_no="+list[i].product_no+"'>";
                str += "<img src='/res/img/"+photoList[i].photo_name+"' alt='...' style='width: 100%; height: 100%;'>";
                str += "</a></div>";
                str += "<div class='col-md-12 product-name'>"+list[i].product_name+"</div>";
                str += "<div class='col-md-12 product-price'>"+list[i].product_price+"원</div>";
                str += "<div class='col-md-12' style='padding: 0px;'>";

                str += "<div class='col-md-6 cart-btn' onclick='insertCart("+list[i].product_no+")' data-toggle='modal' data-target='#cart-modal'><a href='#' style='color: #e72e71; text-decoration: none;'>장바구니</a></div>";
                str += "<div class='col-md-6 order-btn'><a href='#' style='color: white; text-decoration: none;'>주문하기</a></div>";
                str += "</div></div></div>";
            }

            $(".interval-div").remove();
            $(".col-md-3").remove();
            $(".product-board").append(str);
        }


        /* 이전 버튼을 눌렀을 때 동작 */
        $("#pre-button").click(function() {
            if(currentPage != 1) {  // 현재 페이지가 1페이지가 아니라면, 게시글 요청
                setPagingButton(currentPage, currentPage-1);
                getProductList();
            }
        });


        /* 다음 버튼을 눌렀을 때 동작 */
        $("#next-button").click(function() {
            if(currentPage != maxPage) {    // 현재 페이지가 마지막 페이지가 아니라면 게시글 요청
                setPagingButton(currentPage, currentPage+1);
                getProductList();
            }
        });


        /* 페이징 버튼을 눌렀을 때 동작 */
        function pagingBtnClick(clickPage) {
            if(currentPage != clickPage) {  // 현재 페이지가 클릭한 페이지가 아니라면, 게시글 요청
                setPagingButton(currentPage, clickPage);
                getProductList();
            }
        }


        /* 페이징 버튼 설정 */
        function setPagingButton(previousPage, clickPage) {
            $("#paging-btn"+previousPage).removeClass("active");
            $("#paging-btn"+clickPage).addClass("active");

            currentPage = clickPage;

            if(currentPage == 1) {
                $("#pre-button").addClass("disabled");
                $("#next-button").removeClass("disabled");
            } else if(currentPage == maxPage) {
                $("#next-button").addClass("disabled");
                $("#pre-button").removeClass("disabled");
            } else {
                $("#pre-button").removeClass("disabled");
                $("#next-button").removeClass("disabled");
            }

            if(currentPage % 5 == 0) {                                  // case 6 -> 5
                $(".paging-btn").remove();
                appendPagingButton(currentPage);
            } else if(currentPage != 1 && currentPage % 5 == 1) {       // case 5 -> 6
                $(".paging-btn").remove();
                appendPagingButton(currentPage);
            }
        }


        /* 페이징 버튼 출력 */
        function appendPagingButton(page) {     // page - 현재 페이지
            var str = "";
            var start;
            var end;

            if(page % 5 == 0) {         // 6 -> 5의 case
                start = page-4;
                end = page;
            } else if(page % 5 == 1) {  // 5 -> 6의 case
                start = page;
                if(maxPage > page+4) {
                    end = page+4;
                } else {
                    end = maxPage;
                }
            }

            for(var i=start; i<=end; i++) {
                str += "<li id='paging-btn"+i+"' class='page-item paging-btn'><span class='page-link' style='cursor:pointer;' onclick='pagingBtnClick("+i+")'>"+i+"</span></li>";
            }

            $("#pre-button").after(str);
            $("#paging-btn"+currentPage).addClass("active");
        }


        /* productList 가져오기 */
        function getProductList() {
            $.ajax({
                type : "get",
                url : "./productList",
                data : {
                    subcategory_no : subcategoryNo,
                    page : (currentPage-1)*20
                },
                dataType : "json",
                success : function(data) {
                    appendProductList(data);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        }


		/* 장바구니에 추가 */
        function insertCart(productNo) {
            $.ajax({
                type : "get",
                url : "./insertCart",
                data : {
                    id : "${sessionScope.loginId}",
                    product_no : productNo
                },
                dataType : "json",
                success : function(data) {
                    console.log(data);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        }


        function cartView() {
            location.href = "./cartView";
        }
    </script>
</html>