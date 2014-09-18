<form action="#"   enctype="multipart/form-data" method="post" target="ajaxUpload"  id="contractUpdateForm">
    <table class="p_table form-inline">
    <tbody>
    	<input type="hidden" name ="contractId" id="contractId" value=${contractId}>
          <tr> 
            <td>请选择文件：</td>  
            <td class="querytd">
               <input type="hidden" id="pid" />
			   <input type="hidden" id="fileName" />
               <input  type="file" id="uploadFile" style="width:80px" serverType="COM_AFFIX"/> 支持jpg、gif、pdf、tiff、png格式
            </td>
        </tr> 
    </tbody>
</table>
</form>

<script type="text/javascript">
	var basePath = "/vst_back/pet";
</script>
<script src="/vst_back/js/file/ajaxUpload.js"></script>

<script>

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
						uploadContractDialog.close();
						$.alert(result.message,function(){
				   			$("#searchForm").submit();
				   		});
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
