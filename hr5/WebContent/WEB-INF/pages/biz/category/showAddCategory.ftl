<form  id="dataForm">
    <input id="categoryId" type="hidden" name="categoryId" value="${bizCategory.categoryId!''}"> 
    <input id="cancelFlag" type="hidden" name="cancelFlag" value="${bizCategory.cancelFlag!''}"> 
    
    <table class="p_table form-inline">
    <tbody>
        <tr>
        	<td class="p_label">品类名称：<span class="notnull">*</span></td>
            <td><input autocomplete="off" type="text" name="categoryName"  required=true value="${bizCategory.categoryName!''}"></td>
		</tr>
        <tr>
        	<td class="p_label">品类上级：</td>
            <td>
            	<select autocomplete="off" name="parentId">
				  <option value="">顶级品类</option>
				  <#list parentCategoryList as parentCategory> 					    
		                <option value="${parentCategory.categoryId}"
						<#if (bizCategory.parentId == parentCategory.categoryId) >selected</#if>
						>${parentCategory.categoryName}</option>
				  </#list>
	            </select></td>
		</tr>
        <tr>
        	<td class="p_label">排序值：</td>
            <td><input autocomplete="off" type="text" style="width:60px" name="seq" value="${bizCategory.seq!''}"></td>
        </tr>
        <tr>
			<td class="p_label">代码：<span class="notnull">*</span></td><td><input autocomplete="off" type="text" name="categoryCode" required=true value="${bizCategory.categoryCode!''}"></td>
		</tr>
    </tbody>
    </table>
</form>
