
    <form id="houseStatusForm">
    
    <input type="hidden" name="stockStatus" value="FULL">
    
    <div class="iframe_content form-inline">
        <div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：更新方法，选中需要更新字段的前面的复选框，编辑内容后，点击保存，即更新了复选框选中的字段内容。</div>
        
        <h2><span class="fnb">酒店名称：</span>[${houseControlQueryVO.districtName}]${houseControlQueryVO.productName}(酒店编号:${houseControlQueryVO.productId})</h2>
        </br>
        <h5>已选供应商：${houseControlQueryVO.supplierName}</h5>
        </br>
        <table class="xtable">
            	<#if perPayList??>
							<#assign index=0>
		 					<#list perPayList as good>
 							<#if index%5==0><tr></#if>
								<td>
			 					<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index}]" value="${good.suppGoodsId}" data="${good.payTarget}"   />${good.productBranchName}-${good.goodsName}-<#if good.payTarget=="PREPAID">[预付]</#if>&nbsp;&nbsp;</label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==perPayList?size></tr></#if>
			 				</#list>
		 		</#if>
           		<#if payList??>
							<#assign index=0>
		 					<#list payList as good>
 							<#if index%5==0><tr></#if>
								<td>
								<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${perPayList?size+index}]" value="${good.suppGoodsId}" data="${good.payTarget}"  />${good.productBranchName}-${good.goodsName}-<#if good.payTarget=="PAY">[现付]</#if>&nbsp;&nbsp;</label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==payList?size></tr></#if>
			 				</#list>
		 		</#if>
        </table>
        
        <hr>
        <h5>设置房态</h5>
        <table class="xtable">
            <tr>
                <td><label class="inline">日期范围：<input required=true type="text" name="startDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /> - <input type="text" required=true name="endDate" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></label>
                	<div class="e_error" style="display:inline" id="selectDateError"></div>
                </td>
            </tr>
            <tr>
                <td>适用日期：
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDayAll">全部</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="2">一</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="3">二</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="4">三</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="5">四</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="6">五</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="7">六</label>
                <label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="1">日</label>
                 </td>
            </tr>
        </table>
         
      
           
    </div>
    </form>
     <p align="center">
			<button class="pbtn pbtn-small btn-ok" style="margin-top:20px;" id="saveAndCloseButton">确认满房</button>
	</p>
<script>
	$(function(){
	
		
		//设置week选择,全选
		$("input[type=checkbox][name=weekDayAll]").click(function(){
			if($(this).attr("checked")=="checked"){
				$("input[type=checkbox][name=weekDay]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=weekDay]").removeAttr("checked");
			}
		})
		
		 //设置week选择,单个元素选择
		$("input[type=checkbox][name=weekDay]").click(function(){
			if($("input[type=checkbox][name=weekDay]").size()==$("input[type=checkbox][name=weekDay]:checked").size()){
				$("input[type=checkbox][name=weekDayAll]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=weekDayAll]").removeAttr("checked");
			}
		});
		
		
	
	   function submitData(){
			var buttonId = $(this).attr("id");
			if(!$("#houseStatusForm").validate({
				rules : {
					startDate : {
						required : true
					}
					,
					endDate : {
						required : true
					}
				},
			messages : {
				startDate : '请选择开始日期',
				endDate : '请选择结束日期'
			}
			}).form()){
				return;
			}
			
			//保存
			$.ajax({
				url : "/vst_back/goods/house/editHouseStatus.do",
				data :　$("#houseStatusForm").serialize(),
				dataType:'JSON',
				type : 'POST',
				success : function(result){
					if(result.code == 'success'){
						$.alert(result.message);
					}else {
						$.alert(result.message);
					}
					
				}
			});
		} 
		$("#saveAndCloseButton").bind("click",submitData);
		
		//默认选中
		$("input[type='checkbox'][value='${houseControlQueryVO.suppGoodsId}']").click();
		
	});
</script>


