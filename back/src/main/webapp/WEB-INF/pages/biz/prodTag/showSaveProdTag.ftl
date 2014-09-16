<!DOCTYPE html>
<html>
<head>
</head>
  <body>
	<form id="dataForm">
		<table class="p_table form-inline">
			<tbody>
				<tr>
					<input type="hidden" id="tagId" name="tagId" value=<#if bizTag??>${bizTag.tagId}</#if>>
					<td class="p_label" width="100px;"><i class="cc1">*</i>小组名称：</td>
                	<td colspan=2>
                		<div>
	                		<select id="tagGroup" name="tagGroup" required>
							  	<option value="">请选择</option>
							  	<#if tagGroups?? && tagGroups?size gt 0>
		                    		<#list tagGroups as tagGroup>
		                    			<option value="${tagGroup.tagGroup}">
		                    				${tagGroup.tagGroup}
		                    			</option>
		                    		</#list>
	                    		</#if>
		                	</select>
                	   </div>
                	</td>
				</tr>
				<tr>
					<td class="p_label"><i class="cc1">*</i>标签名称：</td>
					<td colspan=2>
                		<div>
	                		<select id="tagName" name="tagName" required>
							  	<option value="">请选择</option>
		                	</select>
                	   </div>					
					</td>
				</tr>
				<tr>
					<td class="p_label">标签有效期：</td>
					<td colspan=2>
						<input type="text" name="startTime" errorEle="code" class="Wdate" id="startDate" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'endDate\',{d:0});}'})"/>
						——
						<input type="text" name="endTime" errorEle="code" class="Wdate" id="endDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'startDate\',{d:0});}'})"/>
						<div id="codeError" style="display:inline"></div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="fl operate" style="margin:20px;width: 700px;" align="center">
			<input type="hidden" value="${prodTagVO.objectId}" name="objectIds" id="objectIds"/>
			<input type="hidden" value="${prodTagVO.objectType}" name="objectType" id="objectType"/>
			<a class="btn btn_cc1" id="saveOrUpdate">提交</a>
			<a class="btn btn_cc1" id="cancel">取消</a>
		</div>		
	</form>
	
	<form id="saveDataForm">
	</form>
</body>
</html>
	<script>
	
	   // 创建表单元素
	   function createItem(name,value){
     	   $("#saveDataForm").append('<input type=hidden name='+name+' value='+value+'>');
	   }
	   
	
		$(function(){
			// 新增与修改
			$('#saveOrUpdate').bind('click',function(){
				
				var url = '/vst_back/biz/prodTag/saveProdTag.do';
				//验证
				if(!$("#dataForm").validate({
					rules : {
						tagGroup:{
							required : true
						},
						tagName:{
							required : true
						}
					}
				}).form()){
					return false;
				} 
				
				var startDate = $('#startDate').val();
				var endDate = $('#endDate').val();
				if(startDate>endDate){
					$.alert("标签有效期开始日期不能大于结束日期！");
					return false;
				}				
				// 清空表单
				$('#saveDataForm').empty();
				
				var objectIds = $('#objectIds').val();
				if(objectIds.length<=0){
					 $("input[type=checkbox][name=objectIds]:checked").each(function(){
					 	 var value = $(this).val();
						 createItem('objectIds',value);
					 });
					 url = '/vst_back/biz/prodTag/saveBatchProdTag.do'
				}else{
					createItem('objectId',objectIds);
				}
			
				// 开始时间
				var startDate = $('#startDate').val();
				createItem('startTime',startDate);			
				
				// 结束时间
				var endDate = $('#endDate').val();
				createItem('endTime',endDate);
				
				// 小组名称
				var tagGroup = $('#tagGroup').val();
				createItem('tagGroup',tagGroup);
				
				// 标签名称
				var tagName = $('#tagName').val();
				createItem('tagName',tagName);
				
				// 对象类型
				var objectType = $('#objectType').val();
				createItem('objectType',objectType);
				
				var msg = '确定新增';
				$.confirm(msg,function(){
					$.ajax({
						url : url,
						type : "post",
						data : $("#saveDataForm").serialize(),
						success : function(result) {
							if(result.code=='success'){
					 	 	 	 $.alert(result.message,function(){
					 	 	 	 	search();
					   				addDialog.close();	
					 	 	 	 });
					 	 	 }else{
								$.alert(result.message);			 	 	 
					 	 	 }
						}
					});				
				});
			});
			
			// 取消
			$('#cancel').bind('click',function(){
				addDialog.close();	
			});
			
			$('#tagGroup').bind('change',function(){
				findTagNameByGroup();
			});
			
			findTagNameByGroup();			
		})
		
		// 根据小组名称查询标签
		function findTagNameByGroup(){
			var tagGroup = $('#tagGroup').val();
			$('#saveDataForm').empty();
			createItem('tagGroup',tagGroup);
			$.ajax({
				url : "/vst_back/biz/bizTag/findTagNameByGroup.do",
				type : "post",
				async: false,
				data : $("#saveDataForm").serialize(),
				success : function(result) {
					$('#tagName').empty();
					$('#tagName').append("<option value=\'\'>请选择</option>");
					$.each(result,function(index,data){
						$('#tagName').append("<option value=\'"+data.tagName+"\'>"+data.tagName+"</option>");
					});
				},
				error : function(result) {
					$.alert(result.message);
				}
			});		
		}		
	</script>