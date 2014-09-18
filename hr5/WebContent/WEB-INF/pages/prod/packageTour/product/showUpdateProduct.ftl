<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
<link rel="stylesheet" href="/vst_back/css/calendar.css" type="text/css"/>

</head>
<body onload="initReservationLimit();">
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${prodProduct.bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">修改产品</li>
        </ul>
</div> 
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/prod/product/addProduct.do" method="post" id="dataForm">
	   <input type="hidden" name="senisitiveFlag" value="N">
       <div class="p_box box_info p_line">
            <div class="box_content">
            <table class="e_table form-inline">
            <tbody>
            	<#assign routeNum = '' />
               	<#assign stayNum = '' />
               	<#assign trafficNum = '' />
               	<#assign lineRouteId = '' />
               	<#if prodProduct.prodLineRoute ?? >
               		<#assign routeNum=prodProduct.prodLineRoute.routeNum />
               		<#assign stayNum=prodProduct.prodLineRoute.stayNum />
               		<#assign trafficNum =prodProduct.prodLineRoute.trafficNum />
               		<#assign lineRouteId=prodProduct.prodLineRoute.lineRouteId />
               	</#if>
               	
                <tr>
                	<td width='150' class="e_label"><span class="notnull">*</span>所属品类：</td>
                	<td>
                		<input type="hidden" name="bizCategoryId" value="${prodProduct.bizCategory.categoryId}" required/>
                		<input type="hidden" name="categoryName" value="${prodProduct.bizCategory.categoryName}"/>
                		<input type="hidden"  name="prodLineRoute.lineRouteId" id="lineRouteId" value="${lineRouteId }" required/>
                		<input type="hidden"  name="prodLineRoute.productId"  value="${prodProduct.productId }" required/>
                		${prodProduct.bizCategory.categoryName}
                	</td>
                </tr>
                <tr>
                	<td class="e_label"><span class="notnull">*</span>产品ID：</td>
                    <td>
                    	<input type="text" class="w35" name="productId" value="${prodProduct.productId}" readonly="readonly">
                    </td>
                </tr>
				<tr>
                	<td class="e_label"><span class="notnull">*</span>产品名称：</td>
                    <td>
                    	<label><input type="text" class="w35" style="width:700px" name="productName" id="productName" value="${prodProduct.productName}" required=true maxlength="50">&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
                    	<div id="productNameError"></div>
                    </td>
                </tr>
                <tr>
                	<td class="e_label"><span class="notnull">*</span>供应商产品名称：</td>
                    <td>
                    	<label><input type="text" class="w35" style="width:700px" name="suppProductName" id="suppProductName" value="${prodProduct.suppProductName}" required=true maxlength="50">&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
                    	<div id="productNameError"></div>
                    </td>
                </tr>
               	<tr>
					<td class="e_label"><span class="notnull">*</span>是否有效：</td>
					<td>
						<select name="cancelFlag" required>
			                    <option value='Y' <#if prodProduct.cancelFlag == 'Y'>selected</#if> >是</option>
			                    <option value='N' <#if prodProduct.cancelFlag == 'N'>selected</#if> >否</option>
	                    </select>
                   	</td>
                </tr>
                <tr>
					<td class="e_label"><span class="notnull">*</span>推荐级别：</td>
					<td>
					  <label>
						<select name="recommendLevel" required>
	                    	<option value="5" <#if prodProduct.recommendLevel == '5'>selected</#if> >5</option>
	                    	<option value="4" <#if prodProduct.recommendLevel == '4'>selected</#if> >4</option>
	                    	<option value="3" <#if prodProduct.recommendLevel == '3'>selected</#if> >3</option>
	                    	<option value="2" <#if prodProduct.recommendLevel == '2'>selected</#if> >2</option>
	                    	<option value="1" <#if prodProduct.recommendLevel == '1'>selected</#if> >1</option>
	                    </select>
	                    	说明：由高到低排列，即数字越高推荐级别越高
	                   </label> 
                    </td>
                </tr>
                <tr>
                	<td class="e_label"><i class="cc1">*</i>类别：</td>
                 	 <td >
                    	<span style="background:#ddd">
                    		<!-- categoryId=15 跟团游-->
			                <#if prodProduct.bizCategory.categoryId != 15 >
                  				<#list productTypeList as list>
                  					<#if list.code != 'INNERSHORTLINE' && list.code != 'INNERLONGLINE'>
										<input type="radio" name="productTypeTD" value="${list.code!''}" disabled <#if prodProduct.productType == list.code>checked</#if>/>  ${list.cnName!''}
                  					</#if>
               	 				</#list>
               	 			</#if>
               	 			<#if prodProduct.bizCategory.categoryId == 15 >
                  				<#list productTypeList as list>
                  					<#if list.code != 'INNERLINE'>
										<input type="radio" name="productTypeTD" value="${list.code!''}" <#if prodProduct.productType == list.code>checked</#if> disabled/>  ${list.cnName!''}
									</#if>
               	 				</#list>
               	 			</#if>
               	 			<input type="hidden" name="productType" value="${prodProduct.productType!''}" /> 
                 	 	</span>
                    	<div id="productTypeError"></div>
                    </td>
               </tr>
               
               <!--依据产品类别=出境条件显示-->
               <tr id="bizVisaDocList">
                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>关联材料：</td>
                    <td><input type="hidden" id="docIds" name="docIds" value="${docIds!''}" class="w35">
                    	<input type="hidden" id="oldDocIds" name="oldDocIds" value="${docIds!''}" class="w35">
                    	<a class="btn btn_cc1" id="choice_material">选择（修改）材料</a>
                    	</br>已选材料：
                    	<table width="70%" border="1" cellpadding="1" cellspacing="0">
	                        <thead>
					        	<tr>
					            	<th>签证材料ID</th>
					                <th>签证材料名称</th>
					            	<th>签证国家/地区</th>
					                <th>签证类型</th>	                    
					                <th>送签城市</th>
					                <th>操作</th>
					            </tr>
					        </thead>
					        <tbody id="visaDoc">
					        <#if bizVisaDocList?? && bizVisaDocList?size gt 0>
					        	<#list bizVisaDocList as bizVisaDoc>
					        	<tr name='visadocTr' id="tr_${bizVisaDoc.docId!''}" data="${bizVisaDoc.docId!''}">
					        		<td>${bizVisaDoc.docId!''}</td>
					        		<td>${bizVisaDoc.docName!''}</td>
					        		<td>${bizVisaDoc.country!''}</td>
					        		<td> <#list vistTypeList as bizDict>
						                   <#if bizVisaDoc!=null && bizVisaDoc.visaType==bizDict.dictId>${bizDict.dictName}</#if>
									  	</#list>
									</td>
					        		<td><#list vistCityList as bizDict>
						                   <#if bizVisaDoc!=null && bizVisaDoc.city==bizDict.dictId>${bizDict.dictName}</#if>
									  	</#list>
									</td>
									<td>
										<a href='javascript:delVisaDoc(${bizVisaDoc.docId!''});'>删除</a>
									</td>
					        	</tr>
					        	</#list>
					        </#if>
	                        </tbody>
	            		</table>
            		</td>
                </tr>
                
              	<tr>
                	<td class="e_label"><i class="cc1">*</i>打包类型：</td>
                 	 <td>
                 	 		<span style="background:#ddd">
                 	 			<#list packageTypeList as list>
                 	 					<input type="radio" name="packageTypeTD" value="${list.code!''}"  <#if prodProduct.packageType == list.code>  checked </#if> disabled/>${list.cnName!''}
                 	 			</#list>
                 	 			<input type="hidden" name="packageType" value="${prodProduct.packageType!''}"  />
                 	 		</span>
                    	<div id="packageTypeError"></div>
                    </td>
                </tr>
                <#if prodProduct.packageType == 'LVMAMA'>
	               	 <tr id="managerTr">
	                	<td class="e_label"><i class="cc1">*</i>组合产品设计人员：</td>
	                 	 <td>
	                    	<input type="text" class="w35 searchInput" name="managerName" id="managerName" required value="${prodProduct.managerName }"/>
							<input type="hidden" name="managerId" id="managerId" required value="${prodProduct.managerId }"/>
							<div id="managerNameError"></div>
	                    </td>
	                </tr>
                </#if>
               	<tr>
                	<td class="e_label"><i class="cc1">*</i>所属分公司：</td>
                 	 <td>
                    	<select name="filiale" id="filiale" required>
						  	<#list filiales as filiale>
			                    <option value="${filiale.code}" <#if prodProduct.filiale == filiale>selected</#if>>${filiale.cnName}</option>
						  	</#list>
					  	</select>
					  	<div id="filialeError"></div>
                    </td>
                </tr>
                <tr>
	            	<td class="e_label"><i class="cc1">*</i>行程天数：</td>
	                 	 <td>
	                 	 	<label>
	                 	 		<input type="text" class="w35" name="prodLineRoute.routeNum" id="routeNum" readonly="readonly" required="true" number="true" maxlength="4"    value="${routeNum !''}"/>天
	                 	 	</label>
	                 	 	<#if prodProduct.bizCategory.categoryCode == 'category_route_group' || prodProduct.bizCategory.categoryCode == 'category_route_freedom'>
		                 	 	<input type="checkbox"  name="trafficNumFlag" id="trafficNumFlag" />航班原因：
		                 	 	<select name="prodLineRoute.trafficNum" id="trafficNum" disabled="disabled" ">
			                    	<option value="1" <#if trafficNum == '1'>selected</#if>>+1天</option>
			                    	<option value="-1" <#if trafficNum == '-1'>selected</#if>>-1天</option>
			                    </select>
			                 </#if>
						  	<div id="routeNum"></div>
	                    </td>
	                </tr>
	                <#if prodProduct.bizCategory.categoryCode != 'category_route_local'>
		                <tr>
		                	<td class="e_label"><i class="cc1">*</i>入住几晚：</td>
		                 	 <td><label>
		                    	<input type="text" class="w35" name="prodLineRoute.stayNum" id="stayNum" readonly="readonly" required=true number="true" maxlength="4"   value="${stayNum!'' }"/>晚
							  	<div id="stayNumError"></div>
							  	</label>
		                    </td>
		                </tr>
	                 </#if>
                </table>
            </div>
        </div>
        AAAAAAAAAA
        	<!-- 条款品类属性分组Id -->
       		<#assign suggGroupIds = [26,27,28,29,30,31,32,33]/>  
 			<#assign productId="${prodProduct.productId}" />
  			<#assign index=0 />
 			<#list bizCatePropGroupList as bizCatePropGroup>
	            <#if (!suggGroupIds?seq_contains(bizCatePropGroup.groupId)) && bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size &gt; 0) >
		            <div class="p_box box_info">
		            <div class="title">
					    <h2 class="f16">${bizCatePropGroup.groupName!''}：</h2>
				    </div>
		            <div class="box_content">
		            	<table class="e_table form-inline">
		             		<tbody>
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
						                <td width="150" class="e_label td_top">
						                	<#if bizCategoryProp.nullFlag == 'Y'><span class="notnull">*</span></#if>
						                	${bizCategoryProp.propName!''}
						                	<#if bizCategoryProp.cancelFlag=='N'><span style="color:red" class="cancelProp">[无效]</span></#if>：
						                </td>
					                	<td> <span class="${bizCategoryProp.inputType!''}">     		
					                		<input type="hidden" name="prodProductPropList[${index}].prodPropId" value="${prodPropId}" ${disabled}  />
					                		<input type="hidden" name="prodProductPropList[${index}].propId" value="${propId}" ${disabled} />
					                		 <!-- 調用通用組件 -->
					                		 BBB
					                		<@displayHtml productId index bizCategoryProp  />
					                		CCCC
					                		<div id="errorEle${index}Error" style="display:inline"></div>
					                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
					        				</span></td>
						        		</tr>
					              	</#if>
					               <#assign index=index+1 />
		                	</#list>
		                 </tbody>
				       </table>
		            </div>
		        </div>
	        </#if>
		</#list>
        
        <!-- 插件位置 -->
		<div class="p_box box_info p_line">
			  <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
                     <#if prodProduct.bizCategory.categoryCode != 'category_route_hotelcomb'>
		                <tr>
		                	<td class="e_label"><i id="districtFlag" class="cc1">*</i>出发地：</td>
		                 	 <td>
		                    	<input type="text" class="w35" id="district" name="district" readonly = "readonly" required value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtName!''}</#if>">
		                    	<input type="hidden" name="bizDistrictId" id="districtId" value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtId}</#if>" >
		                    	<div id="bizDistrictIdError"></div>
		                    </td>
		                </tr>
	                </#if>
	                <#list prodProduct.prodDestReList as prodDestRe>
		                <tr <#if prodDestRe_index=0>name='no1'</#if>>
		                	<#if prodDestRe_index=0>
					   			<td name="addspan" rowspan='${prodProduct.prodDestReList?size}' class="e_label"><i class="cc1">*</i>目的地：</td>
					   		</#if>
				            <td>
				            	<input type="text" name="dest" class="w35" id="dest${prodDestRe_index}" value="${prodDestRe.destName}[${prodDestRe.destTypeCnName }]" readonly = "readonly" required>
				            	<input type="hidden" name="prodDestReList[${prodDestRe_index}].destId" id="destId" value="${prodDestRe.destId}"> <#if prodDestRe_index gt 0 >  <a class='btn btn_cc1' name='del_button'>删除</a></#if>
				            	<input type="hidden" name="prodDestReList[${prodDestRe_index}].reId" id="reId" value="${prodDestRe.reId}">
				            	<input type="hidden" name="prodDestReList[${prodDestRe_index}].productId" value="${prodProduct.productId}">
				            	<#if prodDestRe_index=0><a class="btn btn_cc1" id="new_button">添加目的地</a></#if>
				            </td>
		        	    </tr>
                	</#list>
                
                	</tbody>
                </table>
            </div>
		</div>
		
		<div class="p_box box_info p_line">
			<#include "/prod/packageTour/product/showDistributorProd.ftl"/>
		</div>
