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
                <tbody class="table-data-group">
                    <tr>
                        <td class="table-data"><input type="checkbox" name="rowCheck" /></td>
                        <td class="table-data"><a href="#">test</a></td>
                        <td class="table-data">1</td>
                        <td class="table-data">2,500원</td>
                        <td class="table-data">15,000원</td>
                    </tr>
                </tbody>
            </table>
            <!-- // table1 -->


            <!-- pagination -->
            <div class="row">
                <div class="text-center">
                  <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="#">◀</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                    <li class="page-item"><a class="page-link" href="#">▶</a></li>
                  </ul>
                </div>
            </div>
            <!-- // pagination -->


            <!-- table2 -->
            <table class="table detailView">
                <thead>
                    <tr>
                        <th class="table-header">총 상품 가격</th>
                        <th class="table-header">총 배송비</th>
                        <th class="table-header">총 주문 금액</th>
                    </tr>
                </thead>
                <tbody class="table-data-group">
                    <tr>
                        <td class="table-data">15,000원</td>
                        <td class="table-data">2,500원</td>
                        <td class="table-data">17,500원</td>
                    </tr>
                </tbody>
            </table>
            <!-- // table2 -->

            <!-- button -->
            <div class="col-md-push-4 col-md-4 orderCancel_btn">주문 취소</div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>


    <script>
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