
	     <form id="reservationLimitForm">
	     	<#if categoryId??><input type="hidden" name="categoryId" value="${categoryId!''}" /></#if>
	     	<#if comOrderRequired??><input type="hidden" name="reqId" value="${comOrderRequired.reqId!''}" /></#if>
	     	<#if suppGoodsId??><input type="hidden" name="objectId" value="${suppGoodsId!''}" /></#if>
	     	<#if prodProduct?? && prodProduct.productId??><input type="hidden" name="objectId" value="${prodProduct.productId!''}" /></#if>
			<div class="box_content">
				<div id="travNum">
			 		<table class="e_table form-inline">
			 			<tr>
			 				<td class="e_label" width="150">
			 					<label><i class="cc1">*</i>1笔订单需要的“游玩人/取票人”数量：</label>
			 				</td>
			 				<td>
							  	<#list travNumTypeList as list>
							  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL'>
							  		<input type="radio" name="travNumType" value="${list.code!''}" <#if comOrderRequired?? && comOrderRequired.travNumType==list.code>checked</#if> required/>${list.cnName!''}
							  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
							  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
							  		</#if>
							  		<#if travNumTypeList?size-4!=list_index></br></#if>
							  		</#if>
							  	</#list>
							  	<div class="e_error" id="travNumTypeError"/>
			 				</td>
					 	</tr>
					 </table></br>
				 </div>
				 <div id="ennameNum">
					 <table class="e_table form-inline">
			 			<tr>
			 				<td class="e_label" width="150">
			 					<label><i class="cc1">*</i>英文姓名：</label>
			 				</td>
			 				<td>
							  	<#list travNumTypeList as list>
							  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL' || list.code=='TRAV_NUM_NO'>
							  		<input type="radio" name="ennameType" value="${list.code!''}"  <#if comOrderRequired?? && comOrderRequired.ennameType==list.code>checked</#if> required/>${list.cnName!''}
							  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
							  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
							  		</#if>
							  		<#if travNumTypeList?size-2!=list_index></br></#if>
							  		</#if>
							  	</#list>
							  	<div class="e_error" id="ennameTypeError"/>
			 				</td>
					 	</tr>
			 		 </table></br>
				 </div>
				 <div id="occupNum">
					 <table class="e_table form-inline">
			 			<tr>
			 				<td class="e_label" width="150">
			 					<label><i class="cc1">*</i>人群：</label>
			 				</td>
			 				<td>
							  	<#list travNumTypeList as list>
							  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL' || list.code=='TRAV_NUM_NO'>
							  		<input type="radio" name="occupType" value="${list.code!''}"  <#if comOrderRequired?? && comOrderRequired.occupType==list.code>checked</#if> required/>${list.cnName!''}
							  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
							  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
							  		</#if>
							  		<#if travNumTypeList?size-2!=list_index></br></#if>
							  		</#if>
							  	</#list>
							  	<div class="e_error" id="occupTypeError"/>
			 				</td>
					 	</tr>
			 		 </table></br>
			 	  </div>
			 	  <div id="phoneNum">
					 <table class="e_table form-inline">
			 			<tr>
			 				<td class="e_label" width="150">
			 					<label><i class="cc1">*</i>手机号：</label>
			 				</td>
			 				<td>
							  	<#list travNumTypeList as list>
							  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL' || list.code=='TRAV_NUM_NO'>
							  		<input type="radio" name="phoneType" value="${list.code!''}"  <#if comOrderRequired?? && comOrderRequired.phoneType==list.code>checked</#if> required/>${list.cnName!''}
							  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
							  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
							  		</#if>						  		
							  		<#if travNumTypeList?size-2!=list_index></br></#if>
							  		</#if>	
							  	</#list>
							  	<div class="e_error" id="phoneTypeError"/>
			 				</td>
					 	</tr>
			 		</table></br>
		 		 </div>
		 		 <div id="emailNum">
				 <table class="e_table form-inline">
		 			<tr>
		 				<td = class="e_label"  width="150">
		 					<label><i class="cc1">*</i>email：</label>
		 				</td>
		 				<td>
						  	<#list travNumTypeList as list>
						  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL' || list.code=='TRAV_NUM_NO'>
						  		<input type="radio" name="emailType" value="${list.code!''}"  <#if comOrderRequired?? && comOrderRequired.emailType==list.code>checked</#if> required/>${list.cnName!''}
						  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
						  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
						  		</#if>						  		
						  		<#if travNumTypeList?size-2!=list_index></br></#if>
						  		</#if>
						  	</#list>
						  	<div class="e_error" id="emailTypeError"/>
		 				</td>
				 	</tr>
		 		 </table></br>
		 		 </div>
		 		 <div id="credNum">
				 <table class="e_table form-inline">
		 			<tr>
		 				<td class="e_label" width="150">
		 					<label><i class="cc1">*</i>证件：</label>
		 				</td>
		 				<td>
						  	<#list travNumTypeList as list>
						  		<#if list.code=='TRAV_NUM_ONE' || list.code=='TRAV_NUM_ALL' || list.code=='TRAV_NUM_NO'>
						  		<input type="radio" name="credType" value="${list.code!''}"  <#if comOrderRequired?? && comOrderRequired.credType==list.code>checked</#if> required/>${list.cnName!''}
						  		<#if list.code=='TRAV_NUM_ONE'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类只需要一个游玩人即可。</span>
						  		<#elseif list.code=='TRAV_NUM_ALL'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color:grey">注，代表该品类基于“数量关联”有几个游玩人就需要填写几个。</span>
						  		</#if>						  		
						  		<#if travNumTypeList?size-2!=list_index></br></#if>
						  		</#if>
						  	</#list>
						  	<div class="e_error" id="credTypeError"/>
		 				</td>
				 	</tr>
		 		</table></br>
		 		</div>
		 		<div id="credNumType">
				<table class="e_table form-inline">
		 			<tr>
		 				<td class="e_label" width="150" rowspan=4>
		 					<label><i class="cc1">*</i>可用证件类型：</label>
		 				</td>
		 				<td>
		 					<i class="cc1">*</i>身份证：&nbsp;<input type="radio" name="idFlag" value="N" <#if comOrderRequired && comOrderRequired.idFlag=='N'>checked</#if> required/>不可用&nbsp;<input type="radio" name="idFlag" value="Y" <#if comOrderRequired?? && comOrderRequired.idFlag=='Y'>checked</#if> required/>可用<div class="e_error" id="idFlagError"/>
		 					
		 				</td>
				 	</tr>
				 	<tr>
		 				<td>
		 					<i class="cc1">*</i>护照：&nbsp;&nbsp;&nbsp;<input type="radio" name="passportFlag" value="N" <#if comOrderRequired?? && comOrderRequired.passportFlag=='N'>checked</#if> required/>不可用&nbsp;<input type="radio" name="passportFlag" value="Y" <#if comOrderRequired?? && comOrderRequired.passportFlag=='Y'>checked</#if> required/>可用<div class="e_error" id="passportFlagError"/>
		 				</td>
				 	</tr>
				 	<tr>
		 				<td>
		 					<i class="cc1">*</i>港澳通行证：<input type="radio" name="passFlag" value="N" <#if comOrderRequired?? && comOrderRequired.passFlag=='N'>checked</#if> required/>不可用
		 					<input type="radio" name="passFlag" value="Y" <#if comOrderRequired?? && comOrderRequired.passFlag=='Y'>checked</#if> required/>可用<div class="e_error" id="passFlagError"/>
		 				</td>
				 	</tr>
				 	<tr>
		 				<td>
		 					<i class="cc1">*</i>台湾通行证：
		 					<input type="radio" name="twPassFlag" value="N" <#if comOrderRequired?? && comOrderRequired.twPassFlag=='N'>checked</#if> required/>不可用
		 					<input type="radio" name="twPassFlag" value="Y" <#if comOrderRequired?? && comOrderRequired.twPassFlag=='Y'>checked</#if> required/>可用<div class="e_error" id="twPassFlagError"/>
		 				</td>
				 	</tr>				 					 	
		 		</table>
		 		</div>	 		
			 </div>
		 </form>