</form>       
        <div class="p_box box_info p_line" id="reservationLimit">
			<div class="title">
			   <h2 class="f16">预订限制</h2>
			</div>
			<#include "/common/reservationLimit.ftl"/>
		</div>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
        </div>


</div>
<#include "/base/foot.ftl"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</body>
</html>
<script>
	//判断打包类型，然后更新父页面菜单
	var packageType = $("input[name=packageTypeTD]:checked").val();
	if("SUPPLIER"==packageType){
		$("#lvmama",parent.document).remove();
		$("#supplier",parent.document).show();
	}else if("LVMAMA"==packageType){
		$("#supplier",parent.document).remove();
		$("#lvmama",parent.document).show();
	}else {
		alert("打包类型没有!");
	}
	
	if(packageType=="SUPPLIER"){
			$("#reservationLimit").show();
		}else if(packageType=="LVMAMA"){
			$("#reservationLimit").hide();
	}
	
	//判断是否有大交通
	if($("input[traffic=traffic_flag]:checked").size() > 0 && "SUPPLIER"==packageType){
		var transportType = $("input[traffic=traffic_flag]:checked").val();
		if(transportType == 'Y'){
			$("#transportLi",parent.document).show();
		}else {
			$("#transportLi",parent.document).hide();
		}
	}

	function initReservationLimit(){
		if($("input[name='bizCategoryId']").val()==18 && $("input[name=productTypeTD]:checked").val()=="INNERLINE"){
			var addtion=$("input[traffic=traffic_flag]:checked").val();
			showRequire($("input[name='bizCategoryId']").val(),$("input[name=productTypeTD]:checked").val(),addtion);
		}else{
			showRequire($("input[name='bizCategoryId']").val(),$("input[name=productTypeTD]:checked").val(),"");
		}
		
		//产品类别出境显示签证信息
		if($("input[name=productTypeTD]:checked").val() !="FOREIGNLINE"){
			$("#bizVisaDocList").hide();
		}
	}
	
