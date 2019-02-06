<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- bootstrap -->
        <link href="./res/fonts/fonts.css" rel="stylesheet">
        <link href="./res/css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>

        <div class="container">
            <div class="row">
                <div class="col-md-offset-2 col-md-8" style="padding: 50px 0px 50px 0px; border: 0.25px solid #dddddd;">
                    <div class="col-md-offset-2 col-md-8">
                        <h1 class="text-header">로그인</h1>

                        <form action="./login" method="post">
                            <!-- input id -->
                            <div class="row">
                                <div class="col-md-12">
                                    <input name="id" class="inputBox" type="text" placeholder="ID"/>
                                </div>
                            </div>

                            <!-- input password -->
                            <div class="row">
                                <div class="col-md-12">
                                    <input name="pw" class="inputBox" type="password" placeholder="Password"/>
                                </div>
                            </div>

                            <!-- button -->
                            <div class="row">
                                <div class="col-md-12">
                                    <button class="btn-custom">로그인</button>
                                </div>
                            </div>
                        </form>

                        <hr style="padding: 0px; margin: 20px 0px 20px 0px;">
                        <div class="row">
                            <div class="col-md-2">
                                <a href="./joinForm" class="sub-login-menu">회원가입</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var msg = "${msg}";

        if(msg != "") {
            alert(msg);
            msg = "";
        }

        $(document).ready(function() {
            $("input[name='id']").focus();
        });
    </script>
</html>