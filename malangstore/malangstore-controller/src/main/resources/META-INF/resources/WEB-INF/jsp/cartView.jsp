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
            <h1 class="text-header-custom">장바구니</h1>
            <hr style="padding: 1px; margin: 0px 0px 50px 0px;">

            <!-- table 1-->
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
                <tbody class="addContext1">
                    <!--
                        append Data
                    -->
                </tbody>
            </table>
            <!-- // table1 -->

            <div class="order-delete-btn pull-right" onclick="selectOrderDelete()">선택삭제</div>

            <!-- table2 -->
            <table class="table" style="margin-top: 100px;">
                <thead>
                    <tr>
                        <th class="table-header">총 상품 가격</th>
                        <th class="table-header">총 배송비</th>
                        <th class="table-header">총 주문 금액</th>
                    </tr>
                </thead>
                <tbody class="addContext2">
                    <!--
                        append Data
                    -->
                </tbody>
            </table>
            <!-- // table2 -->

            <!-- button -->
            <div class="col-md-push-4 col-md-4 direct_order_btn">주문하기</div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>


    <script>
        var product_price_sum = 0;
        var product_delivery_sum = 0;

        $(document).ready(function() {
            $.ajax({
                type : "get",
                url : "./cartList",
                data : {
                    id : "${sessionScope.loginId}"
                },
                dataType : "json",
                success : function(data) {
                    orderlistPrint(data.list);
                },
                error : function(error) {
                    console.log(error);
                }
            });
        });

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

        function orderlistPrint(list) {
            var str = "";

            for(var i=0; i<list.length; i++) {
                product_delivery_sum = list[i].product_delivery;    // todo - 배송비
                product_price_sum += list[i].product_price;

                str += "<tr id='order-data"+list[i].orderlist_no+"'>";
                str += "<td class='table-data'><input type='checkbox' name='rowCheck' id='row"+list[i].orderlist_no+"'/></td>";
                str += "<td class='table-data'><a href='#'>"+list[i].product_name+"</a></td>";
                str += "<td class='table-data'>"+list[i].orderlist_count+"</td>";
                str += "<td class='table-data' id='row_delivery"+list[i].orderlist_no+"'>"+list[i].product_delivery+"원</td>";
                str += "<td class='table-data' id='row_price"+list[i].orderlist_no+"'>"+list[i].product_price+"원</td>";
                str += "<td class='table-data cart_delete_btn' onclick='deleteOrder("+list[i].orderlist_no+", "+list[i].product_price+", "+list[i].product_delivery+")'>삭제</td>";
                str += "</tr>";
            }

            $(".addContext1").append(str);

            orderlistAllPrint(product_price_sum, product_delivery_sum);
        }


        function orderlistAllPrint(price_sum, delivery_sum) {
            var str = "";

            str += "<tr id='order-data-all'>";
            str += "<td class='table-data'>"+price_sum+"원</td>";
            str += "<td class='table-data'>"+delivery_sum+"원</td>";
            str += "<td class='table-data'>"+(price_sum + delivery_sum)+"원</td>";
            str += "</tr>";

            $(".addContext2").append(str);
        }


        function deleteOrder(orderlist_no, price, delivery) {

            $.ajax({
                type : "get",
                url : "./deleteOrder",
                data : {
                    orderlist_no : orderlist_no
                },
                dataType : "json",
                success : function(data) {
                    console.log(data);
                },
                error : function(error) {
                    console.log(error);
                }
            });

            $("#order-data"+orderlist_no).remove();
            $("#order-data-all").remove();

            product_price_sum = product_price_sum - price;

            if($(".addContext1").children().size() == 0) {
                product_delivery_sum = product_delivery_sum - delivery;
            }

            orderlistAllPrint(product_price_sum, product_delivery_sum);
        }

        // 선택 삭제(완)
        function selectOrderDelete() {
            $("input[name=rowCheck]:checked").each(function() {
                var orderlist_no = $(this).attr("id").substring(3);

                var delivery = $("#row_delivery"+orderlist_no).text();
                var price = $("#row_price"+orderlist_no).text();
                delivery = delivery.substring(0, delivery.length-1);
                price = price.substring(0, price.length-1);

                deleteOrder(orderlist_no, price, delivery);
            });
        }
    </script>
</html>