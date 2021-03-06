<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>
<link href="/resources/css/w3school.css" rel="stylesheet" type="text/css" />
<style>
* {
	margin: 0;
	padding: 0;
}

.table-x {
	margin-left: 30px;
}

.jb-x-small {
	font-size: x-small;
}

.text-x {
	text-align: right;
	vertical-align: bottom;
}

a {
	text-decoration-line: none;
	color: black;
}

.line {
	border-bottom: 1px solid black;
}

.table1 {
	border-bottom: 1px solid #dddbdb;
	margin-left: 15px;
	margin-right: 15px;
	width:470px;
}

input {
	border: none;
	border-right: 0px;
	border-top: 0px;
	width: 470px;
	height: 30px;
	font-size: 15px;
}

textarea {
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	width: 470px;
	height: 50px;
	resize: none;
	font-size: 15px;
	margin-top:10px;
}

.btn_submit {
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 40px;
	height: 35px;
	cursor: pointer;
	outline: 0;
	float: right;
	margin-top: 16px;
	margin-bottom: 9px;
	margin-right: 10px;
	outline: 0;
	border: 0;
}

.btn_remove {
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 40px;
	height: 38px;
	cursor: pointer;
	outline: 0;
	float: right;
	margin-top: 15px;
	margin-right: 10px;
	outline: 0;
	border: 0;
}

input:focus {
	outline: none;
}

textarea:focus {
	outline: none;
}
input[type=text] {
 
  font-size : 16px;
  margin: 8px 0;
  box-sizing: border-box;
}

.inputstyle {
  border-radius: 5px;
  background-color: white;

}

textarea {
  height: 300px;
  box-sizing: border-box;
  border: 2px solid white;
  border-radius: 4px;
  background-color: white;
  font-size: 16px;
  resize: none;
  width:470px;
}
.uploadResult {
	width: 100%;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 110px;
	height: 100px;
}
.attach {
	width: 42px;
	height: 42px;
	margin-left: 10px;
}
.button{
background-color : white;
border : 0;
outline : 0;
cursor : pointer;
}
</style>



<div class="carousel-item active"></div>

<%@include file="../layout/header3.jsp"%>

<form role="form" action="/board/modify" method="post">
<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					
	<sec:authentication property = "principal" var = "pinfo"/>
	<sec:authorize access = "isAuthenticated()">
	<c:if test = "${pinfo.username eq board.userId }">				
	<button type="submit" data-oper='modify' class='btn_submit'>
		<img src="../resources/images/community/submit.png">
	</button>
	</c:if>
	</sec:authorize>
	<input type="hidden" name="bno" readonly="readonly"
		value='<c:out value = "${board.bno }"/>'>
		<input type = "hidden" name = 'pageNum' value = '<c:out value = "${cri.pageNum }"/>'>
		<input type = "hidden" name = 'amount' value = '<c:out value = "${cri.amount }"/>'>
		<!-- ???????????? ?????? ?????? -->
		<input type = 'hidden' name = 'keyword' value = '<c:out value = "${cri.keyword }"/>'>
        <input type = 'hidden' name = 'type' value = '<c:out value = "${cri.type }"/>'>
        
	<table class="table1">

		<tr>
			<td style="font-weight: bold; border-bottom: 1px solid #dddbdb;">
			<input type="text" name="title" style = "font-size: 20px; margin-top:33px"
				value='<c:out value = "${board.title }"/>'></td>
		</tr>
	
		<tr>
			<td><textarea name="content"><c:out
						value="${board.content }" /></textarea></td>
		</tr>


	</table>

	
	<table style = "height : 150px;">
		<tr>
			<td><a id="" href="javascript:fnUpload();"><img
					src="../resources/images/community/attach.png" alt="????????????"
					class="attach" /></a> <input name="uploadFile" type="file"
				id="fileUpload" style="display: none; float : top;" multiple 
				onchange="$('#fileNm').val(this.value)" /></td>
			<!-- <td><input type="text" id="fileNm" readonly
				style="margin-left: 10px; margin-top: 20px;"
				placeholder="????????? ??????????????????" /></td> -->
				
	
		<td><div class = "uploadResult">
					<ul></ul></div></td>
						</tr>
	</table>

	<input type="hidden" name="userId" readonly="readonly"
		value='<c:out value = "${board.userId }"/>'>
		
	<sec:authentication property = "principal" var = "pinfo"/>
	<sec:authorize access = "isAuthenticated()">
	<c:if test = "${pinfo.username eq board.userId }">		
	<button type="submit" data-oper='remove' class='btn_remove'>
		<img src="../resources/images/community/remove.png">
	</button>
	</c:if>
	</sec:authorize>
</form>

