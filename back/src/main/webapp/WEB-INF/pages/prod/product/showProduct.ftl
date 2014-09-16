
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label">所属品类：</td>
                	<td>
                	<#if prodProduct?? && prodProduct.bizCategory??>
                		${prodProduct.bizCategory.categoryName}
                	</#if>
                	</td>
                </tr>
				<tr>
                	<td class="p_label">产品名称：</td>
                    <td>
                    <#if prodProduct??>
                    	${prodProduct.productName}
                    </#if>
                    </td>
                </tr>
               	<tr>
					<td class="p_label">是否有效：</td>
					<td>
					<#if prodProduct??>
						${prodProduct.cancelFlag!''}
					</#if>
                   	</td>
                </tr>
                <tr>
					<td class="p_label">是否可售：</td>
					<td>
					<#if prodProduct??>
						${prodProduct.saleFlag!''}
					</#if>
                   	</td>
                </tr>
                <tr>
					<td class="p_label">推荐级别：</td>
					<td>
					<#if prodProduct??>
						${prodProduct.recommendLevel!''}
					</#if>
                    </td>
                </tr>
                <#assign index=0 />
                <#list bizCatePropGroupList as bizCatePropGroup>
                <#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)>
            	<tr><td class='p_label'>属性分组：</td><td>${bizCatePropGroup.groupName}</td></tr>
                	<#list bizCatePropGroup.bizCategoryPropList as bizCategoryProp>
                		
                		<#if (bizCategoryProp?? && bizCategoryProp.prodProductPropList?size gt 0 && bizCategoryProp.prodProductPropList[0].propValue??)>
	                	<tr>
		                <td class="p_label"><#if bizCategoryProp.nullFlag == 'Y'><span class="notnull">*</span></#if>${bizCategoryProp.propName!''}：</td>
	                	<td>
	                		<#if bizCategoryProp.inputType == "INPUT_TYPE_TEXT">
	                		 	${bizCategoryProp.prodProductPropList[0].propValue}
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_COORDINATE">
	                		 	${bizCategoryProp.prodProductPropList[0].propValue}
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_CHECKBOX">
	                			<#list bizCategoryProp.bizDictList as bizDict>
	            					<input type="checkbox" name="prodProductPropList[${index}].propValue" disabled="disabled" value="${bizDict.dictName!''}" <#if bizCategoryProp.prodProductPropList[0].propValue?contains(bizDict.dictName)>checked</#if> >${bizDict.dictName!''}
	                			</#list>
		                	
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_RICH">
	                			<textarea name="prodProductPropList[${index}].propValue" disabled="disabled"
		                	    <#if bizCategoryProp.nullFlag == 'Y'>required</#if> > ${bizCategoryProp.prodProductPropList[0].propValue}</textarea>
							
							<#elseif bizCategoryProp.inputType == "INPUT_TYPE_TEXTAREA">
	                			<textarea name="prodProductPropList[${index}].propValue" disabled="disabled"
		                	    <#if bizCategoryProp.nullFlag == 'Y'>required</#if> > ${bizCategoryProp.prodProductPropList[0].propValue}</textarea>
		                	    
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YYYYMM">
	                			${bizCategoryProp.prodProductPropList[0].propValue}
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YYYYMMDD">
	                			${bizCategoryProp.prodProductPropList[0].propValue}
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YESNO">
	                			<#if "Y" == bizCategoryProp.prodProductPropList[0].propValue>是</#if>
	                			<#if "N" == bizCategoryProp.prodProductPropList[0].propValue>否</#if>
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_RADIO">
	            				<#list bizCategoryProp.bizDictList as bizDict>
	            					<input type="radio" name="prodProductPropList[${index}].propValue" disabled="disabled" value="${bizDict.dictName!''}" <#if bizDict.dictName == bizCategoryProp.prodProductPropList[0].propValue>checked</#if> >${bizDict.dictName!''}
	            				</#list>
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_SELECT">
	                			<select name="prodProductPropList[${index}].propValue" disabled="disabled">
								  	<option value="">请选择</option>
								  	<#list bizCategoryProp.bizDictList as bizDict>
					                    <option value="${bizDict.dictName}" <#if bizDict.dictName == bizCategoryProp.prodProductPropList[0].propValue>selected</#if> >${bizDict.dictName}</option>
								  	</#list>
	                			</select>
	                	
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_NUMBER">
	                			${bizCategoryProp.prodProductPropList[0].propValue}
	                		
	                		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_IMG_L">
	                			${bizCategoryProp.prodProductPropList[0].propValue}
	                		</#if>
	                	</td>
		               </tr>
		                </#if>
		               <#assign index=index+1 />
                	</#list>
                	</#if>
				</#list> 
                
                
            </tbody>
        </table>
<#include "/base/foot.ftl"/>
</body>
</html>