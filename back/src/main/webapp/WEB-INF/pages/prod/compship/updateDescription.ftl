<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
</head>
<body>
	<div class="iframe_content mt10">
		<form action="/vst_back/prod/cruiseCombinationProduct/addProduct.do" method="post" id="dataForm">
			<div class="p_box box_info">
				<input type="hidden" name="productId"  id="productId" value="${prodProduct.productId}"/>
				<input type="hidden" name="bizCategoryId" id="addcategoryId" value="${categoryId}"/>		
				<input type="hidden" name="senisitiveFlag" value="N">	
				<#assign index=0 />
				<#assign productId="${prodProduct.productId}" />
				<div class="box_content">
					<table class="e_table form-inline">
						
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
					                <td width="150" class="e_label td_top">
					                	<#if bizCategoryProp.nullFlag == 'Y'><span class="notnull">*</span></#if>
					                	${bizCategoryProp.propName!''}
					                	<#if bizCategoryProp.cancelFlag=='N'><span style="color:red" class="cancelProp">[无效]</span></#if>：
					                </td>
				                	<td> <span class="${bizCategoryProp.inputType!''}"> 		
				                		<input type="hidden" name="prodProductPropList[${index}].prodPropId" value="${prodPropId}" ${disabled}  />
				                		<input type="hidden" name="prodProductPropList[${index}].propId" value="${propId}" ${disabled} />
				                		
				                		<!-- 調用通用組件 -->
				                		<@displayHtml productId index bizCategoryProp  />         		
				                		
				                		
				                		<div id="errorEle${index}Error" style="display:inline"></div>
				                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
				        				</span></td>
					        		</tr>
					              </#if>									
							      <#assign index=index+1 />
							</#list>
							</#if>
						</#list>
					</table>
									
				</div>
			</div>
		</form>
		
		
		<#--
		<form id="searchForm" method="post">
			<input type="hidden" id="productId" name="productId" value="${prodProduct.productId}"/>
			<input type="hidden" name="categoryId" value="${categoryId}"/>
		</form>
		
		-->
	</div>
	<div class="fl operate" style="margin:20px;">
						<a class="btn btn_cc1" id="save">保存</a>
		</div>	
	
	<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	$(function(){
		var addcategoryId = $('#hCategoryId', window.parent.document).val();
		$('#addcategoryId').val(addcategoryId);
	});
		
	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	
	$("#save").click(function(){
	
		$(this).attr("disabled","disabled");
	
		var productId = $('#productId').val(); 
	   	if(productId<=0){
    		$.alert('请先添加产品基础信息!!');
    		$("#save").removeAttr("disabled");	
    		return;
   		}	
		$(this).attr("disabled","disabled");
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
				productName : '不可输入特殊字符'
				
			}
		}).form()){
					$(this).removeAttr("disabled");
					return false;
		}
		
		//刷新AddValue的值		
		refreshAddValue();
		
	   var msg = '确认保存吗 ？';	
	   if(refreshSensitiveWord($("input[type='text'],textarea"))){
	 	 msg = '内容含有敏感词,是否继续?';
	   }
		
		$.confirm(msg,function(){
			//遮罩层
    		var loading = pandora.loading("正在努力保存中...");		
    	
			$.ajax({
				url : "/vst_back/prod/compship/descinfo/addDescInfo.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						$.alert(result.message);
						
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
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>
