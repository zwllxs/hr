<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<!-- 订单详情页面查回传-->
<#if RequestParameters.source!="orderHotelDetails" > 

<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li> 
            <#if ebkFaxVO.readUserStatus =="Y">
            <li class="active">已读取的传真回传件</li>
            <#else>
             <li class="active">未读取的传真回传件</li>
            </#if>
        </ul>
</div>
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/ebooking/faxRecv/findEbookingFaxRecvList.do"  method="post">
		<table border="0" cellpadding="0" style="width:1000px;">
			<tr>
				<td>&nbsp;</td>
				<td>订单号:
					<input class="ggbt_w330" type="text" name="orderId" maxlength="150" value="${ebkFaxVO.orderId}"/>
				&nbsp;发送号码:
					<input class="ggbt_w330" type="text" name="callerId" maxlength="150" value="${ebkFaxVO.callerId}"/>
				&nbsp;接收时间:
					<input type="text" <#if ebkFaxVO.recvBeginTime??> value="${ebkFaxVO.recvBeginTime?string('yyyy-MM-dd HH:mm')}"</#if> name="recvBeginTime" errorEle="selectDate" class="Wdate input-text" id="recvBeginTime" onFocus="WdatePicker({readOnly:true})" />
                	 - 
                	<input type="text" <#if ebkFaxVO.recvEndTime??> value="${ebkFaxVO.recvEndTime?string('yyyy-MM-dd HH:mm')}"</#if> name="recvEndTime" errorEle="selectDate" class="Wdate input-text" id="recvEndTime" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'recvBeginTime\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'recvBeginTime\',{d:0});}'})" />
				</td>								
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="hidden" name="readUserStatus" value="${ebkFaxVO.readUserStatus}"/>
					<input type="hidden" id="isCancelFlag" value="${ebkFaxVO.cancelFlag}"/>
					&nbsp;
				</td>
			</tr>			
			<tr>
				<td>关联状态:</td>
				<td>
					<input class="ggbt_w330" id="selectALL" type="checkbox" />&nbsp;全部
					<input class="ggbt_w330" id="LINKED" type="checkbox" name="resultStatus" value="LINKED"/>&nbsp;手动已关联
					<input class="ggbt_w330" id="AUTO_LINKED" type="checkbox" name="resultStatus" value="AUTO_LINKED"/>&nbsp;自动已关联 
					<input class="ggbt_w330" id="NOT_LINKED" type="checkbox" name="resultStatus" value="NOT_LINKED"/>&nbsp;未关联 
				</td>								
			</tr>	
			<tr>
				<td>&nbsp;</td>
				<td>
                	<#if ebkFaxVO.readUserStatus =="Y">
                		<input class="ggbt_w330" id="N" type="checkbox" name="cancelFlag" value="N"/>&nbsp;删除记录
					</#if>					
				</td>								
			</tr>					
			<tr align="center">
				<td colspan="6">
					<input type="submit" class="u10 btn btn-small" value="查询">
				</td>
			</tr>			
		</table>
	</form>
</div>

<#else>
         	  
</#if>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                    <!-- 订单详情页面查回传-->
<#if RequestParameters.source=="orderHotelDetails" > 
	                	<th>发送号码</th>
	                    <th>接收时间</th>
	                    <th>操作</th>
<#else>
         	  			<th>发送号码</th>
	                    <th>接收时间</th>
         	  			<th>订单号</th>
	                    <th>订单创建时间</th>	                    
	                    <th>产品名称</th>	                    
	                    <th>品类</th>	                    
	                    <th>关联状态</th>	                    
	                    <th>操作</th>
</#if>
	                	
                    </tr>
                </thead>
                <tbody>
                	<#list pageParam.items as faxRecv>
						<tr>
<#if RequestParameters.source=="orderHotelDetails" > 
			                <td>
			                	${faxRecv.callerId!''}
			                </td>
			                <td>
			                	<#if faxRecv.recvTime??>${faxRecv.recvTime?string('yyyy-MM-dd')}</#if>
			                </td>
			                <td>
			                	<a  target="_blank"  href="/vst_back/ebooking/faxRecv/showFaxRecvFileDetail.do?recvId=${faxRecv.recvId!''}">查看&nbsp;</a>
			                </td>
