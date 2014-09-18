<!DOCTYPE html>
<html>
<head>
</head>
  <body>
  	<div class="iframe_content mt10">
		<form id="dataForm">
			<table class="p_table form-inline">
				<tbody>
					<tr>
						<input type="hidden" id="subjectId" name="subjectId" value=<#if bizSubject??>${bizSubject.subjectId}</#if>>
						<td class="p_label"><i class="cc1">*</i>主题名称：</td>
						<td colspan=2>
	            			<input maxlength="50" id="subjectName" type="text" name="subjectName" value="<#if bizSubject??>${bizSubject.subjectName}</#if>"/>
						</td>
					</tr>
					<tr>
						<td class="p_label"><i class="cc1">*</i>主题拼音：</td>
						<td colspan=2>
	            			<input maxlength="100" id="pinyin" type="text" name="pinyin" value="<#if bizSubject??>${bizSubject.pinyin}</#if>"/>
						</td>
					</tr>
					<tr>
						<td class="p_label"><i class="cc1">*</i>主题类型：</td>
						<td colspan=2>
	                		<#list subjectTypeList as type>
	                			<label>
	                			<input type="radio" errorEle="code" name="subjectType" <#if bizSubject?? && (type.code == bizSubject.subjectType)>checked="checked"</#if> value="${type.code}" />
	                			${type.cnName}
	                			</label>
	                		</#list>
	                		<div id="codeError" style="display:inline"></div>						
						</td>
					</tr>							
					<tr>
						<td class="p_label">是否标红：</td>
	                	<td colspan=2>
	                		<select id="redFlag" name="redFlag" required>
							  	<#if bizSubject?? && bizSubject.redFlag=='Y'>
							  		<option value="Y" selected>是</option>
							  		<option value="N">否</option>
							  	<#else>
							  		<option value="Y">是</option>
							  		<option value="N" selected>否</option>						  	
							  	</#if>
		                	</select>
	                	</td>
					</tr>
					<tr>
						<td class="p_label">状态：</td>
						<td colspan=2>
	                		<select id="cancelFlag" name="cancelFlag" required>
							  	<#if bizSubject?? && bizSubject.cancelFlag=='Y'>
							  		<option value="Y" selected>有效</option>
							  		<option value="N">无效</option>
							  	<#else>
							  		<option value="Y">有效</option>
							  		<option value="N" selected>无效</option>						  	
							  	</#if>
		                	</select>					
						</td>
					</tr>
					<tr>
						<td class="p_label">排序值：</td>
						<td colspan=2>
							<input id="seq" type="text" name="seq" value="<#if bizSubject??>${bizSubject.seq}</#if>" />
						</td>
					</tr>				
				   <tr>
						<td class="p_label">引用次数：</td>
						<td colspan=2>
							${count}
						</td>
				   </tr>
				   <tr>
						<td class="p_label">创建时间：</td>
						<td colspan=2>
							<#if bizSubject?? && bizSubject.createTime??>${bizSubject.createTime?string('yyyy-MM-dd HH:mm:ss')!''}</#if>
						</td>
				   </tr>
				   <tr>
						<td class="p_label">更新时间：</td>
						<td colspan=2>
							<#if bizSubject?? && bizSubject.updateTime>
								${bizSubject.updateTime?string('yyyy-MM-dd HH:mm:ss')!''}
							</#if>
						</td>
				   </tr>			   			   
				   <tr>
						<td class="p_label"></td>
						<td colspan=2 align="center">
							<#if bizSubject?? && bizSubject.subjectId>
								<a class="btn btn_cc1 saveOrUpdate">修改</a>
							<#else>
								<a class="btn btn_cc1 saveOrUpdate">新增</a>
							</#if>
							<a class="btn btn_cc1" id="cancel">取消</a>
						</td>
				   </tr>			   
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
	<script>
		$(function(){
			// 新增与修改
			$('.saveOrUpdate').bind('click',function(){
				
				/**
				 * 验证整数或验证非零的负整数
				 */
				jQuery.validator.addMethod("isMinus1", function(value, element) {
				    var chars =  /^[0-9]\d*$/;// 验证正整数  
				    var rq =  /^\-[1-9][0-9]*$/;// 验证非零的负整数
				    return this.optional(element) || (chars.test(value) || (rq.test(value)));       
				 }, "只能填写整数或负整数");
				
				//验证
				if(!$("#dataForm").validate({
					rules : {
						subjectName:{
							required : true
						},
						pinyin:{
							required : true
						},						
						subjectType:{
							required : true
						},
						seq:{
							isMinus1 : true
						}
					}
				}).form()){
					return false;
				}   
				
				var msg = '确定新增';
				var subjectId = $('#subjectId').val();
				if(subjectId.length>0){
					msg = '确定修改';				
				}
				$.confirm(msg,function(){
					$.ajax({
						url : "/vst_back/biz/bizSubject/subjectNameOrPyisExists.do",
						type : "post",
						data : $("#dataForm").serialize(),
						success : function(result) {
							if(result.code=='success'){
								$.ajax({
									url : "/vst_back/biz/bizSubject/saveOrUpdateProdTag.do",
									type : "post",
									data : $("#dataForm").serialize(),
									success : function(result) {
									   if(result.code=='success'){
									 	 	 $.alert(result.message,function(){
									 	 	 	search();
									 	 	 	showAddOrUpdate.close();
									 	 	 });
								 	   }else{
										  	$.alert(result.message);			 	 	 
								 	   }
									}
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
				showAddOrUpdate.close();	
			});
			
			// 根据标签名称动态生成拼音
			$("#dataForm #subjectName").bind("change",function(){
				var py = vst_pet_util.convert2pinyin($(this).val());
				$("#pinyin").val(py);
			});			
		})
	</script>