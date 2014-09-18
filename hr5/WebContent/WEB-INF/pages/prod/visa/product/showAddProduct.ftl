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
            <li><a href="#">签证产品维护</a> &gt;</li>
            <li class="active">添加产品</li>
        </ul>
</div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/visa/product/addProduct.do" method="post" id="dataForm">
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
	                	<td class="e_label"><i class="cc1">*</i>签证产品名称：</td>
	                    <td><label><input type="text" class="w35" maxlength="50" style="width:700px" name="productName" id="productName" required>&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
	                   <div id="productNameError"></div>
	                    </td>
	                    
	                </tr>
	               	<tr>
						<td class="e_label"><i class="cc1">*</i>状态：</td>
						<td>
							<select name="cancelFlag" required>
								<option value="N">无效</option>
		                    	<option value="Y">有效</option>
		                    </select>
	                   	</td>
	                </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>推荐级别：</td>
						<td>
							<label><select name="recommendLevel" required>
		                    	<option value="5" selected="selected">5</option>
		                    	<option value="4">4</option>
		                    	<option value="3">3</option>
		                    	<option value="2">2</option>
		                    	<option value="1">1</option>
		                    </select>说明：由高到低排列，即数字越高推荐级别越高</label>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>签证国家/地区：</td>
	                 	 <td>
	                    	<input type="text" class="w35" id="district" readonly = "readonly" required>
	                    	<input type="hidden" name="bizDistrictId" id="districtId" >
	                    	<div id="bizDistrictIdError"></div>
	                    </td>
	                </tr>
                	</tbody>
                </table>
            </div>
        </div>


<div class="p_box box_info">
 			<#assign index=0 />
 			<#assign productId="" />
		    <#list bizCatePropGroupList as bizCatePropGroup>
            <#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)>
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
        </div>
        </#if>
		</#list>
</div>
</form>
		<div class="p_box box_info p_line">
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
vst_pet_util.commListSuggest("#countryName", "#countryId",'/vst_back/biz/district/searchDistrictList.do','${suppJsonList}');
	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	
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
		
    	
    	var comOrderRequiredFlag = "Y";
		if($("#reservationLimitForm").is(":hidden")){
			comOrderRequiredFlag = "N";
		}	
		//刷新AddValue的值		
		refreshAddValue();
		
		  var msg = '确认保存吗 ？';	
		  if(refreshSensitiveWord($("input[type='text'],textarea"))){
		  	 $("input[name=senisitiveFlag]").val("Y");
		 	 msg = '内容含有敏感词,是否继续?';
		  }else {
			$("input[name=senisitiveFlag]").val("N");
			}
		
		  $.confirm(msg,function(){
		  		//遮罩层
    			var loading = top.pandora.loading("正在努力保存中...");	
			  	$.ajax({
					url : "/vst_back/visa/product/addProduct.do",
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
							$("#countryName",window.parent.document).val($("#countryName").val());
							$("#visaTypeName",window.parent.document).val($("#visaTypeName").find("option:selected").text());
							$("#visaCityName",window.parent.document).val($("#visaCityName").find("option:selected").text());
							pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
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
		
		var comOrderRequiredFlag = "Y";
		if($("#reservationLimitForm").is(":hidden")){
			comOrderRequiredFlag = "N";
		}
		//刷新AddValue的值		
		refreshAddValue();
		
		 var msg = '确认保存吗 ？';	
		  if(refreshSensitiveWord($("input[type='text'],textarea"))){
		  	 $("input[name=senisitiveFlag]").val("Y");
		 	 msg = '内容含有敏感词,是否继续?';
		  }else {
			$("input[name=senisitiveFlag]").val("N");
			}
		
		$.confirm(msg,function(){
		var loading = top.pandora.loading("正在努力保存中...");
    	//遮罩层
		$.ajax({
				url : "/vst_back/visa/product/addProduct.do",
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
						$("#countryName",window.parent.document).val($("#countryName").val());
						$("#visaTypeName",window.parent.document).val($("#visaTypeName").find("option:selected").text());
						$("#visaCityName",window.parent.document).val($("#visaCityName").find("option:selected").text());	
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
							var categoryId = $("#categoryId").val();
							var productId = result.attributes.productId;
							window.location = "/vst_back/visa/range/findProdVisaRangeList.do?productId="+productId+"&categoryId="+categoryId;
						}});
						$(".pg_title", parent.document).html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("input[name='productName']").val()+"   "+"品类:"+$("input[name='categoryName']").val()+"   "+"产品ID："+$("input[name='productId']").val());
					}else {
						$.alert(result.message);
					}
				},
				error : function(){
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
</script>