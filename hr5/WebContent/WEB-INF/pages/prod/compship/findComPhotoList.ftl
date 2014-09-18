<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:700px;">
<div class="operate" style="margin-bottom:10px;">
<a class="btn btn_cc1" id="new_button" onclick="addComPhoto()" href="javascript:void(0);">新增</a>
</div>
<input type="hidden" value="${objectType!''}" name="objectType"  id="objectType"/>
<input type="hidden" value="${objectId!''}" name="objectId"  id="objectId"/>
<input type="hidden" value="${compShipPhotoSize!''}" id="compShipPhotoSize"/>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
	    <thead>
	        <tr>
	    	<th>编号</th>
	        <th>名称</th>
	        <th>类型</th>
	        <th>操作</th>
	        </tr>
	    </thead>
	    <tbody>
			<#list list as item> 
			<tr>
				<td>${item.photoId!''} </td>
				<td>${item.photoContent!''} </td>
				<td>${item.photoTypeCN!''}</td>
				<td>
					<a href="javascript:void(0);" onclick="showComPhoto('${item.photoId!''}')" class="cancel">查看</a>
					<a href="javascript:void(0);" onclick="deletePhoto('${item.photoId!''}')" class="cancel">删除</a>
				</td>
	        </tr>
			</#list>
	    </tbody>
	</table>
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	$(document).ready(function(){
		var compShipPhotoSize = $('#compShipPhotoSize').val();
		var new_button = $('#new_button');
		if(compShipPhotoSize>=4){
			new_button.removeAttr('href');
		}
	})
	
	function deletePhoto(id) {
		if(!id) {
			return false;
		}
		$.ajax({
			url : "/vst_back/pub/comphoto/deleteComPhoto.do?id="+id,
			type : "get",
			dataType:"json",
			async: false,
			success : function(result) {
			   if(result.code=="success"){
					alert(result.message);
	   				window.location.reload();
				}else {
					alert(result.message);
		   		}
			}
	   });
	}
	function addComPhoto() {
		if($("#objectType").val() != "" && $("#objectId").val() != "") {
			var url = "/vst_back/prod/compship/showAddComPhoto.do?objectType="+$("#objectType").val()+"&objectId="+$("#objectId").val();
			comPhotoAddDialog = new xDialog(url,{},{title:"图片"+$("#objectId").val(),iframe:true,width:600,height:600});
		}
	}
	function showComPhoto(id) {
		if(id) {
			var url = "/vst_back/pub/comphoto/showComPhotoByPhotoId.do?id="+id;
			comPhotoShowDialog = new xDialog(url,{},{title:"图片"+$("#objectId").val(),iframe:true,width:600,height:600});
		}
	}
</script>
