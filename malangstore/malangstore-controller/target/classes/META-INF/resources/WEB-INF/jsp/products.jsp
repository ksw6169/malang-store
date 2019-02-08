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
                        </ol>

                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <!--
                                Append Data

                                밑에 src delete 해놓음
                            -->
                        </div>

                        <!-- todo : Controls(Prev, Next) -->
                    </div>

                    <!-- thumbnail -->
                    <div class="product_thumbnail">
                        <div class="col-md-12 product_name"></div>
                        <div class="col-md-12 product_price"></div>
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


        // ajax 2번 -> 1번으로 수정(이전과 같이 한꺼번에 불러오는 식으로)
        $(document).ready(function() {
            var product_no = "${param.product_no}";

            $.ajax({
                type : "get",
                url : "./productDetail",
                data : {
                    product_no : product_no
                },
                dataType : "json",
                success : function(data) {
                    console.log(data);
                    printProduct(data.product);
                },
                error : function(error) {
                    console.log(error);
                }
            });

            $.ajax({
                type : "get",
                url : "./getPhotoList",
                data : {
                    product_no : product_no
                },
                dataType : "json",
                success : function(data) {
                    console.log(data);
                    printPhotoList(data.photoList);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        });


        // 상품 정보 출력(완)
        function printProduct(product) {
            $(".product_name").text(product.product_name);
            $(".product_price").text(product.product_price);
            $(".product_content").text(product.product_detail);
        }


        // 사진 리스트 출력(완)
        function printPhotoList(photoList) {
            console.log(photoList);
            var str1 = "";
            var str2 = "";

            photoList.forEach(function(item, i, array) {
                if(i == 0) {
                    str1 += "<div class='item active'>";
                } else {
                    str1 += "<div class='item'>";
                    str2 += "<li data-target='#carousel-example-generic' data-slide-to='"+i+"'></li>";
                }

                str1 += "<img src='/res/img/"+item.photo_name+"' alt='First slide' class='img-fluid img-responsive main-slide img1' style='height: 100%;'/>";
                str1 += "</div>";
            });

            $(".carousel-indicators").append(str2);
            $(".carousel-inner").append(str1);
        }
    </script>
</html>