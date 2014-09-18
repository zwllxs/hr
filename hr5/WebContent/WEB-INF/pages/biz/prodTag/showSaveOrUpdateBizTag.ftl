<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
  <body>
	<form id="dataForm">
		<table class="p_table form-inline">
			<tbody>
				<tr>
					<input type="hidden" id="cancelFlag" name="cancelFlag" value="Y"/>
					<input type="hidden" id="tagId" name="tagId" value=<#if bizTag??>${bizTag.tagId}</#if>>
					<td class="p_label" width="100px;"><i class="cc1">*</i>小组名称：</td>
                	<td colspan=2>
                		<div id="showTagGroup" style="display:block" class="divTagGroup">
	                		<select id="tagGroup" name="tagGroup" required>
							  	<option value="">请选择</option>
							  	<#if tagGroups?? && tagGroups?size gt 0>
		                    		<#list tagGroups as tagGroup>
		                    			<option value="${tagGroup.tagGroup}" <#if bizTag?? && (bizTag.tagGroup == tagGroup.tagGroup)>selected</#if>>
		                    				${tagGroup.tagGroup}
		                    			</option>
		                    		</#list>
	                    		</#if>
		                	</select>
	                		<span><input type="radio" value="addTagGroup" name="tagGroupName"/>
	                			<#if bizTag?? && bizTag.tagId??>
	                				修改小组名称
	                			<#else>
	                				新增小组名称
	                			</#if>
	                		<span>
                	   </div>
                		<div id="showTagName" style="display:none" class="divTagGroup">
	                		<input type="text" maxlength="20" name="addTagGroup" id="addTagGroup" required/>
	                		<span><input type="radio" value="selectTagGroup" name="tagGroupName"/>选择已有小组名称<span>
                	    <div>                	   
                	</td>
				</tr>
				<tr>
					<td class="p_label"><i class="cc1">*</i>标签名称：</td>
					<td colspan=2>
            			<input maxlength="20" id="tagName" type="text" name="tagName" value="<#if bizTag??>${bizTag.tagName}</#if>"/>
					</td>
				</tr>
				<tr>
					<td class="p_label"><i class="cc1">*</i>标签拼音：</td>
					<td colspan=2>
            			<input maxlength="40" id="pinyin" type="text" name="pinyin" value="<#if bizTag??>${bizTag.pinyin}</#if>"/>
					</td>
				</tr>
				<tr>
					<td class="p_label">SEQ：</td>
					<td colspan=2>
						<input id="seq" type="text" name="seq" value="<#if bizTag??>${bizTag.seq}</#if>">
					</td>
				</tr>
				<tr>
					<td class="p_label">样式ID：</td>
					<td colspan=2>
						<input id="style" type="text" name="style" value="<#if bizTag??>${bizTag.style}</#if>">
					</td>
				</tr>				
			   <tr>
					<td class="p_label">标签描述：</td>
					<td colspan=2>
						<textarea class="w35 textWidth" style="width: 700px; height: 80px;" id="memo" name="memo" maxlength="20"><#if bizTag??>${bizTag.memo}</#if></textarea>
					</td>
			   </tr>
			   <tr>
					<td class="p_label"></td>
					<td colspan=2>
						<a class="btn btn_cc1" id="saveOrUpdate">提交</a>
						<a class="btn btn_cc1" id="cancel">取消</a>
					</td>
			   </tr>			   
			</tbody>
		</table>
	</form>
<#include "/base/foot.ftl"/>
</body>
</html>
	<script>
		$(function(){
			
			$('input[type=radio][name=tagGroupName]').bind('click',function(){
				  if($(this).attr('checked')=='checked'){
					  var value = $(this).val();
					  if(value=='selectTagGroup'){
					  	 $('#addTagGroup').val('');
					  }
				  }
			});
			
			/**
			 * 验证整数或验证非零的负整数
			 */
			jQuery.validator.addMethod("isMinus1", function(value, element) {
			    var chars =  /^[0-9]\d*$/;// 验证正整数  
			    var rq =  /^\-[1-9][0-9]*$/;// 验证非零的负整数
			    return this.optional(element) || (chars.test(value) || (rq.test(value)));       
			 }, "只能填写整数或非零的负整数");		
			 
			/**
			 * 验证整数或验证非零的负整数
			 */
			jQuery.validator.addMethod("isInteger1", function(value, element) {
			    var chars =  /^[0-9]\d*$/;// 验证正整数  
			    return this.optional(element) || chars.test(value);       
			 }, "只能填写整数");			
		
			$(".textWidth[maxlength]").each(function(){
				var	maxlen = $(this).attr("maxlength");
				if(maxlen != null && maxlen != ''){
					var l = maxlen*12;
					if(l >= 500) {
						l = 500;
					} else if (l <= 200){
						l = 200;
					} else {
						l = 400;
					}
					$(this).width(l);
				}
				$(this).keyup(function() {
					vst_util.countLenth($(this));
				});
			});
			
			// 隐藏或显示小组名称
			$("input[name=tagGroupName][type=radio]").bind('click',function(){
				if($(this).attr("checked")=='checked'){
					var value = $(this).val();
					if(value=='addTagGroup'){
						$('#showTagName').attr('style','display:block');
						$('#showTagGroup').attr('style','display:none');	
					}else{
						$('#showTagName').attr('style','display:none');
						$('#showTagGroup').attr('style','display:block');	
					}
				}			
			});	
			
			// 新增与修改
			$('#saveOrUpdate').bind('click',function(){
				//验证
				if(!$("#dataForm").validate({
					rules : {
						addTagGroup:{
							required : true
						},
						tagGroup:{
							required : true
						},						
						tagName:{
							required : true
						},
						pinyin:{
							required : true
						},
						style:{
							isInteger1 : true
						},
						seq:{
							isMinus1 : true
						}
					}
				}).form()){
					return false;
				}   
				
				var msg = '确定新增';
				var tagId = $('#tagId').val();
				if(tagId.length>0){
					msg = '确定修改';				
				}
				$.confirm(msg,function(){
					$.ajax({
						url : "/vst_back/biz/bizTag/tagGroupOrNameisExists.do",
						type : "post",
						data : $("#dataForm").serialize(),
						success : function(result) {
							if(result.code=='success'){
								$.ajax({
									url : "/vst_back/biz/bizTag/saveOrUpdateBizTag.do",
									type : "post",
									data : $("#dataForm").serialize(),
									success : function(result) {
									   if(result.code=='success'){
									 	 	 $.alert(result.message,function(){
									   			parent.search();
									   			parent.showAddOrUpdate.close();	
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
				parent.showAddOrUpdate.close();	
			});
			
			// 根据标签名称动态生成拼音
			$("#dataForm #tagName").bind("change",function(){ 
				var py = vst_pet_util.convert2pinyin($(this).val());
				$("#pinyin").val(py);
			});							
		})
	</script>