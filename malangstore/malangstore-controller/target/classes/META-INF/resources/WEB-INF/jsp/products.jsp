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
                            <span class="col-md-2 quantity-minus" onclick="minusQuantity()">-</span>
                            <input type="text" class="col-md-8 quantity-input" value="1" maxlength="3" style="border: 0.1px solid #e6e6e6;" onkeyup="inputQuantity()" numberOnly/>
                            <span class="col-md-2 quantity-plus" onclick="plusQuantity()">+</span>
                        </div>
                        <div class="col-md-12 product-btn-group" style="margin: 0px; padding: 0px;">
                            <div class="col-md-6 cart-btn" onclick="insertCart(${param.product_no}, 1)" data-toggle="modal" data-target="#product-cart-modal">장바구니</div>
                            <div class="col-md-6 order-btn" onclick="insertCart(${param.product_no}, 2)">주문하기</div>
                        </div>
                    </div>

                    <div class="product-content">
                        <div class="col-md-12"></div>
                    </div>

                    <div class="modal" id="product-cart-modal" tabindex="-1" role="dialog" style="top: 30%;">
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
            </div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>


    <script>
        $('.carousel').carousel();

		var currentPrice;

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
            currentPrice = product.product_price;

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


		/* 장바구니에 담기 */
        function insertCart(productNo, page) {
            $.ajax({
                type : "get",
                url : "./insertCart",
                data : {
                    id : "${sessionScope.loginId}",
                    product_no : productNo,
                    orderlist_count : $(".quantity-input").val()
                },
                dataType : "json",
                success : function(data) {
                    if(page == 2) {
                        location.href = "./moveOrder?orderlistNo="+data.orderlistNo;
                    }
                },
                error : function(error) {
                    console.log(error);
                }
            });
        }


		/* 장바구니 바로 가기 */
        function cartView() {
            location.href = "./cartView";
        }


		/* 수량 감소 */
		function minusQuantity() {
			var currentQuantity = Number($(".quantity-input").val())-1;

			if(currentQuantity <= 0) {
				currentQuantity = 1;
			}

			$(".quantity-input").val(currentQuantity);
			$(".product-price").text(currentPrice*currentQuantity);
		}


		/* 수량 증가 */
		function plusQuantity() {
			var currentQuantity = Number($(".quantity-input").val())+1;

			if(currentQuantity >= 999) {
                currentQuantity = 999;
            }

			$(".quantity-input").val(currentQuantity);
			$(".product-price").text(currentPrice*currentQuantity);
		}


		/* 수량 입력 */
		function inputQuantity() {
			var currentQuantity = Number($(".quantity-input").val());

			if(currentQuantity <= 0) {
                currentQuantity = 1;
            } else if(currentQuantity >= 999) {
				currentQuantity = 999;
            }

			$(".product-price").text(currentPrice*currentQuantity);
		}


        /* 숫자가 아닌 나머지 문자를 공백으로 처리 */
        $("input:text[numberOnly]").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });
    </script>
</html>