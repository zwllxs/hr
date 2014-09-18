<form action="#" method="post"  id="prewarningForm">
	<input type="hidden" name="supplierId" value="${supplierId}">
    <table class="p_table form-inline">
    <tbody>
        <tr>				                   
            <td class="p_label">押金回收时间：</td>
             <td>
              <#if depositTime!''>
              		<input type="text" name="depositTime" class="Wdate" id="d432" value="${depositTime?string("yyyy-MM-dd")}" onFocus="WdatePicker({readOnly:true})" required=true />
              <#else>
              		<input type="text" name="depositTime" class="Wdate" id="d432" onFocus="WdatePicker({readOnly:true})" required=true />
              </#if>
            </td>
        </tr> 
		<tr>
			<td class="p_label">预存款预警金额：</td>
             <td>  
            <input type="text" id="depositMoneys" name="depositMoneys" value="${depositMoneys}" required=true number=true  min=1  /></td>
           	</td>	
        </tr>                
    </tbody>
    </table>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="SaveButton">保存</button>
<script>
$("#SaveButton").bind("click",function(){
	//验证
	if(!$("#prewarningForm").validate().form()){
		return;
	}
	if($("#depositMoney").val()<0){
	alert("test");
		breek;
	}
	$.ajax({
	   url : "/vst_back/supp/supplier/addSupplierPrewarning.do",
	   data : $("#prewarningForm").serialize(),
	   type:"POST",
	   dataType:"JSON",
	   success : function(result){
	   		if(result.code=="success"){
	   			prewarningAddDialog.close();
		   		$.alert(result.message,function(){
		   			$("#searchForm").submit();
		   		});
	   		}else {
	   		  	$.alert(result.message);
	   		}
	   }
	});						
});
	
</script>