<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<!-- 订单详情页面传真查询 -->
<#if RequestParameters.source!="orderHotelDetails" > 

<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">传真管理</a> &gt;</li>
            <li class="active">传真列表</li>
        </ul>
</div>
 	<div class="price_tab">
        <ul class="J_tab ui_tab">   
        
            <li <#if tabNo==null || tabNo==1>class="active"</#if>><a href="javascript:;" name="tabChange" data=0>传真查询</a></li>
            
            <li <#if tabNo?? && tabNo==2>class="active"</#if>><a href="javascript:;" name="tabChange" data=1>发送成功未回传</a></li>
        </ul>
     </div>
<div class="iframe_search">
		<form method="post" action='/vst_back/ebooking/fax/findEbkFaxList.do' id="searchForm">
		<input type="hidden" id="tabNo" name="tabNo" value="${tabNo!''}">
        <table class="s_table">
            <tbody>
                <tr>
                    <td class="s_label">订单号:</td>
                    <td class="w18"><input type="text" name="orderId" value="${ordEbkFaxVO.orderId!''}"></td>
                    <td class="s_label">产品名称:</td>
                    <td class="w18"><input type="text" name="productName" value="${ordEbkFaxVO.productName!''}" ></td>
					<td class="s_label">供应商名称:</td>
                    <td class="w18"><input type="text" name="supplierName" value="${ordEbkFaxVO.supplierName!''}" ></td>
                    <td class="s_label">供应商传真号码:</td>
                    <td class="w18"><input type="text" name="toFax" value="${ordEbkFaxVO.toFax!''}" ></td>
                </tr>
                <tr>
                	<td class="s_label">游玩人:</td>
                    <td class="w18"><input type="text" name="travellerName" value="${ordEbkFaxVO.travellerName!''}"></td>
                 	<td class="s_label">发送方式:</td>
                   	<td class="w18">
	                   	<select name="autoFlag">
	                   		<option value=""></option>
	                   		<option value="Y" <#if ordEbkFaxVO.autoFlag?? && ordEbkFaxVO.autoFlag == 'Y'>selected</#if>>自动发送</option>
			                <option value="N" <#if ordEbkFaxVO.autoFlag?? && ordEbkFaxVO.autoFlag == 'N'>selected</#if>>人工发送</option>
	                   	</select>
                   	</td>
                    <td class="s_label">计划发送时间:</td>
                    <td colspan=3><input type="text" <#if ordEbkFaxVO.planTimeStart??> value="${ordEbkFaxVO.planTimeStart?string('yyyy-MM-dd HH:mm:ss')}"</#if> name="planTimeStart" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                     ~ <input type="text" <#if ordEbkFaxVO.planTimeEnd??> value="${ordEbkFaxVO.planTimeEnd?string('yyyy-MM-dd HH:mm:ss')}"</#if> name="planTimeEnd" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/></td>
                   
                </tr>
                <tr>
                 	<td class="s_label">实际发送时间:</td>
                    <td colspan=3><input type="text" <#if ordEbkFaxVO.sendTimeStart??> value="${ordEbkFaxVO.sendTimeStart?string('yyyy-MM-dd HH:mm:ss')}"</#if> name="sendTimeStart" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                     ~ <input type="text" <#if ordEbkFaxVO.sendTimeEnd??> value="${ordEbkFaxVO.sendTimeEnd?string('yyyy-MM-dd HH:mm:ss')}"</#if> name="sendTimeEnd" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/></td>
                 	<td class="s_label">传真类型:</td>
                 	<td class="w18">
                 		<select name="certifType" id="certifType">
                   			<option value=""></option>
		            		<#list certifTypeList as list>
					            <option value="${list.code!''}" <#if ordEbkFaxVO.certifType?? && ordEbkFaxVO.certifType==list.code>  selected </#if>>${list.cnName!''}</option>
					        </#list>
                		</select>
                 	</td>
                 	<td class="s_label"></td>
                 	<td class="w18"></td>
                </tr>
               	<tr>
                	<td class="s_label" width='50'>品类：</td>
                    <td colspan=7>
                			<#list bizCategoryList as list>
                				<#if list.categoryCode!='category_single_ticket' && list.categoryCode!='category_other_ticket' && list.categoryCode!='category_comb_ticket'>
	                				<input type="checkbox" name="categoryId" value="${list.categoryId}"
	                    				<#list ordEbkFaxVO.categoryIds as categoryId>
	            								 <#if categoryId?? && list.categoryId == categoryId>checked</#if>
	            						</#list>
	            					>${list.categoryName!''}
                				</#if>
                			</#list>
                    </td>
                </tr>
                <tr name="showflag1">
                	<td class="s_label">传真状态：</td>
                    <td colspan=5>
                    		<#assign count = 0>
                    		<#list sendStatusList as list>
                    				<#assign count = count+1>
                    				<#if count lt 10>
                    				<input type="checkbox" name="sendStatus" value="${list.status}"
                    				<#list ordEbkFaxVO.sendStatuss as sendStatus>
            								 <#if sendStatus?? && list.status == sendStatus>checked</#if>
            						</#list>
            						>${list.cnName!''}
            						</#if>
					        </#list>
                    </td>
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10"></td>
                </tr>
                <tr name="showflag1">
                	<td class="s_label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td colspan=5>
                   		 	<#assign count = 0>
                    		<#list sendStatusList as list>
                    				<#assign count = count+1>
                    				<#if count gte 10>
                    				<input type="checkbox" name="sendStatus" value="${list.status}"
                    				<#list ordEbkFaxVO.sendStatuss as sendStatus>
            								 <#if sendStatus?? && list.status == sendStatus>checked</#if>
            						</#list>
            						>${list.cnName!''}
            						</#if>
					        </#list>
                    </td>
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button1">查询</a></td>
                </tr>
                <tr name="showflag2">
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button2">查询</a></td>
                </tr>
            </tbody>
        </table>	
		</form>
    </div>
