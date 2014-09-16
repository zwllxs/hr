<table class="p_table table_center">
                <thead>
                    <tr>
                    <th><input type="checkbox" class="w6"  onclick="ckAll(this);"/></th>
                	<th>分销商ID</th>
                	<th>分销商名称</th>
                    <th>分销商状态</th>
                    </tr>
                </thead>
                <tbody>
					<#list distributorList as distributor > 
					<tr>
					<td><input type="checkbox" class="w6" name="distributorCk" value="${distributor.distributorId!''}" showName="${distributor.distributorName!''}"/></td>
					<td>${distributor.distributorId!''} </td>
					<td>${distributor.distributorName!''} </td>
					<td><#if distributor.cancelFlag == 'Y'>开启</#if> <#if distributor.cancelFlag == 'N'>禁用</#if></td>
					</tr>
					</#list>
                </tbody>
            </table>
<script>
	function ckAll(obj){
				if(obj.checked){
					$("input[name='distributorCk']").attr("checked",true);
				  }else{
					  $("input[name='distributorCk']").attr("checked",false);
				  }
			}
</script>