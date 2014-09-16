<html>
   <head>
  </head>
  <body>
	<form id="dataForm">
		<table class="p_table form-inline">
			<tbody>
				<tr>
					<td colspan="3" width="100">费用包含：</td>
					<input type="hidden" name="suppGoodsId" value=${suppGoodsDesc.suppGoodsId}>
				</tr>
				<tr>
					<td class="p_label"><i class="cc1">*</i>费用包含：</td>
					<td colspan=2>
						<textarea maxlength="100"  id="priceIncludes" name="priceIncludes" class="textWidth" style="width:419px; height:70px" required>${suppGoodsDesc.priceIncludes}</textarea>&nbsp;&nbsp;50个汉字以内
					</td>
				</tr>
				
				<tr>
					<td colspan=3>入园须知：</td>
				</tr>
				<tr>
					<td class="p_label">取票时间：</td>
					<td colspan=2>
						<input   maxlength="50" id="changeTime" type="text" name="changeTime" value="${suppGoodsDesc.changeTime}" style="width:300px; height:25px"></td>
				</tr>
				 <tr>
					<td class="p_label">取票地点：</td>
					<td colspan=2>
						<input  maxlength="50" type="text" name="changeAddress" id="changeAddress" value="${suppGoodsDesc.changeAddress}" style="width:300px; height:25px"></td>
				</tr>
				
				<tr>
					<td class="p_label">入园方式：</td>
					<td colspan=2>
						<input  maxlength="50" type="text" name="enterStyle" id="enterStyle" value="${suppGoodsDesc.enterStyle}" style="width:300px; height:25px"></td>
				</tr>               
				<tr>
					<td class="p_label">有效期：</td>
					<td colspan=2>
						<#if suppGoodsExp?? && suppGoods??>
							<#if suppGoods.aperiodicFlag=='Y'>
								&nbsp;${suppGoodsExp.startTime?string('yyyy-MM-dd')}&nbsp;至&nbsp;${suppGoodsExp.endTime?string('yyyy-MM-dd')}&nbsp;有效，期票商品不适用日期：${suppGoodsExp.unvalid}
							<#else>
								指定游玩日后${suppGoodsExp.days}天内有效
							</#if>				
						</#if>
					</td>
				</tr>
				
			   <tr>
					<td class="p_label"><i class="cc1">*</i>入园限制：</td>
					<td>
						<#if suppGoodsDesc.limitFlag==1>
							<input id='wx' type="radio" name="limitFlag" value="1" checked="checked">无限制</br>
							<input type="radio" name="limitFlag" value="0" id='yx'>有限制&nbsp;&nbsp;&nbsp;							
						<#elseif suppGoodsDesc.limitFlag==0>
							<input id='wx' type="radio" name="limitFlag" value="1">无限制</br>
							<input type="radio" name="limitFlag" value="0" checked="checked" id='yx'>有限制&nbsp;&nbsp;&nbsp;							
						<#else>
							<input id='wx' type="radio" name="limitFlag" checked="checked" value="1">无限制</br>
							<input type="radio" name="limitFlag" value="0" id='yx'>有限制&nbsp;&nbsp;&nbsp;								
						</#if>
						 请在入园当天的
							<select class="w10 mr10" style="width:60px;font-size=1px"  name="hour" id="hour">
							 <#list hourList as item>
							 	<#if item==hour>
							   		<option value="${item}" selected="selected">${item}</option>
							   	<#else>
							   		<option value="${item}">${item}</option>
							   	</#if>
							  </#list>
							</select>
						  点
						  <select class="w10 mr10" style="width:60px" name="minute"  id="minute">								   	
							   <#list minuteList as item>									   
							 	<#if item==minute>
							   		<option value="${item}" selected="selected">${item}</option>
							   	<#else>
							   		<option value="${item}">${item}</option>
							   	</#if>
							  </#list>
						  </select>
						  分以前入园
					</td>
			   </tr>
			   <tr>
					<td colspan=3>重要提示：</td>
				</tr>
				<tr>
					<td class="p_label">退改说明：</td>
					<td colspan=2>
						<#if suppGoods?? && suppGoodsRefunds?? && suppGoodsRefunds?size &gt; 0>
							<#if suppGoods.aperiodicFlag=='N'>
								<#list suppGoodsRefunds as suppGoodsRefund>
									<#if suppGoodsRefund.cancelStrategy=='MANUALCHANGE'>
										<#if suppGoodsRefund.deductType=='AMOUNT'>
											<#if suppGoodsRefund.deductValue==0>
												可退改：游玩${suppGoodsRefund.lastTime}前随时退，不承担任何损失
											<#else>
												可退改： 游玩${suppGoodsRefund.lastTime}之前，如修改或取消订单，将收取${suppGoodsRefund.deductValueYuan}元作为违约金 。超过该时间点退改，需要人工核实后，方可操作
											</#if>
											</br>
										<#elseif suppGoodsRefund.deductType=='PERCENT'>
											<#if suppGoodsRefund.deductValue==0>
												可退改： 游玩${suppGoodsRefund.lastTime}前随时退，不承担任何损失
											<#else>
												可退改： 游玩${suppGoodsRefund.lastTime}之前，如修改或取消订单，将收取票价的${suppGoodsRefund.deductValueYuan}%作为违约金 。超过该时间点退改，需要人工核实后，方可操作											
											</#if>
											</br>										
										</#if>
									<#elseif suppGoodsRefund.cancelStrategy=='UNRETREATANDCHANGE'>
										 预订成功后 ，如修改或取消订单，将收取订单的总金额作为违约金
								    </#if>
								</#list>
							<#else>
								<#list suppGoodsRefunds as suppGoodsRefund>
									<#if suppGoodsRefund.cancelStrategy=='MANUALCHANGE'>
										<#if suppGoodsRefund.deductType=='AMOUNT'>
											<#if suppGoodsRefund.deductValue==0>
												可退改：最晚有效期${suppGoodsRefund.lastTime}前随时退,不承担任何损失
											<#else>
												可退改： 最晚有效期${suppGoodsRefund.lastTime}之前，如修改或取消订单，将收取${suppGoodsRefund.deductValueYuan}元作为违约金 。超过该时间点退改，需要人工核实后，方可操作
											</#if>
											</br>
										<#elseif suppGoodsRefund.deductType=='PERCENT'>
											<#if suppGoodsRefund.deductValue==0>
												可退改： 最晚有效期${suppGoodsRefund.lastTime}前随时退，不承担任何损失
											<#else>
												可退改： 最晚有效期${suppGoodsRefund.lastTime}之前，如修改或取消订单，将收取票价的${suppGoodsRefund.deductValueYuan}%作为违约金 。超过该时间点退改，需要人工核实后，方可操作											
											</#if>
											</br>										
										</#if>
									<#elseif suppGoodsRefund.cancelStrategy=='UNRETREATANDCHANGE'>
										 预订成功后，如修改或取消订单，将收取订单的总金额作为违约金
								    </#if>
								</#list>							
							</#if>
						</#if>
					</td>
				</tr>
				<tr>
					<td rowspan="7" class="p_label">票种说明：</td>
					
				</tr>
				<tr align="right">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;身高:<input  maxlength="25" type="text" name="height" value="${suppGoodsDesc.height}" style=" width:300px; height:25px">
				</tr>
				<tr align="right">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年龄:<input maxlength="25" type="text" name="age" value="${suppGoodsDesc.age}" style="width:300px; height:25px">
				</tr>
				<tr align="right">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地域:<input maxlength="25" type="text" name="region" value="${suppGoodsDesc.region}" style="width:300px; height:25px">
				</tr>
				<tr align="right">
					<td>最大限购:<input maxlength="25" type="text" name="maxQuantity" value="${suppGoodsDesc.maxQuantity}" style="width:300px; height:25px">
				</tr>
				<tr align="right">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;快递:<input maxlength="25" type="text" name="express" value="${suppGoodsDesc.express}" style="width:300px; height:25px">
				</tr>
				<tr align="right">
					<td>实体票:&nbsp;&nbsp;
					  <input maxlength="25" type="text" name="entityTicket" value="${suppGoodsDesc.entityTicket}" style="width:300px; height:25px">
					</td>
				</tr>
				<tr>
					<td>
						其他:
					</td>
					<td>
						<input maxlength="25" type="text" name="others" value="${suppGoodsDesc.others}" style="width:350px ; height:25px"></td>
					</td>
				</tr>
				
			</tbody>
		</table>
	</form>
