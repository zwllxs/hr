<form  id="dataForm">
	<input type="hidden" name="categoryId" value="${bizBranch.categoryId}">
	<input type="hidden" name="branchId" value="${bizBranch.branchId!''}">
	<table class="p_table form-inline">
		<tr>
			<td class="p_label">名称：<span class="notnull">*</span></td><td><input type="text" name="branchName" required=true value="${bizBranch.branchName!''}"></td>
		</tr>
		<tr>
		<td class="p_label">类型：<span class="notnull">*</span></td><td class=" operate mt10">
			<select name="attachFlag" required=true>
				  <option value="Y" ${(bizBranch.attachFlag== "Y")?string("selected", "")}>主规格</option>
				  <option value="N" ${(bizBranch.attachFlag== "N")?string("selected", "")}>次规格</option>				  
			</select>
		</tr>
		<tr>
			<td class="p_label">代码：<span class="notnull">*</span></td><td><input type="text" name="branchCode" required=true value="${bizBranch.branchCode!''}"></td>
		</tr>
	</table>
</form>

<script>
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
			return false;
	}
	$.confirm("确认修改吗 ？", function () {
	$.ajax({
		url : "/vst_back/biz/branch/updateBranch.do",
		type : "post",
		dataType:"json",
		async: false,
		data : $("#dataForm").serialize(),
		success : function(result) {
		   if(result.code=="success"){
				$.alert(result.message,function(){
	   				updateBranchDialog.close();
	   				branchListDialog.reload();
   				});
				}else {
					$.alert(result.message);
		   		}
		   }
		});
	});						
});

</script>