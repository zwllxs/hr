			<#list visaStatusTypeList as list>
				<#if (list_index+1)%2 gt 0>
					<div class="operate mt20" style="text-align:left">
				</#if>
				<a class="btn btn_cc1" name="btChangeVisaStatus" data=${list.code!''}>${list.cnName!''}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<#if (list_index+1)%2 ==0>
					</div>
				</#if>
			 </#list>
	  <br/>
<br/>

<script>
		$("a[name=btChangeVisaStatus]").click(function(){
				var visaStatus = $(this).attr("data");
				var visaApprovalIds = "${visaApprovalIds}";
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/batchUpdateVisaStatus.do",
						type : "post",
						dataType : 'json',
						data : {"visaStatus":visaStatus,"visaApprovalIds":visaApprovalIds},
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
							 	$.alert(result.message,function(){
									loadVisaApprovalList();
									batchChangeVisaStatusDialog.close();
			   					});
						 	}
							
						}
				});
		});
	</script>