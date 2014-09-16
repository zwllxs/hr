
<form action="#"  enctype="multipart/form-data" method="post" target="ajaxUpload" id="contractUpdateForm">
    <table class="p_table form-inline">
    <tbody>
    	<input type="hidden" name ="contractId" id="contractId" value=${contractId}>
    	<input type="hidden" name ="supplierId" id="supplierId" value=${supplierId}>
    	
         <tr>
			<td class="p_label">关联合同(${contractId})：</td>
            <td>${contractNo}</td>
        </tr>    
        <tr>
			<td class="p_label" style="width:60px" >变更类型：</td>
            <td style="width:60px">
            	<select name="changeType" id="changeType" onchange="showEndTime()">
                	<#list changeTypeList as changeType>
                		<option value="${changeType.code!''}">${changeType.cnName!''}</option>
                    </#list>
                </select>
            </td>
           </tr> 
           <tr id="end" style="display:none">
			<td class="p_label" style="width:60px" >到期时间：</td>
            <td >            	
              	<input type="text"   id="endTime" name="endTime" class="Wdate" id="d432" value="${endTime}"  onFocus="WdatePicker()" required=true />
            </td>
           </tr>
           <tr> 
            <td class="p_label">上传附件：</td>  
               <td class="querytd">
                    <input type="hidden" id="attachment" name="attachment"/>
					<input type="hidden" id="fileName" name="fileName"/>
					<input type="button" value="附件" id="uploadFile" style="width:80px" serverType="COM_AFFIX"/>
					<div id="uploadResult"></div>
               </td>
            </td>
        </tr> 
		<tr>                   
           <td class="p_label">变更内容说明：</td>                     
            <td>
            	<textarea name="changeDesc" id="changeDesc" cols="90" rows="4" />
            </td> 
        </tr>
    </tbody>
    </table>
</form>
        <button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="contractUpdateButton">保存</button>

<script type="text/javascript">
	var basePath = "/vst_back/pet";
</script>
<script src="/vst_back/js/file/ajaxUpload.js"></script>
 
<script>
function showEndTime()
{   //选择顺延合同,显示到期时间
   if($("#changeType").val()=="EXTENDED_CONTRACT")  
   {    $("#end").show();    	
   }else{
     $("#end").hide();
    $("#endTime").val(null); 
   }
}
    
 //保存变更附件		
$("#uploadFile").fileUpload({
	onSubmit:function() {
		$("#uploadFile").attr("disabled", true);
	},
	onComplete:function(file,dt){
		var data=eval("("+dt+")");
		if(data.success){
			$("#fileName").val(data.fileName);
			$("#attachment").val(data.file);
			$("#uploadResult").append("上传文件：" +data.fileName);
		}else{
			alert(data.msg);
		}
		$("#uploadFile").attr("disabled","disabled");
	}
 });

//保存
$("#contractUpdateButton").bind("click",function(){
	$.ajax({
	   url : "/vst_back/supp/suppContractCheck/updateContractChange.do",
	   data : $("#contractUpdateForm").serialize(),
	   type:"POST",
	   dataType:"JSON",
	   success : function(result){
	   		if(result.code=="success"){
	   			contractUpdateDialog.close();
		   		$.alert(result.message,function(){
		   			$("#searchForm").submit();
		   		});
	   		}else {
	   		  	$.alert(result.message);
	   		}
	   }
	});						
}); 
  </script>
