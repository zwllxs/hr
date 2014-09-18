<form action="/visa/approval/updateVisaApprovalDetail.do" method="post" id="demoForm">
	 <input type="hidden" name="detailsId" value="${detailsId}">
	 <textarea style="width:300px; height:100px" name="memo" id="memo">${visaApprovalDetail.memo}</textarea>
	  <br/><br/>
	   <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
	            <div class="fl operate"><a class="btn btn_cc1" id="saveMomo">保存</a></div>
	   </div>
</form>
<script>
	$("#saveMomo").click(function(){
			var detailsId=$("input[type=hidden][name=detailsId]").val();
			if($.trim(detailsId)==""){
				$.alert("明细id为空");
				return;
			}
			var memo=$("#memo").val();
			//if($.trim(memo)==""){
			//	$.alert("备注为空");
			//	return;
			//}
			var excludeReg=/[<>&\'"';\\:=]/;
			if(getStrLength(memo)>400){
	    		$.alert("备注过长（中文(200个)/英文(400个)）");
	    		return false;
			}
			var loading = pandora.loading("正在努力保存中...");
			$.ajax({
					url : "/vst_back/visa/approval/updateVisaApprovalDetail.do",
					type : "post",
					dataType : 'json',
					data : $("#demoForm").serialize(),
					success : function(result) {
						loading.close();
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		loadList();
						 	addMemoDialog.close();
					 	}
						
					}
				});
		});
		
		function getStrLength(str) {   
		    var cArr = str.match(/[^\x00-\xff]/ig);   
		    return str.length + (cArr == null ? 0 : cArr.length);   
		}
</script>