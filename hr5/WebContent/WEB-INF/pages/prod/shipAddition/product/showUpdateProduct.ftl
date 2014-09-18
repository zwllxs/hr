<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
<link rel="stylesheet" href="/vst_back/css/calendar.css" type="text/css"/>

</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${prodProduct.bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">修改产品</li>
        </ul>
</div>
<div class="iframe_content mt10">
<form action="/vst_back/prod/shipAddition/addProduct.do" method="post" id="dataForm">
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
                	<input type="hidden" name="bizCategoryId" value="${prodProduct.bizCategory.categoryId}" required>
                	<input type="hidden" name="categoryName" value="${prodProduct.bizCategory.categoryName}">
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
                    	<label><input type="text" class="w35" style="width:700px" name="productName" maxLength="50" id="productName" value="${prodProduct.productName}" required>&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '|| -"</label>
                    	<div id="productNameError"></div>
                    </td>
                </tr>
               	 <tr>
	                	<td class="e_label"><i class="cc1">*</i>产品经理：</td>
	                    <td>                 
	                    	<input type="text" name="managerName" id="managerName" value="${managerName}" required=true>
	                	    <input type="hidden" value="${prodProduct.managerId}" name="managerId" id="managerId" required=true>
	                    	<div id="managerIdError"></div>
	                    </td>
	                </tr>
	                
	               
                </table>
            </div>
        </div>
        
 			<#assign productId="${prodProduct.productId }" />
  			<#assign index=0 />
 			<#list bizCatePropGroupList as bizCatePropGroup>
            <#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size &gt; 0)>
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
                		<#assign propValue='' />
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
	                		<@displayHtml productId index bizCategoryProp />
	                		
	                		<div id="errorEle${index}Error" style="display:inline"></div>
	                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
	        				</span></td>
		        		</tr>
		              </#if>
		               <#assign index=index+1 />
                	</#list>
                </table>
            </div>
        </div>
        </#if>
		</#list>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate">
            <a class="btn btn_cc1"  id="save">保存</a>
            <#-- 
            <a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a>
            -->
            </div>
        </div>
</form>
</div>
<#include "/base/foot.ftl"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</body>
</html>
<script>
vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
var coordinateSelectDialog,districtSelectDialog;

$(function(){
	
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
			
			//验证
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
				return;
			}
    		$.confirm("确认修改吗 ？",function(){
    		
    			var loading = top.pandora.loading("正在努力保存中...");
    			//设置附加属性的值
				refreshAddValue();
				$.ajax({
					url : "/vst_back/prod/shipAddition/updateProduct.do",
					type : "post",
					dataType : 'json',
					data : $("#dataForm").serialize(),
					success : function(result) {
						loading.close();
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
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
			//验证
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
			$.confirm("确认修改吗 ？", function () {
			var loading = top.pandora.loading("正在努力保存中...");
			//设置附加属性的值
			refreshAddValue();
			$.ajax({
				url : "/vst_back/prod/shipAddition/updateProduct.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
				
					loading.close();
					$.alert(result.message);
					var productId = $("input[name='productId']").val();
					var categoryId = $("input[name='bizCategoryId']").val();
					$(".pg_title", parent.document).html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("input[name='productName']").val()+"   "+"品类:"+$("input[name='categoryName']").val()+"   "+"产品ID："+$("input[name='productId']").val());
					window.location.href="/vst_back/prod/shipAddition/showSuppGoodsList.do?productId="+productId;
				
					
				},
				error : function(result) {
					loading.close();
					$.alert(result.message);
				}
			});
			});
	});	
		
});
	
	function showAddFlagSelect(params,index){
		$(params).next().remove();
		if($(params).find("option:selected").attr('addFlag') == 'Y'){
			$(params).after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
		}
	}
	
</script>