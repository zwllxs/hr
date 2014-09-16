<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${categoryName}</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">产品修改</li>
        </ul>
</div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/prod/traffic/addProduct.do" method="post" id="dataForm">
		<input type="hidden" name="productId" value="${product.productId!''}">
		<input type="hidden" name="trafficId" value="${traffic.trafficId!''}">
		<input type="hidden" name="senisitiveFlag" value="N">
		<div class="p_box box_info p_line">
            <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
	                <tr>
	                	<td class="e_label" width="150"><i class="cc1">*</i>所属品类：</td>
	                	<td>
	                		<input type="hidden" id="categoryId" name="bizCategoryId" value="${product.bizCategoryId}" required>
	                		<input type="hidden" id="categoryName" name="bizCategory.categoryName" value="${categoryName}" >
	                		${categoryName}
	                	</td>
	                </tr>
					<tr>
	                	<td class="e_label"><i class="cc1">*</i>产品名称：</td>
	                    <td><label><input type="text" class="w35" style="width:700px" name="productName" id="productName" required=true maxlength="50" value=${product.productName!''}>&nbsp;产品名称要便于识别</label>
	                    <div id="productNameError"></div>
	                    </td>
	                </tr>
	              <tr>
						<td class="e_label"><i class="cc1">*</i>产品状态：</td>
						<td>
							<select name="cancelFlag" required>
								<option value='Y' <#if product.cancelFlag == 'Y'>selected</#if> >是</option>
			                    <option value='N' <#if product.cancelFlag == 'N'>selected</#if> >否</option>
		                    </select>
	                   	</td>
	                </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>推荐级别：</td>
						<td>
							<label><select name="recommendLevel" required>
		                    	<option value="5" <#if product.recommendLevel == '5'>selected</#if> >5</option>
	                    	<option value="4" <#if product.recommendLevel == '4'>selected</#if> >4</option>
	                    	<option value="3" <#if product.recommendLevel == '3'>selected</#if> >3</option>
	                    	<option value="2" <#if product.recommendLevel == '2'>selected</#if> >2</option>
	                    	<option value="1" <#if product.recommendLevel == '1'>selected</#if> >1</option>
		                    </select>说明：由高到低排列，即数字越高推荐级别越高</label>
	                    </td>
	                </tr>
                	</tbody>
                </table>
            </div>
        </div>
<div class="p_box box_info">
            <div class="title">
			    <h2 class="f16">基本信息：</h2>
		    </div>
            <div class="box_content">
            	<table class="e_table form-inline">
                    <tbody>
	                <tr>
	                	<td class="e_label" width="150"><i class="cc1">*</i>单程/往返：</td>
	                	<td>
	                		<select name="toBackType" required>
								<option value="N" <#if traffic.toBackType == 'N'>selected</#if> >单程</option>
		                    	<option value="Y" <#if traffic.toBackType == 'Y'>selected</#if> >往返</option>
		                    </select>
	                	</td>
	                </tr>
	                <#if product.bizCategory.categoryCode!='category_traffic_bus_other' &&  product.bizCategory.categoryCode!='category_traffic_ship_other'>
					<tr>
	                	<td class="e_label"><i class="cc1">*</i>采购类型：</td>
	                    <td>
	                    	<select name="referFlag" required>
								<option value="Y" <#if traffic.toBackType == 'Y'>selected</#if> >参考车次</option>
		                    	<option value="N" <#if traffic.toBackType == 'N'>selected</#if> >精确车次</option>
		                    </select>
	                    <div id="productNameError"></div>
	                    </td>
	                </tr>
	                </#if>
	              <tr>
						<td class="e_label"><i class="cc1">*</i>出发城市：</td>
						<td>
							<label><input type="text" class="w15" name="" id="startDistrict" readonly=readonly required=true value="${traffic.startDistrictObj.districtName}" >
							<input type="hidden" class="w15" name="startDistrict" id="startDistrictId" required=true value="${traffic.startDistrictObj.districtId}" >
							&nbsp;</label>
	                   	</td>
	                </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>到达城市：</td>
						<td>
							<label><input type="text" class="w15" name="" id="endDistrict" readonly=readonly required=true value="${traffic.endDistrictObj.districtName}">
							<input type="hidden" class="w15" name="endDistrict" id="endDistrictId" required=true value="${traffic.endDistrictObj.districtId}" >
							&nbsp;</label>
	                    </td>
	                </tr>
                	</tbody>
                </table>
            </div>
        </div>
</div>
</form>
<div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

	vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	
	$("#save").click(function(){
		$.each( $("input[autoValue='true']"), function(i, n){
			if($(n).val()==""){
				$(n).val($(n).attr('placeholder'));
			}
		}); 
		
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
			return false;
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
					url : "/vst_back/prod/traffic/updateProduct.do",
					type : "post",
					dataType : 'json',
					data : $("#dataForm").serialize(),
					success : function(result) {
						loading.close();
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
							parent.checkAndJump();
						}});
					},
					error : function(){
						loading.close();
					}
				});
			
			});
		
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
			return false;
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
							pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
								$("#traffic",parent.document).parent("li").trigger("click");
							}});
						},
						error : function(){
							loading.close();
						}
					});	
			 });
		
	});
	
	//打开选择行政区窗口
	$("#startDistrict").click(function(){
		districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
	});
	
	//打开选择行政区窗口
	$("#endDistrict").click(function(){
		districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do?callBack=onSelectDistrict1",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
	});
	
	
	//选择行政区
	function onSelectDistrict(params){
		if(params!=null){
			$("#startDistrict").val(params.districtName);
			$("#startDistrictId").val(params.districtId);
		}
		districtSelectDialog.close();
		$("#districtError").hide();
	}
	
	//选择行政区
	function onSelectDistrict1(params){
		if(params!=null){
			$("#endDistrict").val(params.districtName);
			$("#endDistrictId").val(params.districtId);
		}
		districtSelectDialog.close();
		$("#districtError").hide();
	}
	
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>