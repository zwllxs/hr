<form action="#"   enctype="multipart/form-data" method="post" target="ajaxUpload"  id="templateUpdateForm">
    <table class="p_table form-inline">
    <tbody>
     	<input type="hidden" name ="detailId" id="detailId" value=${detailId}>
    	<input type="hidden" name ="docId" id="docId" value=${docId}>
    	<input type="hidden" name ="occupId" id="occupId" value=${occupId}>
          <tr> 
            <td>请选择文件：</td>  
            <td class="querytd">
               <input type="hidden" id="pid" />
			   <input type="hidden" id="fileName" />
               <input  type="file" id="uploadFile" style="width:140px" serverType="COM_AFFIX"/>
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
			var detailId = $("#detailId").val();
			var attachment = data.file;
			var docId = $("#docId").val();
			var occupId = $("#occupId").val();
			$.ajax({
			   url : "/vst_back/visa/visaDoc/addBizVisaDetailTemplate.do",
			   data : {docId:docId,occupId:occupId,detailId:detailId,attachment:attachment,fileName:fileName},
			   type:"POST",
			   dataType:"JSON",
			   success : function(result){
			   		if(result.code=="success"){
						uploadTemplateDialog.close();
						$.alert(result.message,function(){
							 $("#mark").empty();
							$(result.attributes.bizVisaDocDetailList).each(function(i){
							    $that =$(this);
							    var temp = "<tr><td>"+$that.attr('title')+"</td><td>"+$that.attr('content')+"</td><td>";
								$($that.attr('bizVisaDetailTemplateList')).each(function(i){
									temp = temp +"<a href='javascript:void(0);' onclick='delBizVisaDetailTemplate(this,"+$(this).attr('templateId')+")' >"+$(this).attr('templateName')+"<i class='e_icon icon-error'></i></a>";
								}); 
								temp = temp + "</td><td>"+$that.attr('seq')+"</td><td><a href='javascript:void(0);' onclick='editBizVisaDocDetail(this,"+$that.attr('detailId')+");' class='ml20'>修改</a><a href='javascript:void(0);' onclick='delBizVisaDocDetail("+$that.attr('detailId')+")' class='ml20'>删除</a><a href='javascript:void(0);' onclick='showUploadTemplate("+$that.attr('detailId')+")' class='ml20'>上传文件</a></td></tr>";
						 		$("#mark").append(temp);
						 	}); 
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
