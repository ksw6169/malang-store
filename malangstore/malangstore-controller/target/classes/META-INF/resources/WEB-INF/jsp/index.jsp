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

        <div class="container-fluid" style="padding: 0px;">
            <div id="carousel-example-generic" class="carousel slide">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Carousel items -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="/res/img/slide1.png" alt="First slide" class="img-fluid img-responsive main-slide"/>
                    </div>
                    <div class="item">
                        <img src="/res/img/slide2.png" alt="Second slide" class="img-fluid img-responsive main-slide"/>
                    </div>
                    <div class="item">
                        <img src="/res/img/slide3.png" alt="Third slide" class="img-fluid img-responsive main-slide"/>
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                    <img src="/res/img/left.png" class="control">
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                    <img src="/res/img/right.png" class="control">
                </a>
            </div>
        </div>
    </body>
    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>
    <script>
        var msg = "${msg}";
        console.log("msg: "+msg);

        $(document).ready(function() {
            if(msg != "") {
                alert(msg);
                msg = "";
            }
        });

        $('.carousel').carousel();
    </script>
</html>