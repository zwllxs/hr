<!DOCTYPE html>
<html>
<head>
</head>
  <body>
	<input type="hidden" id="tagId" name="tagId" value=<#if bizTag??>${bizTag.tagId}</#if> />
	<div class="iframe-content">   
	    <div class="p_box">
		    <table class="p_table table_center" style="margin-top: 10px;">
                <tr>
					<th>小组名称</th>
                    <th>标签名称</th>
                    <th>起始时间</th>
                    <th>结束时间</th>
                    <th>操作</th>
	            </tr>
		    	<#if prodTagVOs?? &&  prodTagVOs?size &gt; 0>
					<#list prodTagVOs as item> 
						<tr>
							<td>${item.tagGroup}</td>
							<td>${item.tagName}</td>
							<td>
								<#if item.startTime??>
									${item.startTime?string('yyyy-MM-dd')}
								</#if>
							</td>
							<td>
								<#if item.endTime??>
									${item.endTime?string('yyyy-MM-dd')}
								</#if>							
							</td>
							<td>
								<a href="javascript:void(0);" class="delProdTag" data="${item.reId}">删除</a>
							</td>								
						</tr>
					</#list>
			    </#if>
			   <tr>
					<td colspan=5>
						<a class="btn btn_cc1" id="cancel">关闭</a>
					</td>
			   </tr>				    
	        </table>
       </div>
   </div>
</body>
</html>
	<script>
		$(function(){
			// 删除
			$('.delProdTag').bind('click',function(){
				var msg = '确定删除';
				var reId = $(this).attr('data');
				$.confirm(msg,function(){
					$.ajax({
						url : "/vst_back/biz/prodTag/deleteProdTagByReId.do",
						type : "post",
						data : {reIds:reId},
						success : function(result) {
							if(result.code=='success'){
					 	 	 	 $.alert(result.message,function(){
					   				  updateDialog.reload();
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
				updateDialog.close();
			});
		})
		
		
	</script>