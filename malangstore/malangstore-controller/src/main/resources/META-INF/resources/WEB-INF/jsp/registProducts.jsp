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
            select { width: 100%; height: 50px; padding-left: 10px; font-family: 'NanumsquareR'; font-size: 18px; font-weight: 600; color: #000; border: 1px solid gray; }
            select option { font-family: 'NanumsquareR'; font-size: 15px; font-weight: 600; }
		</style>
    </head>
    <body>
        <jsp:include page="nav-bar.jsp" flush="false"/>

        <div class="container">
            <h1 class="text-header-custom">상품 등록</h1>
            <hr style="padding: 1px; margin: 0px 0px 50px 0px;">

            <div class="col-md-12">
                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">상품명</b>
                    </span>
                    <span class="col-md-10">
                        <input class="inputBox" name="product-name" type="text" maxlength="50"/>
                    </span>
                </div>

                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">상품 대표 사진</b>
                    </span>
                    <span class="col-md-10">
                        <label class="btn-custom" for="input-imgs" style="cursor:pointer; text-align:center;">파일 첨부(jpg, gif, png / 최대 3장까지 가능합니다.)</label>
                        <input type="file" id="input-imgs" style="display: none;" multiple/>
                    </span>
                </div>

                <div id="preview" class="row" style="display: none; margin-bottom: 40px;">
                    <!--
                        append Data
                    -->
                </div>

				<form id="uploadForm" style="display: none;"></form>

                <div class="row" style="margin-bottom: 40px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">내용</b>
                    </span>
                    <span class="col-md-10">
                        <textarea id="write-content" class="write-content-area" onkeyup="lenCheck()"></textarea>
                    </span>
                </div>

                <div style="margin-bottom: 40px;"></div>

                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">상품 판매 가격</b>
                    </span>
                    <span class="col-md-10">
                        <input class="inputBox" name="product-price" type="text" maxlength="8" numberonly />
                    </span>
                </div>

                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">배송비</b>
                    </span>
                    <span class="col-md-10">
                        <input class="inputBox" name="product-delivery" type="text" maxlength="6" numberonly />
                    </span>
                </div>

                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">1차 분류</b>
                    </span>
                    <span class="col-md-10">
                        <select id="category" onchange="getSubCategories()">
                            <option value="1" selected>의류</option>
                            <option value="2">인형/피규어</option>
                            <option value="3">리빙</option>
                        </select>
                    </span>
                </div>

                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">2차 분류</b>
                    </span>
                    <span class="col-md-10">
                        <select id="subcategory">
                            <!--
                                append Data
                            -->
                        </select>
                    </span>
                </div>

                <button id="registBtn" class="btn-custom" onclick="newProduct()">상품 등록</button>
            </div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>

    <script>
        var files = {};
        var previewIndex = 0;


		$(document).ready(function() {
            getSubCategories();
        });


		/* 파일 첨부 시 동작 */
		$('input[type=file]').change(function() {
            $("#preview").css("display", "block");  // display none -> block
            addPreview($(this));                    // preview에 사진 추가
        });


        /* image Preview */
        function addPreview(input) {
            if (input[0].files) {
                // 파일 선택이 여러 개라면,
                for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
                    var file = input[0].files[fileIndex];

					// 파일 이름 유효성 검사
                    if (validation(file.name)) {
                        continue;
                    }

                    var reader = new FileReader();

                    reader.onload = function(img) {
                        var imgNum = previewIndex++;
                        var str = "";

                        str += "<span class='preview-box col-md-4' value='"+imgNum+"'>";
                        str += "<img class='thumbnail' src='"+img.target.result+"' style='width:150px; height:150px; margin-left:auto; margin-right:auto; display:block;'/>";
                        str += "<p class='file-name'>"+file.name+"</p>";
                        str += "<a class='file-delete-btn' href='#' value='"+imgNum+"' onclick='deletePreview(this)'>";
                        str += "삭제</a></span>";

                        $("#preview").append(str);

                        files[imgNum] = file;
                    };
                    reader.readAsDataURL(file);
                }
            } else {
                alert('invalid file input');
            }
        }


        /* preview 영역에서 삭제 버튼 클릭 시 해당 미리보기 이미지 및 이미지 영역 삭제 */
        function deletePreview(obj) {
            var imgNum = obj.attributes['value'].value;
            delete files[imgNum];

            $("#preview .preview-box[value=" + imgNum + "]").remove();
            previewIndex--;

            if(previewIndex == 0) {
                $("#preview").css("display", "none");
            }
        }


		/* 파일 이름 유효성 검사 */
        function validation(fileName) {
            fileName = fileName + "";
            var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
            var fileNameExtension = fileName.toLowerCase().substring(fileNameExtensionIndex, fileName.length);
            if (!((fileNameExtension === 'jpg') || (fileNameExtension === 'gif') || (fileNameExtension === 'png'))) {
                alert('jpg, gif, png 확장자만 업로드 가능합니다.');
                return true;
            } else {
                return false;
            }
        }


        /* 상품 등록 버튼을 눌렀을 때 유효성 검사 후 상품 등록 */
        function newProduct() {
            if($("input[name='product-name']").val() == "") {
                alert("상품명을 입력해주세요.");
            } else if(previewIndex == 0) {
                alert("상품 대표 사진을 첨부해주세요. (최소 1장)");
            } else if($("input[name='product-price']").val() == "") {
                alert("상품 판매가를 입력해주세요.");
            } else if($("input[name='product-delivery']").val() == "") {
                alert("배송비를 입력해주세요.");
            } else {
				var form = $('#uploadForm')[0];
                var formData = new FormData(form);

                for (var index = 0; index < Object.keys(files).length; index++) {
                    formData.append("files", files[index]); // formData 공간에 files라는 이름으로 파일을 추가한다. (동일명으로 계속 추가 가능)
                }

                formData.append("product_name", $("input[name='product-name']").val());         // 상품명
                formData.append("product_detail",  $("#write-content").val());                  // 상품 상세 내용
                formData.append("product_price", $("input[name='product-price']").val());       // 상품 판매가
                formData.append("product_delivery", $("input[name='product-delivery']").val()); // 상품 배송비
                formData.append("subcategory_no", $("#subcategory option:selected").val());     // 서브 카테고리 번호

                $.ajax({
                    type : 'post',
                    enctype : 'multipart/form-data',
                    processData : false,
                    contentType : false,
                    url : '/newProduct',
                    dataType : 'JSON',
                    data : formData,
                    success : function(data) {
                        if(data.success == 1) {
                            alert("상품 등록에 성공했습니다.");
                            location.href = "./";
                        } else {
                            alert("상품 등록에 실패했습니다.");
                        }
                    },
                    error : function(error) {
                        console.log(error);
                    }
                });
            }
        }


        /* 1차 카테고리를 선택했을 때 2차 카테고리 추가 */
		function getSubCategories() {
			$("#subcategory option").remove();  // 기존 2차 카테고리 제거

			$.ajax({
                type : "post",
                url : "./getSubCategories",
                data : {
                    category_no : $("#category option:selected").val()
                },
                dataType : "json",
                success : function(data) {
                    appendCategory(data.list);
                },
                error : function(error) {
                    console.log(error);
                }
            });
		}


		/* textarea 글자수 제한 */
        function lenCheck() {
            var content = $("#write-content").val();

            if(content.length >= 1000) {
                var content = $("#write-content").val();
                content = content.substring(0, 999);
                $("#write-content").val(content);
                alert("1000자 이상 입력할 수 없습니다.");
            }
        }


		/* 2차 카테고리 추가 */
		function appendCategory(list) {
			var str = "";

            for(var i=0; i<list.length; i++) {
                if(i==0) {
                    str += "<option value='"+list[i].subcategory_no+"' selected>"+list[i].subcategory_name+"</option>";
                } else {
                    str += "<option value='"+list[i].subcategory_no+"'>"+list[i].subcategory_name+"</option>";
                }
            }

            $("#subcategory").append(str);
		}


        /* 숫자가 아닌 나머지 문자를 공백으로 처리 */
        $("input:text[numberOnly]").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });
    </script>
</html>