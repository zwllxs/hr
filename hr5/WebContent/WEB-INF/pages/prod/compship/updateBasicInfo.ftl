<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
</head>
<body>
	<div class="iframe_content mt10">
		<form action="/vst_back/prod/cruiseCombinationProduct/addProduct.do" method="post" id="dataForm">
			<input type="hidden" name="senisitiveFlag" value="N">
			<div class="p_box box_info">
				<div class="box_content">
					<table class="e_table form-inline">
						<tr>
							<td class="e_label"><i class="cc1">*</i>产品ID</td>
							<td><label style="color: red;">&nbsp;${prodProduct.productId}</label>
							</td>
						</tr>
		                <tr>
		                	<td class="e_label" valign="top"><i class="cc1">*</i>产品名称：</td>
		                    <td rowspan="1" valign="top">
    		                    <input type="hidden" id="categoryId" name="bizCategoryId" value="${prodProduct.bizCategoryId}" required=true>
	                			<input type="hidden" id="categoryName" name="bizCategory.categoryName" value="${prodProduct.bizCategory.categoryName}" >
		                    	<input type="hidden" class="w35" name="productId" id="upProductId" value="${prodProduct.productId}">
		                    	<input type="text" class="w35" name="productName" maxlength="50" value="${prodProduct.productName}" id="productName" required=true>
		                  		 <div id="productNameError"></div>
		                  		 <table>
		                  		 	<tr>
										<td>
											<span style="color:grey">命名规则：【邮轮公司-邮轮名称】目的地几晚几天[出发港口-停靠港口-停靠港口-下船港口/促销方式]</span>
										</td>
		                  		 	</tr>
		                  		 	<tr>
										<td>
											<span style="color:grey">录入规则：名称字数限制为50个字，不得录入特殊符号，如：*&%￥#@！等</span>
										</td>
		                  		 	</tr>
		                  		 </table>
		                    </td>
		                </tr>						
						<tr>
							<td class="e_label"><i class="cc1">*</i>所属公司</td>
							<td>
								<select name="filiale" required>
									<option>请选择</option>
								  	<#list filiales as filiale>
					                    <option value="${filiale.code}" <#if (prodProduct.filiale == filiale.code) >selected</#if>>${filiale.cnName}</option>
								  	</#list>
							  	</select>
							  	<div id="managerIdError"></div>						
							</td>
						</tr>
						<tr>
							<td class="e_label"><i class="cc1">*</i>产品经理</td>
							<td>
								<input type="text" class="w35" name="managerName" id="managerName" value="${prodProduct.managerName}" required=true>
								<input type="hidden" value="${prodProduct.managerId}" name="managerId" id="managerId" required=true>
								<div id="managerIdError"></div>
							</td>
						</tr>
						<tr>
							<td class="e_label"><i class="cc1">*</i>出发地</td>
							<td>
								<input type="text" class="w35" name="districtName" <#if prodProduct.bizDistrict??> value="${prodProduct.bizDistrict.districtName}" </#if> id="district" required=true>
								<input type="hidden" <#if prodProduct.bizDistrict??> value="${prodProduct.bizDistrict.districtId}" </#if> id="districtId" name="bizDistrictId" required=true>
								<div id="managerIdError"></div>
							</td>
						</tr>				
						<!-- 定义变量 -->
						<#assign index=0 />
						<#assign productId="${prodProduct.productId}" />
															
						<#list bizCatePropGroupList as bizCatePropGroup>
							<#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)> 
								<#list bizCatePropGroup.bizCategoryPropList as bizCategoryProp>
									<#if (bizCategoryProp??)>
				                		<#assign disabled='' />
				                		<#if bizCategoryProp.cancelFlag=='N'>
				                			<#assign disabled='disabled' />
				                		</#if>
				                		<#assign prodPropId='' />
				                		<#assign propId=bizCategoryProp.propId />
				                		<#if bizCategoryProp?? && bizCategoryProp.prodProductPropList[0]!=null>
					                		<#assign prodPropId=bizCategoryProp.prodProductPropList[0].prodPropId />
				                		</#if>
				                		
					                	<tr>
						                <td width="150" class="e_label td_top" >
						                	<#if bizCategoryProp.nullFlag == 'Y'><span class="notnull">*</span></#if>
						                	${bizCategoryProp.propName!''}
						                	<#if bizCategoryProp.cancelFlag=='N'><span style="color:red" class="cancelProp">[无效]</span></#if>：
						                </td>
					                	<td> <span class="${bizCategoryProp.inputType!''}">    
					                	
					                		<input type="hidden" name="prodProductPropList[${index}].prodPropId" value="${prodPropId}" ${disabled}  />
					                		<input type="hidden" name="prodProductPropList[${index}].propId" value="${propId}" ${disabled} />
				                			<@displayHtml productId index bizCategoryProp/>
					                		
					                		<!-- 調用通用組件 -->
					                		
					                		<div id="errorEle${index}Error" style="display:inline"></div>
					                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
					        				</span></td>
						        		</tr>
						              </#if>									
								   <#assign index=index+1 />
								</#list>
							</#if>
						</#list>
						<tr>
							<td class="e_label">电子合同范本<i class="cc1">*</i></td>
							<td>
								<select name="prodEcontract.econtractTemplate" required>
									<option value="">请选择</option>
								  	<#list econtractTemplates as econtractTemplate>
					                    <option value="${econtractTemplate.code}" <#if (prodProduct.prodEcontract.econtractTemplate == econtractTemplate.code) >selected</#if>>${econtractTemplate.cnName}</option>
								  	</#list>
							  	</select>							
							</td>
						</tr>	
						<tr>
							<td class="e_label">最低成团人数</td>
							<td>
								<input type="text"  name="prodEcontract.minPerson" value="${prodProduct.prodEcontract.minPerson}" min="1" maxlength="4" number=true/>
							</td>
						</tr>	
						<tr>
							<td class="e_label">导游服务</td>
							<td>
							  	<#list guided_tours as guided_tour>
							  		<#if guided_tour.code=='CAPTAIN'>
							  			<input type="radio" checked="checked" name="prodEcontract.guideService" value="${guided_tour.code}"/>${guided_tour.cnName}
							  		<#else>
							  			<input type="radio" name="prodEcontract.guideService" value="${guided_tour.code}"/>${guided_tour.cnName}
							  		</#if>
							  	</#list>
							  	<input type="hidden" id="guideService" value="${prodProduct.prodEcontract.guideService}"/>					
							</td>
						</tr>
						<tr>
							<td class="e_label" valign="top">组团类型<i class="cc1">*</i></td>
							<td valign="top"> 
							  	<#list group_types as group_type>
							  		<#if group_type_index==0>
							  			<input type="radio" id="groupTypeVluaes" required=true checked="checked" name="prodEcontract.groupType" value="${group_type.code}"/>${group_type.cnName}
							  		<#else>
							  			<br/><input type="radio" required=true name="prodEcontract.groupType" value="${group_type.code}"/>${group_type.cnName}
							  		</#if>
							  	</#list>
							  	<input type="hidden" id="groupType" value="${prodProduct.prodEcontract.groupType}"/>		
							</td>
						</tr>
						<tr>
							<td class="e_label">游客手续<i class="cc1">*</i></td>
							<td>
								<#list visitors_procedures as visitors_procedure>
							  		<input type="checkbox" onclick="otherTflities();" errorEle="code" name="prodEcontract.travelFormalities" value="${visitors_procedure.code}" required/>${visitors_procedure.cnName}
							  	</#list>
							  		<div id="codeError" style="display:inline"></div>
							  	<span id="ohter" style="display: none;">
							  		<input type="text" name="prodEcontract.otherTravelformalities" value="${prodProduct.prodEcontract.otherTravelformalities}" required=true maxlength=20 />
							  		<div id="managerIdError"></div>
							  	<span>
							  	<input type="hidden" id="travelFormalities" value="${prodProduct.prodEcontract.travelFormalities}"/>
							</td>
						</tr>																										
					</table>
					<div class="fl operate" style="margin:20px;">
						<a class="btn btn_cc1" id="save">保存</a>
					</div>					
				</div>
			</div>
		</form>
		<form id="searchForm" method="post">
			<input type="hidden" id="groupName" name="groupName" value="基础属性"/>
			<input type="hidden" id="descCategoryId" name="categoryId" value="${prodProduct.bizCategoryId}"/>
			<input type="hidden" id="productId" name="productId" value="${prodProduct.productId}"/>
		</form>
	</div>
	<#include "/base/foot.ftl"/>
