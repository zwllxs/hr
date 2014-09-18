
<style>
	.notnull {color:red;}
</style>
<form  id="dataForm">
		
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label">分销商ID：</td>
                    <td> <input type="text" name="distributorId" value="${distributor.distributorId!''}" readonly="readonly"> </td>
                	<td class="p_label">名称<span class="notnull">*</span>：</td>
                    <td><input type="text" name="distributorName" value=${distributor.distributorName!''} required=true></td>
                </tr>
                <tr>
                   <td class="p_label">分销商KEY：</td>
                   <td> <input type="text" name="distributorKey" value="${distributor.distributorKey!''}" readonly="readonly"> </td>
                   <td class="s_label">分销商状态：</td>
                       <td class="w18">
                    	<select name="cancelFlag">
	                    		<option value="Y" <#if distributor.cancelFlag =="Y">selected="selected" </#if>>开启</option>
	                    		<option value="N" <#if distributor.cancelFlag =="N">selected="selected" </#if>>禁用</option>
                    	</select>
                    </td>
                </tr>
                
                	<td class="s_label">发送方：</td>
                       
                    <td>   
                       <select name="smsFlag" required>
	                    		<option value="Y" <#if distributor.cancelFlag =="Y">selected="selected" </#if>>驴妈妈</option>
	                    		<option value="N" <#if distributor.cancelFlag =="N">selected="selected" </#if>>分销商</option>
                    	</select>
                    </td>
                
                	<td class="s_label">是否自有：</td>
                       <td>
                       <#if distributor.lvmamaFlag== "Y">
                    	<input type="radio" name="lvmamaFlag" value="Y" checked="true" >是 
                    	<#else>
                		<input type="radio" name="lvmamaFlag" value="N" checked="true" >否
                		</#if>
                    </td>
                <tr>
                
                </tr>
                
            </tbody>
        </table>
</form>
