			<#list docStatusTypeList as list>
				<#if (list_index+1)%2 gt 0>
					<div class="operate mt20" style="text-align:left">
				</#if>
				<a class="btn btn_cc1" name="btChangeDocStatus" data=${list.code!''}>${list.cnName!''}</a>&nbsp;&nbsp;
				<#if (list_index+1)%2 ==0>
					</div>
				</#if>
			 </#list>
	  <br/>
<br/>
	<script>
		$("a[name=btChangeDocStatus]").click(function(){
				var docStatus = $(this).attr("data");
				var visaApprovalId = ${visaApprovalId};
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/updateDocStatus.do",
						type : "post",
						dataType : 'json',
						data : {"docStatus":docStatus,"visaApprovalId":visaApprovalId},
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
							 	$.alert(result.message,function(){
									loadVisaApprovalList();
									changeDocStatusDialog.close();
			   					});
						 	}
							
						}
				});
		});
	</script>