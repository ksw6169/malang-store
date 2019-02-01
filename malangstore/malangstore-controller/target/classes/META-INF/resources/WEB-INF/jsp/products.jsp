<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="./res/css/main.css" rel="stylesheet">

    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>
        <div class="container">
            <div class="row">
                <!-- start -->
                <div class="col-md-push-1 col-md-10">
                    <div class="carousel slide">

                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="/res/img/slide1.png" alt="First slide" class="img-fluid img-responsive main-slide" style="height: 100%;"/>
                            </div>
                            <div class="item">
                                <img src="/res/img/slide2.png" alt="Second slide" class="img-fluid img-responsive main-slide" style="height: 100%;"/>
                            </div>
                            <div class="item">
                                <img src="/res/img/slide3.png" alt="Third slide" class="img-fluid img-responsive main-slide" style="height: 100%;"/>
                            </div>
                        </div>

                        <!-- todo : Controls(Prev, Next) -->
                    </div>

                    <!-- thumbnail -->
                    <div class="product_thumbnail">
                        <div class="col-md-12 product_name">말랑말랑피규어</div>
                        <div class="col-md-12 product_price">10000원</div>
                        <div class="col-md-12 product_quantity_div">
                            <span class="col-md-2 quantity_minus">-</span>
                            <span class="col-md-8 quantity_input">1</span>
                            <span class="col-md-2 quantity_plus">+</span>
                        </div>
                        <div class="col-md-12 product_btn_group" style="margin: 0px; padding: 0px;">
                            <div class="col-md-6 cart_btn">장바구니</div>
                            <div class="col-md-6 order_btn">주문하기</div>
                        </div>
                    </div>


                    <!-- product_content -->
                    <div class="product_content">
                        <div class="col-md-12">
                            내용
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
        $('.carousel').carousel();

        // 체크박스 전체 선택(완)
        function allCheck(obj) {
            var chkObj = $("input[name='rowCheck']");
            var rowCnt = chkObj.length - 1; //상단에 있는 갯수 -1
            var check = obj.checked;

            if(check) {
                for (var i=0; i<=rowCnt; i++) {
                    if(chkObj[i].type == "checkbox") {
                        chkObj[i].checked = true;
                    }
                }
            } else {
                for (var i=0; i<=rowCnt; i++) {
                    if(chkObj[i].type == "checkbox"){
                        chkObj[i].checked = false;
                    }
                }
            }
        }
    </script>
</html>