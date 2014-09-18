<form action="/visa/approval/saveVisaApprovalSend.do" method="post" id="visaApprovalSendForm">
	<input type="hidden" name="visaApprovalIds" value="${visaApprovalIds}" required>
	<input type="hidden" name="sendId" value="">
		<table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label" style="width:120px;"><i class="cc1">*</i>寄送方式：</td>
                	<td >
                		<select name="sendWay" required onchange="checkRequired();">
                    	 			<option value="">请选择</option>
		    				<#list sendWayTypeList as list>
			                    	<option value=${list.code!''}>${list.cnName!''}</option>
			                </#list>
			        	</select>
                	</td>
                </tr>
				<tr>
                	<td class="p_label" style="width:120px;" name="expressNumber*"><i class="cc1">*</i>快递单号：</td>
                    <td >
         	    		<input type="text" class="w35" maxlength=20 id="expressNumber" name="expressNumber" value="" required>
                    </td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" ><i class="cc1">*</i>类型：</td>
                    <td >
                    	<#list sendTypeList as list>
                    		<input type="radio" name="sendType" value=${list.code!''} required>${list.cnName!''}
			            </#list>
			            <div id="sendTypeError" style="display:inline"></div>
                    </td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" >备注：</td>
                    <td >
                    	  <textarea class="w35 textWidth" name="memo" maxlength=200 style="width: 410px; height: 75px;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan=2>
                	   <div class="p_box box_info clearfix mb20" style="padding-left:160px;">
				            <div class="fl operate"><a class="btn btn_cc1" id="btSaveVisaApprovalSend">保存</a></div>
					   </div>
                    </td>
                </tr>
            </tbody>
        </table>
	  <br/>
</form>
<br/>
<hr/>
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
	
	
		
		$("#btSaveVisaApprovalSend").click(function(){
				if(!$("#visaApprovalSendForm").validate().form()){
						return false;
				 }
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/batchSaveVisaApprovalSend.do",
						type : "post",
						dataType : 'json',
						data : $("#visaApprovalSendForm").serialize(),
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
						 		 batchSendDocDialog.close();
						 	}
						}
				});
		});
		
		function checkRequired(){
			$(".e_error").remove();
			if($("select[name=sendWay]").val()=='STORE_PICKUP'){
				$("input[name=expressNumber]").removeAttr("required");
				$("td[name='expressNumber*']>i").text("");
			}else{
				$("input[name=expressNumber]").attr("required",true);
				$("td[name='expressNumber*']>i").text("*"); 
			}
		}
	</script>