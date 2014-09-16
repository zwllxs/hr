<h2>保证金列表：</h2>
   <table class="p_table table_center">
		<thead>
			<tr>
		        <th>序号</th>
		        <th>保证金形式</th>
		        <th>银行</th>
		        <th>保证金金额(元)</th>
		        <th>保证金状态</th>
		        <th>操作时间</th>
		        <th>操作</th>
		    </tr>
		 </thead>
		<tbody>
			<#list list as item>
				<tr>
					<td>${item.depId}</td>
					<td><#list depositTypeList as list>
					           <#if item.depositType?? && list.code==item.depositType>${list.cnName!''}</#if>
					    </#list></td>
				    <td><#list bankList as list>
				           <#if item.bank?? && list.code==item.bank>${list.cnName!''}</#if>
				    </#list></td>
					<td>${item.amount}</td>
					<td><#list depositStatusList as list>
					           <#if item.depStatus?? && list.code==item.depStatus>${list.cnName!''}</#if>
					    </#list>
					</td>
					<td>${item.operateTime?string('yyyy-MM-dd HH:mm:ss')}</td>
					<td>
					<a href="javascript:void(0);" onclick="edit(${item.depId});">修改</a>&nbsp;
	            	<a href="javascript:void(0);" onclick="returnDeposit(${item.depId});">退回</a>&nbsp;
					</td>
				</tr>
			</#list>
		  </tbody>
  	</table>