<#else>
         	  
</#if>	

<!-- 主要内容显示区域\\ -->
 <form method="post"  id="editMemoForm">
<div class="iframe-content">   
    <#if pageParam??>
    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
    <div class="p_box">
    <table class="p_table table_center">
                <thead>
                    <tr>
<#if RequestParameters.source=="orderHotelDetails" > 
					<th>凭证编号</th>
                    <th>传真类型</th>
                    <th>计划发送时间</th>
                    <th>实际发送时间</th>
                    <th>供应商名称</th>
                 	<th>传真号码</th>
                 	<th>品类</th>
                 	<th>状态  </th>
                    <th>操作</th>

<#else>
                	<th>凭证编号</th>
                    <th>传真类型</th>
                    <th>内部备注</th>
                    <th>订单号</th>
                    <th>产品名称</th>
                    <th>出游日期</th>
                    <th>计划发送时间</th>
                    <th>发送方式</th>
                	<th>供应商名称</th>
                 	<th>传真号码</th>
                 	<th>发送次数</th>
                 	<th>品类</th>
                 	<th>状态  </th>
                    <th>操作</th>
</#if>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as fax> 
					<tr>
<#if RequestParameters.source=="orderHotelDetails" > 

						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.certifId!''}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>
							<#list certifTypeList as list>
					            <#if fax.ebkCertif.certifType?? && fax.ebkCertif.certifType==list.code>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><#if fax?? && fax.planTime??>${fax.planTime?string('yyyy-MM-dd HH:ss')}</#if></td>
						<td><#if fax?? && fax.sendTime??>${fax.sendTime?string('yyyy-MM-dd HH:ss')}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.supplierName}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.toFax}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.categoryName}</#if></td>
						<td><#if fax??>
							<#list sendStatusList as list>
                    			<#if fax.sendStatus?? && list.status == fax.sendStatus>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><a href="javascript:void(0);"  target="_blank" class="showFaxTask" data=${fax.faxTaskId!''}>查看内容</a>
						<a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${fax.faxTaskId},'objectType':'EBK_FAX_TASK'}">操作日志</a> 
						</td>
						
