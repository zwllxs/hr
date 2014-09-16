<div class="iframe_header">
        <i class="icon-home ihome"></i>
        <ul class="iframe_nav">
            <li><a href="#">首页</a> ></li>
            <li><a href="#">维护组件</a> ></li>
            <li class="active">房态设置</li>
        </ul>
    </div>
    <form id="houseStatusForm">
    <input type="hidden" id="supplierId" name="supplierId" value="${supplierId}"/> 
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
								<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index}]" value="${good.suppGoodsId}" data="${good.payTarget}"  />${good.productBranchName}-${good.goodsName}-<#if good.payTarget=="PAY">[现付]</#if>&nbsp;&nbsp;</label>
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
        
        <hr>
        <h5>预付</h5>
        <table class="xtable">
        		<tr class="prePay">
                    <td>
                    <label class="checkbox"><input type="checkbox" class="checkable" name="cancelStrategy">退改类型：</label>
                      <select class="w10 mr10"  id="cancelStrategy1">
                      		<option value="">请选择</option>
	                    	<option value="RETREATANDCHANGE">可退改</option>
	                    	<option value="UNRETREATANDCHANGE">不退不改</option>	                    
	                  </select>
                    </td>
                </tr>
            	<tr>
                <td id="lastCancelTime"><label class="checkbox"><input type="checkbox" class="checkable" name="latestCancelTime" disabled="disabled"> 预付最晚无损取消时间：</label>
                	<select class="w10 mr10" name="lastCancelTime_Day" disabled="disabled">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="lastCancelTime_Hour" disabled="disabled">
		                      <#list 0..24 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>时
		                <select class="w10 mr10" name="lastCancelTime_Minute" disabled="disabled">
		                      <#list 0..60 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
                </td>
            </tr>
            <tr class="prePay">
                <td><label class="checkbox"><input type="checkbox" name="bookLimitType"> 预付预授权限制：</label>
                  	<select class="w10" id="bookLimitType">
                    	<option value="NONE">无限制</option>
                    	<option value="PREAUTH" disabled="disabled">一律预授权</option>
                    </select>
                </td>
            </tr>
            <tr class="prePay">
                <td><label class="checkbox"><input type="checkbox" name="deductType"> 预付扣款类型：</label>
                <select class="w10"  id="deductType">
                	<option value="NONE">否</option>
                	<option value="FULL">全额</option>                	
                	<option value="FIRSTDAY">首日</option>
                	<option value="MONEY">固定金额</option>
                	<option value="PERCENT">百分比</option>
                </select>   
                <input type="hidden" id="deductValue" name="deductValue" />                        
                <input type="text" name="deductValueInput" id="deductValueInput" value="${deductValue}" number=true />
                </td>
            </tr>
        </table>
        
        <hr>
        <h5>现付</h5>
        <table class="xtable">
            <tr class="pay">
                <td><label class="checkbox"><input type="checkbox" name="guarType"> 担保类型：</label>
                 <select class="w10" id="guarType">
                	<option value="NONE">无</option>
                	<option value="CREDITCARD">信用卡</option>
                </select>
                </td>
            </tr>           
            <tr class="pay">
                <td><label class="checkbox"><input type="checkbox" name="bookLimitType" id="bookLimitTypeCheckbox"> 预订限制：</label>
                 <select class="w10" id="bookLimitType2">
                	<option value="NONE">无限制</option>
                	<option value="TIMEOUTGUARANTEE">超时担保</option>
                	<option value="ALLTIMEGUARANTEE">全程担保</option>
                	<option value="ALLGUARANTEE">一律担保</option>
                </select>
               	 保留时间：
                <select class="w10" name="latestUnguarTime" id="latestUnguarTime">	                
	                	 <#list 1..24 as i>
	                      <option value="${i}">${i}:00</option>
	                     </#list>
                    </select>
                </td>
            </tr>
             <tr class="pay">
                <td><label class="checkbox"><input type="checkbox" name="deductType"> 全额/峰时担保扣款：</label>
                 <select class="w10" name="deductType1" id="deductType1">
                	<option value="NONE">否</option>
                	<option value="FULL">全额</option>                	
                	<option value="FIRSTDAY">首日</option>
	              </select>
                </td>
            </tr>
            <tr class="pay">
                <td><label class="checkbox"><input type="checkbox" name="guarQuantity"> 预订限制_是否房量担保：</label>
                <select class="w10" id="isGuarQuantity"  >	                    	
                  <option value="Y">是</option>
                  <option value="N">否</option>
               </select>
         		需担保房量：                    
              	<select class="w10" id="guarQuantity"  >	                    	
                	 <#list 1..50 as i>
                      <option value="${i}">${i}</option>
                     </#list>
               </select>
                </td>
            </tr>
           <tr class="pay">
                <td>
                <label class="checkbox"><input type="checkbox" class="checkable" name="cancelStrategy">退改类型：</label>
                  <select class="w10 mr10"  id="cancelStrategy">
                  		<option value="">请选择</option>
                    	<option value="RETREATANDCHANGE">可退改</option>
                    	<option value="UNRETREATANDCHANGE">不退不改</option>	                    
                  </select>
                </td>
            </tr>
            <tr>
            <td id="lastCancelTime_1"><label class="checkbox"><input type="checkbox" name="latestCancelTime" disabled="disabled"> 担保最晚无损取消时间：</label>
        		<select class="w10 mr10" name="lastCancelTime_Day" disabled="disabled">
                      <#list 0..50 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>天
                <select class="w10 mr10" name="lastCancelTime_Hour" disabled="disabled">
                      <#list 0..24 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>时
                <select class="w10 mr10" name="lastCancelTime_Minute" disabled="disabled">
                      <#list 0..60 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分
                </td>
            </tr>
        </table>
        <hr>
        <table class="xtable">
            <tr>
                <td><label class="checkbox"><input type="checkbox" name="latestHoldTime" > 保留房最晚预订时间：</label>
                 <select class="w10 mr10" name="latestHoldTime_Day">
	                      <#list 0..50 as i>
	                      <option value="${i}">${i}</option>
	                      </#list>
	                </select>天
	                <select class="w10 mr10" name="latestHoldTime_Hour">
	                      <#list 0..24 as i>
	                      <option value="${i}">${i}</option>
	                      </#list>
	                </select>时
	                <select class="w10 mr10" name="latestHoldTime_Minute">
	                      <#list 0..60 as i>
	                      <option value="${i}">${i}</option>
	                      </#list>
	                </select>分
                </td>
            </tr>
            <tr>
                <td><label class="checkbox"><input type="checkbox" name="restoreFlag"> 保留房是否可恢复：</label>
                 <select class="w10" id="restoreFlag">
                	<option value="Y">可恢复</option>
                	<option value="N">不可恢复</option>
                </select>
                </td>
            </tr>
            <tr>
                <td><label class="checkbox"><input type="checkbox" name="stockStatus"> 房态：</label>
                	<select class="w10" id="stockStatus">
                    <option value="NORMAL">正常</option>
                    <option value="LESS">紧张</option>
                    <option value="FULL">满房</option>
                </select></td>
            </tr>
            <tr>
                <td><label class="checkbox"><input type="checkbox" name="aheadBookTime"> 提前预定时间：</label>
            	<select class="w10 mr10" name="aheadHour_day">
                      <#list 0..50 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>天
                <select class="w10 mr10" name="aheadHour_hour">
                      <#list 0..24 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>时
                <select class="w10 mr10" name="aheadHour_minute">
                      <#list 0..60 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分
               </td>
            </tr>
            <tr>
                <td><label class="checkbox"><input type="checkbox" name="freeSaleFlag"> Freesale：</label>
                 <select class="w8" id="freeSaleFlag">
                    <option value="N">否</option>
                    <option value="Y">是</option>
                </select></td>
            </tr>
        </table>
        
        
         <p class="mt20 operate">
         <a class="btn btn_cc1" id="saveAndNextButton">保存并继续</a>
         <a class="btn btn_cc1" id="saveAndCloseButton">保存并关闭</a>
        </p>
    </div>
    </form>
