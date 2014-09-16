	<form id="addAnnouncement" method="post" enctype="multipart/form-data">
		<input type="hidden" name="announcementId" value="${announcementId}" />
		<table>
			<tr height="26">
				<td>公告标题:<span class="notnull">*</span></td>
				<td><input class="ggbt_w330" type="text" name="title"
					value="${title}" maxlength="150" required=true/></td>
			</tr>
			<tr>
				<td>公告内容:</td>
				<td><textarea id="contentA" style="width: 600px; height: 300px;" class="ckeditor">${content}</textarea>
					<input type="hidden" name="content" id="content"/>
				</td>
			</tr>
			<tr height="26">
				<td>上传附件:</td>
				<td>
					<input type="text" id="fileName" name="fileName"/>
					<input type="hidden" id="pid" name="attachment"/>
					<input type="button" value="附件" id="uploadFile" serverType="COM_AFFIX"/>				
				</td>
			</tr>
			<tr height="26">
				<td>发布时间:<span class="notnull">*</span></td>
				<td>
				<input type="text" name="beginTime" <#if announcement.beginDate??> value="${announcement.beginDate?string('yyyy-MM-dd HH:mm:ss')}"</#if> required=true id="defaultInput" class="Wdate" id="defaultInput" onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				<div id="validatebeginDateError"></div>					
			</tr>
		</table>
	</form>
<script type="text/javascript">
	var basePath = "/vst_back/pet";
</script>
<script src="/vst_back/js/file/ajaxUpload.js"></script>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>

<script>
	$(document).ready(function(){
		CKEDITOR.replace("contentA"); 
	});

 //保存合同附件		
  $("#uploadFile").fileUpload({
  		onSubmit:function() {
			$("#uploadFile").attr("disabled", true);
		},
		onComplete:function(file,dt){
			var data=eval("("+dt+")");
			if(data.success){
				$("#fileName").val(data.fileName);					
				$("#pid").val(data.file);
				
				//异步提交合同附件
				var fileName = data.fileName;
				var contractId = $("#contractId").val();
				var attachment = data.file;
				$.ajax({
				   url : "/vst_back/supp/suppContractCheck/addContracAttachment.do",
				   data : {contractId:contractId,attachment:attachment,fileName:fileName},
				   type:"POST",
				   dataType:"JSON",
				   success : function(result){
				   		if(result.code=="success"){
				   		}else {
				   		  	alert(result.message);
				   		}
				   }
				});	
			}else{
				alert(data.msg);
			}
			$("#uploadFile").removeAttr("disabled");
		}
 });


  </script>	
	