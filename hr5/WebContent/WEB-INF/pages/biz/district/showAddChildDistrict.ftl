
<form action="/vst_back/biz/district/addDistrict.do" method="post" id="dataForm">
	<input type="hidden" name="parentId" value="${district.districtId!''}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label">上级区域：</td>
                <td>
                	${district.districtName!''}
                </td>
                <td class="p_label"><span class="notnull">*</span>区域名称：</td>
                <td><input type="text" name="districtName" required=true></td>
            </tr> 
			<tr>
            	<td class="p_label">区域级别：</td>
                <td>
                	<select name="districtType">
            		<#list districtTypeList as distType>
            			<#if district.districtType == distType.code>
                		<option value="${distType.code!''}" selected="selected">${distType.cnName!''}</option>
                		<#else>
                		<option value="${distType.code!''}">${distType.cnName!''}</option>
                		</#if>
                	</#list>
                	</select>
                </td>
				<td class="p_label"><i class="cc1">*</i>拼音：</td>
                <td>
                	<input type="text" name="pinyin" required=true>
                </td>
            </tr>
        </tbody>
    </table>
</form>
