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
            <h1 class="text-header-custom">주문조회</h1>
            <hr style="padding: 1px; margin: 0px 0px 50px 0px;">
            <!-- table 1-->
            <form id="orderForm" action="./orderCancel" method="post">
	            <table class="table">
	                <thead>
	                    <tr>
	                        <th class="table-header"><input type="checkbox" onclick="allCheck(this)"/></th>
	                        <th class="table-header">상품명</th>
	                        <th class="table-header">수량</th>
	                        <th class="table-header">배송비</th>
	                        <th class="table-header">금액</th>
	                    </tr>
	                </thead>
	                <tbody class="addContext1">
	                    <!--
	                        append Data
	                    -->
	                </tbody>
	            </table>
            </form>
            <!-- // table1 -->

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
            <div class="col-md-push-4 col-md-4 orderCancel_btn" onclick="orderCancel()">주문 취소</div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>


    <script>
        var msg = "${msg}";
		var product_delivery_sum = 0;
		var product_price_sum = 0;


        $(document).ready(function() {
			if(msg != "") {
				alert(msg);
				msg = "";
			}

			// 리스트 띄우기
			$.ajax({
                type : "get",
                url : "./orderView",
                data : {
                    id : "${sessionScope.loginId}"
                },
                dataType : "json",
                success : function(data) {
                    console.log(data);
					orderlistPrint(data.orderlist);
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


		// 완
		function orderlistPrint(list) {
            var str = "";

            for(var i=0; i<list.length; i++) {
                product_delivery_sum = list[i].product_delivery;    // todo - 배송비
                product_price_sum += list[i].product_price;

                str += "<tr id='order-data"+list[i].orderlist_no+"'>";
                str += "<td class='table-data'><input type='checkbox' name='rowCheck' value='"+list[i].orderlist_no+"'/></td>";
                str += "<td class='table-data'><a href='#'>"+list[i].product_name+"</a></td>";
                str += "<td class='table-data'>"+list[i].orderlist_count+"</td>";
                str += "<td class='table-data' id='row_delivery"+list[i].orderlist_no+"'>"+list[i].product_delivery+"원</td>";
                str += "<td class='table-data' id='row_price"+list[i].orderlist_no+"'>"+list[i].product_price+"원</td>";
                str += "</tr>";
            }

            $(".addContext1").append(str);

            orderlistAllPrint(product_price_sum, product_delivery_sum);
        }


		// 완
        function orderlistAllPrint(price_sum, delivery_sum) {
            var str = "";

            str += "<tr id='order-data-all'>";
            str += "<td class='table-data'>"+price_sum+"원</td>";
            str += "<td class='table-data'>"+delivery_sum+"원</td>";
            str += "<td class='table-data'>"+(price_sum + delivery_sum)+"원</td>";
            str += "</tr>";

            $(".addContext2").append(str);
        }


		// todo - 주문 취소
		function orderCancel() {
			var orderlist = [];

            $("input[name=rowCheck]:checked").each(function() {
                orderlist.push($(this).attr("value"));
            });

            if(orderlist.length == 0) {
                alert("취소할 상품을 선택해주세요.");
            } else {
                $("#orderForm").submit();
            }
		}



    </script>
</html>