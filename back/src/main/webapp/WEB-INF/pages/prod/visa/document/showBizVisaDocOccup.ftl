<!DOCTYPE html>
<html>
	<head>
	
	<#include "/base/head_meta.ftl"/>
	</head>
	<body>
		<div class="iframe_header">
		        <ul class="iframe_nav">
		            <li>签证&gt;</li>
		            <li class="active">签证材料维护</li>
		        </ul>
		</div>
		<div class="iframe_search">
			<a id="add_visa_document_button" class="btn btn_cc1 mb20">新增签证材料</a>
			<a id="back_button" class="btn btn_cc1 mb20">返回</a>
			<div class="p_box box_info clearfix  mt20">
				<table class="p_table form-inline" style="border:0px;">
			            <tbody>
			                <tr>
			                	<td width="130"><h2 class="f16">签证国家:</h2>
			                	</td>
			                	<td>
			                		<span style="font-weight:bold;font-size:14px;" id="country">${bizVisaDoc.country}</span>
			                	</td>
			                	<td width="100"><h2 class="f16">签证类型:</h2>
			                	</td>
			                	<td>
			                		<span style="font-weight:bold;font-size:14px;" id="visaType">
			                		<#list vistTypeList as bizDict>
		                    			<#if bizVisaDoc.visaType==bizDict.dictId>${bizDict.dictName}</#if>
					  				</#list>
			                		</span>
			                	</td>
			                	<td width="100"><h2 class="f16">送签城市:</h2>
			                	</td>
			                	<td>
			                		<span style="font-weight:bold;font-size:14px;" id="city">
			                		<#list vistCityList as bizDict>
		                    			<#if bizVisaDoc.city==bizDict.dictId>${bizDict.dictName}</#if>
					  				</#list>
					  				</span>
			                	</td>
			                </tr>
			             </tbody>
			     </table>
			     <table class="p_table table_center">
			     		<thead>
		                    <tr>
		                	<th style="width:140px;">所属人群</th>
		                    <th>操作</th>
		                    </tr>
		                </thead>
			            <tbody>
			            <#if bizVisaDocOccupList?? && bizVisaDocOccupList?size &gt; 0>
			           	 <#list bizVisaDocOccupList as bizVisaDocOccup> 
				                <tr>
				                	<td>
				                	<#list occupTypeList as occupType>
				                		<#if occupType.code==bizVisaDocOccup.occupType>${occupType.cnName}</#if>
				                	</#list>
				                	</td>
				                	<td >
				                		<a onclick="showBizVisaDocDetail(${bizVisaDocOccup.docId},${bizVisaDocOccup.occupId});" href="javascript:void(0);" class="ml20">编辑材料明细</a>
				                		<a onclick="copyBizVisaDocOccup(${bizVisaDocOccup.docId},${bizVisaDocOccup.occupId});" href="javascript:void(0);" class="ml20">复制新增</a>
				                		<a onclick="delBizVisaDocOccup(this,${bizVisaDocOccup.docId},${bizVisaDocOccup.occupId});"  href="javascript:void(0);" class="ml20">删除</a>
				                		 <a href="javascript:void(0);" class="showLogDialog ml20" param="{'objectId':${bizVisaDocOccup.occupId},'objectType':'VISA_DOCUMNET_DETAIL'}">操作日志</a>
				                	</td>
				                </tr>
			                </#list>
			               </#if>
			            </tbody>
			     </table>
			</div>
			
		</div>
		<#include "/base/foot.ftl"/>
	</body>
</html>
<script> 
	var visaDocumentDialog;
	var showLogDialog;
	$(document).ready(function(){
		
		$("#add_visa_document_button").click(function(){
			visaDocumentDialog = 
			new xDialog("/vst_back/visa/visaDoc/showAddBizVisaDocOccup.do",
			{"docId":${bizVisaDoc.docId}},
			{title:"编辑签证材料所属人群",width:400,height:400});
		});
		
		$("#back_button").click(function(){
			location.href="/vst_back/visa/visaDoc/findBizVisaDocList.do";
		});
		
		
	});
	
	function copyBizVisaDocOccup(docId,occupId){
			visaDocumentDialog = 
			new xDialog("/vst_back/visa/visaDoc/showAddBizVisaDocOccup.do",
			{"occupId":occupId,"docId":docId},
			{title:"编辑签证材料所属人群",width:400,height:400});
	}
	
	function showBizVisaDocDetail(docId,occupId){
			visaDocumentDialog = 
			new xDialog("/vst_back/visa/visaDoc/showBizVisaDocDetail.do",
			{"occupId":occupId,"docId":docId},
			{title:"编辑签证材料明细",width:1000,height:1000});
	}
	
	function delBizVisaDocOccup(obj,docId,occupId){
		 if(confirm('确定要删除此材料吗(删除此材料将会级联删除相应材料明细等)'))
		 	$.ajax({
					url : "/vst_back/visa/visaDoc/delBizVisaDocOccup.do",
					type : "post",
					dataType : 'json',
					data : {"occupId":occupId,"docId":docId},
					success : function(result) {
						if(result.code=='success'){
					 		$.alert(result.message,function(){
					 			$(obj).parents("tr").remove();
					 		});
					 	}else{
					 		$.alert(result.message);
					 	}
						
					}
				});
	}
	
</script>
