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
                <!-- product_name -->
                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">상품명</b>
                    </span>
                    <span class="col-md-10">
                        <input class="inputBox" name="product_name" type="text" maxlength="50"/>
                    </span>
                </div>
                <!-- // product_name -->

                <!-- product_photo -->
                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">상품 대표 사진</b>
                    </span>
                    <span class="col-md-10">
                        <label class="btn-custom" for="input_imgs" style="cursor:pointer; text-align:center;">파일 첨부(jpg, gif, png / 최대 3장까지 가능합니다.)</label>
                        <input type="file" id="input_imgs" style="display: none;" multiple/>
                    </span>
                </div>
				<!-- // product_photo -->

                <!-- Preview Area -->
                <div id="preview" class="row" style="display: none; margin-bottom: 40px;">
                    <!--
                        append Data
                    -->
                </div>
                <!-- // Preview Area -->

                <!-- product_content -->
                <div class="row" style="margin-bottom: 40px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">내용</b>
                    </span>
                    <span class="col-md-10">
                        <textarea id="writeContent" class="writeContentArea" onKeyUp="lenCheck()"></textarea>
                    </span>
                </div>
                <!-- // product-content -->

                <div style="margin-bottom: 40px;"></div>

                <!-- product_category 1 -->
                <div class="row" style="margin-bottom: 30px;">
                    <span class="col-md-2 input-title">
                        <b class="product-header">1차 분류</b>
                    </span>
                    <span class="col-md-10">
                        <select id="category" onchange="selectCategory()">
                            <option value="1" selected>의류</option>
                            <option value="2">인형/피규어</option>
                            <option value="3">리빙</option>
                        </select>
                    </span>
                </div>
                <!-- // product-category 1 -->

                <!-- product-category 2 -->
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
                <!-- // product-category 2 -->

                <button id="registBtn" class="btn-custom" onclick="registProduct()">상품 등록</button>
            </div>
        </div>
    </body>

    <footer class="footer-custom">
            All contents copyright&#169; 2019 sungwon.kim
    </footer>

    <script>
        // ref : https://extracold.tistory.com/40
        var files = {};
        var previewIndex = 0;

        // image Preview 기능
        function addPreview(input) {
            if (input[0].files) {
                // 파일 선택이 여러 개라면,
                for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
                    var file = input[0].files[fileIndex];

                    if (validation(file.name))
                        continue;

                    var reader = new FileReader();

                    reader.onload = function(img) {
                        var imgNum = previewIndex++;
                        var str = "";

                        str += "<span class='preview-box col-md-4' value='"+imgNum+"'>";
                        str += "<img class='thumbnail' src='"+img.target.result+"' style='width:150px; height:150px; margin-left:auto; margin-right:auto; display:block;'/>";
                        str += "<p class='fileName'>"+file.name+"</p>";
                        str += "<a class='fileDeleteBtn' href='#' value='"+imgNum+"' onclick='deletePreview(this)'>";
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

        // preview 영역에서 삭제 버튼 클릭 시 해당 미리보기 이미지 및 이미지 영역 삭제
        function deletePreview(obj) {
            var imgNum = obj.attributes['value'].value;
            delete files[imgNum];


            $("#preview .preview-box[value=" + imgNum + "]").remove();
            previewIndex--;

            if(previewIndex == 0) {
                $("#preview").css("display", "none");
            }
        }

        // client-side validation
        // always server-side validation required
        function validation(fileName) {
            fileName = fileName + "";
            var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
            var fileNameExtension = fileName.toLowerCase().substring(
                    fileNameExtensionIndex, fileName.length);
            if (!((fileNameExtension === 'jpg')
                    || (fileNameExtension === 'gif') || (fileNameExtension === 'png'))) {
                alert('jpg, gif, png 확장자만 업로드 가능합니다.');
                return true;
            } else {
                return false;
            }
        }


        // todo 작업중(다중 파일 업로드)
        $(document).ready(function() {
            selectCategory();


            //submit 등록. 실제로 submit type은 아니다.
            $('.submit a').on('click',function() {
                var form = $('#uploadForm')[0];
                var formData = new FormData(form);

                for (var index = 0; index < Object.keys(files).length; index++) {
                    //formData 공간에 files라는 이름으로 파일을 추가한다.
                    //동일명으로 계속 추가할 수 있다.
                    formData.append('files',files[index]);
                }

                //ajax 통신으로 multipart form을 전송한다.
                $.ajax({
                    type : 'POST',
                    enctype : 'multipart/form-data',
                    processData : false,
                    contentType : false,
                    cache : false,
                    timeout : 600000,
                    url : '/imageupload',
                    dataType : 'JSON',
                    data : formData,
                    success : function(result) {
                        //이 부분을 수정해서 다양한 행동을 할 수 있으며,
                        //여기서는 데이터를 전송받았다면 순수하게 OK 만을 보내기로 하였다.
                        //-1 = 잘못된 확장자 업로드, -2 = 용량초과, 그외 = 성공(1)
                        if (result === -1) {
                            alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.');
                            // 이후 동작 ...
                        } else if (result === -2) {
                            alert('파일이 10MB를 초과하였습니다.');
                            // 이후 동작 ...
                        } else {
                            alert('이미지 업로드 성공');
                            // 이후 동작 ...
                        }
                    }
                    //전송실패에대한 핸들링은 고려하지 않음
                });
            });


            // 파일 첨부 시 동작
            $('input[type=file]').change(function() {
                $("#preview").css("display", "block");  // display none -> block

                addPreview($(this)); // preview에 사진 추가
            });
        });


        // textarea 글자수 제한(완)
        function lenCheck() {
            var content = $("#writeContent").val();

            if(content.length >= 1000) {
                var content = $("#writeContent").val();
                content = content.substring(0, 999);
                $("#writeContent").val(content);
                alert("1000자 이상 입력할 수 없습니다.");
            }
        }

        // todo - 상품 등록 버튼을 눌렀을 때(작업중)
        function registProduct() {
            if($("input[name='product_name']").val() == "") {
                alert("상품명을 입력해주세요.");
            } else if(previewIndex == 0) {
                alert("상품 대표 사진을 첨부해주세요. (최소 1장)");
            }
        }


        // 1차 카테고리를 선택했을 때 작업(완)
		function selectCategory() {
			$("#subcategory option").remove();  // 기존 옵션 삭제

			$.ajax({
                type : "post",
                url : "./selectCategory",
                data : {
                    category_no : $("#category option:selected").val()
                },
                dataType : "json",
                success : function(data) {
                    printCategory(data.list);
                },
                error : function(error) {
                    console.log(error);
                }
            });
		}

		function printCategory(list) {
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

    </script>
</html>