</body>
</html>
<script>

vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");

	$(function(){
		var groupType = $('#groupType').val();
		var guideService = $('#guideService').val();
		$("input:radio[value="+groupType+"]").attr('checked','true');
		$("input:radio[value="+guideService+"]").attr('checked','true');
		
		var travelFormalities = $('#travelFormalities').val();
		var str = new Array();
		str = travelFormalities.split(","); 
		
		$("input[name='prodEcontract.travelFormalities']").each(function(){
       		for(var i = 0;i<str.length;i++){
       			if($(this).attr('value')==str[i]){
   					$(this).attr('checked',true);
	   			}
       		}
       });
       
       otherTflities();	
       
    	// 设置定金计算单位从元转为分
    	var djIndex = 0;
    	$('.INPUT_TYPE_NUMBER input').each(function(i){
    		 var v = $(this).val();
    		 if(v==154){
				  djIndex = i+1;  		 	
    		 }
    		 if(i>0 && i==djIndex){
    		 	 v = parseFloat($(this).val()/100);
    		 	 $(this).val(v);
    		 }
    	});       
       
       refreshSensitiveWord($("input[type='text'],textarea"));
	});
	

	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	
	
	$("#save").click(function(){
	
		$(this).attr("disabled","disabled");
		
		var productId = $('#upProductId').val(); 
	   	if(productId<=0){
    		$.alert('请先添加基础信息!!');
    		return;
   		}	
	    var categoryId = $("#categoryId").val();
		if(categoryId==null || categoryId.length<=0){	
			$.alert("请先选择品类！");
			return;
		}
		$(this).attr("disabled","disabled");
		$.each( $("input[autoValue='true']"), function(i, n){
			if($(n).val()==""){
				$(n).val($(n).attr('placeholder'));
			}
		}); 
		
		$(".ckeditor").each(function(){
			var that = $(this);
			$.each(CKEDITOR.instances, function(i, n){
					if(that.attr('name')==n.name){
		    			if(n.getData()==""){
							that.text(that.attr('placeholder'));
						}else{
							that.text(n.getData());
						}
						if(that.attr("data")=="Y"){
								that.attr("required",true);
								that.show();
						}
		    		}
			});
		});
		
		$("textarea").not(".ckeditor").each(function(){
			if($(this).text()==""){
				$(this).text($(this).attr('placeholder'));
			}
		});
		if(!$("#dataForm").validate({
			rules : {
				productName : {
					isChar : true
				}
					},
			messages : {
				productName : '该字段不能为空，且不可输入特殊字符'
				
			}
		}).form()){
					$(this).removeAttr("disabled");
					return false;
		}
		
		//刷新AddValue的值		
		refreshAddValue();
		
    	// 设置定金计算单位从分转为元
    	var dingjinIndex = 0;
    	$('.INPUT_TYPE_NUMBER input').each(function(i){
    		 var v = $(this).val();
    		 if(v==154){
				  dingjinIndex = i+1;  		 	
    		 }
    		 if(i>0 && i==dingjinIndex){
    		 	 v = parseFloat($(this).val()*100);
    		 	 $(this).val(v);
    		 }
    	});		
		
		 var msg = '确认修改吗 ？';	
	   if(refreshSensitiveWord($("input[type='text'],textarea"))){
		   	 $("input[name=senisitiveFlag]").val("Y");
		 	 msg = '内容含有敏感词,是否继续?';
		  }else {
		  	$("input[name=senisitiveFlag]").val("N");
		  }
		
	$.confirm(msg,function(){
			//遮罩层
    	var loading = pandora.loading("正在努力保存中...");		
		$.ajax({
			url : "/vst_back/prod/compship/baseinfo/addBasicInfo.do",
			type : "post",
			dataType : 'json',
			data : $("#dataForm").serialize(),
			success : function(data) {
			   if (data.message>=0) {
			   	  $('#upProductId').val(data.message); 
			   	  $('#productId').val(data.message); 
			   	  $("#save").removeAttr("disabled");
			    	// 设置定金计算单位从元转为分
			    	var djIndex = 0;
			    	$('.INPUT_TYPE_NUMBER input').each(function(i){
			    		 var v = $(this).val();
			    		 if(v==154){
							  djIndex = i+1;  		 	
			    		 }
			    		 if(i>0 && i==djIndex){
			    		 	 v = parseFloat($(this).val()/100);
			    		 	 $(this).val(v);
			    		 }
			    	});				   	  
			   	  $.alert('保存成功!!');
			   }else{
			   	  $.alert(data.message);
			   }
			   loading.close();
			}
		});
		
		});
		
		
	});
	
	function showAddFlagSelect(params,index){
		if($(params).find("option:selected").attr('addFlag') == 'Y'){
			var StrName = document.getElementsByName("prodProductPropList["+index+"].addValue")
			if($(StrName).size()==0){
				$(params).after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
			}
		}else{
			$(params).next().remove();
		}
	}
	
	// 游客手续其他文本框显示
	function otherTflities(){
       $("input[name='prodEcontract.travelFormalities']").each(function(){
       		$('#ohter').css('display','none');
       		if($(this).attr("checked")=="checked"){
       			if($(this).attr('value')=="OTHER"){
       				$('#ohter').css('display','block');
       			}else{
       				$('#ohter').css('display','none');
       			}
       		}
       });	
	}
	
	$(document).ready(function(){
		parent.initLoading.close();
	});

</script>
