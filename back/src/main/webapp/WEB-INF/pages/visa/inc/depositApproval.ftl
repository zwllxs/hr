<form action="/visa/approval/saveVisaApprovalDeposit.do" method="post" id="visaApprovalDepositForm">
	<input type="hidden" name="visaApprovalId" value="${visaApprovalId}" required>
	<input type="hidden" name="depId" value="">
		<table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label" style="width:120px;"><i class="cc1">*</i>保证金形式：</td>
                	<td >
                		<select name="depositType" required onchange="checkRequired();">
                    	 			<option value="">请选择</option>
		    				<#list depositTypeList as list>
			                    	<option value=${list.code!''}>${list.cnName!''}</option>
			                </#list>
			        	</select>
                	</td>
                	<td class="p_label" style="width:120px;" name="bank*"><i class="cc1">*</i>开户银行：</td>
                	<td >
                		<select name="bank" required>
                    	 			<option value="">请选择</option>
		    				<#list bankList as list>
			                    	<option value=${list.code!''}>${list.cnName!''}</option>
			                </#list>
			        	</select>
                	</td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" name="amount*"><i class="cc1">*</i>保证金(元)：</td>
                    <td >
                    	<input type="text" name="amount" required maxlength=7 number="true" value=${list.code!''} >${list.cnName!''}
                    </td>
                    <td colspan=2>
                    	   <div class="fl operate"><a class="btn btn_cc1" id="btSaveVisaApprovalDeposit">保存</a></div>
                    </td>
                </tr>
            </tbody>
        </table>
	  <br/>
</form>
<br/>
<hr/>
<div id="listDiv">
	 <#include "/visa/inc/depositApprovalList.ftl"/>
</div>
	<script>
	$(function(){
	
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
	}); 
	
	
		
		$("#btSaveVisaApprovalDeposit").click(function(){
				if(!$("#visaApprovalDepositForm").validate().form()){
						return false;
				 }
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/saveVisaApprovalDeposit.do",
						type : "post",
						dataType : 'json',
						data : $("#visaApprovalDepositForm").serialize(),
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
						 		$("#listDiv").load('/vst_back/visa/approval/showDepositApprovalList.do',$("#visaApprovalDepositForm").serialize(),function(){
						 				$("#visaApprovalDepositForm").find("input[type=hidden][name=depId]").val("");
										$("#visaApprovalDepositForm")[0].reset();
								});
						 	}
							
						}
					});
			});
		
		function edit(depId){
			 $.ajax({
					url : "/vst_back/visa/approval/initVisaApprovalDeposit.do",
					type : "post",
					dataType : 'json',
					data : {depId:depId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#visaApprovalDepositForm").find("input[type=hidden][name=depId]").val(result.attributes.visaApprovalDeposit.depId);
						 	$("#visaApprovalDepositForm").find("input[type=hidden][name=visaApprovalId]").val(result.attributes.visaApprovalDeposit.visaApprovalId);
						 	$("#visaApprovalDepositForm").find("select[name=depositType]").val(result.attributes.visaApprovalDeposit.depositType);
						 	$("#visaApprovalDepositForm").find("select[name=bank]").val(result.attributes.visaApprovalDeposit.bank);
						 	$("#visaApprovalDepositForm").find("input[name=amount]").val(result.attributes.visaApprovalDeposit.amount);
						 	$(".e_error").remove();
							if($("select[name=depositType]").val()=='WITHOUT_BOND'){
								$("select[name=bank]").removeAttr("required");
								$("td[name='bank*']>i").text("");
								$("input[name=amount]").removeAttr("required");
								$("td[name='amount*']>i").text("");
							}else{
								$("select[name=bank]").attr("required",true);
								$("td[name='bank*']>i").text("*");
								$("input[name=amount]").removeAttr("required");
								$("td[name='amount*']>i").text("");
							}
					 	}
					}
				});
		}
		
		
		function returnDeposit(depId){
			if(confirm('确定要退回吗?'))
				 $.ajax({
					url : "/vst_back/visa/approval/returnVisaApprovalDeposit.do",
					type : "post",
					dataType : 'json',
					data : {depId:depId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#listDiv").load('/vst_back/visa/approval/showDepositApprovalList.do',$("#visaApprovalDepositForm").serialize(),function(){
										 
							});
					 	}
					}
				});
		}
		
		function checkRequired(){
			$(".e_error").remove();
			if($("select[name=depositType]").val()=='WITHOUT_BOND'){
				$("select[name=bank]").removeAttr("required");
				$("td[name='bank*']>i").text("");
				$("input[name=amount]").removeAttr("required");
				$("td[name='amount*']>i").text("");
			}else{
				$("select[name=bank]").attr("required",true);
				$("td[name='bank*']>i").text("*");
				$("input[name=amount]").attr("required",true);
				$("td[name='amount*']>i").text("*");
			}
		}
	</script>