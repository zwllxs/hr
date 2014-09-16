<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe-content">   
	<div class="p_box">
		<table class="p_table table_center">
			<tr>
				<th>发送编号</th>
				<th>发送传真号</th>	
				<th>请求发送时间</th>
				<th>实际发送时间</th>
				<th>发送状态</th>
				<th>操作人</th>
			</tr>
			<#list pageParam.items as faxSend> 
				<tr>
					<td>${faxSend.faxSendId }</td>
					<td>${faxSend.toFax }</td>
					<td>
						<#if faxSend.createTime??>
							${faxSend.createTime?string('yyyy-MM-dd HH:mm:ss')}
						</#if>
					</td>
					<td>
						<#if faxSend.sendTime??>
							${faxSend.sendTime?string('yyyy-MM-dd HH:mm:ss')}
						</#if>					
					</td>
					<td>${faxSend.ebkFaxSendStatusCN}</td>
					<td>${faxSend.operator }</td>
				</tr>
			</#list>
		</table>
		<#if pageParam.items?exists> 
			<div class="paging" > 
				${pageParam.getPagination()}
			</div> 
		</#if>		
		<br/>
		<#if ebkFaxRecvs?? && ebkFaxRecvs?size gt 0> 
			<div class="p_box" > 
				<table class="p_table table_center">
					  <tbody>
							<tr>
								<th>传真编号</th>
								<th>发送号码</th>
								<th>接收时间</th>
								<th>传真文件</th>
								<th>操作</th>
							</tr>
							<#list ebkFaxRecvs as recv> 
								<tr>
								  <td>${recv.recvId }</td>
								  <td>${recv.callerId }</td>
								  <td>
										<#if recv.recvTime??>
											${recv.recvTime?string('yyyy-MM-dd HH:mm:ss')}
										</#if>										  
								  </td>
								  <td>${recv.fileUrl }</td>
								  <td><a href="javascript:void(0);" target="_blank" class="showFaxReceiveFile2" data="${recv.recvId }">查看回传件</a></td>
								</tr>
							</#list>
					 </tbody>
				</table>
			</div> 
		</#if>
	</div>
	</div>
	<div id="show_receive_file_div2" url="${basePath }/fax/faxReceive/showFaxRecvFileDetail.do"></div>
	<#include "/base/foot.ftl"/>
	<script type="text/javascript">
		$(function(){
			 $(".showFaxReceiveFile2").bind("click", function() {
				var data = $(this).attr("data");
				if (data == undefined || data == null || data == "") {
					alert("无法查看该回传件！");
					return false;
				}
				var url = "/vst_back/ebooking/faxRecv/showFaxRecvFileDetail.do?recvId="+data;
				this.href=url;
			 });
		});
	</script>
</body>

