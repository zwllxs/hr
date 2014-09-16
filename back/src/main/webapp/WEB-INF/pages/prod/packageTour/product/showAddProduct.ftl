<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">添加产品</li>
        </ul>
</div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/prod/product/addProduct.do" method="post" id="dataForm">
		<input type="hidden" name="productId" value="${productId!''}">
		<input type="hidden" name="senisitiveFlag" value="N">
		<div class="p_box box_info p_line">
            <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
	                <tr>
	                	<td class="e_label" width="150"><i class="cc1">*</i>所属品类：</td>
	                	<td>
	                		<input type="hidden" id="categoryId" name="bizCategoryId" value="${bizCategory.categoryId}" required>
	                		<input type="hidden" id="categoryName" name="bizCategory.categoryName" value="${bizCategory.categoryName}" >
	                		${bizCategory.categoryName}
	                	</td>
	                </tr>
					<tr>
	                	<td class="e_label"><i class="cc1">*</i>产品名称：</td>
	                    <td><label><input type="text" class="w35" style="width:700px" name="productName" id="productName" required=true maxlength="50">&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
	                   <div id="productNameError"></div>
	                    </td>
	                    
	                </tr>
	                <tr>
                	<td class="e_label"><span class="notnull">*</span>供应商产品名称：</td>
                    <td>
                    	<label><input type="text" class="w35" style="width:700px" name="suppProductName" id="suppProductName" value="<#if prodProduct??>${prodProduct.suppProductName}</#if>" required=true maxlength="50">&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
                    	<div id="productNameError"></div>
                    </td>
                </tr>
	              <tr>
						<td class="e_label"><i class="cc1">*</i>状态：</td>
						<td>
							<select name="cancelFlag" required>
								<option value="N" selected="selected">无效</option>
		                    	<option value="Y" >有效</option>
		                    </select>
	                   	</td>
	                </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>推荐级别：</td>
						<td>
							<label><select name="recommendLevel" required>
		                    	<option value="5">5</option>
		                    	<option value="4">4</option>
		                    	<option value="3">3</option>
		                    	<option value="2" selected="selected">2</option>
		                    	<option value="1">1</option>
		                    </select>说明：由高到低排列，即数字越高推荐级别越高</label>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>类别：</td>
	                 	 <td>
	                 	 <!-- categoryId=15 跟团游-->
			                <#if bizCategory.categoryId != '15' >
                  				<#list productTypeList as list>
                  					<#if list.code != 'INNERSHORTLINE' && list.code != 'INNERLONGLINE'>
										<input type="radio" name="productType" value="${list.code!''}" required/>  ${list.cnName!''}
                  					</#if>
               	 				</#list>
               	 			</#if>
               	 			<#if bizCategory.categoryId == '15' >
                  				<#list productTypeList as list>
                  					<#if list.code != 'INNERLINE'>
										<input type="radio" name="productType" value="${list.code!''}" required/>  ${list.cnName!''}
									</#if>
               	 				</#list>
               	 			</#if>
			                
	                    	<div id="productTypeError"></div>
	                    </td>
	                </tr>
	                <tr id="bizVisaDocList">
	                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>关联材料：</td>
	                    <td><input type="hidden" id="docIds" name="docIds" class="w35">
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
		                        </tbody>
		            		</table>
		                    
	            		</td>
	                </tr>  
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>打包类型：</td>
	                 	 <td>
			                <#if bizCategory.categoryId == '16' || bizCategory.categoryId == '17' >
                 	 			<input type="radio" name="packageType" value="SUPPLIER"  required checked onclick="return false;"/>供应商打包
                 	 		<#else>
                 	 			<#list packageTypeList as list>
                 	 				<input type="radio" name="packageType" value="${list.code!''}"  required />${list.cnName!''}
                 	 			</#list>
                 	 		</#if>
			                
	                    	<div id="packageTypeError"></div>
	                    </td>
	                </tr>
	                <tr id="managerTr" >
	                	<td class="e_label"><i class="cc1">*</i>组合产品设计人员：</td>
	                 	 <td>
	                    	<input type="text" class="w35 searchInput" name="managerName" id="managerName"  >
							<input type="hidden" name="managerId" id="managerId" >
							<div id="managerNameError"></div>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>所属分公司：</td>
	                 	 <td>
	                    	<select name="filiale" id="filiale" required>
							  	<#list filiales as filiale>
				                    <option value="${filiale.code}" >${filiale.cnName}</option>
							  	</#list>
						  	</select>
						  	<div id="filialeError"></div>
	                    </td>
	                </tr>
	                
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>行程天数：</td>
	                 	 <td>
	                 	 	<label>
	                 	 		<input type="text" class="w35" name="prodLineRoute.routeNum" id="routeNum" required="true" number="true" maxlength="4">天
	                 	 	</label>
	                 	 	<#if bizCategory.categoryCode == 'category_route_group' || bizCategory.categoryCode == 'category_route_freedom'>
		                 	 	<input type="checkbox"  name="trafficNumFlag" id="trafficNumFlag" />航班原因：
		                 	 	<select name="prodLineRoute.trafficNum" id="trafficNum" disabled="disabled">
				                    	<option value="1">+1天</option>
				                    	<option value="-1">-1天</option>
			                    </select>
		                    </#if>
						  	<div id="routeNum"></div>
						  	
	                    </td>
	                </tr>
	                <#if bizCategory.categoryCode != 'category_route_local'>
		                <tr>
		                	<td class="e_label"><i class="cc1">*</i>入住几晚：</td>
		                 	 <td><label>
		                    	<input type="text" class="w35" name="prodLineRoute.stayNum" id="stayNum" required=true number="true" maxlength="4"/>晚
							  	<div id="stayNumError"></div>
							  	</label>
		                    </td>
		                </tr>
	                </#if>
	                
                	</tbody>
                </table>
            </div>
        </div>
        
        <!-- 条款品类属性分组Id -->
       	<#assign suggGroupIds = [26,27,28,29,30,31,32,33]/>  
		<div class="p_box box_info p_line">
	 			<#assign index=0 />
	 			<#assign productId="" />
			    <#list bizCatePropGroupList as bizCatePropGroup>
		            <#if (!suggGroupIds?seq_contains(bizCatePropGroup.groupId)) && bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)>
		            <div class="title">
					    <h2 class="f16">${bizCatePropGroup.groupName!''}：</h2>
				    </div>
		            <div class="box_content">
		            <table class="e_table form-inline">
		                <tbody>
		               		<#list bizCatePropGroup.bizCategoryPropList as bizCategoryProp>
			                	<tr>
				                <td width="150" class="e_label td_top"><#if bizCategoryProp.nullFlag == 'Y'><i class="cc1">*</i></#if>${bizCategoryProp.propName!''}：</td>
			                	<td><span class="${bizCategoryProp.inputType!''}">
			                		<input type="hidden" name="prodProductPropList[${index}].propId" value="${bizCategoryProp.propId!''}"/>
			                		
			                		<!-- 調用通用組件 -->
			                		<@displayHtml productId index bizCategoryProp />
			                		
			                		<div id="errorEle${index}Error" style="display:inline"></div>
			                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
			                	</span></td>
				               </tr>
				               <#assign index=index+1 />
		                	</#list>
		                </table>
		            </div>
		        </#if>
			</#list> 
		</div>
		
		<!-- 插件位置 -->
		<div class="p_box box_info p_line">
			  <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
                     <#if bizCategory.categoryCode != 'category_route_hotelcomb'>
		                <tr>
		                	<td class="e_label"><i id="districtFlag" class="cc1">*</i>出发地：</td>
		                 	 <td>
		                    	<input type="text" class="w35" id="district" name="district" readonly = "readonly" required>
		                    	<input type="hidden" name="bizDistrictId" id="districtId" >
		                    	<div id="districtError"></div>
		                    </td>
		                </tr>
	                </#if>
	                <tr name='no1'>
	                	<td name="addspan" class="e_label"><i class="cc1">*</i>目的地：</td>
	                 	 <td>
	                    	<input type="text" class="w35" id="dest0" name="dest" readonly = "readonly" required>
	                    	<input type="hidden" name="prodDestReList[0].destId" id="destId0" />
	                    	<a class="btn btn_cc1" id="new_button">添加</a>
	                    	<div id="destError"></div>
	                    </td>
	                </tr>
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
</div>
<div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

	vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	//目的地窗口
	var destSelectDialog;
	$("#bizVisaDocList").hide();
	$("#managerTr").hide();
	
	$("#save").click(function(){
	
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
			
		//产品类别出境填写签证信息
		if($("input[name=productType]:checked").val()=="FOREIGNLINE"){
			var docIds = $("#docIds").val();
			if (docIds.length < 2){
				alert("请选择签证材料");
				return false;
			}
		}
		
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
			$(this).removeAttr("disabled");
			flag1 = false;
		}
		 
		if(!$("#reservationLimitForm").validate().form()){
			flag2 = false;
		}
		if(flag1==false || flag2==false){
			return false;
		}
		
		if(validateRouteNum()){
			//刷新AddValue的值
			var comOrderRequiredFlag = "Y";
			if($("#reservationLimitForm").is(":hidden")){
				comOrderRequiredFlag = "N";
			}
			
			refreshAddValue();
			
			var msg = '确认保存吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?'
			 }else {
			$("input[name=senisitiveFlag]").val("N");
	}
			
			$.confirm(msg,function(){
				//遮罩层
	    	var loading = top.pandora.loading("正在努力保存中...");		
				$.ajax({
					url : "/vst_back/packageTour/prod/product/addProduct.do",
					type : "post",
					dataType : 'json',
					data : $("#dataForm").serialize()+"&"+$("#reservationLimitForm").serialize()+"&comOrderRequiredFlag="+comOrderRequiredFlag,
					success : function(result) {
						loading.close();
						if(result.code == "success"){
							//为子窗口设置productId
							$("input[name='productId']").val(result.attributes.productId);
							//为父窗口设置productId
							$("#productId",window.parent.document).val(result.attributes.productId);
							$("#productName",window.parent.document).val(result.attributes.productName);
							$("#categoryName",window.parent.document).val(result.attributes.categoryName);
							pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
							parent.checkAndJump();
							}});
						}else {
							$.alert(result.message);
						}
						$("#save").removeAttr("disabled");
					},
					error : function(){
						$("#save").removeAttr("disabled");
						loading.close();
					}
				});
			
			});
			
		}
		
	});
	 
	$("#saveAndNext").click(function(){
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
			
		//产品类别出境填写签证信息
		if($("input[name=productType]:checked").val()=="FOREIGNLINE"){
			var docIds = $("#docIds").val();
			if (docIds.length < 2){
				alert("请选择签证材料");
				return false;
			}
		}
		
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
		
		if(validateRouteNum()){
			var comOrderRequiredFlag = "Y";
			if($("#reservationLimitForm").is(":hidden")){
				comOrderRequiredFlag = "N";
			}
			//刷新AddValue的值		
			refreshAddValue();
			 var msg = '确认保存吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?'
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
			 $.confirm(msg,function(){
			 	//遮罩层
			 	var loading = top.pandora.loading("正在努力保存中...");
				$.ajax({
						url : "/vst_back/packageTour/prod/product/addProduct.do",
						type : "post",
						dataType : 'json',
						data : $("#dataForm").serialize()+"&"+$("#reservationLimitForm").serialize()+"&comOrderRequiredFlag="+comOrderRequiredFlag,
						success : function(result) {
							loading.close();
							if(result.code == "success"){
								//为子窗口设置productId
								$("input[name='productId']").val(result.attributes.productId);
								//为父窗口设置productId
								$("#productId",window.parent.document).val(result.attributes.productId);
								$("#productName",window.parent.document).val(result.attributes.productName);
								$("#categoryName",window.parent.document).val(result.attributes.categoryName);					
								//更新菜单
								refreshTable();
								pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
									$("#route",parent.document).parent("li").trigger("click");
								}});
							}else {
								$.alert(result.message);
							}
						},
						error : function(){
							loading.close();
						}
					});	
			 });
		}
		
	});
	
	function refreshTable(){
	//判断打包类型，然后更新父页面菜单
	var packageType = $("input[name=packageType]:checked").val();
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
	}
	
	
	
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
	
	//目的地维护开始
	var dests = [];//子页面选择项对象数组
	var count =0;
	var markDest;
	var markDestId;
	
	//选择目的地
	function onSelectDest(params){
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
		$tbody.append("<tr><td><input type='text' class='w35' name='dest' id='dest"+count+"' readonly = 'readonly' required/>" + 
						"<input type='hidden' name='prodDestReList["+count+"].destId' id='destId"+count+"'/>&nbsp;" + 
						"<a class='btn btn_cc1' name='del_button'>删除</a></td></tr>"); 
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
	
	//目的地维护结束
	
	$("input[name=productType]").live("change",function(){
		var addtion=$("input[traffic=traffic_flag]:checked").val();
		if(typeof(addtion) == "undefined"){
			addtion="";
		}
		showRequire($("input[name='bizCategoryId']").val(),$("input[name=productType]:checked").val(),addtion);
		
		//产品类别出境显示签证信息
		if($("input[name=productType]:checked").val()=="FOREIGNLINE"){
			$("#bizVisaDocList").show();
		}else{
			$("#bizVisaDocList").hide();
		}
	});
	
	$("input[traffic=traffic_flag]").live("change",function(){
	//只有自由行的时候才需要判断大交通
		if($("input[name='bizCategoryId']").val()==18 && $("input[name=productType]:checked").val()=="INNERLINE"){
			var addtion=$("input[traffic=traffic_flag]:checked").val();
			showRequire($("input[name='bizCategoryId']").val(),$("input[name=productType]:checked").val(),addtion);
		}
		
	});
	
	//自由行品类属性是否有大交通 选择是必填 选择否 则置灰不维护
	$("input[traffic=traffic_flag]").live("change",function(){
		onChangeTrafficFlag();
	});
	
	function validateRouteNum(){
		var validateFlag = true;
		//正整数
		var integerReg1 = /^[0-9]*[1-9][0-9]*$/;
		var routeNum = $("#routeNum").val();
		var stayNum = $("#stayNum").val();
		
		if(routeNum != null && routeNum != '' ){
			if(!integerReg1.test(parseInt(routeNum))){
				$.alert("请输入正确的行程天数(数字>0)");
				validateFlag = false;
			}
		}
		
		var integerReg2 = /^(0|[1-9]\d*)$/;
		if(stayNum != null && stayNum != '' ){
			if(!integerReg2.test(parseInt(stayNum))){
				$.alert("请输入正确的入住晚数(数字>=0)");
				validateFlag = false;
			}
		}
		
		return validateFlag;
	}
	
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

//组合产品设计人员
$("input[name=packageType]").live("change",function(){
		if($("input[name=packageType]:checked").val()=="LVMAMA"){
			$("#managerTr").show();
			$("#managerName").attr("required","true");
		}else{
			$("#managerTr").hide();
			$("#managerName").removeAttr("required");
		}
	});

$("input[name=packageType]").click(function(){
		var val = $(this).val();
		if(val=="SUPPLIER"){
			$("#reservationLimit").show();
		}else if(val=="LVMAMA"){
			$("#reservationLimit").hide();
		}
});
</script>