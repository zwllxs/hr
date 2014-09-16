<form action="/visa/approval/saveVisaApprovalUpload.do" method="post" id="vsiaUploadFileForm">
	<input type="hidden" name="visaApprovalId" value="${visaApprovalId}" required>
	<input type="hidden" name="uploadId" value="">
		<table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label" style="width:120px;">上传文件：</td>
                	<td >
                		<div id="cluesDiv" style="width:140px"></div>
		               	<input  type="file" id="uploadFile" style="width:65px" serverType="COM_AFFIX"/> 
                		<input type="hidden" id="pid" name="fileId" required/>
                	</td>
                </tr>
				<tr>
                	<td class="p_label" style="width:120px;" >文件命名：</td>
                    <td >
         	    		<input type="text" id="fileName" name="fileName" value="" required>
                    </td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" >文件类型：</td>
                    <td >
                    	<select name="uploadType" required>
            	 			<option value="VISA_DOC" >签证材料</option>
	                    	<option value="VISA_AMOUNT" >保证金</option>
			        	</select>
                    </td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" >备注：</td>
                    <td >
                    	  <textarea name="memo" class="textWidth" maxlength="200" style="width: 410px; height: 75px;"/>
                    	  <div class="cc3"><span class="cc1">0</span>/200字（中文(100个)/英文(200个)）</div>
                    </td>
                </tr>
            </tbody>
        </table>
	  <br/>
	   <div class="p_box box_info clearfix mb20" style="padding-left:160px;">
	            <div class="fl operate"><a class="btn btn_cc1" id="btSaveVisaApprovalUpload">保存</a></div>
	   </div>
</form>
<br/>
<hr/>
<div id="listDiv">
	 <#include "/visa/inc/uploadFileList.ftl"/>
</div>
	
  	<script type="text/javascript">
		var basePath = "/vst_back/pet";
	</script>
  	<script src="/vst_back/js/file/ajaxUpload.js"></script>
	<script>
		//上传附件		
	$("#uploadFile").fileUpload({
		onSubmit:function() {
			$("#uploadFile").attr("disabled", true);
			$("#cluesDiv").html("");
		},
		onComplete:function(file,dt){
			var data=eval("("+dt+")");
			if(data.success){
				$("#fileName").val(data.fileName);					
				$("#pid").val(data.file);
				$("#cluesDiv").html("上传成功");
			}else{
				alert(data.msg);
			}
			$("#uploadFile").removeAttr("disabled");
		}
	 });
		$("#btSaveVisaApprovalUpload").click(function(){
				if(!$("#vsiaUploadFileForm").validate().form()){
						return false;
				 }
				var memo=$("textarea[name=memo]").val();
				var excludeReg=/[<>&\'"';\\:=]/;
				if(getStrLength(memo)>200){
		    		$.alert("备注过长（中文(100个)/英文(200个)）");
		    		return false;
				}
				var loading = pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/visa/approval/saveVisaApprovalUpload.do",
						type : "post",
						dataType : 'json',
						data : $("#vsiaUploadFileForm").serialize(),
						success : function(result) {
							loading.close();
							if(!result.success){
						 		$.alert(result.message);
						 	}else{
						 		$("#listDiv").load('/vst_back/visa/approval/showUploadFileList.do',$("#vsiaUploadFileForm").serialize(),function(){
						 				$("#vsiaUploadFileForm").find("input[type=hidden][name=uploadId]").val("");
										$("#vsiaUploadFileForm").find("input[type=hidden][name=fileId]").val("");
										$("#vsiaUploadFileForm")[0].reset();
								});
						 	}
							
						}
					});
			});
		
		function edit(uploadId){
			 $.ajax({
					url : "/vst_back/visa/approval/initVisaApprovalUpload.do",
					type : "post",
					dataType : 'json',
					data : {uploadId:uploadId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#vsiaUploadFileForm").find("input[type=hidden][name=uploadId]").val(result.attributes.visaApprovalUpload.uploadId);
						 	$("#vsiaUploadFileForm").find("input[type=hidden][name=fileId]").val(result.attributes.visaApprovalUpload.fileId);
						 	$("#vsiaUploadFileForm").find("input[type=hidden][name=visaApprovalId]").val(result.attributes.visaApprovalUpload.visaApprovalId);
						 	$("#vsiaUploadFileForm").find("input[type=text][name=fileName]").val(result.attributes.visaApprovalUpload.fileName);
						 	$("#vsiaUploadFileForm").find("textarea[name=memo]").val(result.attributes.visaApprovalUpload.memo);
						 	$("#vsiaUploadFileForm").find("select[name=uploadType]").val(result.attributes.visaApprovalUpload.uploadType);
					 	}
					}
				});
		}
		function del(uploadId){
			if(confirm('确定要删除此附件记录吗?'))
				 $.ajax({
					url : "/vst_back/visa/approval/delVisaApprovalUpload.do",
					type : "post",
					dataType : 'json',
					data : {uploadId:uploadId},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else{
					 		$("#listDiv").load('/vst_back/visa/approval/showUploadFileList.do',$("#vsiaUploadFileForm").serialize(),function(){
										 
							});
					 	}
					}
				});
		}
		
		function getStrLength(str) {
		    var cArr = str.match(/[^\x00-\xff]/ig);   
		    return str.length + (cArr == null ? 0 : cArr.length);   
		}
		
		$("textarea[name=memo]").change(function(){
			$(this).closest("td").find("div span").html(getStrLength(this.value));
		});
	</script>