<script>
//选择目的地

		if($("input[name=credType]:checked").val()=='TRAV_NUM_NO'){
			$("#credNumType").hide();
		}
		
	function showRequire(categoryId,productType,addtion){
		$("#travNum").show();
		$("input[name='travNumType']").removeAttr("disabled");
		$("#ennameNum").show();
		$("input[name='ennameType']").removeAttr("disabled");
		$("#occupNum").show();
		$("input[name='occupType']").removeAttr("disabled");
		$("#phoneNum").show();
		$("input[name='phoneType']").removeAttr("disabled");
		$("#emailNum").show();
		$("input[name='emailType']").removeAttr("disabled");
		$("#credNum").show();
		$("input[name='credType']").removeAttr("disabled");
		var key = "";
		if(categoryId==15){
			key = "GROUP"
		}else if(categoryId==18){
			key = "FREEDOM"
		}else if(categoryId==16){
			key = "LOCAL"
		}else if(categoryId==3){
			key = "INSURANCE"
		}else if(categoryId==11){
			key = "SINGLE_TICKET"
		}else if(categoryId==13){
			key = "COMB_TICKET"
		}else if(categoryId==12){
			key = "OTHER_TICKET"
		}else if(categoryId==21){
			key = "TRAFFIC_AERO_OTHER"
		}else if(categoryId==23){
			key = "TRAFFIC_TRAIN_OTHER"
		}else if(categoryId==25){
			key = "TRAFFIC_BUS_OTHER"
		}else if(categoryId==27){
			key = "TRAFFIC_SHIP_OTHER"
		}
		if(productType!=""){
			key = key+"_"+productType;
		}
		if(addtion!=""){
			key = key+"_"+addtion;
		}
		$.ajax({
			url:'/vst_back/biz/orderRequired/findOrderRequiredList.do',
			type:"get",
			data :{"groupCode":key},
			async:false,
			dataType:'JSON',
            success: function (result) {
            	if(result == null){
            		return;	
            	}
            	if(result.needTravFlag != null){
	            	if(result.needTravFlag=="N"){
		            	$("#reservationLimitForm").hide();
		            	$("#reservationLimitForm").children().find("input").each(function(){
							$(this).attr("disabled","disabled"); 
						}); 
		            }else{
	            		if($("#reservationLimitForm").is(":hidden")){
	            			$("#reservationLimitForm").show();
	            		}
	            		$("#reservationLimitForm").children().find("input").each(function(){
							$(this).removeAttr("disabled");
						}); 
	            		if(result.travNumType != "TRAV_NUM_CONF"){
	            			$("#travNum").hide();
	            			$("input[name='travNumType']").attr("disabled","disabled"); 
	            		}else{
	            			$("#travNum").show();
	            			$("input[name='travNumType']").remove("disabled"); 
	            		}
	            		if(result.ennameType != "TRAV_NUM_CONF"){
	            			$("#ennameNum").hide();
	            			$("input[name='ennameType']").attr("disabled","disabled"); 
	            		}else{
	            			$("#ennameNum").show();
	            			$("input[name='ennameType']").remove("disabled"); 
	            		}
						if(result.occupType != "TRAV_NUM_CONF"){
	            			$("#occupNum").hide();
	            			$("input[name='occupType']").attr("disabled","disabled");
	            		}else{
	            			$("#occupNum").show();
	            			$("input[name='occupType']").remove("disabled"); 
	            		}
	            		if(result.phoneNumType != "TRAV_NUM_CONF"){
	            			$("#phoneNum").hide();
	            			$("input[name='phoneType']").attr("disabled","disabled");
	            		}else{
	            			$("#phoneNum").show();
	            			$("input[name='phoneType']").remove("disabled"); 
	            		}
	            		if(result.emailType != "TRAV_NUM_CONF"){
	            			$("#emailNum").hide();
	            			$("input[name='emailType']").attr("disabled","disabled");
	            		}else{
	            			$("#emailNum").show();
	            			$("input[name='emailType']").remove("disabled"); 
	            		}
	            		if(result.idNumType != "TRAV_NUM_CONF"){
	            			$("#credNum").hide();
	            			$("#credNumType").hide();
	            			$("input[name='credType']").attr("disabled","disabled");
	            		}else{
	            			$("#credNum").show();
	            			$("#credNumType").show();
	            			$("input[name='credType']").remove("disabled"); 
	            		}
		            }
            	}
	            
            }
		});
	}
	
	$("input[name=credType]").change(function(){
		if($("input[name=credType]:checked").val()=='TRAV_NUM_NO'){
			$("#credNumType").hide();
		}else{
			$("#credNumType").show();
		}
	});
	
</script>