<form  id="dataForm">
	<input type="hidden" name="categoryId" value="${bizCatePropGroup.categoryId}">
	<input type="hidden" name="groupId" value="${bizCatePropGroup.groupId!''}">
	<table class="p_table form-inline">
		<tr>
			<td class="p_label">分组名称：<span class="notnull">*</span></td><td ><input type="text" name="groupName" required=true value="${bizCatePropGroup.groupName!''}">&nbsp;&nbsp;
		</tr>
		<tr>
			<td class="p_label">排序值：</td><td><input type="text" number="true" name="seq" value="${bizCatePropGroup.seq!''}"></td>
		</tr>
	</table>
</form>

<!--<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>-->

<script>

//添加属性分组
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return false;
	}
	$.confirm("确认修改吗 ？", function () {
		$.ajax({
		url : "/vst_back/biz/categoryPropGroup/updateCategoryPropGroup.do",
		type : "post",
		dataType:"json",
		async: false,
		data : $("#dataForm").serialize(),
		success : function(result) {
		   if(result.code=="success"){
					$.alert(result.message,function(){
			   				updateDialog.close();
			   				window.location.reload();
	   			});
				}else {
					$.alert(result.message);
		   		}
		   }
		});
	});						
});

</script>