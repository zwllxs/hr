<form action="/visa/approval/saveVisaApprovalSend.do" method="post" id="visaApprovalSendForm">
	<input type="hidden" name="visaApprovalId" value="${visaApprovalId}" required>
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
            </tbody>
        </table>
	  <br/>
	   <div class="p_box box_info clearfix mb20" style="padding-left:160px;">
	            <div class="fl operate"><a class="btn btn_cc1" id="btSaveVisaApprovalSend">保存</a></div>
	   </div>
</form>
<br/>
<hr/>
<div id="listDiv">
	 <#include "/visa/inc/sendDocList.ftl"/>
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
	
		$("#btSaveVisaApprovalSend").click(function(){
				if(!$("#visaApprovalSendForm").validate().form()){
						return false;
				 }
				
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/saveVisaApprovalSend.do",
						type : "post",
						dataType : 'json',
						data : $("#visaApprovalSendForm").serialize(),
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
						 		$("#listDiv").load('/vst_back/visa/approval/showSendDocList.do',$("#visaApprovalSendForm").serialize(),function(){
						 				$("#visaApprovalSendForm").find("input[type=hidden][name=sendId]").val("");
										$("#visaApprovalSendForm")[0].reset();
								});
						 	}
							
						}
					});
			});
		
		function edit(sendId){
			 $.ajax({
					url : "/vst_back/visa/approval/initVisaApprovalSend.do",
					type : "post",
					dataType : 'json',
					data : {sendId:sendId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#visaApprovalSendForm").find("input[type=hidden][name=sendId]").val(result.attributes.visaApprovalSend.sendId);
						 	$("#visaApprovalSendForm").find("input[type=hidden][name=visaApprovalId]").val(result.attributes.visaApprovalSend.visaApprovalId);
						 	$("#visaApprovalSendForm").find("textarea[name=memo]").val(result.attributes.visaApprovalSend.memo);
						 	$("#visaApprovalSendForm").find("select[name=sendWay]").val(result.attributes.visaApprovalSend.sendWay);
						 	$("#visaApprovalSendForm").find("input[name=sendType][value="+result.attributes.visaApprovalSend.sendType+"]").attr('checked','true');
						 	$("#visaApprovalSendForm").find("input[name=expressNumber]").val(result.attributes.visaApprovalSend.expressNumber);
						 	$(".e_error").remove();
						 	if($("select[name=sendWay]").val()=='STORE_PICKUP'){
						 		$("td[name='expressNumber*']>i").text("");
								$("input[name=expressNumber]").removeAttr("required");
							}else{
								$("input[name=expressNumber]").attr("required",true);
								$("td[name='expressNumber*']>i").text("*"); 
							}
					 	}
					}
				});
		}
		function del(sendId){
			if(confirm('确定要删除此记录吗?'))
				 $.ajax({
					url : "/vst_back/visa/approval/delVisaApprovalSend.do",
					type : "post",
					dataType : 'json',
					data : {sendId:sendId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#listDiv").load('/vst_back/visa/approval/showSendDocList.do',$("#visaApprovalSendForm").serialize(),function(){
										 
							});
					 	}
					}
				});
		}
		
		
		function checkRequired(){
			$(".e_error").remove();
			if($("select[name=sendWay]").val()=='STORE_PICKUP' || $("select[name=sendWay]").val()=='OTHERS'){
				$("input[name=expressNumber]").removeAttr("required");
				$("td[name='expressNumber*']>i").text("");
			}else{
				$("input[name=expressNumber]").attr("required",true);
				$("td[name='expressNumber*']>i").text("*"); 
			}
		}
	</script>