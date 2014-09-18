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
				                	<td class="e_label" width="100"><i class="cc1">*</i>游玩景点名称：</td>
				                	<td>
				                		<input type="hidden" id="productId" name="productId" value="${prodViewSpot.productId}" required>
				                		<input type="hidden" id="spotId" name="spotId" value="${prodViewSpot.spotId}" required>
				                		<label>
				                			<input type="text" id="spotName" maxlength="50"  class="textWidth11" name="spotName" value="${prodViewSpot.spotName}" style="width: 400px;">
				                		</label>
				                	</td>
				                	
				                </tr>
				                <tr>
				                	<td class="e_label" width="100"><i class="cc1">*</i>描述信息：</td>
				                	<td>
				                		<label>
				                			<textarea id="spotDesc" maxlength="400" class="textWidth" name="spotDesc" rows="3" cols="20">${prodViewSpot.spotDesc}</textarea>
				                			简短描述200个汉字以内
				                		</label>
				                	</td>
				                </tr>
				               <!--  <tr>
				                	<td class="e_label" width="100" rowspan=2><i class="cc1">*</i>图片：</td>
				                	<td>本地上传&nbsp;&nbsp;&nbsp;&nbsp;图库选择 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;可上传1-2张图片</td>
				                </tr>
				                <tr>
				                	
				                	<td>
				                		<img src="http://s1.lvjs.com.cn/opi/jd-0422-lj-780x320.jpg" width="250" height="150" alt="">
				                		<img src="http://s1.lvjs.com.cn/opi/jd-0422-pjd-780x320.jpg" width="250" height="150" alt="">
				                	</td>
				                </tr> -->
		                	</tbody>
		                </table>
		            </div>
		        </div>
			</form>
		</div>
		<div class="fl operate">
			<a class="btn btn_cc1" id="save">保存</a>
		</div>
	</body>
</html>
<script>
	 
	$(function(){

		$(".textWidth[maxlength]").each(function(){
			var	maxlen = $(this).attr("maxlength");
			if(maxlen != null && maxlen != ''){
				var l = maxlen;
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
					spotName : {
						isChar : true
					}
						},
				messages : {
					spotName : '不可输入特殊字符'
					
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
		  	$.ajax({
				url : "/vst_back/singleTicket/prod/prodViewSpot/saveOrUpdateProdViewSpot.do",
				type : "post",
				dataType:"json",
				async: false,
				data : $("#dataForm").serialize(),
				success : function(result) {
				   if(result.code=="success"){
						$.alert(result.message,function(){
			   				window.location.reload();
			   				parent.categorySelectDialog.close();
						});					
					}else {
						$.alert(result.message);
			   		}
				}
			});			
		  
		  });
			
		});		
		
	});
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>