<div class="p_box box_info clearfix mb20">
            <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="saveDesc">保存</a></div>
</div>
</body>
</html>
	<script>
		$(function(){
		
			$(".textWidth[maxlength]").each(function(){
				var	maxlen = $(this).attr("maxlength");
				if(maxlen != null && maxlen != ''){
					var l = maxlen*12;
					if(l >= 500) {
						l = 500;
					} else if (l <= 200){
						l = 200;
					} else {
						l = 400;
					}
					$(this).width(l);
				}
				$(this).keyup(function() {
					vst_util.countLenth($(this));
				});
			});		
			
			if($("#wx").attr("checked")=='checked'){
			  $("#minute").attr("disabled","true");
			  $("#hour").attr("disabled","true");
			}
			 $("#wx").click(function(){
			 	 $("#minute").attr("disabled","true");
			  	 $("#hour").attr("disabled","true");
			 })
			 
			 $("#yx").click(function(){
			     $("#minute").removeAttr("disabled");
			  	 $("#hour").removeAttr("disabled");			 
			 })
		})
		
		$("#saveDesc").bind('click',function(){
			if(!$("#.dialog #dataForm").validate({
				rules : {
					priceIncludes : {
					}					
				},
				messages : {
					featureDesc : '不可输入特殊字符'
				}
			}).form()){
				$(this).removeAttr("disabled");
				return false;
			}
			
			var msg = '确认保存吗 ？';	
			if(refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"))){
			 	msg = '内容含有敏感词,是否继续?'
			}			
			
			$.confirm(msg,function(){
				$.ajax({
					url : "/vst_back/ticket/goods/goods/suppGoodsDescAdd.do",
					type : "post",
					data : $(".dialog #dataForm").serialize(),
					success : function(result) {
						alert(result.message);
					}
				});
			});
		});
		refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"));
	</script>