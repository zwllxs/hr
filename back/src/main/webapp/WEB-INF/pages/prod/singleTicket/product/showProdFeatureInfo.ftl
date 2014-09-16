<!DOCTYPE html>
<html>
<head>
</head>
	<body>
		<div class="iframe_content mt10">
			<form action="/vst_back/prod/product/addProduct.do" method="post" id="dataForm">
				<div class="p_box box_info p_line">
		            <div class="box_content">
		                <table class="e_table form-inline">
		                    <tbody>
				                <tr>
				                	<td class="e_label" width="150"><i class="cc1">*</i>景区特色：</td>
				                	<td>
				                		<input type="hidden" id="productId" name="productId" value="${prodFeature.productId}" required>
				                		<input type="hidden" id="featureId" name="featureId" value="${prodFeature.featureId}" required>
				                		<label>
				                			<input type="text" id="featureDesc" maxlength="60" class="textWidth" name="featureDesc" value="${prodFeature.featureDesc}"/>
				                			<span style="color:grey">30个汉字以内</span>
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
		
		var saveFlag = true;
		
		$('#featureDesc').css('width','300px');
		
		$(".textWidth[maxlength]").each(function(){
			var	maxlen = $(this).attr("maxlength");
			if(maxlen != null && maxlen != ''){
				var l = maxlen*12;
				if(l >= 700) {
					l = 400;
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
					featureDesc : {
					}
						},
				messages : {
					featureDesc : '不可输入特殊字符'
					
				}
			}).form()){
						$(this).removeAttr("disabled");
						return false;
			}	
		
		 var msg = '确认保存吗 ？';	
		 if(refreshSensitiveWord($("input[type='text'],textarea"))){
		 	msg = '内容含有敏感词,是否继续?'
		 }
		
		$.confirm(msg,function(){
			if(saveFlag){
				$.ajax({
					url : "/vst_back/singleTicket/prod/prodFeature/saveOrUpdateProdFeature.do",
					type : "post",
					dataType:"json",
					async: false,
					data : $("#dataForm").serialize(),
					success : function(result) {
					   if(result.code=="success"){
							saveFlag = false;
							$.alert(result.message,function(){
				   				window.location.reload();
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
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>