<script>
	$(function(){
	
		$("#deductType").bind("change",function(){
			if($(this).val()=="PERCENT"||$(this).val()=="MONEY"){
				$("#deductValueInput").removeAttr("disabled");
			}else{
			  	$("#deductValueInput").attr("disabled","disabled");
			}
		});
	
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
	
		//退改类型
	$("#cancelStrategy,#cancelStrategy1").bind("change",function(){
		checkCancelStrategy();
	});
	
	//检查退改类型
	function checkCancelStrategy(){
		//现付
		var cancelStrategy = $("#cancelStrategy").val();
		if($("#cancelStrategy").attr("disabled")=="disabled"||cancelStrategy==''||cancelStrategy=='UNRETREATANDCHANGE'){
			$("#lastCancelTime_1").find("select,input").attr("disabled","disabled");
		}else if(cancelStrategy=='RETREATANDCHANGE'){
			$("#lastCancelTime_1").find("select,input").removeAttr("disabled");
		}
		//预付
		var cancelStrategy1 = $("#cancelStrategy1").val();
		if($("#cancelStrategy1").attr("disabled")=="disabled"||cancelStrategy1==''||cancelStrategy1=='UNRETREATANDCHANGE'){
			$("#lastCancelTime").find("select,input").attr("disabled","disabled");
		}else if(cancelStrategy1=='RETREATANDCHANGE'){
			$("#lastCancelTime").find("select,input").removeAttr("disabled");
		}
	}
	
		//disable预付
		disablePrePay();
		//disable现付
		disablePay();
		//禁用预付款设置
		function disablePrePay(){
			//预付扣款类型金额，百分比
			$(".prePay").find("input").not("input[name=deductValueInput]").removeAttr("disabled");		
			$(".prePay").find("input").attr("disabled","disabled");
			$(".prePay").find("select").attr("disabled","disabled");
			checkCancelStrategy();
		}
		//禁用现付设置
		function disablePay(){
			$(".pay").find("input").attr("disabled","disabled")
			$(".pay").find("select").attr("disabled","disabled");			
			checkCancelStrategy();
			
		}
		//启用预付设置
		function enablePrePay(){			
			$(".prePay").find("input").removeAttr("disabled");
			$(".prePay").find("select").removeAttr("disabled");
			//预付扣款类型金额，百分比	
			$("#deductValueInput").attr("disabled","disabled");		
			checkCancelStrategy();
			
		}
		//启用现付设置
		function enablePay(){
			$(".pay").find("input").removeAttr("disabled")
			$(".pay").find("select").removeAttr("disabled");
			//如果不是超时担保,保留时间 disabled
			if($("#bookLimitType2").val()!='TIMEOUTGUARANTEE'){		
				$("#latestUnguarTime").attr("disabled","disabled");
			}
			checkCancelStrategy();
		}
		//商品选择事件
		$(".checkGoods").change(function(){
			//如果不是退改策略则不设置该规则
			if($(this).attr("data")=="PREPAID"){
				if($(this).attr("checked")=="checked"){
					enablePrePay();
					disablePay();
					$("input[data=PAY]").removeAttr("checked");
				}else {
					if($("input[class=checkGoods][data=PREPAID]:checked").size()==0){
						disablePrePay();
					}
				}
			}else if($(this).attr("data")=="PAY"){
				if($(this).attr("checked")=="checked"){
					enablePay();
					disablePrePay();
					$("input[data=PREPAID]").removeAttr("checked");
				}else {
					if($("input[class=checkGoods][data=PAY]:checked").size()==0){
						disablePay();
					}
				}
			}
		});
		
		//预定限制监听
		$("#bookLimitType2").change(function(){
			//如果为超时担保
			if($(this).val()=='TIMEOUTGUARANTEE'){
				$("#deductType1").find("option[value=NONE]").removeAttr("disabled");
				$("#deductType1").find("option[value=NONE]").attr("selected","selected");				
				$("#deductType1").find("option[value=FIRSTDAY]").removeAttr("disabled");
				//显示保留时间
				$("#latestUnguarTime").removeAttr("disabled");				
			//全程担保
			}else  if($(this).val()=='ALLTIMEGUARANTEE'){				
				$("#latestUnguarTime").attr("disabled","disabled");
				$("#deductType1").find("option[value=FULL]").attr("selected","selected");		
				$("#deductType1").find("option[value=NONE]").attr("disabled", "disabled");		
				$("#deductType1").find("option[value=FIRSTDAY]").attr("disabled", "disabled");				
			}
			else {
				$("#deductType1").find("option[value=NONE]").removeAttr("disabled");
				$("#deductType1").find("option[value=NONE]").attr("selected","selected");				
				$("#deductType1").find("option[value=FIRSTDAY]").removeAttr("disabled");
				$("#latestUnguarTime").attr("disabled","disabled");
			}
		});
		
		$("#saveAndNextButton,#saveAndCloseButton").click(function(){
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
		
			//把提前预定时间转换为分钟数	
			var day = $("select[name=aheadHour_day]").val() == "" ? 0 : parseInt($("select[name=aheadHour_day]").val());
			var hour = $("select[name=aheadHour_hour]").val() == "" ? 0 : parseInt($("select[name=aheadHour_hour]").val());
			var minute = $("select[name=aheadHour_minute]").val() == "" ? 0 : parseInt($("select[name=aheadHour_minute]").val());
			$("select[name=aheadHour_day]").prev("label").find("input").val(day*24*60-hour*60-minute);
			
			//把最晚预定时间转化为分钟数
			var day1 = $("select[name=latestHoldTime_Day]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Day]").val());
			var hour1 = $("select[name=latestHoldTime_Hour]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Hour]").val());
			var minute1 = $("select[name=latestHoldTime_Minute]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Minute]").val());
			$("select[name=latestHoldTime_Day]").prev("label").find("input").val(day1*24*60-hour1*60-minute1);
			
			//设置最晚无损取消时间
			var day2 = $("select[name=lastCancelTime_Day][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Day][disabled!=disabled]").val());
			var hour2 = $("select[name=lastCancelTime_Hour][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Hour][disabled!=disabled]").val());
			var minute2 = $("select[name=lastCancelTime_Minute][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Minute][disabled!=disabled]").val());
			$("select[name=lastCancelTime_Day]").prev("label").find("input").val(day2*24*60-hour2*60-minute2);
			
			//设置预授权限制【预付】
			$("#bookLimitType").prev("label").find("input").val($("#bookLimitType").val());
			//设置预付扣款类型
			$("#deductType").prev("label").find("input").val($("#deductType").val());
			//设置担保类型
			$("#guarType").prev("label").find("input").val($("#guarType").val());
			//全额/峰时担保扣款
			$("#deductType1").prev("label").find("input").val($("#deductType1").val());
			//设置预定限制【现付】
			$("#bookLimitType2").prev("label").find("input").val($("#bookLimitType2").val());
			//退款类型
			$("#cancelStrategy1").prev("label").find("input").val($("#cancelStrategy1").val());
			$("#cancelStrategy").prev("label").find("input").val($("#cancelStrategy").val());
			//是否房量担保
			if($("#isGuarQuantity").val()=='Y'){
				$("#isGuarQuantity").prev("label").find("input").val($("#guarQuantity").val());
			}else {
				$("#isGuarQuantity").prev("label").find("input").val(-1);
			}
			//	预付扣款类型为金额，转换为分
			if($("#deductType").val()=="MONEY"){			
		  		 $(".prePay").find("input[name=deductValue]").val(Math.round(parseFloat($(".prePay").find("input[name=deductValueInput]").val())*100));
			}else{
				$(".prePay").find("input[name=deductValue]").val($(".prePay").find("input[name=deductValueInput]").val());
				
			}
			//保留房是否可恢复
			$("#restoreFlag").prev("label").find("input").val($("#restoreFlag").val());
			//房态
			$("#stockStatus").prev("label").find("input").val($("#stockStatus").val());
			//freesale
			$("#freeSaleFlag").prev("label").find("input").val($("#freeSaleFlag").val());
			
			//保存
			$.ajax({
				url : "/vst_back/goods/house/editHouseStatus.do",
				data :　$("#houseStatusForm").serialize(),
				dataType:'JSON',
				type : 'POST',
				success : function(result){
					if(result.code == 'success'){
						$.confirm(result.message,function(){
							if(buttonId=='saveAndNextButton'){
								//清空
								$('#houseStatusForm')[0].reset();
								checkCancelStrategy();
							}else if(buttonId=='saveAndCloseButton'){
								houseStatusDialog.close();
								$("#searchForm").submit();
							}
							
						});
					}else {
						$.alert(result.message);
					}
					
				}
			});
		});
		//默认选中
		$("input[type='checkbox'][value='${houseControlQueryVO.suppGoodsId}']").click();
		
	});
</script>


