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
			</tbody>
		</table>
		<div class="fl operate" style="margin:20px;width: 700px;" align="center">
			<input type="hidden" value="${prodTagVO.objectType}" name="objectType" id="objectType"/>
			<a class="btn btn_cc1" id="delete">删除</a>
			<a class="btn btn_cc1" id="cancel">取消</a>
		</div>		
	</form>
	
	<form id="deleteForm">
	</form>	
	
	<form id="saveDataForm">
	</form>	
</body>
</html>
	<script>
		
	   function createItem(name,value){
     	   $("#deleteForm").append('<input type=hidden name='+name+' value='+value+'>');
	   }
	
		$(function(){
			// 删除
			$('#delete').bind('click',function(){
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
				
				// 清空表单
				$('#deleteForm').empty();				
				
				$("input[type=checkbox][name=objectIds]:checked").each(function(){
				 	 var value = $(this).val();
					 createItem('objectIds',value);
				});
				
				// 小组名称
				var tagGroup = $('#tagGroup').val();
				createItem('tagGroup',tagGroup);
				
				// 标签名称
				var tagName = $('#tagName').val();
				createItem('tagName',tagName);
				
				// 对象类型
				var objectType = $('#objectType').val();
				createItem('objectType',objectType);				
				
				$.confirm('确定删除',function(){
					$.ajax({
						url : "/vst_back/biz/prodTag/deleteProdTagByObject.do",
						type : "post",
						data : $("#deleteForm").serialize(),
						success : function(result) {
							if(result.code=='success'){
					 	 	 	 $.alert(result.message,function(){
					 	 	 	 	search();
					   				delDialog.close();	
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
				delDialog.close();	
			});
			
			$('#tagGroup').bind('change',function(){
				findTagNameByGroup();
			});
		})
		
		// 根据小组名称查询标签
		function findTagNameByGroup(){
			var tagGroup = $('#tagGroup').val();
			$('#saveDataForm').empty();
			$("#saveDataForm").append("<input type=\'hidden\' name=\'tagGroup\' value=\'"+tagGroup+"\'>");
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