var coordinateSelectDialog;
$(function(){
	
	var trafficNum = '${trafficNum}';
	if(trafficNum != null && trafficNum != '' &&  trafficNum != '0' ){
		$("#trafficNumFlag").attr("checked", "checked");
		$("#trafficNum").removeAttr("disabled");
	}
	
	//自由行品类属性是否有大交通 选择是必填 选择否 则置灰不维护
	onChangeTrafficFlag();
	
	$("#save").bind("click",function(){
    		$.each(CKEDITOR.instances, function(i, n){
    			$(".ckeditor").each(function(){
    				if($(this).attr('name')==n.name){
    					$(this).text(n.getData());
    					if($(this).attr("data")=="YY")
    					$(this).attr("required","true")
    				}
    			});
			}); 
			//产品类别出境填写签证信息
			if($("input[name=productTypeTD]:checked").val()=="FOREIGNLINE"){
				var docIds = $("#docIds").val();
				if (docIds.length < 3){
					alert("请选择签证材料");
					return false;
				}
			}
			//验证
			var flag1;
			var flag2;
			if(!$("#dataForm").validate({
				rules : {
					productName : {
						isChar : true
					}
						},
				messages : {
					productName : '不可输入特殊字符'
					
				}
			}).form()){
				flag1 = false;
			}
			if(!$("#reservationLimitForm").validate().form()){
				flag2 = false;
			}
			if(flag1==false || flag2==false){
				return false;
			}
			
			var msg = '确认修改吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?'
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
			
    		$.confirm(msg,function(){
    		
    			var loading = top.pandora.loading("正在努力保存中...");
    			//设置附加属性的值
				refreshAddValue();
				$.ajax({
					url : "/vst_back/packageTour/prod/product/updateProduct.do",
					type : "post",
					dataType : 'json',
					data : $("#dataForm").serialize()+"&"+$("#reservationLimitForm").serialize(),
					success : function(result) {
						loading.close();
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
							parent.checkAndJump();
					}});
					},
					error : function(result) {
						loading.close();
						$.alert(result.message);
					}
				});
    		});	
	});
	
	$("#saveAndNext").bind("click",function(){
			$.each(CKEDITOR.instances, function(i, n){
    			$(".ckeditor").each(function(){
    				if($(this).attr('name')==n.name){
    					$(this).text(n.getData());
    				}
    				if($(this).attr("data")=="Y"){
						$(this).attr("required",true);
						$(this).show();
					}
    			});
			}); 
			//产品类别出境填写签证信息
			if($("input[name=productTypeTD]:checked").val()=="FOREIGNLINE"){
				var docIds = $("#docIds").val();
				if (docIds.length < 3){
					alert("请选择签证材料");
					return false;
				}
			}
			//验证
			var flag1;
			var flag2;
			if(!$("#dataForm").validate({
					rules : {
								productName : {
									isChar : true
								}
							},
					messages : {
								productName : '不可输入特殊字符'
							}
				}).form()){
				flag1 = false;
			}
			if(!$("#reservationLimitForm").validate().form()){
				flag2 = false;
			}
			if(flag1==false || flag2==false){
				return false;
			}
			
			var msg = '确认修改吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?'
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
			
			$.confirm(msg, function () {
			var loading = top.pandora.loading("正在努力保存中...");
			//设置附加属性的值
			refreshAddValue();
			$.ajax({
				url : "/vst_back/packageTour/prod/product/updateProduct.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize()+"&"+$("#reservationLimitForm").serialize(),
				success : function(result) {
					loading.close();
					$.alert(result.message);
					$("#route",parent.document).parent("li").trigger("click");
				},
				error : function(result) {
					loading.close();
					$.alert(result.message);
				}
			});
			});
	});	
		
	if($("#isView",parent.document).val()=='Y'){
		$("#save,#saveAndNext").remove();
	}	
});

