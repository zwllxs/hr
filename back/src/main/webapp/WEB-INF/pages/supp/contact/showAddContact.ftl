<form action="#" method="post" id="contactAddForm">
	<input type="hidden" name="supplierId" value="${supplierId}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label"><span class="notnull">*</span>姓名：</td>
                <td>
                	<input type="text" name="name" required=true>
                </td>
                <td class="p_label"><span class="notnull">*</span>电话：</td>
                <td>
                	<input type="text" name="tel" required=true>
                </td>
            </tr> 
			<tr>
				<td class="p_label">性别：</td>
                <td>
                	<input type="radio" name="sex" value="MAN" checked="checkede">先生&nbsp;&nbsp;<input type="radio" name="sex" value="WOMAN">女士
                </td>
                <td class="p_label"><span class="notnull">*</span>手机：</td>
                <td>
                	<input type="text" name="mobile" required=true>
                </td>
            </tr>
            <tr>
                <td class="p_label">Email：</td>
                <td>
                	<input type="text" name="email">
                </td>
                <td class="p_label"><span class="notnull">*</span>联系人作用：</td>
                <td>
                	<input type="text" name="personDesc" required=true>
                </td>
            </tr>
            <tr>
                <td class="p_label">其它联系方式：</td>
                <td>
                	<input type="text" name="otherAddress">
                </td>
                <td class="p_label">职务：</td>
                <td>
                	<input type="text" name="job">
                </td>
            </tr>
            <tr>
             <td class="p_label">地址：</td>
                <td>
                	<input type="text" name="address">
                </td>
            </tr>
        </tbody>
    </table>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="contactSaveButton">保存</button>
<script>
$("#contactSaveButton").bind("click",function(){
	if(!$("#contactAddForm").validate().form()){
		return;
	}
	$.ajax({
		   url : "/vst_back/supp/contact/addContact.do",
		   data : $("#contactAddForm").serialize(),
		   type:"POST",
		   dataType:"JSON",
		   success : function(result){
		   		if(result.code = "success"){
		   			$.alert(result.message,function(){
		   				contractAddDialog.close();
		   				contactListDialog.reload();
		   			});
		   		}else {
		   			$.alert(result.message);
		   		}
		   }
	});
});
</script>