<#else>
			                <td>
			                	${faxRecv.callerId!''}
			                </td>
			                <td>
			                	<#if faxRecv.recvTime??>${faxRecv.recvTime?string('yyyy-MM-dd HH:mm')}</#if>
			                </td>
			                <td>
			                	<#list faxRecv.ebkFaxRecvLinks as link>
			                		<#list link.ebkCertifItemList as item>
			                		<#if item_index ==0>
										${item.orderId!''}
									</#if>
			                		</#list>
			                	</#list>						
							</td>
			                <td>
			                	<#list faxRecv.ebkFaxRecvLinks as link>
			                		<#list link.ebkCertifItemList as item>
			                			<#if item_index ==0>
											${item.orderCreateTime?string('yyyy-MM-dd HH:mm')}
										</#if>
			                		</#list>
			                	</#list>			                	
			               	 </td>
			                <td>
			                	<#list faxRecv.ebkFaxRecvLinks as link>
			                		<#if link.ebkCertif?? && link.ebkCertif.categoryCode=='category_comb_cruise'>
			                			${link.ebkCertif.productName}
			                		<#else>
				                		<#list link.ebkCertifItemList as item>
				                			<#if item_index ==0>
				                				${item.productName!''}
				                			</#if>
				                		</#list>
			                		</#if>
			                	</#list>				                
			               	 </td>	               	 
			                <td>
			                	<#list faxRecv.ebkFaxRecvLinks as link>
			                		${link.categoryName!''}
			                	</#list> 
			                </td>
			                <td>
			                	<#if faxRecv.recvStatus =="LINKED">
			                	手动已关联
			                	<#elseif faxRecv.recvStatus=='AUTO_LINKED'>
			                	自动已关联
			                	<#elseif faxRecv.recvStatus=='NOT_LINKED'>
			                	未关联 
								</#if>		
			                </td>
			                <td>
			                	<#if faxRecv.recvStatus =="NOT_LINKED">
			                		<#if faxRecv.cancelFlag =="Y">
			                			<a  target="_blank"  href="/vst_back/ebooking/faxRecv/showFaxRecvFileDetail.do?recvId=${faxRecv.recvId!''}">查看&nbsp;</a>
			                		</#if>
			                		 <#if faxRecv.cancelFlag =="Y" || ebkFaxVO.cancelFlag==null>
			                			<a href="javascript:void(0)" onclick="updateEbkFaxRecvCancelFlag(${faxRecv.recvId!''});">删除记录&nbsp;</a>
			                		</#if>
			                		  
			                	<#else>
									<a  target="_blank"  href="/vst_back/ebooking/faxRecv/showFaxRecvFileDetail.do?recvId=${faxRecv.recvId!''}">查看&nbsp;</a>
									
								</#if>
								<a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${faxRecv.recvId!''},'objectType':'EBK_FAX_TASK'}">操作日志</a>
			                </td>
</#if>
						</tr>						
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
</div>
<!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	$(function(){
	    // 加载关联状态
		var status = '${ebkFaxVO.resultStatus}';
		var readUserStatus = '${ebkFaxVO.readUserStatus}';
		var str = new Array();
		str = status.split(","); 
		for(var i = 0;i<str.length;i++){
			$("#"+str[i]).attr("checked", true);
		}
		if(str.length==4){
			$("#selectALL").attr("checked", true);
		}
		
		var isCancelFlag = $('#isCancelFlag').val();
		$("#"+isCancelFlag).attr("checked", true);
		
		$("#selectALL").bind("click",function(){
			if(($('#selectALL').attr("checked")=='checked')==true){
				$("input[name='resultStatus']").attr("checked",true);
			}else{
				$("input[name='resultStatus']").attr("checked",false);
			}		
		});
	});
	
	// 逻辑删除任务回传信息
	function updateEbkFaxRecvCancelFlag(recvId){
		$.confirm("确认删除吗 ？", function () {
			$.ajax({
				url : "/vst_back/ebooking/faxRecv/updateEbkFaxRecvCancelFlag.do",
				type : "post",
				data : {recvId:recvId},
				success : function(result) {
					$("#searchForm").submit();
				}
			});	
	   });
	}
</script>