function showAddFlagSelect(params,index){
	$(params).next().remove();
	if($(params).find("option:selected").attr('addFlag') == 'Y'){
		$(params).after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
	}
}

var dests = [];//子页面选择项对象数组
var count =0;
var markDest;
var markDestId;

//选择目的地
function onSelectDest(params){
	/* var noRepeatCount = 0;
	$("input[id^=destId]").each(function(index, obj){
	   if(obj.id != null && $("#" + obj.id).val() == params.destId){
		   $.alert("添加目的地重复");
		   return;
	   }else{
		   noRepeatCount ++;
	   }
	  }); */
	if(params!=null){
		$("#"+markDest).val(params.destName + "[" + params.destType + "]");
		$("#"+markDestId).val(params.destId);
	}
	destSelectDialog.close();
	$("#destError").hide();
}

//新建目的地
$("#new_button").live("click",function(){
	count++;
	var rows = $("input[name=dest]").size();
	$("td[name=addspan]").attr("rowspan",rows+1);
	var $tbody = $(this).parents("tbody");
	$tbody.append("<tr><td><input type='text' class='w35' name='dest' id='dest"+count+"' readonly = 'readonly' required/><input type='hidden' name='prodDestReList["+count+"].destId' id='destId"+count+"'/>&nbsp;<a class='btn btn_cc1' name='del_button'>删除</a></td></tr>"); 
});

