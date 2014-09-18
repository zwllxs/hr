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
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/prod/product/addProduct.do" method="post" id="dataForm">
       <div class="p_box box_info p_line">
            <div class="box_content">
            <table class="e_table form-inline">
            <tbody>
                <tr>
                	<td width='150' class="e_label"><span class="notnull">*</span>所属品类：</td>
                	<td>
                		<input type="hidden" name="bizCategoryId" value="${prodProduct.bizCategory.categoryId}" required>
                		<input type="hidden" name="senisitiveFlag" value="N">
                		<input type="hidden" name="categoryName" value="${prodProduct.bizCategory.categoryName}">
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
                	<td class="e_label"><span class="notnull">*</span>邮轮中文名称：</td>
                    <td>
                    	<label><input type="text" class="w35" style="width:700px" name="productName" id="productName" value="${prodProduct.productName}" required=true maxlength="50">&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
                    	<div id="productNameError"></div>
                    </td>
                </tr>
                <tr>
	                	<td class="e_label"><i class="cc1">*</i>url拼音：</td>
	                    <td><label><input type="text" class="w35" style="width:700px" name="urlId" id="urlId" value="${prodProduct.urlId}" required=true maxlength="50">&nbsp;请只输入大小写英文字母</label>
	                   <div id="urlIdError"></div>
	                    </td>
	                    
	            </tr>
            <#--   	<tr>
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
                	<td class="e_label"><span class="notnull">*</span>行政区划：</td>
                    <td>
                    	<input type="text" class="w35" id="district" name="district" required=true  readonly="readonly" value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtName!''}</#if>" required>
                    	<input type="hidden" name="bizDistrictId" id="districtId" value="${prodProduct.bizDistrict.districtId}">
                    	<div id="bizDistrictIdError"></div>
                    </td>
                </tr>-->
                </table>
            </div>
        </div>
        
 			<#assign productId="${prodProduct.productId}" />
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
                </table>
            </div>
        </div>
        </#if>
		</#list>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
        </div>
</form>
</div>
<#include "/base/foot.ftl"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</body>
</html>
<script>
var coordinateSelectDialog;
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
				productName : '不可输入特殊字符'
				
			}
		}).form()){
				return;
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
					url : "/vst_back/ship/prod/product/updateProduct.do",
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
				url : "/vst_back/ship/prod/product/updateProduct.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					$.alert(result.message);
					var productId = $("input[name='productId']").val();
					var categoryId = $("input[name='bizCategoryId']").val();
					$(".pg_title", parent.document).html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("input[name='productName']").val()+"   "+"品类:"+$("input[name='categoryName']").val()+"   "+"产品ID："+$("input[name='productId']").val());
					window.location.href="/vst_back/ship/prod/prodbranch/findProductBranchList.do?productId="+productId+"&categoryId="+categoryId;
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
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>