<script type="text/javascript">
function fnUpload() {

	$('#fileUpload').click();

}
		$(document).ready(function() {
			var formObj = $("form");
			
			$('button').on("click", function(e) {
				e.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
				
				if (operation === 'remove') {
					formObj.attr("action", "/board/remove");
				} else if(operation === 'modify') {
					console.log("submit clicked");
					var str = "";
					
					$(".uploadResult ul li").each(function(i, obj){
						var jobj = $(obj);
						console.dir(jobj);
						
						str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '" + jobj.data("filename")+"'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '" + jobj.data("uuid") + "'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '" + jobj.data("path") + "'>";
						str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '" + jobj.data("type") + "'>";
				
					});
					formObj.append(str);
				}
				 
				formObj.submit();
			});//submit button click event
			
			//????????? ?????? ??? ?????? ?????? ????????? JSON ???????????? ???????????? ????????? ??????
			   var bno = '<c:out value = "${board.bno}"/>';
			    $.getJSON("/board/getAttachList", {bno : bno}, function(arr) {
			    	console.log(arr);
			    	
			    	 var str = "";
						$(arr).each(function(i, obj) {
							if(!obj.fileType) {	//???????????? ?????? ??????
								
								  var fileCallPath = encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
								  str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='"
						          + obj.fileName + "'data-type='" + obj.fileType + "'><div>";
						          str += "<span> "+ obj.fileName+"</span>";
						          str += "<button class = 'button' type='button' data-file=\'"+ fileCallPath +"\' data-type='file'>&nbsp;X</button><br>";
						          str += "<img src='/resources/images/attach.png'>";
						          str += "</div></li>";
						        
					    		   
							} else { //???????????? ??????
								
								  var fileCallPath = encodeURIComponent( obj.uploadPath+"/s_"+ obj.uuid +"_"+obj.fileName);            
						          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						          str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='"
						          + obj.fileName + "'data-type='" + obj.fileType + "'><div>";				       
						          str += "<span> "+ obj.fileName+"</span>";
						          str += "<button class = 'button' type='button' data-file=\'"+ fileCallPath +"\' data-type='file'>&nbsp;X</button><br>";
						          str += "<img src='/display?fileName="+ fileCallPath +"'>";
						          str += "</div></li>";
							}
						});
						$(".uploadResult ul").html(str);
			    	
			    });
			
			//uploadAjax??? checkExtension ?????? ??????
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB

			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("?????? ????????? ??????");
					return false;
				}

				if (regex.test(fileName)) {
					alert("?????? ????????? ????????? ????????? ??? ??? ??????");
					return false;
				}
				return true;
			}//checkExtension

			var csrfHeaderName = "${_csrf.headerName}";
		    var csrfTokenValue = "${_csrf.token}";
			$("input[type='file']").change(function(e) {
				//FormData ??????
				var formData = new FormData();
				//????????? ??????
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;

				//formData??? ??????????????? ??????
				for (var i = 0; i < files.length; i++) {
					//????????? ???????????? ?????? ??????
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					beforeSend: function(xhr){
			               xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			           },
					dataType : 'json',
					success : function(result) {
					
						console.log(result);
						showUploadedFile(result);
					}
				});//$.ajax
				
				 //???????????? ????????? ??????, ????????? ?????? ?????? ???
				   
				function showUploadedFile(uploadResultArr){
					  if(!uploadResultArr || uploadResultArr.length == 0){return ;}
					  var uploadUL = $(".uploadResult ul");
					  var str = "";
					$(uploadResultArr).each(function(i, obj) {
						if(!obj.image) {	//???????????? ?????? ??????
							
							  var fileCallPath = encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
							  str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='"
					          + obj.fileName + "'data-type='" + obj.image + "'><div>";
					          str += "<span> "+ obj.fileName+"</span>";
					          str += "<button class = 'button' type='button' data-file=\'"+ fileCallPath +"\' data-type='file'>&nbsp;X</button><br>";
					          str += "<img src='/resources/images/attach.png'>";
					          str += "</div></li>";
					        
				    		   
						} else { //???????????? ??????
							
							  var fileCallPath = encodeURIComponent( obj.uploadPath+"/s_"+ obj.uuid +"_"+obj.fileName);            
					          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					          str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='"
					          + obj.fileName + "'data-type='" + obj.image + "'><div>";				          
					          str += "<span> "+ obj.fileName+"</span>";
					          str += "<button class = 'button' type='button' data-file=\'"+ fileCallPath +"\' data-type='image'>&nbsp;X</button><br>";
					          str += "<img src='/display?fileName="+ fileCallPath +"'>";
					          str += "</div></li>";
						}
					});
					uploadUL.append(str);
				}//showUploadedFile
			
			});

			    $(".uploadResult").on("click", "button", function(e){
				      if(confirm("??? ???????????? ????????????????????????? ")){
				         var targetLi = $(this).closest("li");
				         targetLi.remove();
				      }
				   }); //uploadResult click event
			
		});//end javascript
	
	
</script>

</body>
</html>