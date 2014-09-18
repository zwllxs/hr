<h2>附件列表：</h2>
   <table class="p_table table_center">
		<thead>
			<tr>
		        <th class="w4">序号</th>
		        <th>文件名</th>
		        <th class="w12">类型</th>
		        <th class="w20">备注</th>
		        <th>操作时间</th>
		        <th class="w20">操作</th>
		    </tr>
		 </thead>
		<tbody>
			<#list list as item>
				<tr>
					<td>${item.uploadId}</td>
					<td>${item.fileName}</td>
					<td>
						<#if item.uploadType=='VISA_DOC'>
		            		签证材料
		            	<#elseif item.uploadType=='VISA_AMOUNT'>
		            		保证金
		            	</#if>
					</td>
					<td>${item.memo}</td>
					<td><#if item.operateTime??>${item.operateTime?string('yyyy-MM-dd')}</#if></td>
					<td>
					<a href="javascript:void(0);" onclick="edit(${item.uploadId});">修改</a>&nbsp;
	            	<a href="javascript:void(0);" onclick="del(${item.uploadId});">删除</a>&nbsp;
					</td>
				</tr>
			</#list>
		  </tbody>
  	</table>