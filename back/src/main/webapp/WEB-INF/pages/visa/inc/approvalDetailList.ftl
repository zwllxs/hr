<table class="p_table table_center">
	<thead>
		<tr>
	        <th class="w8">材料名称</th>
	        <th>材料明细</th>
	        <th class="w8">审核状态</th>
	        <th>备注</th>
	        <th class="w20">操作</th>
	    </tr>
	 </thead>
	<tbody>
		<#list detailList as detail>
		<tr>
				<td>${detail.title}</td>
				<td>${detail.content}</td>
				<td>
					<#if detail.apprStatus=='APPR_UN'>
	            		未审核
	            	<#elseif detail.apprStatus=='APPR_IN'>
	            		审核中
	            	<#elseif detail.apprStatus=='APPR_UNPASS'>
	            		审核不通过
	            	<#elseif detail.apprStatus=='APPR_PASS'>
	            		审核通过
	            	</#if>
				</td>
				<td>${detail.memo}</td>
				<td>
				<a href="javascript:void(0);" onclick="approvalStatusChange(${detail.detailsId},'APPR_PASS');">通过</a>&nbsp;
            	<a href="javascript:void(0);" onclick="approvalStatusChange(${detail.detailsId},'APPR_UNPASS');">不通过</a>&nbsp;
            	<a href="javascript:void(0);" onclick="addMemo(${detail.detailsId})">备注</a>&nbsp;
				</td>
		</tr>
		</#list>
	  </tbody>
  </table>