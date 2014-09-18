<!DOCTYPE html>
<html>
<head>
</head>
<body>
<!-- 订单详情页面EBK及传真列表查询 -->

<!-- 主要内容显示区域\\ -->
<form method="post"  id="editMemoForm">
<div class="iframe-content">   
	<div class="p_box"><strong>凭证方式：EBK</strong></div>  
    <div class="p_box">
    <table class="p_table table_center">
                <thead>
                    <tr>
                    <th>凭证类型</th>
                    <th>发送时间</th>
                    <th>处理时间</th>
                 	<th>处理结果</th>
                 	<th>供应商备注</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list ebkTaskList as ebk> 
					<tr>
						<td><#if ebk?? && ebk.ebkCertif??>
							<#list certifTypeList as list>
					            <#if ebk.ebkCertif.certifType?? && ebk.ebkCertif.certifType==list.code>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td>
						<#if ebk?? && ebk.ebkCertif.createTime??>${ebk.ebkCertif.createTime?string('yyyy-MM-dd HH:mm:ss')}</#if>
						</td>
						<td><#if ebk?? && ebk.ebkCertif.confirmTime??>${ebk.ebkCertif.confirmTime?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
						<td><#if ebk??>
							<#list ebkStatusList as list>
                    			<#if ebk.ebkCertif.certifStatus?? && list.code == ebk.ebkCertif.certifStatus>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><#if ebk?? && ebk.ebkCertif??>${ebk.ebkCertif.memo}</#if></td>
						<td><a href="javascript:void(0);" class="showEbkTask" data=${ebk.ebkTaskId!''}>查看</a>
						<#if ebk.ebkCertif.certifStatus??  && ebk.ebkCertif.certifStatus == 'CREATE'><a href="javascript:void(0);"  class="showEbkToFax" data=${ebk.ebkCertif.certifId!''}>转传真</a></#if>
						</td>
				     </tr>
					</#list>
                </tbody>
            </table>
        
	</div><!-- div p_box -->
</div>
<!-- //主要内容显示区域 -->
</form>


<form method="post"  id="editMemoForm">
<div class="iframe-content"> 
	<div class="p_box"><strong>凭证方式：传真</strong></div>  
    <div class="p_box">
    <table class="p_table table_center">
                <thead>
                    <tr>
                    <th>凭证类型</th>
                    <th>计划发送时间</th>
                 	<th>发送号码</th>
                 	<th>发送结果</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list ebkFaxTaskList as fax> 
					<tr>
						<td><#if fax?? && fax.ebkCertif??>
							<#list certifTypeList as list>
					            <#if fax.ebkCertif.certifType?? && fax.ebkCertif.certifType==list.code>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><#if fax?? && fax.planTime??>${fax.planTime?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.toFax}</#if></td>
						<td><#if fax??>
							<#list sendStatusList as list>
                    			<#if fax.sendStatus?? && list.status == fax.sendStatus>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><a href="javascript:void(0);" class="showFaxTask" data=${fax.faxTaskId!''}>查看</a>
						</td>
				     </tr>
					</#list>
                </tbody>
            </table>
        
	</div><!-- div p_box -->
</div>
<!-- //主要内容显示区域 -->
</form>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var forwardOrderFaxDialog;
$(function(){
		// 显示EBK信息

		var showEbkDialog;
		$("a.showEbkTask").bind("click",function(){
			var ebkTaskId = $(this).attr("data");
			showEbkDialog = new xDialog("/vst_back/ebooking/task/viewEbkDetail.do",{"ebkTaskId":ebkTaskId},{title:"查看订单",width:800});
		});  

		// 显示传真发送信息
		
		var showFaxDialog;
		$("a.showFaxTask").bind("click",function(){
			var faxTaskId = $(this).attr("data");
			showFaxDialog = new xDialog("/vst_back/ebooking/fax/showFax.do",{"faxTaskId":faxTaskId},{title:"查看传真",width:1200});
		}); 
		
		
		

		
		$("a.showEbkToFax").bind("click",function(){
			var certifId = $(this).attr("data");
			forwardOrderFaxDialog = new xDialog("/vst_order/order/orderStatusManage/showForwardSendOrderFax.do?orderId=${RequestParameters.orderId}",{"certifId":certifId},{title:"转传真",width:500});
		});
		

});
	
</script>


