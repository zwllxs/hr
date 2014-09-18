<input type="hidden" name="visaApprovalId" value="${visaApprovalId}">
&nbsp;&nbsp;<span class="f14" style="color:#FF0000;">${visaApproval.name}</span>的签证材料
<br/><br/>
<div id="detailListDiv">
	 <#include "/visa/inc/approvalDetailList.ftl"/>
</div>
  <br/>
   <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
            <div class="fl operate">
            	<a class="btn btn_cc1" id="btn_approval_pass">审核通过</a>&nbsp;&nbsp;&nbsp;&nbsp;
            	<a class="btn btn_cc1" id="btn_approval_unpass">审核不通过</a>&nbsp;&nbsp;&nbsp;&nbsp;
            	<a class="btn btn_cc1" id="saveConfirmDocument" onclick="closeDialog();">关闭</a>
            </div>
   </div>
<script>
	var addMemoDialog;
	$("#btn_approval_pass").click(function(){
			var msg="确认全部签证材料"+"<span style='color:red;'>已通过审核</span>"+"？";
			$.confirm(msg, function() {
				var visaApprovalId=$("input[type=hidden][name=visaApprovalId]").val();
				if($.trim(visaApprovalId)==""){
					$.alert("审核ID为空");
					return;
				}
				 $.ajax({
						url : "/vst_back/visa/approval/batchVisaApprovalDetail.do",
						type : "post",
						dataType : 'json',
						data :{"visaApprovalId":visaApprovalId,"apprStatus":"APPR_PASS"},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
							 	loadList();
						 	}
						}
					});
    		});
		});
		
	$("#btn_approval_unpass").click(function(){
			var msg="确认全部签证材料"+"<span style='color:red;'>不通过审核</span>"+"？";
			$.confirm(msg, function() {
				var visaApprovalId=$("input[type=hidden][name=visaApprovalId]").val();
				if($.trim(visaApprovalId)==""){
					$.alert("审核ID为空");
					return;
				}
				$.ajax({
						url : "/vst_back/visa/approval/batchVisaApprovalDetail.do",
						type : "post",
						dataType : 'json',
						data :{"visaApprovalId":$("input[type=hidden][name=visaApprovalId]").val(),"apprStatus":"APPR_UNPASS"},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
							 	loadList();
						 	}
						}
					});
			});
		});
		function approvalStatusChange(detailsId,apprStatus){
		  var visaApprovalId=$("input[type=hidden][name=visaApprovalId]").val();
			if($.trim(visaApprovalId)==""){
				$.alert("审核ID为空");
				return;
			}
			if($.trim(detailsId)==""){
				$.alert("审核明细ID为空");
				return;
			}
			if($.trim(apprStatus)==""){
				$.alert("审核状态为空");
				return;
			}
			var loading = pandora.loading("正在努力保存中...");
			$.ajax({
					url : "/vst_back/visa/approval/saveVisaApprovalDetail.do",
					type : "post",
					dataType : 'json',
					data :{"visaApprovalId":visaApprovalId,"detailsId":detailsId,"apprStatus":apprStatus},
					success : function(result) {
						loading.close();
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
						 	loadList();
					 	}
					}
				});
		}
		function addMemo(detailsId){
				addMemoDialog = 
				new xDialog("/vst_back/visa/approval/showAddMemo.do",
				{"detailsId":detailsId},
				{title:"备注",width:400,height:400});
		}
		
		function loadList(){
			var visaApprovalId=$("input[type=hidden][name=visaApprovalId]").val();
			$("#detailListDiv").load('/vst_back/visa/approval/showApprovalDetailList.do',{"visaApprovalId":visaApprovalId},function(){
 				 
			});
		}
		
		function closeDialog(){
		 docDetailApprovalDialog.close();
		}
</script>