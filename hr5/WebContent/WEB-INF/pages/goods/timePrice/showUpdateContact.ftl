<form action="#" method="post" id="contactUpdateForm">
	<input type="hidden" name="personId" value="${contact.personId}">
    <table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label">姓名：</td>
                    <td>
                    	<input type="text" name="name" value=${contact.name}>
                    </td>
                    <td class="p_label">电话：</td>
                    <td>
                    	<input type="text" name="tel" value=${contact.tel}>
                    </td>
                </tr> 
				<tr>
					<td class="p_label">性别：</td>
                    <td>
                    	<input type="radio" name="sex" value="MAN" <#if contact.sex == "MAN" >checked="checked"</#if> >先生&nbsp;&nbsp;<input type="radio" name="sex" value="WOMAN" <#if contact.sex == "WOMAN" >checked="checked"</#if>>女士
                    </td>
                    <td class="p_label">手机：</td>
                    <td>
                    	<input type="text" name="mobile" value=${contact.mobile}>
                    </td>
                </tr>
                <tr>
                    <td class="p_label">Email：</td>
                    <td>
                    	<input type="text" name="email" value=${contact.email}>
                    </td>
                    <td class="p_label">联系人作用：</td>
                    <td>
                    	<input type="text" name="personDesc" value=${contact.personDesc}>
                    </td>
                </tr>
                <tr>
                    <td class="p_label">其它联系方式：</td>
                    <td>
                    	<input type="text" name="otherAddress" value=${contact.otherAddress}>
                    </td>
                    <td class="p_label">职务：</td>
                    <td>
                    	<input type="text" name="job" value=${contact.job}>
                    </td>
                </tr>
                <tr>
                    
                </tr>
            </tbody>
        </table>
</form>
<div class="fl operate"><a class="btn btn_cc1" id="contactUpdateButton">修改</a></div>
<script>
		$("#contactUpdateButton").bind("click",function(){
			$.ajax({
				   url : "/vst_back/supp/contact/updateContact.do",
				   data : $("#contactUpdateForm").serialize(),
				   type:"POST",
				   success : function(result){
				   		if(result.code = "SUCCESS"){
				   			contractUpdateDialog.close();
				   			contactListDialog.reload();
				   		}else {
				   			alert(result.message);
				   		}
				   }
			});
		});
</script>