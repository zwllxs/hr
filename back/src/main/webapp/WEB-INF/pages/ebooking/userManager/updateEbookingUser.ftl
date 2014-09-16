<form id="updateBbkUserForm" method="post">
	<ul class="gl3_top" style="width: 380px; line-height:30px;">
		<li>
			　供应商：${suppSupplier.supplierName}
		</li>
		<li>　　　用户名：${ebkUser.userName}</li>
		<li>打印通关票据：
			<input type="hidden" name="userId" value="${ebkUser.userId}">
			<#if ebkUser.printFlag=='N'>
				<input type="checkbox" id="canPrintShow">
			<#else>
				<input type="checkbox" id="canPrintShow" checked="true">
			</#if> 			
			<input type="hidden" id="printFlag" name="printFlag"> 
		</li>
		<li>驴妈妈联系人：<input type="text" name="lvmamaContactName" value="${ebkUser.lvmamaContactName}"></li>
		<li>　　联系电话：<input type="text" name="lvmamaContactPhone" value="${ebkUser.lvmamaContactPhone}"></li>
		<li>　　账号备注：<input type="text" name="description" value="${ebkUser.description}">
			<span style="font-size: 12px;color: gray;">填写景区或者酒店名称</span>
		</li> 
		<li>状态：
			<input type="radio" value="Y" name="cancelFlag" 
				<#if ebkUser.cancelFlag == 'Y'>checked="true" </#if>
			/>正常
			<input type="radio" value="N" name="cancelFlag" 
				<#if ebkUser.cancelFlag == 'N'>checked="true" </#if>
			/>锁定			
		</li> 
	</ul>
</form>
<script type="text/javascript">
	$(function(){
		if(($('#canPrintShow').attr("checked")=='checked')==true){
			$('#printFlag').val('Y');	
		}else{
			$('#printFlag').val('N');
		}
		$('#canPrintShow').click(function(){
			if(($('#canPrintShow').attr("checked")=='checked')==true){
				$('#printFlag').val('Y');
			}else{
				$('#printFlag').val('N');			
			}
		});
	}); 
</script>
	