<#else>

						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.certifId!''}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>
							<#list certifTypeList as list>
					            <#if fax.ebkCertif.certifType?? && fax.ebkCertif.certifType==list.code>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.memo!''}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>
								<#if fax.ebkCertif.ebkCertifItemList?size &gt; 1>
										<table width="100%" height="100%" style="border:0">
											<tbody>
										<#list fax.ebkCertif.ebkCertifItemList as ebkCertifItem> 
										    <#if ebkCertifItem_index+1 ==fax.ebkCertif.ebkCertifItemList?size>
												<tr style="background:none;"><td style="border-left:0; border-right:0; border-bottom:0;">${ebkCertifItem.orderId}</td></tr>
											<#else> 
												<tr style="background:none;"><td style="border-top:0; border-left:0; border-right:0;">${ebkCertifItem.orderId}</td></tr>
											</#if>
										</#list>
											</tbody>
										</table>
								<#else>
									<#list fax.ebkCertif.ebkCertifItemList as ebkCertifItem>
										<#if ebkCertifItem_index ==0>
											${ebkCertifItem.orderId}
										</#if>
									</#list>
								</#if>
							</#if></td>
						<td><#if fax?? && fax.ebkCertif??>
							<#if fax.ebkCertif.categoryCode=='category_comb_cruise'>
								${fax.ebkCertif.productName}
							<#elseif fax.ebkCertif.ebkCertifItemList?size &gt; 1>
								<table width="100%" height="100%" style="border:0;">
									<tbody>
								<#list fax.ebkCertif.ebkCertifItemList as ebkCertifItem> 
								    <#if ebkCertifItem_index+1 ==fax.ebkCertif.ebkCertifItemList?size>
										<tr style="background:none;"><td style="border-left:0; border-right:0; border-bottom:0;">${ebkCertifItem.productName}</td></tr>
									<#else> 
										<tr style="background:none;"><td style="border-top:0; border-left:0; border-right:0;">${ebkCertifItem.productName}</td></tr>
									</#if>
								</#list>
									</tbody>
								</table>
							<#else>
								<#list fax.ebkCertif.ebkCertifItemList as ebkCertifItem> 
									<#if ebkCertifItem_index ==0>
										${ebkCertifItem.productName}
									</#if>
								</#list>
							</#if>
							</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.visitTime?string('yyyy-MM-dd')}</#if></td>
						<td><#if fax?? && fax.planTime??>${fax.planTime?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
						<td><#if fax??><#if fax.autoFlag=='Y'>自动发送<#elseif fax.autoFlag=='N'>人工发送</#if></#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.supplierName}</#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.toFax}</#if></td>
						<td><#if fax??><a href="javascript:void(0)" class="showFaxSend" ebkFaxTaskId="${fax.faxTaskId}" ebkCertificateId="${fax.certifId}">${fax.sendCount}</a></#if></td>
						<td><#if fax?? && fax.ebkCertif??>${fax.ebkCertif.categoryName}</#if></td>
						<td><#if fax??>
							<#list sendStatusList as list>
                    			<#if fax.sendStatus?? && list.status == fax.sendStatus>${list.cnName!''}</#if>
					        </#list>
							</#if>
						</td>
						<td><a href="javascript:void(0);"  target="_blank" class="showFaxTask" data=${fax.faxTaskId!''} >查看传真</a>
						<#if fax?? && (fax.sendStatus=='0')>
							<a name="unSend" href="javascript:void(0);" data=${fax.faxTaskId!''} >设为不发送</a>
						<#elseif fax.sendStatus!='-1' && fax.againFlag!='Y'>
							<a name="reSend" href="javascript:void(0);" data=${fax.faxTaskId!''} >重新发送</a>
						</#if>
						<#if fax?? && fax.recvId??><a href="/vst_back/ebooking/faxRecv/showFaxRecvFileDetail.do?recvId=${fax.recvId!''}">查看回传件</a></#if>
						<a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${fax.faxTaskId},'objectType':'EBK_FAX_TASK'}">操作日志</a> 
						</td>
					</tr>

</#if>
					</#list>
                </tbody>
            </table>
<#if RequestParameters.source!="orderHotelDetails" > 
				<#if pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
						</div> 
				</#if>
</#if>
        
	</div><!-- div p_box -->
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关传真，重新输入相关条件查询！</div>
    </#if>
    </#if>
</div>
<!-- //主要内容显示区域 -->
	</form>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
