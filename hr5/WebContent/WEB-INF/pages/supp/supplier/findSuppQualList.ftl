<div class="iframe_search">

<form action="#" method="get" id="qualForm">
	<input type="hidden" name="supplierId" id="supplierId" value="${supplierId}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
                <td class="p_label"><i class="cc1">*</i>审核状态</td>            
                <td>
                	<input type="radio" id="qualStatus" name="qualStatus" style="width:30px;" value="Y" required />有效
                	<input type="radio" id="qualStatu" name="qualStatus" value="N" required />无效
                 	<div  id="qualStatusError"></div> 
                </td>                    
                                  
                <td class="p_label"><i class="cc1">*</i>资质到期时间：
                   <input type="text" name="endTime" class="Wdate" id="d432" onFocus="WdatePicker({readOnly:true})" required=true>
                   <div  id="endTimeError"></div>   
                </td>
            </tr> 
			<tr>
				<td class="p_label" style="width:80px;">资质副本上传:</td>
                 <td> 
                   <select name="qualType" id="qualType">
                    	<#list qualTypeList as qualType>
                    		<option value="${qualType.code!''}">${qualType.cnName!''}</option>
                        </#list>
                    </select>     
               	</td>	
                <td >
					<input type="hidden" id="attachment" name="attachment"/>
					<input type="hidden" id="fileName" name="fileName"/>
					<input type="button" value="  附  件  " id="uploadFile" serverType="COM_AFFIX"/>
				</td>
            </tr>
            <tr>
                <td colspan="3"><button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="saveButton">保存</button> </td>
            </tr>
            <tr><td colspan="3"><div id="uploadResult"></div></td></tr>
    </table>
    
    <div></div>
    <div></div>
    
	<table class="p_table table_center">
        <thead>
            <tr>
                <th>资质编号</th>
                <th>结束时间</th>
                <th>审核状态</th>
                <th>附件类型</th>
                <th>附件</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list suppQualAttachVOlist as suppQualAttachVO> 
				<tr>
					<td>${suppQualAttachVO.qualId!''} </td>
					<td>${suppQualAttachVO.endTime?string("yyyy-MM-dd")}</td>
					<td>
						<#if suppQualAttachVO.qualStatus == 'Y'>
							<span style="color:green" class="qualStatus">有效</span>
						<#else>
							<span style="color:red" class="qualStatus">无效</span>
						</#if> 
					</td>
					<td>${suppQualAttachVO.qualTypeName!''} </td>
					<td>
						<#if suppQualAttachVO.attachment??>
							 <a href="/vst_back/pet/ajax/file/downLoad.do?fileId=${suppQualAttachVO.attachment}">下载附件</a>
							 <a href="javascript:void(0);" class="delAttachment" data=${suppQualAttachVO.attachId}>删除附件</a>
						</#if>
					</td>
					<td>
						<a href="javascript:void(0);" class="delQual" data=${suppQualAttachVO.qualId}>删除资质</a>
						<a class="editQualStatus" href="javascript:void(0);" data="${suppQualAttachVO.qualId!''}" data2="${suppQualAttachVO.qualStatus}">${(suppQualAttachVO.qualStatus=='N')?string("设为有效", "设为无效")}</a>
					</td>
				</tr>
			</#list>
        </tbody>
    </table>
</div>
</form>
</div>

<script type="text/javascript">
	var basePath = "/vst_back/pet";
</script>
<script src="/vst_back/js/file/ajaxUpload.js"></script>

<script>
//提交资质审核附件
$("#uploadFile").fileUpload({
	onSubmit:function() {
		$("#uploadFile").attr("disabled", true);
		$("#saveButton").attr("disabled", true);
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
		$("#uploadFile").removeAttr("disabled");
		$("#saveButton").removeAttr("disabled");
	}
 });

//删除附件
$("a.delAttachment").bind("click",function(){
	 var attachId = $(this).attr("data");
	 msg = qualStatus === "N" ? "确认删除 ？" : "确认删除  ？";
	 $.confirm(msg, function () {
		$.ajax({
		   url : "/vst_back/supp/suppQual/delQualAttachment.do",
		   data : {attachId:attachId},
		   type : "POST",
		   dataType : "JSON",
		   success : function(result){
		   		if(result.code=="success"){
		   			qualAddDialog.reload();
		   		}else {
		   		  	alert(result.message);
		   		}
		   }
		});	
	 });
});

//删除资质
$("a.delQual").bind("click",function(){
	 var qualId = $(this).attr("data");
	 msg = qualStatus === "N" ? "确认设为删除 ？" : "确认设为删除  ？";
	 $.confirm(msg, function () {	
		$.ajax({
		   url : "/vst_back/supp/suppQual/delSupplierQual.do",
		   data : {qualId:qualId},
		   type : "POST",
		   dataType : "JSON",
		   success : function(result){
		   		if(result.code=="success"){
		   			qualAddDialog.reload();
		   		}else {
		   		  	alert(result.message);
		   		}
		   }
		});	
	});
});

//设置状态
$("a.editQualStatus").bind("click",function(){
	 var qualId=$(this).attr("data");
	 var qualStatus=$(this).attr("data2") == "N" ? "Y": "N";
	 var url = "/vst_back/supp/suppQual/editStatus.do?qualId="+qualId+"&qualStatus="+qualStatus+"&newDate"+new Date();
	 msg = qualStatus === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		 $.get(url, function(result){
	          qualAddDialog.reload();
	     });
     });
	 return false;
});

//保存资质审核		
$("#saveButton").bind("click",function(){
	// 验证FORM
	if (!$("#qualForm").validate({}).form()) {
		return;
	}
	$.ajax({
	   url : "/vst_back/supp/suppQual/addSuppQual.do",
	   data : $("#qualForm").serialize(),
	   type : "GET",
	   dataType : "JSON",
	   success : function(result){
	   		if(result.code=="success"){
				qualAddDialog.reload();
	   		}else {
	   		  	alert(result.message);
	   		}
	   }
	});			
	return false;
});

</script> 
  
