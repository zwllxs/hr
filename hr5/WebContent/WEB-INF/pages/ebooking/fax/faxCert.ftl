<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<div style="margin:0 auto;width:45%;height:100%;">
 <table class="mt20">
   <tr style="height:60px">
    <td><input type="button" id="downLoadPdf" value="下载PDF" class="btn btn-small w5"/> </td>
    <td>&nbsp;</td>
    <s:if test="ebkFaxTask.disableSend=='false'">
    <td align="right">实际发送号码：<input type="text" style="height:20px" id="toFax" value="${ebkCertificate.toFax!''}"/> <input type="button" id="sendFaxNow" value="立即发送" class="btn btn-small w5"/> <input type="hidden" id="updatebtn" value="修改" class="btn btn-small w5"/></td>
   	</s:if>
   </tr>
   <tr>
    <td colspan="3" >${faxCertContent!''}</td>
   </tr>
 </table>
 </div>
<#include "/base/foot.ftl"/>
</body>
</html>
 <script type="text/javascript">
 var ebkFaxTaskId=${ebkFaxTask.faxTaskId!''};
 var ebkCertificateId=${ebkFaxTask.certifId!''};
 $(function(){
	 $("#sendFaxNow").click(function(){
		 var toFax = $("#toFax").val();
		 if(toFax==""){
			 alert("发送传真的号码为空！请输入传真号码");
			 return;
		 }
	 		$.confirm("确定发送？", function () {
	 		var param = {'faxTaskIds':ebkFaxTaskId,'toFax':toFax};
			$.ajax({
				url:"/vst_back/ebooking/fax/sendFax.do",
				type : "post",
				dataType:"JSON",
				data:param,
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message);
				}else {
					$.alert(result.message);
				}
				}
			});
			});
	 });
	 
	 $("#downLoadPdf").click(function(){
		 window.open("/vst_back/ebooking/fax/downloadPdf.do?faxTaskId="+ebkFaxTaskId);
	 });
 });
 </script>