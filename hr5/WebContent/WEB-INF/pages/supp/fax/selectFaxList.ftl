<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                    <th></th>
                	<th>编号</th>
                    <th>品类</th>
                    <th>名称</th>
                    <th>传真号码</th>
                    <th>发送时间</th>
                    <th>是否体现结算价</th>
                    <th>备注</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as suppFaxRule> 
					<tr>
					<td><input type="radio" name="suppFaxRule">
					<input type="hidden" name="faxRuleId" value="${suppFaxRule.faxRuleId!''}">
					<input type="hidden" name="categoryName" value="${suppFaxRule.categoryName!''}">
					<input type="hidden" name="faxRuleName" value="${suppFaxRule.faxRuleName!''}">
					<input type="hidden" name="fax" value="${suppFaxRule.fax!''}">
					<input type="hidden" name="sendTime" value="${suppFaxRule.sendTime!''}">
					</td>
					<td>${suppFaxRule.faxRuleId!''} </td>
					<td>${suppFaxRule.categoryName!''} </td>
					<td>${suppFaxRule.faxRuleName!''}</td>
					<td>${suppFaxRule.fax!''}</td>
					<#if suppFaxRule.sendTime=="IMMEDIATELY"><td>立即发送</td>
					<#elseif suppFaxRule.sendTime=="MANUAL_SEND"><td>人工发送</td>
					<#elseif suppFaxRule.sendTime=="VISIT_DAY_8"><td>履行当天8点</td>
					<#elseif suppFaxRule.sendTime=="PREVIOUS_ONEDAY_12"><td>履行前一天12点</td>
					<#elseif suppFaxRule.sendTime=="PREVIOUS_ONEDAY_16"><td>履行前一天16点</td>
					<#else><td></td>
					</#if>
					<td>
						<#if suppFaxRule.showSettleFlag == "Y"> 
						<span style="color:green" >是</span>
						<#else>
						<span style="color:red" >否</span>
						</#if>
					</td>
					<td>${suppFaxRule.faxDesc!''}</td>
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
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	//选择一个Item
	$("input[type='radio']").bind("click",function(){
	var radio  = $("input:radio:checked");
	if(radio.size()==0){
		alert("请选择传真");
		return;
	}
		var obj = radio.parent("td");
		var suppFaxRule = {};
		suppFaxRule.faxRuleId = $("input[name='faxRuleId']",obj).val();
    	suppFaxRule.categoryId = $("input[name='categoryId']",obj).val();
    	suppFaxRule.faxRuleName = $("input[name='faxRuleName']",obj).val();
    	suppFaxRule.fax = $("input[name='fax']",obj).val();
    	suppFaxRule.sendTime = $("input[name='sendTime']",obj).val();
	    //传递选择的faxRule对象回传给父窗口函数
	    <#if callback??>
			parent.${callback}(suppFaxRule);
		<#else>
			parent.onSelectSuppFaxRule(suppFaxRule);
		</#if>
});
</script>
