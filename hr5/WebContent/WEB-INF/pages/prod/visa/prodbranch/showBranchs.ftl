
<form id="dataForm">
<table >
	<tr><input id="productId" type="hidden" value ="${productId!''}"></tr>
	<tr>
    	
                    	<select name="branchs" id="branchId" required=true>	
                    			<option value="" >请选择 </option>	
	                    	<#list branchList as list>
	                    		<option value="${list.branchId}">${list.branchName!''}</option>
	                    	</#list>
                    	</select>
                    
	</tr>
</table>
<br/>
<table>
<tr>
<td class=" operate mt10"><a class="btn btn_cc1" id="new_button">选择</a></td>
</tr>
</table>
<br>
</form>

<script>

$("#new_button").bind("click",function(){
		var branchId = $("#branchId").val();
		var productId = $("#productId").val(); 
		
		if(!$("#dataForm").validate().form()){
	     return false;
	   }
		
		dialog("/vst_back/visa/prodbranch/showAddProductBranch.do?branchId="+branchId+"&productId="+productId, "新增产品规格",800,"auto",function(){
		
		
		if(!$("#dataForm").validate().form()){
	     return false;
	   }
        var resultCode;
		$.ajax({
			url : "/vst_back/visa/prodbranch/addProductBranch.do",
			type : "post",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			success : function(result) {
			    resultCode=result.code;
				confirmAndRefresh(result);
			}
		});
		if(resultCode !=="success") return false;
	},"保存");
});


function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				window.location.reload();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	}

</script>
  