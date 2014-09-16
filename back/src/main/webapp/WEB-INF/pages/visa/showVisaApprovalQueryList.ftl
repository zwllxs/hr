<#--页眉-->
<#import "/base/pagination.ftl" as pagination>
<!DOCTYPE html>
<html>
	<head>
	<#include "/base/head_meta.ftl"/>
	</head>
	<body>
		<#--页面导航-->
		<div class="iframe_header">
		        <i class="icon-home ihome"></i>
		        <ul class="iframe_nav">
		            <li><a href="#">首页</a> &gt;</li>
		            <li><a href="#">签证材料审核</a> &gt;</li>
		            <li class="active">签证材料审核列表</li>
		        </ul>
		</div>
	
		<#--查询条件表单区域 start-->
		<div class="iframe_search">
			<form id="searchForm" action="/vst_back/visa/approval/queryVisaApprovalQueryList.do" method="post" onsubmit="return false">
				<table class="s_table  form-inline">
		            <tbody>
		               <tr>
		                    <td class="w6 s_label">订单编号：</td>
		                    <td class="w13"><input type="text" class="w13" name="searchOrderId" value="${visaApprovalVo.searchOrderId!''}" number=true ></td>
		                    <td class="w10 s_label">订单状态：</td>
		                    <td class="w15">
		                        <select class="w15" name="searchOrderStatus">
		                        	<option value="" selected="">全部</option>
		                            <option value="NORMAL" <#if visaApprovalVo.searchOrderStatus == 'NORMAL'>selected</#if>>正常</option>
		                            <option value="CANCEL" <#if visaApprovalVo.searchOrderStatus == 'CANCEL'>selected</#if>>取消</option>
		                        </select>
		                    </td>
		                </tr>
		                 <tr>
		                    <td class="w6 s_label">签证国家：</td>
		                    <td class="w13">
		                    	<input type="text" name="searchVisaCountryName" id="countryName" value="${visaApprovalVo.searchVisaCountryName!''}" >
                    			<input type="hidden" value="${visaApprovalVo.searchVisaCountry!''}" name="searchVisaCountry" id="countryId" >
		                    </td>
		                    <td class="w10 s_label">签证类型：</td>
		                    <td class="w15">
		                        <select class="w15" name="searchVisaType">
		                        	<option value="" selected="">全部</option>
									 <#list vistTypeList as bizDict>
					                    <option value="${bizDict.dictId}" <#if visaApprovalVo?? && visaApprovalVo.searchVisaType == bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
								  	</#list>
		                        </select>
		                    </td>
		                    <td class="w10 s_label">送签城市：</td>
		                    <td class="w15">
		                        <select class="w15" name="searchVisaCity">
		                        	<option value="" selected="">全部</option>
									<#list vistCityList as bizDict>
					                    <option value="${bizDict.dictId}" <#if visaApprovalVo?? && visaApprovalVo.searchVisaCity == bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
								  	</#list>
		                        </select>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w6 s_label">游客姓名：</td>
		                    <td class="w13"><input type="text" class="w13" name="searchName" value="${visaApprovalVo.searchName!''}"></td>
		                    <td class="w10 s_label">出游日期：</td>
		                    <td class="w8">
		                    	<input type="text" <#if visaApprovalVo?? && visaApprovalVo.searchStartVisitDate??> value="${visaApprovalVo.searchStartVisitDate?string('yyyy-MM-dd')}"</#if> name="searchStartVisitDate" errorEle="selectDate" class="Wdate input-text" id="searchStartVisitDate" onFocus="WdatePicker({readOnly:true})" />
		                    </td>
		                    <td class="w2">&nbsp;-&nbsp;</td>
		                    <td class="w8">
		                    	<input type="text" <#if visaApprovalVo?? && visaApprovalVo.searchEndVisitDate??> value="${visaApprovalVo.searchEndVisitDate?string('yyyy-MM-dd')}"</#if>  name="searchEndVisitDate" errorEle="selectDate" class="Wdate input-text" id="searchEndVisitDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'searchStartVisitDate\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'searchStartVisitDate\',{d:0});}'})" />
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w6 s_label">材料状态：</td>
		                    <td class="w15">
								<select class="w15" name="searchDocStatus">
	                    	 		<option value="">请选择</option>
				    				<#list docStatusTypeList as list>
					                    	<option value=${list.code!''} <#if visaApprovalVo!=null && visaApprovalVo.searchDocStatus==list.code>selected</#if> >${list.cnName!''}</option>
					                </#list>
		                        </select>
		                    </td>
		                    <td class="w10 s_label">审核状态：</td>
		                    <td class="w15">
		                        <select class="w15" name="searchApprStatus">
	                    	 		<option value="">请选择</option>
				    				<#list apprStatusTypeList as list>
					                    	<option value=${list.code!''} <#if visaApprovalVo!=null && visaApprovalVo.searchApprStatus==list.code>selected</#if> >${list.cnName!''}</option>
					                </#list>
		                        </select>
		                    </td>
		                    <td class="w10 s_label">送/出签状态：</td>
		                    <td class="w15">
		                        <select class="w15" name="searchVisaStatus">
	                    	 		<option value="">请选择</option>
				    				<#list visaStatusTypeList as list>
					                    	<option value=${list.code!''} <#if visaApprovalVo!=null && visaApprovalVo.searchVisaStatus==list.code>selected</#if> >${list.cnName!''}</option>
					                </#list>
		                        </select>
		                    </td>
		                    <td  class="w15">
		                    	<div class="operate" style="text-align:center">
		                    		<a class="btn btn_cc1" id="searchbutton">查询</a>&nbsp;
		                    	</div>
		                    </td>
		                </tr>
		            </tbody>
		        </table>
			</form>
			<div class="operate mt20" style="text-align:left">
				<a class="btn btn_cc1" id="batchUploadButton" onclick="batchUploadFile();">批量上传文件</a>&nbsp;&nbsp;
				<a class="btn btn_cc1" id="batchSendDocButton" onclick="batchSendDoc();">批量寄送/退还材料</a>&nbsp;&nbsp;
				<a class="btn btn_cc1" id="batchReturnDepositButton" onclick="batchReturnDeposit();">批量退回保证金</a>&nbsp;&nbsp;
				<a class="btn btn_cc1" id="batchChangeDocStatusButton" onclick="batchChangeDocStatus();">批量更新材料状态</a>&nbsp;&nbsp;
				<a class="btn btn_cc1" id="batchChangeVisaStatusButton" onclick="batchChangeVisaStatus();">批量更新送/出签状态</a>&nbsp;&nbsp;
				<a class="btn btn_cc1" id="batchExportButton" >导出材料审核表</a>
			</div>
		</div>
		<#--查询条件表单区域end-->
