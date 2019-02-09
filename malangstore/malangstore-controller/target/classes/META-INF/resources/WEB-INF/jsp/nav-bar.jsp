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
        <nav class="navbar navbar-fixed-top" role="navigation" style="border-bottom: 0.25px solid #ddd;">
            <div class="navbar-header">
                <a class="navbar-brand" href="./">말랑말랑스토어</a>
            </div>

            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="drop-btn">카테고리</a>
                        <div class="dropdown-content">
                            <div class="dropdown-sub">
                                <a href="#" class="dropdown-sub">의류</a><hr>
                                <div class="dropdown-subcontent">
                                    <a href="./categories?subcategory=1" class="drop-btn">의류 1</a><hr>
                                    <a href="./categories?subcategory=2" class="drop-btn">의류 2</a><hr>
                                    <a href="./categories?subcategory=3" class="drop-btn">의류 3</a><hr>
                                </div>
                            </div>

                            <div class="dropdown-sub">
                                <a href="#">인형/피규어</a><hr>
                                <div class="dropdown-subcontent">
                                    <a href="./categories?subcategory=4" class="drop-btn">인형/피규어 1</a><hr>
                                    <a href="./categories?subcategory=5" class="drop-btn">인형/피규어 2</a><hr>
                                    <a href="./categories?subcategory=6" class="drop-btn">인형/피규어 3</a><hr>
                                </div>
                            </div>

                            <div class="dropdown-sub">
                                <a href="#">리빙</a><hr>
                                <div class="dropdown-subcontent">
                                    <a href="./categories?subcategory=7" class="drop-btn">리빙 1</a><hr>
                                    <a href="./categories?subcategory=8" class="drop-btn">리빙 2</a><hr>
                                    <a href="./categories?subcategory=9" class="drop-btn">리빙 3</a>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="drop-btn">마이페이지</a>
                        <div class="dropdown-content">
                            <a id="login-column" href="./loginForm">로그인</a>
                            <a id="join-column" href="./joinForm">회원가입</a>
                            <a id="logout-column" href="./logout">로그아웃</a>
                        </div>
                    </li>
                    <li>
                        <a href="./cartView" class="drop-btn">장바구니</a>
                    </li>
                    <li>
                        <a href="./moveOrderView" class="drop-btn">주문조회</a>
                    </li>
                </ul>
            </div>
        </nav>
    </body>
    <script>
        var loginId = "${sessionScope.loginId}";

        $(document).ready(function() {
            if(loginId == "") {
                $("#login-column").css("display", "block");
                $("#join-column").css("display", "block");
                $("#logout-column").css("display", "none");
            } else {
                $("#login-column").css("display", "none");
                $("#join-column").css("display", "none");
                $("#logout-column").css("display", "block");
            }
        });
    </script>
</html>