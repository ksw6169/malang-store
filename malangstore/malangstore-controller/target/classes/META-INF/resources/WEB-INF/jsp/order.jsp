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
            .table>thead>tr>.table-header { text-align: center; vertical-align: middle; border: 0.25px solid #e6e6e6; }
            .table>tbody>tr>.table-data { text-align: center; vertical-align: middle; }
        </style>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>

        <div class="container">
            <h1 class="text-header-custom">상품 주문</h1>
            <hr style="padding: 1px; margin: 0px 0px 50px 0px;">

			<form id="order-form" action="./directOrder" method="post">
	            <table class="table">
	                <thead>
	                    <tr>
	                        <th class="table-header"><input type="checkbox" onclick="allCheck(this)"/></th>
	                        <th class="table-header">상품명</th>
	                        <th class="table-header">수량</th>
	                        <th class="table-header">배송비</th>
	                        <th class="table-header">금액</th>
	                        <th class="table-header"></th>
	                    </tr>
	                </thead>
	                <tbody class="first-context">
	                    <!--
	                        append Data
	                    -->
	                </tbody>
	            </table>
            </form>

			<div class="order-delete-btn pull-right" onclick="selectedOrderDelete()">선택삭제</div>

            <table class="table" style="margin-top: 100px;">
                <thead>
                    <tr>
                        <th class="table-header">총 상품 가격</th>
                        <th class="table-header">총 배송비</th>
                        <th class="table-header">총 주문 금액</th>
                    </tr>
                </thead>
                <tbody class="second-context">
                    <!--
                        append data
                    -->
                </tbody>
            </table>

            <div class="col-md-push-4 col-md-4 direct-order-btn" onclick="order()">주문하기</div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>

    <script>
        var productPriceSum = 0;    // 상품 가격 합계
        var deliveryChargeSum = 0;  // 배송비 합계


        $(document).ready(function() {
            var msg = "${msg}";

            if(msg != "") {
                alert(msg);
            }

			var orderlistNo = "${param.orderlistNo}";

			if(orderlistNo != "") {
				$.ajax({
                    type : "get",
                    url : "./getOrderlist",
                    data : {
                        orderlist_no : orderlistNo
                    },
                    dataType : "json",
                    success : function(data) {
                        appendOrderlistOne(data.orderlist);
                    },
                    error : function(error) {
                        console.log(error);
                    }
                });
			}

			appendOrderlist();
        });


        /* 체크박스 전체 선택 */
		function allCheck(obj) {
            var checkObj = $("input[name='row-check']");
            var rowCnt = checkObj.length - 1;
            var isChecked = obj.checked;

            for(var i=0; i<=rowCnt; i++) {
                if(isChecked) {
                    if(checkObj[i].type == "checkbox") {
                        checkObj[i].checked = true;
                    }
                } else {
                    if(checkObj[i].type == "checkbox") {
                        checkObj[i].checked = false;
                    }
                }
            }
        }

		/* 주문 내역 1개 추가 */
		function appendOrderlistOne(orderlist) {
			var str = "";

            str += "<tr id='order-data"+orderlist.orderlist_no+"'>";
            str += "<td class='table-data'><input type='checkbox' name='row-check' value='"+orderlist.orderlist_no+"'/></td>";
            str += "<td class='table-data'><a href='#'>"+orderlist.product_name+"</a></td>";
            str += "<td class='table-data'>"+orderlist.orderlist_count+"</td>";
            str += "<td class='table-data' id='row-delivery"+orderlist.orderlist_no+"'>"+orderlist.product_delivery+"원</td>";
            str += "<td class='table-data' id='row-price${item.orderlist_no}'>"+orderlist.product_price+"원</td>";
            str += "<td class='table-data cart-delete-btn' onclick='deleteOrder("+orderlist.orderlist_no+", "+orderlist.product_price+", "+orderlist.product_delivery+")'>삭제</td>";
            str += "</tr>";

            $(".first-context").append(str);
			$(".second-context tr").remove();
            appendOrderlistAll(orderlist.product_price * orderlist.orderlist_count, orderlist.product_delivery);
		}


		/* 주문 내역 추가 */
		function appendOrderlist() {
            var str = "";

			<c:forEach items="${orderlist}" var="item">
				productPriceSum += (Number(${item.product_price}) * Number(${item.orderlist_count}));
                deliveryChargeSum = Number(${item.product_delivery});

				str += "<tr id='order-data${item.orderlist_no}'>";
                str += "<td class='table-data'><input type='checkbox' name='row-check' value='${item.orderlist_no}'/></td>";
                str += "<td class='table-data'><a href='#'>${item.product_name}</a></td>";
                str += "<td class='table-data'>${item.orderlist_count}</td>";
                str += "<td class='table-data' id='row-delivery${item.orderlist_no}'>${item.product_delivery}원</td>";
                str += "<td class='table-data' id='row-price${item.orderlist_no}'>${item.product_price}원</td>";
                str += "<td class='table-data cart-delete-btn' onclick='deleteOrder(${item.orderlist_no}, ${item.product_price}, ${item.product_delivery})'>삭제</td>";
                str += "</tr>";
			</c:forEach>

            $(".first-context").append(str);
            appendOrderlistAll(productPriceSum, deliveryChargeSum);
		}


		/* 최종 가격 항목 추가 */
		function appendOrderlistAll(priceSum, deliverySum) {
            var str = "";

            str += "<tr id='order-data-all'>";
            str += "<td class='table-data'>"+priceSum+"원</td>";
            str += "<td class='table-data'>"+deliverySum+"원</td>";
            str += "<td class='table-data'>"+(priceSum + deliverySum)+"원</td>";
            str += "</tr>";

            $(".second-context").append(str);
        }


		/* 선택 삭제 */
        function selectedOrderDelete() {
            $("input[name=row-check]:checked").each(function() {
                var orderlistNo = $(this).attr("value");

                var price = $("#row-price"+orderlistNo).text();
                var delivery = $("#row-delivery"+orderlistNo).text();

                price = price.substring(0, price.length-1);
                delivery = delivery.substring(0, delivery.length-1);

                deleteOrder(orderlistNo, price, delivery);
            });
        }


		/* 주문 내역 삭제(UI만 제거) */
		function deleteOrder(orderlistNo, price, delivery) {
            $("#order-data"+orderlistNo).remove();
            $("#order-data-all").remove();

            productPriceSum = productPriceSum - price;

            if($(".first-context").children().size() == 0) {
                deliveryChargeSum = deliveryChargeSum - delivery;
            }

            appendOrderlistAll(productPriceSum, deliveryChargeSum);
        }


		/* 주문하기 */
		function order() {
            var orderlist = [];

            $("input[name=row-check]:checked").each(function() {
                orderlist.push($(this).attr("value"));
            });

            if(orderlist.length == 0) {
                alert("주문할 상품을 선택해주세요.");
            } else {
                $("#order-form").submit();
            }
        }
    </script>
</html>