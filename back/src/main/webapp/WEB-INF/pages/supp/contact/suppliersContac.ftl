
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
	<input type="hidden" name ="supplierId" id="supplierId" value=${supplierId}>
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
        <tr>
            <th>选择</th>
	    	<th>联系人姓名</th>
	        <th>电话</th>
	        <th>性别</th>
	        <th>职务</th>
	        <th>状态</th>
		</tr>
        </thead>
        <tbody>
			<#list contactList as contact> 
			<tr>
			<td>
			  <input type="checkbox"  name="personId" value="${contact.personId}">
			  <input type="hidden"  name="pname" value="${contact.name}">
			  <input type="hidden"  name="tel" value="${contact.tel}">
			  <input type="hidden"  name="sex" value="${contact.sex}">
			</td>
			<td>${contact.name!''} </td>
			<td>${contact.tel!''} </td>
			<td><#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if> </td>
			<td>${contact.job!''} </td>
			<td>
				<#if contact.cancelFlag == "Y"> 
				<span style="color:green" class="cancelProp">有效</span>
				<#else>
				<span style="color:red" class="cancelProp">无效</span>
				</#if>
			</td>
			</tr>
			</#list>
        </tbody>
</table>

</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<div class="operate"><a class="btn btn_cc1"  id="selectButton">确定</a></div>

<script>
var strs = '${pids}';
var arr = strs.split(',');
$('input[name="personId"]').each(function(){
     if($.inArray($(this).val(),arr)>-1)
     {
         $(this).attr("checked",true);
     } 
});

$("#selectButton").bind("click",function(){
     
     var oo = $('input[name="personId"]:checked');
     if(oo.size()==0)
     {
        $.alert("请选择联系人");
		return;
     }
     var contacts = [];
     
     $('input[name="personId"]:checked').each(function(){  
             var obj = $(this).parent("td");
             var contact = {};
             contact.personId = $(this).val();
             contact.pname = obj.find("input[name='pname']").val();
             contact.tel = obj.find("input[name='tel']").val();
             contact.sex = obj.find("input[name='sex']").val();
             if(contact.sex=='MAN' )
             {
                contact.sex='先生';
             }
             if(contact.sex=='WOMAN' )
             {
                contact.sex='女士';
             }
             contacts.push(contact);
     });
	 onSelectContact(contacts);

});

</script>
