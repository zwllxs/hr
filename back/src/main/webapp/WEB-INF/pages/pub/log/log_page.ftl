<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>  
<div class="iframe-content"> 
	<#if pageParam.items?? &&  pageParam.items?size &gt; 0>  
		<div style="overflow:scroll;height: 680px;">
			<table style="width:100%" class="log_table table_center">
				<tr>
					<th width="150px">创建时间</th>
					<th width="300px">操作人</th>
					<th>操作内容</th>
				</tr>
				<#list pageParam.items as log>
				<tr>
					<td>${log.createTime?string("yyyy-MM-dd HH:mm:ss")}</td>
					<td>
					<span style="font-weight:bold">
					${log.operatorName!''}</span>-<span>${log.logName!''}
					</span>
					</td>
					<td>${log.content!''}</td>
				</tr>
				</#list>
			</table>
			<#if pageParam.items?exists> 
						<div class="paging" > 
						${pageParam.getPagination()}
						</div> 
			</#if>
		</div>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无操作日志  ！</div>
	</#if>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>