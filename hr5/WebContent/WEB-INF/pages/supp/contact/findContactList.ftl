<div class="operate" style="margin-bottom:10px;"><a class="btn btn_cc1" id="new_contract_button">新增</a></div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
	<input type="hidden" name ="supplierId" id="supplierId" value=${supplierId}>
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
        <tr>
	    	<th>联系人姓名</th>
	        <th>电话</th>
	        <th>性别</th>
	        <th>手机</th>
	        <th>职务</th>
	        <th>Email</th>
	        <th>地址</th>
	        <th>其他联系方式</th>
	        <th>联系人作用</th>
	        <th>状态</th>
	        <th>操作</th>
		</tr>
        </thead>
        <tbody>
			<#list pageParam.items as contact> 
			<tr>
			<td>${contact.name!''} </td>
			<td>${contact.tel!''} </td>
			<td><#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if> </td>
			<td>${contact.mobile!''} </td>
			<td>${contact.job!''} </td>
			<td>${contact.email!''} </td>
			<td>${contact.address!''} </td>
			<td>${contact.otherAddress!''} </td>
			<td>${contact.personDesc!''} </td>
			<td>
				<#if contact.cancelFlag == "Y"> 
				<span style="color:green" class="cancelProp">有效</span>
				<#else>
				<span style="color:red" class="cancelProp">无效</span>
				</#if>
			</td>
			<td class="oper">
				 <a href="javascript:void(0);" class="editContact" data="${contact.personId}">编辑</a>
                <#if contact.cancelFlag == "Y"> 
                    <a href="javascript:void(0);" class="cancelFlagContact" data="N" personId=${contact.personId}>设为无效</a>
                    <#else>
                    <a href="javascript:void(0);" class="cancelFlagContact" data="Y" personId=${contact.personId}>设为有效</a>
                 </#if>
            </td>
			</tr>
			</#list>
        </tbody>
</table>

</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->

<script>
var contractAddDialog,contractUpdateDialog;
$("#new_contract_button").click(function(){
	var supplierId = $("#supplierId").val();
	contractAddDialog = new xDialog("/vst_back/supp/contact/showAddContact.do",{"supplierId":supplierId},{title:"添加联系人",width:800});
});

$("a.editContact").click(function(){
	var personId = $(this).attr("data");
	contractUpdateDialog = new xDialog("/vst_back/supp/contact/showUpdateContact.do",{"personId":personId},{title:"修改联系人",width:800});
});

	//设置为有效或无效
$("a.cancelFlagContact").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var personId = entity.attr("personId");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/supp/contact/cancelContact.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"personId":personId},
			success : function(result) {
				if (result.code == "success") {
					 $.alert(result.message,function(){
					    if(cancelFlag == 'N'){
							entity.attr("data","Y");
							entity.text("设为有效");
							$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
						}else if(cancelFlag == 'Y'){
							entity.attr("data","N");
							entity.text("设为无效");
							$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
						}
					});
				}else {
					$.alert(result.message);
				}
			}
		});
	});
});	
</script>
