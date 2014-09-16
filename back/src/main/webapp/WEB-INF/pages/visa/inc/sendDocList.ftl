<h2>材料寄送与退还列表：</h2>
   <table class="p_table table_center">
		<thead>
			<tr>
		        <th>序号</th>
		        <th>寄送方式</th>
		        <th>快递单号</th>
		        <th>类型</th>
		        <th>备注</th>
		        <th>操作时间</th>
		        <th>操作</th>
		    </tr>
		 </thead>
		<tbody>
			<#list list as item>
				<tr>
					<td>${item.sendId}</td>
					<td><#list sendWayTypeList as list>
					           <#if item.sendWay?? && list.code==item.sendWay>${list.cnName!''}</#if>
					    </#list></td>
					<td>${item.expressNumber}</td>
					<td><#list sendTypeList as list>
					           <#if item.sendType?? && list.code==item.sendType>${list.cnName!''}</#if>
					    </#list>
					</td>
					<td>${item.memo}</td>
					<td>${item.operateTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					<td>
					<a href="javascript:void(0);" onclick="edit(${item.sendId});">修改</a>&nbsp;
	            	<a href="javascript:void(0);" onclick="del(${item.sendId});">删除</a>&nbsp;
					</td>
				</tr>
			</#list>
		  </tbody>
  	</table>