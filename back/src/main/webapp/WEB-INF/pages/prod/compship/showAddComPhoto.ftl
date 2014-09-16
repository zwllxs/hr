<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div id="add">
	<form action="#" id="addForm">
	<table class="p_table form-inline">
        <tbody>
            <tr>
            	<td class="p_label">选择图片：</td>
                <td>
                	<input type="file" id="file" serverType="COM_AFFIX"/>图片大小：480x320
                </td>
            </tr>
        </tbody>
	</table>
	</form>
</div>
<div id="showAdd">
	<form action="#" method="post" id="addComPhotoForm">
	<input type="hidden" value="${objectType!''}" name="objectType"  id="objectType"/>
	<input type="hidden" value="${objectId!''}" name="objectId"  id="objectId"/>
	<table class="p_table form-inline">
        <tbody>
            <tr>
            	<td class="p_label">选择类型：</td>
                <td>
					<select id="photoType" name="photoType">
						<option value=""></option>
						<#list typelist as type>
							<option value="${type.type!''}">${type.cnName!''}</option>
						</#list>
					</select>
                </td>
            </tr>
            <tr>
            	<td class="p_label">选择名称：</td>
                <td>
					<input type="text" id="photoContent" name="photoContent"/>
					<button class="pbtn pbtn-small btn-ok" style="float:right;" id="addButton">保存</button>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
					<button class="pbtn pbtn-small btn-ok" id="addPhotoButton">保存</button>
                </td>
            </tr>
            <tr>
            	<td colspan="2">
					<div id="imgDiv" style="overflow:scroll;height: 400px;width: 800px;"></div>
            	</td>
            </tr>
        </tbody>
	</table>
	</form>
</div>
<div id="resultDiv" style="display:none;"></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script src="/vst_back/js/file/ajaxUpload.js"></script>
<script>
var basePath="";
$("#file").fileUpload({
	onSubmit:function() {
		$("#file").attr("disabled", true);
		$("#photoUrl").remove();
	},
	action:"/vst_back/prod/compship/upload.do",
	onComplete:function(file,dt){
		var data = eval("("+dt+")");
		if(data.success){
			$(data.attributes.photoUrl).each(function(i, val){
				if(!$("#photoUrl").size()) {
					$("#photoType").after($("<input type='hidden' name='photoUrl' id='photoUrl' value='" + val + "'/>"));
				}
				$("#imgDiv").append("<br/><span>第"+i+"张图：</span>");
				$("#imgDiv").append($("<img>").attr("src","http://pic.lvmama.com"+val));
			});
			$("#file").removeAttr("file");
		}else{
			alert(data.message);
		}
	}
 });
$("#addComPhotoForm #addPhotoButton").bind('click',function(){
	if(!$("#photoUrl").size()) {
		return false;
	}
	$.ajax({
		url : "/vst_back/prod/compship/addComPhoto.do",
		type : "post",
		dataType:"json",
		async: false,
		data : $("#addComPhotoForm").serialize(),
		success : function(result) {
		   if(result.code=="success"){
				alert(result.message);
   				parent.window.location.reload();
   				parent.comPhotoAddDialog.close();
			}else {
				alert(result.message);
	   		}
		}
	});
});
</script>


