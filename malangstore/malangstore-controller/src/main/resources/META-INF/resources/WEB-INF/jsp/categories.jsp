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
            #cartModal { top: 30%; }
            .custom-modal-content { text-align: center; font-family: 'NanumsquareR'; font-weight: 600; font-size: 18px; padding: 30px 15px 30px 15px; margin: 0px; }
            .custom-modal-button { text-align: center; font-family: 'NanumsquareR'; font-weight: 600; font-size: 15px; background-color: white; border: 0.1px solid #e72e71; color: #e72e71; padding: 20px; margin: 0px 0px 30px 0px; width: 200px; line-height: 0px; cursor: pointer; }
        </style>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>
        <div class="container">

            <!-- 인자 받아서, jsp 적용할 것 -->
            <h1 class="text-header-custom">인형/피규어</h1>
            <div style="margin: 20px 0px 50px 0px;"><hr>
                <label class="col-md-push-11 col-md-1 item-name"><a href="#">최신순</a></label>
            </div>

            <div class="row">
                <div class="col-md-12 product_board">
                    <!-- add column -->
                </div>
            </div>

            <!-- Navigation -->
            <div class="row">
                <div class="text-center" style="margin: 30px 0px 100px 0px;">
                  <ul class="pagination">
                    <li id="preBtn" class="page-item"><a class="page-link" href="#">◀</a></li>
                    <li id="nextBtn" class="page-item"><a class="page-link" href="#">▶</a></li>
                  </ul>
                </div>
            </div>


            <!-- Modal -->
            <div class="modal" id="cartModal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="custom-modal-content">상품이 장바구니에 담겼습니다.</div>
                            <div class="custom-modal-button center-block" onclick="cartView()" data-dismiss="modal">장바구니 바로가기</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // Modal -->


        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>


    <script>
        var subcategory = "${param.subcategory}";
        var previousPage;
        var currentPage = 1;
        var maxPage;

        $(document).ready(function() {
            $.ajax({
                type : "get",
                url : "./productList",
                data : {
                    subcategory_no : subcategory,
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

                    boardPrint(data.productList);
                    pagingBtnPrint(currentPage);

                    $("#preBtn").addClass("disabled");      // 진입했을 때, 이전 페이지 버튼은 비활성화

                    if(maxPage == 1) {                      // 최대 페이지가 1페이지일 경우
                        $("#nextBtn").addClass("disabled"); // 다음 페이지 버튼은 비활성화
                    }
                },
                error : function(error) {
                    console.log(error);
                }
            });
        });

        // 게시글 그리기(완)
        function boardPrint(list) {
            var str = "";

            for(var i=0; i<list.length; i++) {
                if(i != 0 && i%4 == 0) {
                    str += "<div class='col-md-12 interval_div' style='margin-top: 50px;'></div>";
                }

                str += "<div class='col-md-3' style='padding-left: 0px;'>";
                str += "<div class='thumbnail'>";
                str += "<div class='img-div'>";
                str += "<a href='#'>";
                str += "<img src='/res/img/slide1.png' alt='...' style='width: 100%; height: 100%;'>";
                str += "</a></div>";
                str += "<div class='col-md-12 product_name'>"+list[i].product_name+"</div>";
                str += "<div class='col-md-12 product_price'>"+list[i].product_price+"원</div>";
                str += "<div class='col-md-12' style='padding: 0px;'>";

                str += "<div class='col-md-6 cart_btn' onclick='insertCart("+list[i].product_no+")' data-toggle='modal' data-target='#cartModal'><a href='#' style='color: #e72e71; text-decoration: none;'>장바구니</a></div>";
                str += "<div class='col-md-6 order_btn'><a href='#' style='color: white; text-decoration: none;'>주문하기</a></div>";
                str += "</div></div></div>";
            }

            $(".interval_div").remove();
            $(".col-md-3").remove();
            $(".product_board").append(str);
        }

        // 이전 버튼을 눌렀을 때(완)
        $("#preBtn").click(function() {
            if(currentPage != 1) {              // 현재 페이지가 1페이지가 아니라면,
                setPagingBtn(currentPage, currentPage-1);
                getProductList();               // 게시글 요청
            }
        });


        // 다음 버튼을 눌렀을 때(완)
        $("#nextBtn").click(function() {
            if(currentPage != maxPage) {            // 현재 페이지가 마지막 페이지가 아니라면
                setPagingBtn(currentPage, currentPage+1);

                getProductList();                   // 게시글 요청
            }
        });

        // 페이징 버튼을 눌렀을 때(완)
        function pagingBtnClick(clickPage) {

            if(currentPage != clickPage) {          // 현재 페이지가 클릭한 페이지가 아니라면,
                setPagingBtn(currentPage, clickPage);
                getProductList();                   // 게시글 요청
            }
        }

        // 완
        function setPagingBtn(previousPage, clickPage) {
            $("#pagingBtn"+previousPage).removeClass("active");
            $("#pagingBtn"+clickPage).addClass("active");

            currentPage = clickPage;

            if(currentPage == 1) {
                $("#preBtn").addClass("disabled");
                $("#nextBtn").removeClass("disabled");
            } else if(currentPage == maxPage) {
                $("#nextBtn").addClass("disabled");
                $("#preBtn").removeClass("disabled");
            } else {
                $("#preBtn").removeClass("disabled");
                $("#nextBtn").removeClass("disabled");
            }

            if(currentPage % 5 == 0) {          // case 6 -> 5
                $(".pagingBtn").remove();       // 싹 지운다.
                pagingBtnPrint(currentPage);    // 페이징 버튼을 그린다.
            } else if(currentPage != 1 && currentPage % 5 == 1) {
                $(".pagingBtn").remove();       // 현재 페이징 버튼을 전부 지운다.
                pagingBtnPrint(currentPage);    // 페이징 버튼을 그린다.
            }
        }

        // 페이징 버튼 출력(완), page : 현재 페이지
        function pagingBtnPrint(page) {
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
                str += "<li id='pagingBtn"+i+"' class='page-item pagingBtn'><span class='page-link' style='cursor:pointer;' onclick='pagingBtnClick("+i+")'>"+i+"</span></li>";
            }

            $("#preBtn").after(str);
            $("#pagingBtn"+currentPage).addClass("active");
        }

        // 완
        function getProductList() {
            $.ajax({
                type : "get",
                url : "./productList",
                data : {
                    subcategory_no : subcategory,
                    page : (currentPage-1)*20
                },
                dataType : "json",
                success : function(data) {
                    boardPrint(data.productList);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        }

        function insertCart(product_no) {

            $.ajax({
                type : "get",
                url : "./insertCart",
                data : {
                    id : "${sessionScope.loginId}",     // 현재 ID
                    product_no : product_no             // 상품 번호
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