<form  id="dataForm">

    <input id="dictDefId" type="hidden" name="dictDefId" value="${bizDictDef.dictDefId!''}"> 
    <table class="p_table form-inline">
        <tbody>
            <tr>
            	<td class="p_label">字典定义名称：<span class="notnull">*</span></td>
                <td><input type="text" name="dictDefName" required=true value="${bizDictDef.dictDefName!''}"></td>
            </tr>
            <tr>
                <td class="p_label">字典定义类型：</td>
                <td><select name="dictType">
	                  <#list dictTypeList as dictTypeEnum>
	                    <option value="${dictTypeEnum.code}" 
	                    	<#if bizDictDef.dictType == dictTypeEnum.code>selected</#if>
	                    >${dictTypeEnum.cnName}</option>
				  	  </#list>
                	</select>
                	(业务字典可以设置动态属性)
                </td>
            </tr>
            <tr>
                <td class="p_label">状态：</td>
                <td><select name="cancelFlag">
                    <option value="Y" <#if bizDictDef.cancelFlag == 'Y'>selected</#if> >有效</option>
                    <option value="N" <#if bizDictDef.cancelFlag == 'N'>selected</#if> >无效</option>
                </select></td>
            </tr>
            <tr>
            	<td class="p_label">字典代码：</td>
                <td><input type="text" name="dictCode" id="dictCode"  value="${bizDictDef.dictCode!''}"></td>
            </tr>
        </tbody>
    </table>
</form> 