<#--结果显示-->
    <#if pageParam??>
    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
		 <div class="p_box">
   			 	<table class="p_table table_center">
               		<thead>
                		<tr>
                			<th><input type="checkbox" name="allCk" value="" ></th>
                            <th>订单编号</th>
                            <th>订单状态</th>
                            <th>游客姓名</th>
                            <th>签证产品</th>
                            <th>材料状态</th>
                            <th>审核状态</th>
                            <th>送/出签状态</th>
                            <th>材料最晚提交时间</th>
                            <th>游玩日期</th>
                            <th class="w22">操作</th>
                        </tr>
                     </thead>
   					 <tbody>
                        <#list pageParam.items as visaApproval>
                        	<tr>
                        		<td><input type="checkbox" name="visaApprovalCk" apprStatus="${visaApproval.apprStatusName}" userName="${visaApproval.name}" value="${visaApproval.visaApprovalId}" orderId="${visaApproval.orderId}"></td>
                                <td><a title="点击查看订单详情" href="/vst_order/order/ordCommon/showOrderDetails.do?orderId=${visaApproval.orderId}" target="_blank">
										${visaApproval.orderId}
									</a></td>
                                <td>
                                	<#if visaApproval.orderStatus=='CANCEL'>
					            		取消
					            	<#elseif visaApproval.orderStatus=='NORMAL'>
					            		正常
					            	</#if>
                                </td>
                                <td>${visaApproval.name}</td>
                                <td>${visaApproval.productName}</td>
                                <td>
                                	 ${visaApproval.docStatusName}
                                </td>
                                <td>
                                	${visaApproval.apprStatusName}
                                </td>
                                <td>
                                	${visaApproval.visaStatusName}
                                </td>
                                <td><#if visaApproval.lastDays??>${visaApproval.lastDays?string('yyyy-MM-dd')}</#if></td>
                                <td><#if visaApproval.visitTime??>${visaApproval.visitTime?string('yyyy-MM-dd')}</#if></td>
                                <td style="text-align:left;">
                                	<a href="javascript:void(0);" onclick="confirmDocument(${visaApproval.visaApprovalId},${visaApproval.suppGoodsId});">材料确认</a>&nbsp;
                                	<a href="javascript:void(0);" onclick="docDetailApproval(${visaApproval.visaApprovalId});">材料审核</a>&nbsp;
                                	<a href="javascript:void(0);" onclick="sendDoc(${visaApproval.visaApprovalId});">材料寄送与退还</a>&nbsp;<br/>
                                	<a href="javascript:void(0);" onclick="changeDocStatus(${visaApproval.visaApprovalId});">材料状态</a>&nbsp;
                                	<a href="javascript:void(0);" onclick="changeVisaStatus(${visaApproval.visaApprovalId});">送/出签状态</a>&nbsp;<br/>
                                	<a href="javascript:void(0);" onclick="depositApproval(${visaApproval.visaApprovalId});">保证金</a>&nbsp;
                                	<a href="javascript:void(0);" onclick="uploadFile(${visaApproval.visaApprovalId});">上传文件</a>&nbsp;
                                	<a href="javascript:void(0);" onclick="showVisaApprovalLogList(${visaApproval.visaApprovalId});">操作日志</a>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                   	<#if pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
						</div> 
					</#if>
		</div>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关结果，重新输入相关条件查询！</div>
    </#if>
    </#if>
    <script>
    	$(document).ready(function(){
				 //查询
				$("#searchbutton").click(function(){
					//加载签证审核
					loadVisaApprovalList();
				});
				
				//设置checkbox选择,全选 
				$("input[type=checkbox][name=allCk]").click(function(){ 
					if(this.checked){
						$("input[name='visaApprovalCk']").attr("checked",true);
					  }else{
						  $("input[name='visaApprovalCk']").attr("checked",false);
					  }
				});
				
				//设置checkbox选择,单个元素选择 
				$("input[type=checkbox][name=visaApprovalCk]").click(function(){ 
					var ckLength=$("input[type=checkbox][name=visaApprovalCk]").length;
					var allLength=$("input[type=checkbox][name=visaApprovalCk]:checked").length;
					if(ckLength==allLength){
						$("input[name='allCk']").attr("checked",true);
					}else{
						  $("input[name='allCk']").attr("checked",false);
					  }
				});
			});
    </script>
		<form id="exportForm" action="/vst_back/visa/approval/exportXLSForVisaList.do" method="post">
				<input type="hidden" name="visaApprovalIds" value="">
		</form>
		<#include "/base/foot.ftl"/>
		<script>
			var confirmDocumentDialog;
			var docDetailApprovalDialog;
			var uploadFileDialog;
			var showLogDialog;
			var sendDocDialog;
			var changeDocStatusDialog;
			var changeVisaStatusDialog;
			var batchUploadFileDialog;
			var batchSendDocDialog;
			var batchChangeDocStatusDialog;
			var batchChangeVisaStatusDialog;
			vst_pet_util.commListSuggest("#countryName", "#countryId",'/vst_back/biz/district/searchDistrictList.do','${suppJsonList}');
			
			$(document).ready(function(){
				 //查询
				$("#searchbutton").click(function(){
					//加载签证审核
					loadVisaApprovalList();
				});
			});
			
			//加载签证审核
			function loadVisaApprovalList(){
				if(!$("#searchForm").validate().form()){
						return false;
				 }

				 //ajax加载结果
				$("#searchForm").submit();
			}
			
			function confirmDocument(visaApprovalId,suppGoodsId){
				confirmDocumentDialog = 
				new xDialog("/vst_back/visa/approval/showConfirmDocument.do",
				{"visaApprovalId":visaApprovalId,"suppGoodsId":suppGoodsId},
				{title:"签证材料确认",width:400,height:400});
			}
			
			function docDetailApproval(visaApprovalId){
				var visaApprovalIds=visaApprovalId+"";
				 $.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		docDetailApprovalDialog = 
							new xDialog("/vst_back/visa/approval/showDocumentDetailApproval.do",
							{"visaApprovalId":visaApprovalId},
							{title:"签证材料审核",width:800});
					 	}
					}
				});
			}
			
			function sendDoc(visaApprovalId){
				var visaApprovalIds=visaApprovalId+"";
					$.ajax({
						url : "/vst_back/visa/approval/checkDocConfirm.do",
						type : "post",
						dataType : 'json',
						data : {visaApprovalIds:visaApprovalIds},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else if(!result.attributes.isDoc){
						 		$.alert("请先进行材料确认!");
						 	}else{
						 		sendDocDialog = 
									new xDialog("/vst_back/visa/approval/showSendDoc.do",
									{"visaApprovalId":visaApprovalId},
									{title:"材料寄送与退还",width:1000,height:800});
						 	}
						}
					});
			}
			
			function changeDocStatus(visaApprovalId){
				var visaApprovalIds=visaApprovalId+"";
				$.ajax({
						url : "/vst_back/visa/approval/checkDocConfirm.do",
						type : "post",
						dataType : 'json',
						data : {visaApprovalIds:visaApprovalIds},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else if(!result.attributes.isDoc){
						 		$.alert("请先进行材料确认!");
						 	}else{
									changeDocStatusDialog = 
									new xDialog("/vst_back/visa/approval/showChangeDocStatus.do",
									{"visaApprovalId":visaApprovalId},
									{title:"材料状态",width:385,height:220});
						 	}
						}
					});
			}
			
		    function changeVisaStatus(visaApprovalId){
		    	var visaApprovalIds=visaApprovalId+"";
				$.ajax({
						url : "/vst_back/visa/approval/checkDocConfirm.do",
						type : "post",
						dataType : 'json',
						data : {visaApprovalIds:visaApprovalIds},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else if(!result.attributes.isDoc){
						 		$.alert("请先进行材料确认!");
						 	}else{
						 		changeVisaStatusDialog = 
									new xDialog("/vst_back/visa/approval/showChangeVisaStatus.do",
									{"visaApprovalId":visaApprovalId},
									{title:"签证状态",width:280,height:320});
						 	}
						}
					});
			}
			
			function depositApproval(visaApprovalId){
				var visaApprovalIds=visaApprovalId+"";
				$.ajax({
						url : "/vst_back/visa/approval/checkDocConfirm.do",
						type : "post",
						dataType : 'json',
						data : {visaApprovalIds:visaApprovalIds},
						success : function(result) {
							if(!result.success){
						 		$.alert(result.message);
						 	}else if(!result.attributes.isDoc){
						 		$.alert("请先进行材料确认!");
						 	}else{
						 		docDetailApprovalDialog = 
								new xDialog("/vst_back/visa/approval/showDepositApproval.do",
								{"visaApprovalId":visaApprovalId},
								{title:"添加保证金",width:1000,height:800});
						 	}
						}
					});
			}
			
			function uploadFile(visaApprovalId){
				var visaApprovalIds=visaApprovalId+"";
				 $.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		uploadFileDialog = 
							new xDialog("/vst_back/visa/approval/showUploadFile.do",
							{"visaApprovalId":visaApprovalId},
							{title:"上传文件",width:900});
					 	}
					}
				});
			}
			
			function showVisaApprovalLogList(visaApprovalId){
				var productId=$("#productId",window.parent.document).val();
					showLogDialog = 
					new xDialog("/vst_back/visa/approval/showVisaApprovalLogList.do",
					{"visaApprovalId":visaApprovalId},
					{title:"查看日志",width:800});
			}
			
			function batchUploadFile(){
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				if(checkLength<=0){
					$.alert("请选择需要上传文件的签证审核记录");
					return false;
				}
				$("[input[name='visaApprovalCk'][checked]").each(function(){     
						visaApprovalIds+=$(this).val()+",";
				 })
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				//alert(visaApprovalIds);
				 $.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		batchUploadFileDialog = 
							new xDialog("/vst_back/visa/approval/showBatchUploadFile.do",
							{"visaApprovalIds":visaApprovalIds},
							{title:"上传文件",width:600,height:500});
					 	}
					}
				});
				
			}
			
			function batchSendDoc(){
				
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				if(checkLength<=0){
					$.alert("请选择需要寄送材料的签证审核记录");
					return false;
				}
				$("[input[name='visaApprovalCk'][checked]").each(function(){     
						visaApprovalIds+=$(this).val()+",";
				 })
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				//alert(visaApprovalIds);
				
				$.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		batchSendDocDialog = 
							new xDialog("/vst_back/visa/approval/showBatchSendDoc.do",
							{"visaApprovalIds":visaApprovalIds},
							{title:"材料寄送与退还",width:1000,height:800});
					 	}
					}
				});
			}
			
			function batchChangeDocStatus(){
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				if(checkLength<=0){
					$.alert("请选择需要更改的材料状态");
					return false;
				}
				$("[input[name='visaApprovalCk'][checked]").each(function(){     
						visaApprovalIds+=$(this).val()+",";
				 })
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				
				$.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		batchChangeDocStatusDialog = 
							new xDialog("/vst_back/visa/approval/showBatchChangeDocStatus.do",
							{"visaApprovalIds":visaApprovalIds},
							{title:"材料状态",width:385,height:220});
					 	}
					}
				});
				
			}
			
			function batchChangeVisaStatus(){
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				if(checkLength<=0){
					$.alert("请选择需要更改的材料状态");
					return false;
				}
				$("[input[name='visaApprovalCk'][checked]").each(function(){     
						visaApprovalIds+=$(this).val()+",";
				 })
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				$.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		batchChangeVisaStatusDialog = 
							new xDialog("/vst_back/visa/approval/showBatchChangeVisaStatus.do",
							{"visaApprovalIds":visaApprovalIds},
							{title:"签证状态",width:280,height:320});
					 	}
					}
				});
				
			}
			
			function batchReturnDeposit(){
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				if(checkLength<=0){
					$.alert("请选择需要退回保证金的签证审核记录");
					return false;
				}
				$("[input[name='visaApprovalCk'][checked]").each(function(){     
						visaApprovalIds+=$(this).val()+",";
				 })
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				$.ajax({
					url : "/vst_back/visa/approval/checkDocConfirm.do",
					type : "post",
					dataType : 'json',
					data : {visaApprovalIds:visaApprovalIds},
					success : function(result) {
						if(!result.success){
					 		$.alert(result.message);
					 	}else if(!result.attributes.isDoc){
					 		$.alert("请先进行材料确认!");
					 	}else{
					 		if(confirm('确定要退回吗?'))
							 $.ajax({
								url : "/vst_back/visa/approval/batchReturnDeposit.do",
								type : "post",
								dataType : 'json',
								data : {visaApprovalIds:visaApprovalIds},
								success : function(result) {
									if(!result.success){
								 		$.alert(result.message);
								 	}else{
								 		$.alert(result.message);
								 	}
								}
							});
					 	}
					}
				});
				
			}
			
			
			//导出
			$("#batchExportButton").bind("click",function(){
				var visaApprovalIds="";
				var checkLength=$("[input[name='visaApprovalCk'][checked]").length;
				var orderId="";
				var checkOrderId=true;
				var userName = "";
				$("[input[name='visaApprovalCk'][checked]").each(function(index,element){ 
						visaApprovalIds+=$(this).val()+",";    
						if($(this).attr("apprStatus")=="未审核"){
							userName=userName+$(this).attr("userName")+",";  
						} 
						if(index==0){
							orderId=$(this).attr("orderId");
						}
						if(orderId!=$(this).attr("orderId")){
							checkOrderId=false;
						}
				 })
				if(visaApprovalIds.length<=0){
					$.alert("请选择需要导出的签证审核记录");
					return false;
				}
				 if(userName.length>0){
					  userName = userName.substring(0,userName.lastIndexOf(","));
					 if(!confirm("用户名为:'"+userName+"'未选择人群,无法下载材料! 是否继续下载?")){
						 return;
					 }
				  }
				 if(!checkOrderId){
					$.alert("存在多个订单号,不予以导出材料审核表!");
					return false;
				}
				visaApprovalIds=visaApprovalIds.substr(0,visaApprovalIds.length-1);
				
				$("[input[type=hidden][name='visaApprovalIds']").val(visaApprovalIds);
			  	$("#exportForm").submit();
			});
			
		function IsNum(e){
			var k = window.event ? e.keyCode : e.which;
			if (((k >= 48) && (k <= 57)) || k == 8 || k == 0) { 
           	}else{
				if (window.event) {
		                    window.event.returnValue = false;   
		             } else {  
		 			e.preventDefault(); //for firefox 
				}
	 		} 
  		}
		</script>
		<script src="/vst_back/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	</body>
</html>