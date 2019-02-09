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
                <div class="col-md-push-1 col-md-10">
                    <div class="carousel slide">

                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        </ol>

                        <div class="carousel-inner">
                            <!--
                                Append Data
                            -->
                        </div>

                        <!-- todo - 추후, Controls(Prev, Next) -->
                    </div>

                    <div class="product-thumbnail">
                        <div class="col-md-12 product-name"></div>
                        <div class="col-md-12 product-price"></div>
                        <div class="col-md-12 product-quantity-div">
                            <span class="col-md-2 quantity-minus">-</span>
                            <span class="col-md-8 quantity-input">1</span>
                            <span class="col-md-2 quantity-plus">+</span>
                        </div>
                        <div class="col-md-12 product-btn-group" style="margin: 0px; padding: 0px;">
                            <div class="col-md-6 cart-btn">장바구니</div>
                            <div class="col-md-6 order-btn">주문하기</div>
                        </div>
                    </div>

                    <div class="product-content">
                        <div class="col-md-12"></div>
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


        $(document).ready(function() {
            var productNo = "${param.product_no}";

            $.ajax({
                type : "get",
                url : "./productDetail",
                data : {
                    product_no : productNo
                },
                dataType : "json",
                success : function(data) {
                    appendProduct(data.product);
                    appendPhotoList(data.photoList);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        });


        /* 상품 정보 추가 */
        function appendProduct(product) {
            $(".product-name").text(product.product_name);
            $(".product-price").text(product.product_price);
            $(".product-content").text(product.product_detail);
        }


        /* 사진 리스트 추가 */
        function appendPhotoList(photoList) {
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

            $(".carousel-inner").append(str1);
            $(".carousel-indicators").append(str2);
        }
    </script>
</html>