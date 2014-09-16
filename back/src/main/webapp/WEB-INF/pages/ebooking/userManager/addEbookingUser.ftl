<form id="addBbkUserForm" method="post">
	<ul class="gl3_top" style="width: 380px;line-height:30px;">
		<li>
			　　　供应商：${supplier.supplierName}
				<input id="supHd" type="hidden" name="supplierId" value="${supplier.supplierId}">
		</li>
		<li>　　　用户名：<span class="notnull">*</span><input id="userNameInput" onblur="isExistUsername();" 
			type="text" name="userName" required="true">
			<span id="userNameMsg" style="color: red;"></span>
		</li>
		<li>
			打印通关票据：<input id="canPrintShow" type="checkbox" value="N"/>
			<input id="canPrint" type="hidden" name="printFlag" />
		</li>
		<li>驴妈妈联系人：<input type="text" name="lvmamaContactName"></li>
		<li>　　联系电话：<input type="text" name="lvmamaContactPhone"></li>
		<li>　　账号备注：<input type="text" name="description"><span style="font-size: 12px;color: gray;">填写景区或者酒店名称</span></li> 
		<li>　　　　状态：
			<input type="radio" value="Y" name="cancelFlag" checked="checked"/>正常
			<input type="radio" value="N" name="cancelFlag"/>锁定
		</li> 
	</ul>
</form>
<script>
    // 判断用户名是否存在
	function isExistUsername(){
	    var uName = $('#userNameInput').val();
		$.ajax({
			url : "/vst_back/ebooking/userManager/isExistUsername.do",
			type : "post",
			data : {userName:uName},
			success : function(result) {
				if (result == "fail") {
				    $('#userNameMsg').text('用户名已经存在');
				}else{
					$('#userNameMsg').text('');
				}
			}
		});	
	}
	
	$(function(){
		$('#canPrintShow').click(function(){
			if(($('#canPrintShow').attr("checked")=='checked')==true){
				$('#canPrint').val('Y');
			}else{
				$('#canPrint').val('N');			
			}
		});
	});

</script>