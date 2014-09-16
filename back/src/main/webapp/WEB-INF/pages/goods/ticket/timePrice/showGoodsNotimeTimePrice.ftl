<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="position:relative">
	<div class="iframe_content mt10">
		 <div class="clearfix title">
			<h2 class="f16">商品销售信息查询</h2>
	     </div>
	     <form id="timePriceForm">
			 <div class="p_box clearfix">
		 		<table class="e_table">
		 			<tr>
		 				<td>
		 					<label class="radio">
		 						<#if suppGoods.prodProductBranch.cancelFlag!='Y'>
		 							<span style="color:red">[无效]</span>
		 						</#if>
		 						${suppGoods.prodProductBranch.branchName}-
		 						<#if suppGoods.cancelFlag!='Y'>
		 							<span style="color:red">[无效]</span>
		 						</#if>
		 						${suppGoods.goodsName}-
	 							<#if suppGoods.payTarget=="PREPAID">
	 								[预付:预付驴妈妈]
	 							<#else>
	 								[现付:现付供应商]
	 							</#if>
	 							<#if suppGoods.aperiodicFlag=='Y'>
	 								[期票商品]
	 							<#elseif suppGoods.aperiodicFlag=='N'>
	 								[普通商品]
	 							</#if>		 						
		 						<#if suppGoods.cancelFlag!='Y'>
		 							<span class="poptip-mini poptip-mini-warning">
		 								<div class="tip-sharp tip-sharp-left"></div>商品无效
		 							</span>
		 						</#if>
		 					</label>
		 					<input type="hidden" id="supplierId" name="supplierId" value="${suppGoods.suppSupplier.supplierId}"/>
		 					<input type="hidden" id="suppGoodsId" name="suppGoodsId" value="${suppGoods.suppGoodsId}"/>
		 					<input type="hidden" id="timePriceId" name="timePriceId" <#if suppGoodsNotimeTimePrice??> value="${suppGoodsNotimeTimePrice.timePriceId!''}"</#if>"/>
		 				</td>
				 	</tr>
		 		</table>
			 </div>
			  <div class="p_box box_info">
				<div class="title clearfix">
				    <h2 class="f16 fl" id="timePriceArrowView" style="cursor:pointer">时间价格表</h2>
		        </div>
			 </div>
			 <div class="p_box box_info">
			    <div class="price_content">
			     	<input type="hidden" name="type" value="0">
				     <div style="margin:-10px 0 0 20px">   
		           	 	<div class="p_date">
		                        <ul class="cal_range">
		                            <li><i class="cc1">*</i>可售时间范围:</li>
		                            <li><input type="text" name="startDate" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.startDate??> value="${suppGoodsNotimeTimePrice.startDate?string('yyyy-MM-dd')}"</#if>  errorEle="selectDate" class="Wdate" id="startDate" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'endDate\',{d:0});}'})" required/></li>
		                            <li>-</li>
		                            <li><input type="text" name="endDate" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.endDate??> value="${suppGoodsNotimeTimePrice.endDate?string('yyyy-MM-dd')}"</#if>  errorEle="selectDate" class="Wdate" id="endDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'startDate\',{d:0});}'})" required/></li>
		                            <li class="cc3">仅可操作两年内的时间</li>
		                        </ul>
		                </div>
			             <div class="J_con active" style="position:relative; padding-bottom:80px">
					 		<div class="title clearfix">
							    <h2 class="f16 fl" style="cursor:pointer;font-size:13px;">库存设置：</h2>
				        	</div>
				            <table width="800" class="e_table form-inline" style="width:900px;">
					             <tbody>
					                 <tr>
					                    <td class="e_label"><i class="cc1">*</i>是否限制总库存：</td>
					                    <td rowspan="3" colspan="1">
					                    	<table>
					                    		<tr>
					                    			<td>
					                    				<input type="radio" name="stockFlag" value="N" <#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.stockFlag=='N') || suppGoodsNotimeTimePrice==null>checked="checked"</#if>/>不限制
					                    			</td>
					                    			<td>&nbsp;</td>
					                    			<td>&nbsp;</td>
					                    		</tr>
					                    		<tr>
					                    			<td>
					                    				<input type="radio" name="stockFlag" value="Y" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.stockFlag=='Y'>checked="checked"</#if>/>限制总库存
					                    			</td>
					                    			<td class="e_label" width=100><i class="cc1">*</i>总库存：</td>
					                    			<td>
					                    				<input type="text" name="totalStock" id="totalStock" <#if suppGoodsNotimeTimePrice??> value="${suppGoodsNotimeTimePrice.totalStock!''}"</#if> <#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.stockFlag=='N') || suppGoodsNotimeTimePrice==null>disabled="disabled"</#if> <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.totalStock??>readonly="readonly"</#if>/>
					                    				<#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.totalStock??>剩余库存：</#if>
					                    				<input <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.totalStock??> type="text" readonly="readonly"<#else> type="hidden"</#if> name="stock" id="stock" <#if suppGoodsNotimeTimePrice??> value="${suppGoodsNotimeTimePrice.stock!''}"</#if>>
					                    			<span style="color:grey">为防止库存不同步，请不要直接修改库存。使用增减库存操作。</span></td>
					                    			
					                    		</tr>  
					                    		<tr>
					                    			<td>&nbsp;</td>                    		
					                    			<td class="e_label" >增减库存：</td>
					                    			<td>
								                    	<select id="operation" name="operation" class="w10">
										                      <option value="add">增加</option>
										                      <option value="sub">减少</option>
													    </select>				                    				
					                    				<input type="text" id="operationStock" name="operationStock" value=0 <#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.stockFlag=='N') || suppGoodsNotimeTimePrice==null>disabled="disabled"</#if> />
					                    			</td>
					                    		</tr>                		                    		                  		
					                    	</table>
					                    </td>
					                </tr>
					           </tbody>
				            </table>
							<div class="title clearfix">
							    <h2 class="f16 fl" style="cursor:pointer;font-size:13px;">价格设置：</h2>
				        	</div>
				            <table width="800" class="e_table form-inline" style="width:900px;">
					             <tbody>
					                <tr>
					                	<td class="e_label" width="100"><i class="cc1">*</i>市场价：</td>
					                	<td>
											<input type="text" id="showMarkerPrice" name="showMarkerPrice" maxlength="11" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.markerPriceYuan?string("0.##")}"</#if> required/>
											<input type="hidden" id="markerPrice" name="markerPrice" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.markerPrice!''}"</#if> required/>
					                	</td>
					                </tr>             
					             	<tr>
					                    <td class="e_label"><i class="cc1">*</i>结算价：</td>
					                    <td>
					                    	<input type="text" name="showSettlementPrice" id="showSettlementPrice" maxlength="11" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.settlementPriceYuan?string("0.##")}"</#if> required/>
					                    	<input type="hidden" id="settlementPrice" name="settlementPrice" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.settlementPrice!''}"</#if> required/>
					                    </td>
					                </tr>
					                 <tr>
					                    <td class="e_label"><i class="cc1">*</i>售价模式：</td>
					                    <td rowspan="3" colspan="1">
					                    	<table>
					                    		<tr>
					                    			<td width="100">
					                    				<input type="radio" name="priceModel" <#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.priceModel=='FIRM_PRICE') || suppGoodsNotimeTimePrice==null>checked="checked"</#if> value="FIRM_PRICE"/>固定价格
					                    			</td>
					                    			<td name="firm" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.priceModel!='FIRM_PRICE'>style="display:none"</#if>>
					                    				<i class="cc1">*</i>销售价：<input type="text"  name="showPrice" id="showPrice" maxlength="11" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.priceYuan?string("0.##")}"</#if> required/>					                    				
					                    			</td>
					                    			<input type="hidden" name="price" id="price" <#if suppGoodsNotimeTimePrice??>value="${suppGoodsNotimeTimePrice.price!''}"</#if> required/> 
					                    			<td name="firm">&nbsp;</td>		          
					                    			         			
					                    		</tr>
					                    		<tr>
					                    			<td>
					                    				<input type="radio" name="priceModel" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.priceModel=='PREMIUM'>checked="checked"</#if> value="PREMIUM"/>溢价
					                    			</td>
					                    			<td name="fixed" align="left">
					                    				<input type="radio" name="addType" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType=='FIXED_PRICE'>checked="checked"</#if> value="FIXED_PRICE"/>固定加价：&nbsp;&nbsp;
					                    				
					                    			</td>
					                    			<td name="fixed">
					                    				<i class="cc1">*</i>加价金额：<input type="text" id="addPrice" name="showAddValue" maxlength="8" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType=='FIXED_PRICE'>value="${suppGoodsNotimeTimePrice.addValueYuan?string("0.##")}"</#if> <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType!='FIXED_PRICE'>disabled="disabled"</#if>/>
					                    			</td>
					                    		</tr>
					                    		<tr name="fixed" <#if suppGoodsNotimeTimePrice.priceModel!='PREMIUM'>style="display:none"</#if>>
					                    			<td>&nbsp;</td>                    		
					                    			<td align="left">
					                    				<input type="radio" name="addType" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType=='MAKEUP_PRICE'>checked="checked"</#if> value="MAKEUP_PRICE"/>百分比加价：
					                    			</td>
					                    			<td>
					                    				<i class="cc1">*</i>加价比例：<input type="text" id="addScale" name="showAddValue" maxlength="3" <#if suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType=='MAKEUP_PRICE'>value="${suppGoodsNotimeTimePrice.addValueYuan?string("0.##")}"</#if> <#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.addType=='FIXED_PRICE')|| suppGoodsNotimeTimePrice==null>disabled="disabled"</#if>/>&nbsp;%
					                    			</td>
					                    		</tr>
					                    		<input type="hidden" name="addValue" id="addValue" required/> 
					                    	</table>
					                    </td>
					                </tr>
					           </tbody>
				            </table>  	            
			 			</div>
				 	</div>  
			 	</div>
			 </div>
		 </form>
		 <div class="p_box box_info clearfix mb20">
	       <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a class="btn" id="backToLastPageButton">返回上一步</a></div>
	     </div>
	 </div>
	<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	<#if (suppGoodsNotimeTimePrice?? && suppGoodsNotimeTimePrice.priceModel!='PREMIUM') || suppGoodsNotimeTimePrice==null>
	    $("tr[name=fixed]").hide();
     	$("td[name=fixed]").hide();
    </#if>
	$("#timePriceSaveButton").click(function(){
		if($("input[name=startDate]").val()>$("input[name=endDate]").val()){
			$.alert("开始时间不能大于结束时间！");
			return false;
		}	    
	    		/**
		 * 验证是否为负数
		 */
		jQuery.validator.addMethod("isMinus", function(value, element) {
		    var chars =  /^-/;
		    return this.optional(element) || (!chars.test(value));       
		 }, "不能输入负数");	
		 
		/**
		 * 验证数字
		 */
		jQuery.validator.addMethod("isNum1", function(value, element) {
		    var num = /^[1-9]{0}\d*(\.\d{1,2})?$/;
		    return this.optional(element) || (num.test(value));       
		 }, "请填写数字并且小数点后只能保留2位数");
		 
		/**
		 * 验证正整数
		 */
		jQuery.validator.addMethod("isInteger1", function(value, element) {
		    var chars =  /^[0-9]\d*$/;//验证正整数  
		    return this.optional(element) || (chars.test(value));       
		 }, "只能填写整数");
	    
	    
		if($("input[name=startDate]").val()>$("input[name=endDate]").val()){
			$.alert("开始时间不能大于结束时间！");
			return false;
		}
		
		if(!($("input[name=endDate]").val()<="${suppGoodsExp.endTime?string('yyyy-MM-dd')}")){
			$.alert("时间价格的可售时间范围不能超过期票商品信息的有效期范围！");
			return false;
		}
		
		// 验证正整数
		var rq = /^[0-9]*[1-9][0-9]*$/;
		//验证小数位数
		var req = /^[1-9]{1}\d*(\.\d{1,2})?$/;
		
     	// 是否限制库存
     	$("input[type=radio][name=stockFlag]").bind('click',function(){
     		 var obj = $(this);
     		 if(obj.attr('checked')=='checked'){
				setStockFlag(obj);
     		 }
     	});
     	
     	// 售价模式
     	$("input[type=radio][name=priceModel]").bind('click',function(){
      		var obj = $(this);
     		if(obj.attr('checked')=='checked'){
     			 setPriceModel($(this));
     		}
     	});
	  
		if(!$("#timePriceForm").validate({
			rules : {
				totalStock: {
					isMinus : true,
					isInteger1 : true,
					max:9999999999
				},
				operationStock: {
					isMinus : true,
					isInteger1 : true,
					max:9999999999
				},
				showMarkerPrice :{
					isMinus : true,
					isNum1 : true,
					required: true,
					max:9999999999,
					min:0					
				},
				showSettlementPrice :{
					isMinus : true,
					isNum1 : true,
					required: true,
					max:9999999999,
					min:0
				},
				showPrice :{
					isMinus : true,
					isNum1 : true,
					required: true,
					max:9999999999,
					min:0				
				},						
				showAddValue :{
					isMinus : true,
					isNum1 : true,
					required: true,
					max:9999999999,
					min:0
				}
			},
			messages : {
				startDate : '请选择开始日期',
				endDate : '请选择结束日期',
				cancelStrategy : '请选择退改类型'
			}
		}).form()){
			return false;
		}     	

     	// 计算结算价
     	operationAddType();
	
		//将元转换为分
		// 售价
		if($("#showPrice").val()!=""){
			$("#price").val(Math.round(parseFloat($("#showPrice").val())*100));
		}
		// 市场价
		if($("#showMarkerPrice").val()!=""){
			$("#markerPrice").val(Math.round(parseFloat($("#showMarkerPrice").val())*100));
		}
		// 结算价
		if($("#showSettlementPrice").val()!=""){
			$("#settlementPrice").val(Math.round(parseFloat($("#showSettlementPrice").val())*100));
		}	
		
		// 加价值
		var flag = "addPrice";
		if($("#addPrice").val()!=""){
			$("#addValue").val(Math.round(parseFloat($("#addPrice").val())*100));
		}
		if($("#addScale").val()!=""){
			$("#addValue").val(Math.round(parseFloat($("#addScale").val())*100));
			flag = "addScale";
		}		
		
		// 总库存计算

		if($("input:radio[name='stockFlag']:checked").val()=='Y'){
			if($("#operationStock").val()==""){
		    	$("#operationStock").val(0);
		    }
	    	if($("#stock").val()==""){
	    		$("#stock").val(0);
	    	}
			if($("#operation").find("option:selected").val()=="add"){
				$("#totalStock").val(parseFloat($("#totalStock").val())+parseFloat($("#operationStock").val()));
			}else if($("#operation").find("option:selected").val()=="sub"){
				$("#totalStock").val(parseFloat($("#totalStock").val())-parseFloat($("#operationStock").val()));
			}
			if(parseFloat($("#totalStock").val())<0){
				$("#totalStock").val(0);
			}
			$("#stock").val($("#totalStock").val());

		}

		var iPrice = parseFloat($("#price").val());// 售价
		var sPrice = parseFloat($("#settlementPrice").val()); // 结算价 
		if((sPrice-iPrice)>0){
			$.alert('售价不能小于结算价!!');
			return;
		}	
		// 禁止提交
		// 售价
		$("#showPrice").attr("disabled","disabled");
		// 市场价
		$("#showMarkerPrice").attr("disabled","disabled");
		// 结算价
		$("#showSettlementPrice").attr("disabled","disabled");
		// 加价值
		$("input[name=showAddValue]").attr("disabled","disabled");
	


		$.ajax({
			url : "/vst_back/ticket/goods/timePrice/editGoodsNotimeTimePrice.do",
			data :$("#timePriceForm").serialize(),
			dataType:'JSON',
			type: "POST",
			success : function(result){
				// 解禁
				// 售价
				$("#showPrice").removeAttr("disabled");
				// 市场价
				$("#showMarkerPrice").removeAttr("disabled");
				// 结算价
				$("#showSettlementPrice").removeAttr("disabled");
				// 加价值
				if(flag=="addPrice"){
					$("#addPrice").removeAttr("disabled");
				}else{
					$("#addScale").removeAttr("disabled");
				}
				$("#operationStock").val(0);
		    	$.alert(result.message,function(){
					window.history.go(-1);
				});
			},
			error : function(){
				$.alert(result.message);
			}
		})
	});

	// 设置[增减库存]按钮事件
     	$('#comfirmButton').bind('click',function(){	
			if($("input:radio[name='stockFlag']:checked").val()=='Y' && $("#totalStock").val()!=""){
			    if($("#operationStock").val()==""){
	    			$("#operationStock").val(0);
		    	}
		    	if($("#stock").val()==""){
		    		$("#stock").val(0);
		    	}
			
				if($("#operation").find("option:selected").val()=="add"){
					$("#totalStock").val(parseFloat($("#totalStock").val())+parseFloat($("#operationStock").val()));
					$("#stock").val(parseFloat($("#stock").val())+parseFloat($("#operationStock").val()));
				}else if($("#operation").find("option:selected").val()=="sub"){
					$("#totalStock").val(parseFloat($("#totalStock").val())-parseFloat($("#operationStock").val()));
					$("#stock").val(parseFloat($("#stock").val())-parseFloat($("#operationStock").val()));
				}
				$.ajax({
	 				url:'/vst_back/ticket/goods/timePrice/updateSuppGoodsNotimeTimeStock.do',
	 				type:"get",
					data :{"timePriceId":$("#timePriceId").val(),"totalStock":$("#totalStock").val(),"stock":$("#stock").val()},
					dataType:'JSON',
	                success: function (result) {
	                	$("#operationStock").val(0);
	                 	$.alert(result.message);    
	                }
 				});
			}else{
				$.alert("请先设置限制总库存！"); 
			}
     	});

	    // 是否限制库存
     	$("input[type=radio][name=stockFlag]").bind('click',function(){
     		 var obj = $(this);
     		 if(obj.attr('checked')=='checked'){
				setStockFlag(obj);
     		 }
     	});
	    // 设置[是否限制库存]单选按钮事件
     	$("input[type=radio][name=stockFlag]").bind('click',function(){
     		 var obj = $(this);
     		 if(obj.attr('checked')=='checked'){
				setStockFlag(obj);
     		 }
     	});
     	
     	// 设置[是否限制库存]样式
     	function setStockFlag(obj){
     		 var stockFlag = obj.val();
     		 // Y:限制日库存 N:不限制日库存
     		 if(stockFlag=='N'){
     		 	// 总库存
     		 	$('#totalStock').attr("disabled","disabled");
     		 	$('#totalStock').next("div").remove();
     		 	$('#totalStock').removeAttr("required");
     		 	// 增减库存数
     		 	$('#operationStock').attr("disabled","disabled");
     		 	$('#operationStock').next("div").remove();		
     		 }else{
     		 	// 总库存
     		 	$('#totalStock').removeAttr("disabled");
     		 	$('#totalStock').attr("required",true);
     		 	// 增减库存数
     		 	$('#operationStock').removeAttr("disabled");
     		 }     		
     	}
     	
     	// 售价模式
     	$("input[type=radio][name=priceModel]").bind('click',function(){
      		var obj = $(this);
     		if(obj.attr('checked')=='checked'){
     			 setPriceModel($(this));
     		}
     	});
     	
     	// 设置[售价模式]单选按钮事件
     	$("input[type=radio][name=priceModel]").bind('click',function(){
      		var obj = $(this);
     		if(obj.attr('checked')=='checked'){
     			 setPriceModel($(this));
     		}
     	});
     	// 设置[售价模式]样式
     	function setPriceModel(obj){
			var priceModel = obj.val();
     		 // 固定价格
     		 if(priceModel=='FIRM_PRICE'){
     		 	$("td[name=firm]").show(); 
     		 	// 销售价
     		 	$('#showPrice').removeAttr("disabled");
     		 	$('#showPrice').attr("required",true);
     		 	
     		 	// 加价金额
     		 	$('#addPrice').attr("disabled","disabled");
     		 	$('#addPrice').next().remove();
     		 	$('#addPrice').removeAttr("required");
     		 	
     		 	// 加价比例
     		 	$('#addScale').attr("disabled","disabled");
     		 	$('#addScale').next().remove();
     		 	$('#addScale').removeAttr("required");
     		 	
     		 	// 加价类型
     		 	$("input[type=radio][name=addType]").each(function(){
     		 		$(this).removeAttr("checked");
     		 	});
     		 	$("tr[name=fixed]").hide();
     		 	$("td[name=fixed]").hide();
     		 }else{
     		 	// 溢价
     		 	
     		 	// 销售价
     		 	$("tr[name=fixed]").show();
     		 	$("td[name=fixed]").show();
     		 	$('#showPrice').removeAttr("required");
     		 	$('#showPrice').attr("disabled","disabled");
     		 	$('#showPrice').next().remove();

     		 	//加价类型
     		 	$("input[type=radio][name=addType]").each(function(i){
     		 		if(i==0){
     		 			$(this).attr("checked",true);
		     		 	// 加价金额
		     		 	$('#addPrice').removeAttr("disabled");
		     		 	$('#addPrice').attr("required",true);     		 			
     		 		}
     		 	});	
     		 	$("td[name=firm]").hide(); 	
     		 }     		
     	}
     	
     	// 设置[加价类型]按钮事件
     	$("input[type=radio][name=addType]").bind('click',function(){
     		var obj = $(this);
     		if(obj.attr('checked')=='checked'){
				setAddType(obj);
     		}
     	});
     	
     	//设置[加价类型]样式
     	function setAddType(obj){
			 var addType = obj.val();
			 // 固定加价
			 if(addType=='FIXED_PRICE'){
			 	// 加价金额
     		 	$('#addPrice').removeAttr("disabled");
     		 	$('#addPrice').attr("required",true); 
     		 	// 加价比例	
     		 	$('#addScale').attr("disabled","disabled");
     		 	$('#addScale').next().remove();
     		 	$('#addScale').removeAttr("required");  
     		 	$('#addScale').val("");	 		
			 }else{
			 	// 百分比加价
			 	// 加价金额
     		 	$('#addPrice').removeAttr("required");
     		 	$('#addPrice').attr("disabled","disabled"); 
     		 	$('#addPrice').next().remove();
     		 	$('#addPrice').val("");	 	
     		 	// 加价比例	
     		 	$('#addScale').removeAttr("disabled");
     		 	$('#addScale').attr("required",true); 			 	
			 }
     	}
     	
     	
     	// 根据销售模式计算销售价
     	function operationAddType(){
	     	$("input[type=radio][name=priceModel]").each(function(){
	     		 var obj = $(this);
	     		 if(obj.attr('checked')){
					 var settlementPrice = parseFloat($('#showSettlementPrice').val());// 结算价
					 var priceModel = obj.val();
					 var price = '';// 销售价
					 // FIRM_PRICE:固定价格
					 if(priceModel=='FIRM_PRICE'){
						price = parseFloat($('#showPrice').val());// 销售价
					 }else{
					 	 // 加价类型
					 	 $("input[type=radio][name=addType]").each(function(){
					 	 	   var ts = $(this);
					 	 	   if(ts.attr('checked')){
						 	 	   var addType = ts.val();
						 	 	   // 固定加价
						 	 	   if(addType=='FIXED_PRICE'){
						 	 	   		var addPrice = parseFloat($('#addPrice').val());// 加价金额
						 	 			price = settlementPrice+addPrice;// 结算价+固定价格
						 	 	   }else{
									 	var addScale = parseFloat($('#addScale').val());// 加价比例
									    var scale = parseFloat(settlementPrice*(addScale/100));
									 	price = parseFloat(settlementPrice+scale);// 结算价加固定百分比					 	 	   
						 	 	   }
					 	 	   }
					 	 });
					 }
					 $('#showPrice').val(price);      		 	
	     		 }
	     	});      		
     	} 
     	$("#backToLastPageButton").click(function(){
		window.history.go(-1);
	});
</script>