$(function(){
		// 显示传真发送信息
		$(".showFaxSend").bind("click", function() {
			var ebkFaxTaskId = $(this).attr("ebkFaxTaskId");
			var ebkCertificateId = $(this).attr("ebkCertificateId");
			var url = "/vst_back/ebooking/fax/showFaxSend.do";
			new xDialog(url,{"faxTaskId":ebkFaxTaskId,"certifId":ebkCertificateId}, {title:"传真发送日志",width:1000});
		});	

		<#if tabNo?? && tabNo==2>
		$("tr[name='showflag2']").show();
		$("tr[name='showflag1']").hide();
		<#else>
		$("tr[name='showflag1']").show();
		$("tr[name='showflag2']").hide();
		</#if>
		$("a.showFaxTask").bind("click",function(){
			var faxTaskId = $(this).attr("data");
			this.href="/vst_back/ebooking/fax/showFax.do?faxTaskId="+faxTaskId;
			//window.location.href="/vst_back/ebooking/fax/showFax.do?faxTaskId="+faxTaskId;
		});
		

	//查询
	$("#search_button1").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#tabNo").val('1');
		$("#searchForm").submit();
	});
	
	$("#search_button2").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#tabNo").val('2');
		$("#searchForm").submit();
	});
	
		//设置传真编号选择,全选
		$("input[type=checkbox][name=faxTaskIdAll]").click(function(){
			if($(this).attr("checked")=="checked"){
				$("input[type=checkbox][name=faxTaskId]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=faxTaskId]").removeAttr("checked");
			}
		})
		
		
		 //设置传真编号选择,单个元素选择
		$("input[type=checkbox][name=faxTaskId]").click(function(){
			if($("input[type=checkbox][name=faxTaskId]").size()==$("input[type=checkbox][name=faxTaskId]:checked").size()){
				$("input[type=checkbox][name=faxTaskIdAll]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=faxTaskIdAll]").removeAttr("checked");
			}
		});
		
		$("#editMemo").bind("click",function(){
			if($("input[type=checkbox][name=faxTaskId]:checked").size() == 0){
				$.alert("请先选择传真号！");
			}
		 	$.confirm("确定提交？", function () {
			$.ajax({
				url : "/vst_back/ebooking/fax/updateFaxMemo.do",
				type : "post",
				dataType:"JSON",
				data : $("#editMemoForm").serialize(),
				success : function(result) {
				if (result.code == "success") {
					$("#search_button").click();
				}else {
					$.alert(result.message);
				}
				}
			});
			});	
		});	
		
		$("a[name='unSend']").bind("click",function(){
			var faxTaskId = $(this).attr("data");
		 	$.confirm("确定修改？", function () {
			$.ajax({
				url : "/vst_back/ebooking/fax/updateFaxTask.do?faxTaskId="+faxTaskId+"&disableFlag=Y",
				type : "post",
				dataType:"JSON",
				async:false,
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message, function () {
						if($("#tabNo").val()=='1'){
							$("#search_button1").click();
						}else{
							$("#search_button2").click();
						}
					});
				}else {
					$.alert(result.message);
				}
				}
			});
			});	
		});	
		
		$("a[name='reSend']").bind("click",function(){
			var faxTaskId = $(this).attr("data");
		 	$.confirm("确定修改？", function () {
			$.ajax({
				url : "/vst_back/ebooking/fax/updateFaxTask.do?faxTaskId="+faxTaskId+"&againFlag=Y",
				type : "post",
				dataType:"JSON",
				async:false,
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message, function () {
						if($("#tabNo").val()=='1'){
							$("#search_button1").click();
						}else{
							$("#search_button2").click();
						}
					});
				}else {
					$.alert(result.message);
				}
				}
			});
			});	
		});
		
		//tab切换
		$("a[name=tabChange]").click(function(){
			if($(this).attr("data")==0){
				$("#tabNo").val('1');
				$(this).parent().next().removeClass();
				$(this).parent().addClass('active');
				$("#search_button1").click();
			}else {
				$("#tabNo").val('2');
				$(this).parent().prev().removeClass();
				$(this).parent().addClass('active');
				$("#search_button2").click();
			}
		})
});
	
</script>


