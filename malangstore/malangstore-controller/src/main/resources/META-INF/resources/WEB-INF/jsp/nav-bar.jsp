<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- bootstrap -->
        <link href="./res/fonts/fonts.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

        <style>
            hr { margin: 0px; padding: 0px; color: black;}
        </style>
    </head>
    <body>
        <!-- navbar -->
        <nav class="navbar navbar-fixed-top" role="navigation" style="border-bottom: 0.25px solid #ddd;">
            <!-- logo -->
            <div class="navbar-header">
                <a class="navbar-brand" href="./">말랑말랑스토어</a>
            </div>
            <!-- // logo -->

            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropbtn">카테고리</a>
                        <div class="dropdown-content">
                            <div class="dropdown-sub1">
                                <a href="#" class="dropdown-sub">의류</a><hr>
                                <div class="dropdown-subcontent1">
                                    <a href="./categories?subcategory=1" class="dropbtn">의류 1</a><hr>
                                    <a href="./categories?subcategory=2" class="dropbtn">의류 2</a><hr>
                                    <a href="./categories?subcategory=3" class="dropbtn">의류 3</a><hr>
                                </div>
                            </div>

                            <div class="dropdown-sub2">
                                <a href="#">인형/피규어</a><hr>
                                <div class="dropdown-subcontent2">
                                    <a href="./categories?subcategory=4" class="dropbtn">인형/피규어 1</a><hr>
                                    <a href="./categories?subcategory=5" class="dropbtn">인형/피규어 2</a><hr>
                                    <a href="./categories?subcategory=6" class="dropbtn">인형/피규어 3</a><hr>
                                </div>
                            </div>

                            <div class="dropdown-sub3">
                                <a href="#">리빙</a><hr>
                                <div class="dropdown-subcontent3">
                                    <a href="./categories?subcategory=7" class="dropbtn">리빙 1</a><hr>
                                    <a href="./categories?subcategory=8" class="dropbtn">리빙 2</a><hr>
                                    <a href="./categories?subcategory=9" class="dropbtn">리빙 3</a><hr>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <!-- search -->
                <!--<form class="navbar-form navbar-right" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="검색">
                    </div>
                    <button type="submit" class="btn btn-default">검색</button>
                </form>-->
                <!-- // search -->

                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropbtn">마이페이지</a>
                        <div class="dropdown-content">
                            <a id="login_column" href="./loginForm">로그인</a><hr>
                            <a id="logout_column" href="#">로그아웃</a><hr>
                            <a href="#">회원정보수정</a><hr>
                            <a href="#">주문조회</a><hr>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="dropbtn">장바구니</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- // navbar -->
    </body>
    <script>
        var loginId = "${sessionScope.loginId}";

        $(document).ready(function() {
            if(loginId == "") {
                $("#login_column").css("display", "block");
                $("#logout_column").css("display", "none");
            } else {
                $("#login_column").css("display", "none");
                $("#logout_column").css("display", "block");
            }

            $("#logout_column").click(function() {
                location.href = "/logout";
            });
        });
    </script>
</html>