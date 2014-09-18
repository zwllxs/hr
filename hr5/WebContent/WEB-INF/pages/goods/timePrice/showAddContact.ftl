<form action="#" method="post" id="contactAddForm">
	<input type="hidden" name="supplierId" value="${supplierId}">
    <table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label">姓名：</td>
                    <td>
                    	<input type="text" name="name">
                    </td>
                    <td class="p_label">电话：</td>
                    <td>
                    	<input type="text" name="tel">
                    </td>
                </tr> 
				<tr>
					<td class="p_label">性别：</td>
                    <td>
                    	<input type="radio" name="sex" value="MAN">先生&nbsp;&nbsp;<input type="radio" name="sex" value="WOMAN">女士
                    </td>
                    <td class="p_label">手机：</td>
                    <td>
                    	<input type="text" name="mobile" >
                    </td>
                </tr>
                <tr>
                    <td class="p_label">Email：</td>
                    <td>
                    	<input type="text" name="email">
                    </td>
                    <td class="p_label">联系人作用：</td>
                    <td>
                    	<input type="text" name="personDesc">
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
                    
                </tr>
            </tbody>
        </table>
</form>
<div class="fl operate"><a class="btn btn_cc1" id="contactSaveButton">添加</a></div>
<script>
		$("#contactSaveButton").bind("click",function(){
			$.ajax({
				   url : "/vst_back/supp/contact/addContact.do",
				   data : $("#contactAddForm").serialize(),
				   type:"POST",
				   success : function(result){
				   		if(result.code = "SUCCESS"){
				   			contractAddDialog.close();
				   			contactListDialog.reload();
				   		}else {
				   			alert(result.message);
				   		}
				   }
			});
		});
</script>