<!DOCTYPE html>
<html>
<head>
</head>
	<body>
		<div class="iframe_content mt10">
			<form action="/vst_back/singleTicket/prod/prodActivity/saveOrUpdateProdActivity.do" method="post" id="dataForm">
				<div class="p_box box_info p_line">
		            <div class="box_content">
		                <table class="e_table form-inline" style="margin-left:-20px;">
		                    <tbody>
				                <tr>
				                	<td class="e_label" width="70"><i class="cc1">*</i>活动主题：</td>
				                	<td>
				                		<input type="hidden" id="productId" name="productId" value="${prodActivity.productId}">
				                		<input type="hidden" id="actId" name="actId" value="${prodActivity.actId}" required>
				                		<label>
				                			<input type="text" id="actTheme" value="${prodActivity.actTheme}" maxlength="50" class="textWidth" name="actTheme" required/>
				                		</label>
				                	</td>
				                </tr>
				                <tr>
				                	<td class="e_label"><i class="cc1">*</i>活动时间：</td>
				                	<td>
				                		<label>
				                			<input type="text" required <#if prodActivity.startTime??> value="${prodActivity.startTime?string('yyyy-MM-dd')}"</#if> name="startTime" errorEle="code" class="Wdate" id="startDate" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'endDate\',{d:0});}'})" />
				                			~ 
											<input type="text" required <#if prodActivity.endTime??> value="${prodActivity.endTime?string('yyyy-MM-dd')}"</#if> name="endTime" errorEle="code" class="Wdate" id="endDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'startDate\',{d:0});}'})" />
											<div id="codeError" style="display:inline"></div>
											<span style="color:grey">活动的开始结束时间，活动结束后，前台不再显示</span>
				                		</label>
				                	</td>
				                </tr>
				                <tr>
				                	<td class="e_label"><i class="cc1">*</i>状态：</td>
				                	<td>
										<select name="cancelFlag">
											<option value="Y" <#if prodActivity.cancelFlag=='Y'>selected="selected"</#if>>有效</option>
									    	<option value="N" <#if prodActivity.cancelFlag=='N'>selected="selected"</#if>>无效</option>
										</select>				                		
				                	</td>
				                </tr>				                		                                    
				                <tr>
				                	<td class="e_label"><i class="cc1">*</i>活动详情：</td>
				                	<td>
				                		<label>
				                			<textarea id="actDesc" maxlength="200" class="textWidth" name="actDesc" style="height:80px" required>${prodActivity.actDesc}</textarea>
				                			<span style="color:grey">一句话描述活动详情。(100个汉字以内)</span>
				                		</label>
				                	</td>
				                </tr>
		                	</tbody>
		                </table>
		            </div>
		        </div>
			</form>
		</div>
		<div class="fl operate" style="margin:20px;">
			<a class="btn btn_cc1" id="save">保存</a>
		</div>
	</body>
</html>
<script>

	$(function(){
		
		var saveFlag = true; // 防止重复提交
		
		$(".textWidth[maxlength]").each(function(){
			var	maxlen = $(this).attr("maxlength");
			if(maxlen != null && maxlen != ''){
				var l = maxlen*12;
				if(l >= 700) {
					l = 700;
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
		
		// 修改或新增
		$("#save").click(function(){
			if(!$("#dataForm").validate({
				rules : {
					actTheme : {
					},
					actDesc : {
					}					
				},
				messages : {
					featureDesc : '不可输入特殊字符'
					
				}
			}).form()){
				$(this).removeAttr("disabled");
				return false;
			}
			
			var beginDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			if(Date.parse(endDate)-Date.parse(beginDate)<0){
				$.alert("活动时间：开始时间不能大于结束时间!");
				return;
			}	
			
			 var msg = '确认保存吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			  $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?'
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
			 
			$.confirm(msg,function(){
				if(saveFlag){
				$.ajax({
					url : "/vst_back/singleTicket/prod/prodActivity/saveOrUpdateProdActivity.do",
					type : "post",
					dataType:"json",
					async: false,
					data : $("#dataForm").serialize(),
					success : function(result) {
					   if(result.code=="success"){
					   		saveFlag = false;
							$.alert(result.message,function(){
				   				window.location.reload();
				   				parent.categorySelectDialog.close();
							});					
						}else {
							$.alert(result.message);
				   		}
					}
				});
			}		
			
			});
				
		});
		
		
	});
	refreshSensitiveWord($("input[type='text'],textarea"))
</script>