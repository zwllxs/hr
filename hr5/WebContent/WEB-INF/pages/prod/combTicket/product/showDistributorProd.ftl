 <div class="box_content">
    <table class="e_table form-inline">
        <tbody>
            <tr>
            	<td class="e_label"><i class="cc1">*</i>销售渠道：</td>
            	<td>
            		<#list distributorList as list>
            			<#assign distributorId=0 />
            			<#if  prodProduct?? && prodProduct.distDistributorProds?? && prodProduct.distDistributorProds?size &gt; 0>
            				<#list prodProduct.distDistributorProds as distDistributorProd>
            					<#if list.distributorId==distDistributorProd.distributorId>
            						<input type="checkbox" errorEle="code" checked="checked"  id="distributorIds_${list.distributorId!''}" name="distributorIds" value="${list.distributorId!''}"  />
            						${list.distributorName!''}
            						<#assign distributorId=list.distributorId />
            					</#if>
            				</#list>
            			</#if>
            			<#if distributorId!=list.distributorId>
    						<input type="checkbox" errorEle="code" name="distributorIds"  id="distributorIds_${list.distributorId!''}" value="${list.distributorId!''}"  required/>
    						${list.distributorName!''}                				
            			</#if>
	                </#list>
	                <div id="codeError" style="display:inline"></div>
            	</td>
            </tr>
            <tr id="distributorUserIdstr">
				<td class="e_label">super系统分销商</td>
				<td >
					<#if tntGoodsChannelVo?? && tntGoodsChannelVo.channels?? && tntGoodsChannelVo.channels?size &gt; 0>
						<!--渠道遍历-->
						<#list tntGoodsChannelVo.channels as tntChannelVo>
							<!--分销商遍历-->
							<#if  tntChannelVo.users?? && tntChannelVo.users?size &gt; 0>
								<#list tntChannelVo.users as tntUserVo>
										<input type="checkbox" errorEle="code"  name="distributorUserIds"  required=true
										 	<#if userIdLongStr != null && userIdLongStr?index_of("${tntUserVo.userId}") != -1>checked="checked"</#if>
											value="${tntChannelVo.channelId + "-" + tntUserVo.userId!''}"  /> ${tntUserVo.userName!''}
								</#list>
							<#elseif tntChannelVo.channelId?? && tntChannelVo.channelIdStr == "0">
								<input type="checkbox" errorEle="code"  name="distributorUserIds"  required=true
									<#if userIdLongStr != null && userIdLongStr?index_of("0-0") != -1>checked="checked"</#if> value="0-0"/>其他
							</#if>
						</#list>
					</#if>
				</td>
			</tr>
   		</tbody>
   	</table>
</div>

<script> 
//加载页面，渠道已选择分销(distributorId=4)
var distributorChecked = document.getElementById("distributorIds_4").checked;
if(!distributorChecked){
	//默认展示，未选中就隐藏
	$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
}else{
	$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
}

//渠道选择分销展示和隐藏下行分销商操作
$("input[name=distributorIds]").each(function(index){
	$(this).click(function(){
		if($(this).val() == 4){
			if($(this).attr("checked") != "checked"){
				$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
			}else{
				$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
			}
		}
 	});
});
</script>
