<form action="#" method="post" id="contactUpdateForm">
	<input type="hidden" name="personId" value="${contact.personId}">
    <table class="p_table form-inline">
    <tbody>
        <tr>
			<td class="p_label"><span class="notnull">*</span>姓名：</td>
            <td>
            	<input type="text" name="name" value=${contact.name} required=true>
            </td>
            <td class="p_label"><span class="notnull">*</span>电话：</td>
            <td>
            	<input type="text" name="tel" value=${contact.tel} required=true>
            </td>
        </tr> 
		<tr>
			<td class="p_label">性别：</td>
            <td>
            	<input type="radio" name="sex" value="MAN" <#if contact.sex == "MAN" >checked="checked"</#if> >先生&nbsp;&nbsp;<input type="radio" name="sex" value="WOMAN" <#if contact.sex == "WOMAN" >checked="checked"</#if>>女士
            </td>
            <td class="p_label"><span class="notnull">*</span>手机：</td>
            <td>
            	<input type="text" name="mobile" required=true value=${contact.mobile}>
            </td>
        </tr>
        <tr>
            <td class="p_label">Email：</td>
            <td>
            	<input type="text" name="email" value=${contact.email}>
            </td>
            <td class="p_label"><span class="notnull">*</span>联系人作用：</td>
            <td>
            	<input type="text" name="personDesc" required=true value=${contact.personDesc}>
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
         <td class="p_label">地址：</td>
            <td>
            	<input type="text" name="address" value=${contact.address}>
            </td>
        </tr>
    </tbody>
</table>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="contactUpdateButton">保存</button>
<script>
$("#contactUpdateButton").bind("click",function(){
	if(!$("#contactUpdateForm").validate().form()){
		return;
	}
	$.confirm("确认修改吗 ？", function () {
	$.ajax({
		   url : "/vst_back/supp/contact/updateContact.do",
		   data : $("#contactUpdateForm").serialize(),
		   type:"POST",
		   dataType:"JSON",
		   success : function(result){
		   		if(result.code = "success"){
		   			$.alert(result.message,function(){
			   			contractUpdateDialog.close();
			   			contactListDialog.reload();	
		   			});
		   		}else {
		   			$.alert(result.message);
		   		}
		   }
	});
	});
});
</script>