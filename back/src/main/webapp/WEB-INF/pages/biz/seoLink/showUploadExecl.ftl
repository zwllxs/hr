
<form action="#" enctype="multipart/form-data" method="post" target="ajaxUpload"  id="seoLinkImportForm">
    <table class="p_table form-inline">
    <tbody>
    	<input type="hidden" name ="seoType" id="seoType" value=${seoType}>
          <tr> 
            <td>请选择文件：</td>  
            <td class="querytd">
               <input type="hidden" id="pid" />
			   <input type="hidden" id="fileName" />
               <input  type="file" id="uploadFile" style="width:80px" serverType="COM_AFFIX" name="excel" onchange="javascript:getFileName(this);"/> 
               &nbsp;支持xls、xlsx格式&nbsp;
               <input type="button" class="btn btn-small w5" value="导入" onclick="javascript:return checkForm();"/></div>
            </td>
        </tr> 
         <div id="result"></div>
    </tbody>
</table>
</form>

<script type="text/javascript">
	var basePath = "/vst_back/pet";
</script>
<script src="/vst_back/js/jquery.form.js"></script>

<script>
function checkForm(){
    if($.trim($("#uploadFile").val())==''){
        alert("上传文件不可以为空");
        return false;
    }
    
    var filePath =$("#uploadFile").val();
    if (filePath.lastIndexOf(".") == -1) {
        alert("文件类型错误");
        return;
    }else {
         var suffix=filePath.substring(filePath.lastIndexOf("."));
         if(!(suffix=='.xls'||suffix=='.xlsx')){
             alert("文件名后缀不对请重新上传!");
         }
    }
    $("#result").html("");
	var action="/vst_back/biz/seoLink/importExcelData.do";
	
	var options = { 
            url:action,
            dataType:"",
            async:false,
            type : "POST", 
            success:function(data){ 
                if(data== "success") {
                    alert("操作成功!");
                    importDialog.close();
				    var url = "/vst_back/biz/seoLink/findSeoLinkList.do";
				    $("#searchForm").attr("action",url);
		  			$("#searchForm").submit();
                } else { 
               		 var arrList = data.split(","); 
               		 if(arrList.length > 0){
               		 	$("#result").append("<tr><td> 请修正完以下问题再提交：</td></tr>");
               		 }
               		 for (i = 1; i < arrList.length; i++)
				    {
				    	$("#result").append("<tr><td>"+ arrList[i] +"</td></tr>");
				    }
                } 
            }, 
            error:function(){ 
                alert("操作超时！"); 
            } 
        };
        $('#seoLinkImportForm').ajaxSubmit(options);
    return true;
}
	
function getFileName(obj) {
	var filePath = obj.value;
	if (filePath.lastIndexOf(".") == -1) {
		alert("文件类型错误");
		return;
	}else {
		 var suffix=filePath.substring(filePath.lastIndexOf("."));
		 if(!(suffix=='.xls'||suffix=='.xlsx')){
			 alert("文件名后缀不对请重新上传!");
		 }else{
			 $("#fileName").val(suffix);
		 }
	}

}
</script>
