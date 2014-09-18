
<style>
	.notnull {color:red;}
</style>
<form  id="dataForm">
	
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label">名称<span class="notnull">*</span>：</td>
                    <td><input type="text" name="distributorName" required=true></td>  
                   <td class="s_label">分销商状态：</td>
                       <td class="w18">
                    	<select name="cancelFlag">
                    			<option value="N" >禁用</option>
	                    		<option value="Y" >开启</option>    		
                    	</select>
                    </td>
                 </tr>
                 <tr>
                    <td class="s_label">是否自有<span class="notnull">*</span>：</td>
                       <td>
                    	<input type="radio" name="lvmamaFlag" value="Y" required>是 
                		<input type="radio" name="lvmamaFlag" value="N" >否
                    </td>
                    
                    <td class="s_label">发送方<span class="notnull">*</span>：</td>
                       <td>
                    	 <select name="smsFlag" required>
                    	 		<option value="">请选择</option>
	                    		<option value="Y" >驴妈妈</option>
	                    		<option value="N" >分销商</option>
                    	</select>
                    </td>
                </tr>
            </tbody>
        </table>
</form>