//删除目的地
$("a[name=del_button]").live("click",function(){
	if($(this).parents("tr").attr("name")=="no1"){
		var $td = $(this).parents("tr").children("td:first");
		$(this).parents("tr").next().prepend($td);
		$(this).parents("tr").next().attr("name","no1");
		$(this).parents("tr").next().children("td:last").append("<a class='btn btn_cc1' id='new_button'>添加目的地</a>")
	}
	
	$(this).parents("tr").remove();
	var rows = $("input[name=dest]").size();
	$("td[name=addspan]").attr("rowspan",rows);
});

//打开选择行政区窗口
$("input[name=dest]").live("click",function(){
	markDest = $(this).attr("id");
	markDestId = $(this).next().attr("id");
	var url = "/vst_back/biz/dest/selectDestList.do?type=main";
	destSelectDialog = new xDialog(url,{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
});
	
	
//产品类别选择
$("input[name=productTypeTD]").live("change",function(){
	var addtion=$("input[traffic=traffic_flag]:checked").val();
	if(typeof(addtion) == "undefined"){
		addtion="";
	}
	showRequire($("input[name='bizCategoryId']").val(),$("input[name=productTypeTD]:checked").val(),addtion);
	
	//只有出境需添加签证
	if($("input[name=productTypeTD]:checked").val()=="FOREIGNLINE"){
		$("#bizVisaDocList").show();
	}else{
		$("#bizVisaDocList").hide();
	}
});

$("input[traffic=traffic_flag]").live("change",function(){
	//只有自由行的时候才需要判断大交通
	if($("input[name='bizCategoryId']").val()==18 && $("input[name=productTypeTD]:checked").val()=="INNERLINE"){
		var addtion=$("input[traffic=traffic_flag]:checked").val();
		showRequire($("input[name='bizCategoryId']").val(),$("input[name=productTypeTD]:checked").val(),addtion);
	}
});	
              
//选择签证材料
function onSelectDoc(params){
	if(params!=null){
		var docIds = $("#docIds").val();
		if (docIds.indexOf(params.docId) == -1) {
		 	if(docIds == ","){
		 		docIds = params.docId + ",";
		 	}else{
		 		docIds = docIds + params.docId + ",";
		 	}
		 	$("#docIds").val(docIds);
		}else{
			alert("已有该签证");
			return false;
		}
		var trID = "tr_"+params.docId;
		$("#visaDoc").append("<tr name='visadocTr' id="+trID+" data="+params.docId+"><td>"+params.docId+"</td><td>"+params.docName+"</td><td>"+params.docCountry+"</td><td>"+params.docVisaTypeName+"</td><td>"+params.docCity+"</td><td><a href='javascript:delVisaDoc("+params.docId+");'>删除</a></td></tr>");
	}
	docSelectDialog.close();
}

//打开选择签证材料窗口
$("#choice_material").click(function(){
	var url = "/vst_back/visa/visaDoc/selectBizVisaDocList.do";
	docSelectDialog = new xDialog(url,{},{title:"选择签证材料",iframe:true,width:"1000",height:"600"});
});

//移除该行签证材料
function delVisaDoc(docId){
	var tr = "#tr_"+docId;
	$(tr).remove();
	$("#docIds").val("");
	
	var docIds = ",";
	$('tr[name="visadocTr"]').each(function(){
		if(docIds == ","){
	 		docIds = $(this).attr("data") + ",";
	 	}else{
	 		docIds = docIds + $(this).attr("data") + ",";
	 	}
	 	$("#docIds").val(docIds);
	});
}

refreshSensitiveWord($("input[type='text'],textarea"));
</script>