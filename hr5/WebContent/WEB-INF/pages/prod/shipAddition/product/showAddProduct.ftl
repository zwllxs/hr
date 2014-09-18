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
<form action="/vst_back/prod/product/addProduct.do" method="post" id="dataForm">
		<input type="hidden" name="productId" value="${productId!''}">
		<div class="p_box box_info p_line">
            <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
	                <tr>
	                	<td class="e_label" width="150"><i class="cc1"></i>产品品类：</td>
	                	<td>
						附加项目
						</td>
	                </tr>
	                
					<tr>
	                	<td class="e_label"><i class="cc1"></i>产品子品类：</td>
	                    <td>邮轮附加项</td>
	                    <input type="hidden" id="categoryId" name="bizCategoryId" value="${bizCategory.categoryId}" required>
	                	<input type="hidden" id="categoryName" name="bizCategory.categoryName" value="${bizCategory.categoryName}" >
	                </tr>
	                <tr>
	                	<td class="e_label"><i class="cc1">*</i>产品名称：</td>
	                    <td><label><input type="text" class="w35" style="width:700px" maxLength="50" name="productName" id="productName" required=true>&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '|| -"</label>
	                   <div id="productNameError"></div>
	                    </td>
	                    
	                </tr>
	                 <tr>
	                	<td class="e_label"><i class="cc1">*</i>产品经理：</td>
	                    <td>                 
	                    	<input type="text" name="managerName" id="managerName" value="${managerName}" required=true>
	                	    <input type="hidden" value="${managerId}" name="managerId" id="managerId" required=true>
	                    	<div id="managerIdError"></div>
	                    </td>
	                </tr>
	                
	                
	                
                	</tbody>
                </table>
            </div>
        </div>


<div class="p_box box_info">

			<#assign productId="" />
 			<#assign index=0 />
		    <#list bizCatePropGroupList as bizCatePropGroup>
            <#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)>
            <div class="title">
			    <h2 class="f16">
			    ${bizCatePropGroup.groupName!''}：
			    </h2>
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
</form>
</div>
<div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="save">保存</a>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");

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
		if(!$("#dataForm").validate({
			rules : {
				productName : {
					isChar : true
				}
					},
			messages : {
				productName : '不可为空或者特殊字符'
				
			}
		}).form()){
					$(this).removeAttr("disabled");
					return false;
		}
		
		//遮罩层
    	var loading = top.pandora.loading("正在努力保存中...");		
		//刷新AddValue的值		
		refreshAddValue();
			$.ajax({
				url : "/vst_back/prod/shipAddition/addProduct.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						//为子窗口设置productId
						$("input[name='productId']").val(result.attributes.productId);
						//为父窗口设置productId
						$("#productId",window.parent.document).val(result.attributes.productId);
						$("#productName",window.parent.document).val(result.attributes.productName);
						$("#categoryName",window.parent.document).val(result.attributes.categoryName);
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
			
		}).form()){
				return false;
			}
		
		var loading = top.pandora.loading("正在努力保存中...");
		//刷新AddValue的值		
		refreshAddValue();
    	//遮罩层
		$.ajax({
				url : "/vst_back/prod/product/addProduct.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						//为子窗口设置productId
						$("input[name='productId']").val(result.attributes.productId);
						//为父窗口设置productId
						$("#productId",window.parent.document).val(result.attributes.productId);
						$("#productName",window.parent.document).val(result.attributes.productName);
						$("#categoryName",window.parent.document).val(result.attributes.categoryName);					
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
							var categoryId = $("#categoryId").val();
							var productId = result.attributes.productId;
							window.location = "/vst_back/prod/shipAddition/showSuppGoodsList.do?productId="+productId+"&categoryId="+categoryId;
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
	
</script>