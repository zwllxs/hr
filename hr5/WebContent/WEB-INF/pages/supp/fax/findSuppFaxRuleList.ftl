<div class="operate" style="margin-bottom:10px;"><a class="btn btn_cc1" id="new_button" data=${suppFaxRule.supplierId}>新增</a></div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                	<th>编号</th>
                    <th>品类</th>
                    <th>名称</th>
                    <th>传真号码</th>
                    <th>发送时间</th>
                    <th>备注</th>
                    <th>是否体现结算价</th>
                    <th>状态</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as suppFaxRule> 
					<tr>
					<td>${suppFaxRule.faxRuleId!''} </td>
					<td>${suppFaxRule.categoryName!''} </td>
					<td>${suppFaxRule.faxRuleName!''}</td>
					<td>${suppFaxRule.fax!''}</td>
					<td>${suppFaxRule.sendTimeCn!''}</td>
					<td>${suppFaxRule.faxDesc!''}</td>
					<td>
						<#if suppFaxRule.showSettleFlag == "Y"> 
						<span style="color:green" >是</span>
						<#else>
						<span style="color:red" >否</span>
						</#if>
					</td>
					<td>
						<#if suppFaxRule.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProp">有效</span>
						<#else>
						<span style="color:red" class="cancelProp">无效</span>
						</#if>
					</td>
					
					<td class="oper">
                        <a href="javascript:void(0);" class="editProp" data=${suppFaxRule.faxRuleId}>编辑</a>
                 		<#if suppFaxRule.cancelFlag == "Y"> 
                            <a href="javascript:void(0);" class="cancelProp" data="N" faxRuleId=${suppFaxRule.faxRuleId}>设为无效</a>
                            <#else>
                            <a href="javascript:void(0);" class="cancelProp" data="Y" faxRuleId=${suppFaxRule.faxRuleId}>设为有效</a>
                         </#if>
                     </td>
                     </tr>
					</#list>
                </tbody>
            </table>
			 <#if pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
						</div> 
				</#if>
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->

<script>

var addDialog,updateDialog;

//新建传真

$("#new_button").bind("click",function(){
	var supplierId = $(this).attr("data");
	addDialog = new xDialog("/vst_back/supp/fax/showAddSuppFaxRule.do",{"supplierId":supplierId}, {title:"添加",width:800});
});


//修改传真

$("a.editProp").bind("click",function(){
	var suppFaxRuleId  = $(this).attr("data");
	updateDialog = new xDialog("/vst_back/supp/fax/showUpdateSuppFaxRule.do",{"suppFaxRuleId":suppFaxRuleId}, {title:"修改",width:800});
});


//设置为有效或无效
	$("a.cancelProp").bind("click",function(){
		var entity = $(this);
		var cancelFlag = entity.attr("data");
		var faxRuleId = entity.attr("faxRuleId");
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/supp/fax/cancelSuppFaxRule.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"faxRuleId":faxRuleId},
			success : function(result) {
			if(result.code == "success"){
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
