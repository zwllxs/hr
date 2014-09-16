<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="position:relative">
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><#if prodProduct != null && prodProduct.bizCategory != null>
	            ${prodProduct.bizCategory.categoryName}&gt;
            </#if>
            </li>
            <li>商品维护&gt; </li>
            <li><a href="#">销售信息</a>&gt;</li>
            <li class="active">查看/维护时间价格表</li>
        </ul>
    </div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
        <p class="pl15">1.可以查询的供应商为在“供应商合同关联”里面维护的供应商</p>
        <p class="pl15">2.可查询的商品，为当前产品下，供应商关联的当前规格的所有商品</p>
        <p class="pl15">3.可设置的为，有效的商品</p>
    </div>
<div class="p_box">
<form method="post" action='/vst_back/goods/timePrice/showGoodsTimePrice.do' id="searchForm">
		<input type="hidden" name="prodProduct.productId" value="${prodProduct.productId}" />
		<input type="hidden" name="prodProduct.bizCategory.categoryName" value="${prodProduct.bizCategory.categoryName}" />
		<input type="hidden" name="prodProduct.productName" value="${prodProduct.productName}" />
        <table class="s_table">
            <tbody>
            	<tr>          
                    <td class="s_label">供应商:</td>
                    <td >${suppGoods.suppSupplier.supplierName}</td>
            	</tr>
            </tbody>
        </table>	
	</form>
 </div>
 <div class="clearfix title">
		<h2 class="f16">商品销售信息查询</h2>
             </div>
 <div class="p_box clearfix">
 		<table class="e_table">
 				<#if goodsList??>
 				<#assign index=0>
 				<#list goodsList as good>
 				<#if index%5==0><tr></#if>
	 				<td>
	 					<label class="radio"><input type="radio" name="good" value="${good.suppGoodsId}" data="${suppGoods.suppSupplier.supplierId}" /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}-<#if good.payTarget=="PREPAID">[预付]<#else>[现付]</#if><#if good.cancelFlag!='Y'><span class="poptip-mini poptip-mini-warning"><div class="tip-sharp tip-sharp-left"></div>商品无效</span></#if></label>
	 				</td>
	 				<#assign index = index+1>
	 				<#if index%5==0||index==goodsList?size></tr></#if>
	 			</#list>
 				</#if>
 		</table>
 </div>
  <div class="p_box box_info">
  		<div class="title clearfix">
			    <h2 class="f16 fl" id="timePriceArrowView" style="cursor:pointer">时间价格表</h2>
			    <div id="timePriceArrow" class="J_date_more date_more active"><span>收起</span><span style=" position:relative; top:8px; left:26px; float:left"><i class="ui-arrow-bottom blue-ui-arrow-bottom"></i></span></div>
                <span class="J_tip fr cc3" id="showTips"><i class="J_tip icon-remind" ></i> 查看说明</span> 
            </div>
             <div style="width:300px;background:#ffffe0;border:1px solid #ff8801;position:absolute;right:0px;display:none;padding:10px;z-index:100" id="tips">
                	售：销售价</br>结：结算价</br>提前：提前预定时间</br>价格</br>库存</br>保留：保留房间的数量</br>增减：增减房间的数量</br>可超/不可超：可以超卖/不可以超卖</br>可恢复/不可恢复：保留房可以恢复/不可以恢复</br>退改</br>预授：预售或担保的类型</br>无损：预付或担保最晚取消的时间</br>峰值：预付扣款类型&全额/峰值担保扣款</br>一律/超时：预订限制
             </div>
 		<div id="timePriceDiv" class="time_price">
 			
 		</div>
 </div>
 <#if suppGoods.stockApiFlag??&&suppGoods.stockApiFlag == 'N'>
 <div class="p_box box_info">
 
 	<div class="price_tab">
        <ul class="J_tab ui_tab">
            <li class="active" data="0"><a href="javascript:;">设置价格</a></li>
            <li data="3"><a href="javascript:;">设置库存</a></li>
            <li data="1"><a href="javascript:;">设置退改扣款机制</a></li>
        </ul>
     </div>
     <div class="price_content">
     <form id="timePriceForm">
     <input type="hidden" name="type" value="0">
     <div style="margin:-10px 0 0 20px">   
     <table class="e_table form-inline">
               <tbody>
               	<tr class="payTargetTitle">
               		<td><h2>预付商品</h2></td>
           		</tr>
                <#if perPayList??>
							<#assign index=0>
		 					<#list perPayList as good>
 							<#if index%5==0><tr></#if>
								<td>
			 					<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index}]" value="${good.suppGoodsId}" data="${good.payTarget}" <#if good.cancelFlag!='Y'||good.prodProductBranch.cancelFlag!='Y'>disabled=disabled</#if> /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}-<#if good.payTarget=="PREPAID">[预付]</#if>&nbsp;&nbsp;<#if good.hasTimePriceFlag!="Y"><span style="color:red">[未设置]</span></#if></label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==perPayList?size></tr></#if>
			 				</#list>
		 		</#if>
		 		<tr class="payTargetTitle">
               		<td><h2>现付商品</h2></td>
           		</tr>
           		<#if payList??>
							<#assign index=0>
		 					<#list payList as good>
 							<#if index%5==0><tr></#if>
								<td>
			 					<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index+perPayList?size}]" value="${good.suppGoodsId}" data="${good.payTarget}" <#if good.cancelFlag!='Y'||good.prodProductBranch.cancelFlag!='Y'>disabled=disabled</#if> /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}-<#if good.payTarget=="PAY">[现付]</#if>&nbsp;&nbsp;<#if good.hasTimePriceFlag!="Y"><span style="color:red">[未设置]</span></#if></label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==payList?size></tr></#if>
			 				</#list>
		 		</#if>
                </tbody>
                </table>
            	 <div class="p_date">
                        <ul class="cal_range">
                            <li><i class="cc1">*</i>日期范围:</li>
                            <li><input type="text" name="startDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /></li>
                            <li>-</li>
                            <li><input type="text" name="endDate" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></li>
                            <li class="cc3">仅可操作两年内的时间</li>
                            <div id="selectDateError" style="display:inline"></div>
                        </ul>
                        <ul class="app_week">
                            <li><i class="cc1">*</i>适用日期:</li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDayAll">全部</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="2">一</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="3">二</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="4">三</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="5">四</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="6">五</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="7">六</label></li>
                            <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="1">日</label></li>
                        </ul>
                </div>
     
             <div class="J_con active" style="position:relative; padding-bottom:80px">
			 <input type="hidden" name="supplierId" value="<#if suppGoods.suppSupplier??>${suppGoods.suppSupplier.supplierId}</#if>">
             <table class="e_table form-inline">
             <tbody>
             	<tr>
                    <td width="150" class="e_label">价格禁售：</td>
                    <td>
                    	<select name="onsaleFlag" class="w10" required=true>
		                      <option value="Y">否</option>
		                      <option value="N">是</option>
					    </select>
                    </td>
                </tr>
                 <tr>
                    <td width="150" class="e_label">早餐	情况：</td>
                    <td>
                    	<select name="breakfast" class="w10">
                    	<#list 0..20 as i>
		                      <option value="${i}">${i}</option>
                        </#list>
					</select>
                    </td>
                </tr>
                <tr>
	                <td class="e_label"><i class="cc1">*</i>销售价：</td>
		            <td><input type="hidden" id="price" name="price" /><input type="text" id="priceInput" name="priceInput" number=true  min=0/></td>
                </tr>
                <tr>
	                <td class="e_label"><i class="cc1">*</i>结算价：</td>
                    <td><input type="hidden" id="settlementPrice" name="settlementPrice" /><input type="text" id="settlementPriceInput" name="settlementPriceInput" number=true  min=0/>
                    <div id="settlementPriceInputError"  ></div>
                    </td>
               </tr>
               <tr style="height:120px;">
	                <td colspan="2">
					    <div  style="position:absolute;left:355px;bottom:147px;">
							=卖价<input type="text" id="salePrice" style="width:50px" name="salePrice" number=true  min=0/>-
							佣金<input type="text" style="width:50px" id="commission" name="commission" number=true  min=0/>
							<a class="btn count_1" id="count_1">计算</a><div id="countError" style="display:none" >请输入数字 </div>
							<br/>
							=卖价<input type="text" id="salePrice_2" style="width:50px" name="salePrice_2" number=true  min=0/>
							*(1-佣金率<input type="text" id="commissionRates" style="width:50px" name="commissionRates" number=true  min=0/>)
							<a class="btn count_2" id="count_2">计算</a><div id="countError2" style="display:none" >请输入数字 </div>
						<br/>
							=(卖价<input type="text" style="width:50px" id="salePrice_3" name="salePrice_3" number=true  min=0/>-
							服务费<input type="text" style="width:50px" id="servicePrice" name="servicePrice" number=true  min=0/>)*
							(1-佣金率<input type="text" style="width:50px" id="commissionRates_3" name="commissionRates_3" number=true  min=0/>)
							<a class="btn count_3" id="count_3">计算</a><div id="countError3" style="display:none" >请输入数字 </div>
						<br/>
							=卖价<input type="text" style="width:50px" id="salePrice_4" name="salePrice_4" number=true  min=0/>
							/(1+服务费率<input type="text" style="width:50px" id="serviceRates" name="serviceRates" number=true  min=0/>)*
							(1-佣金率<input type="text" style="width:50px" id="commissionRates_4" name="commissionRates_4" number=true  min=0/>)
							<a class="btn count_4" id="count_4">计算</a><div id="countError4" style="display:none" >请输入数字 </div>
						</div>
					</td>
	            </tr>
               
	             <tr>
                    <td class="e_label">提前预定时间：</td>
                    <td>
                    	<input type="hidden"  name="aheadBookTime" id="aheadBookTime">
                    	<select class="w10 mr10" name="aheadHour_day">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="aheadHour_hour">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>点
		                <select class="w10 mr10" name="aheadHour_minute">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
                    </td>
                </tr>
	            </tbody>
	           </table>
 	</div>
	
 	<div class="J_con" style="position:relative; padding-bottom:80px">
        	<table class="e_table form-inline">
             <tbody>
            	 <tr>
                    <td width="150" class="e_label">合同库存：</td>
                    <td>
                        <select class="w10" name="totalStock" >
                    	  <#list 0..50 as i>
	                      <option value="${i}">${i}</option>
	                      </#list>
		                </select>
		             	<span class="cc3">合同库存，仅呈现，不参与库存扣减。具体库存需要在下面的保留房里面设置</span>
                    </td>
                </tr>
                <tr>
                    <td width="150" class="e_label">库存类型<i class="cc1">*</i>	：</td>
                    <td>
                    	<label class="radio mr10"><input type="radio" name="stockFlag" value="N" id="stockFlag" checked="checked">非保留房</label>
                        <label class="radio"><input type="radio" name="stockFlag" id="stockFlag" value="Y">保留房</label>
                    </td>
                </tr>
                <tr class="stockFlag"><td><h2 class="ml20">保留房设置</h2></td></tr>
                <tr class="stockFlag">
                     <td class="e_label">增减保留房：</td>
                     <td>
                     	<input type="hidden" name="increase" value="0"/>
                    	<label class="radio"><input type="radio" name="increaseRadio">增加</label>
                        <select class="w10 mr10">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>
                        <label class="radio"><input type="radio" name="increaseRadio">减少</label>
                        <select class="w10">
		                      <#list 0..50 as i>
		                      <option value="${-i}">${i}</option>
		                      </#list>
		                </select>
                    </td>
                </tr>
                <tr class="stockFlag">
                    <td class="e_label">保留房最晚预订时间：</td>
                     <td colspan="2">
                     <input type="hidden" name="latestHoldTime" id="latestHoldTime">
                     <select class="w10 mr10" name="latestHoldTime_Day">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="latestHoldTime_Hour">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>点
		                <select class="w10 mr10" name="latestHoldTime_Minute">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
		                
                </tr>
                <tr class="stockFlag">
                    <td class="e_label">保留房可否恢复：</td>
                     <td>
	                    <select class="w10" name="restoreFlag">
	                    	<option value="Y">可恢复</option>
	                    	<option value="N" disabled="disabled">不可恢复</option>
	                    </select>
                    </td>
                </tr>
                <tr class="stockFlag">
                     <td class="e_label">是否可超卖：</td>
                     <td colspan="2">
	                    <select class="w10" name="overshellFlag">
	                    	<option value="Y">可超卖</option>
	                    	<option value="N">不可超卖</option>
	                    </select>
                    </td>
                </tr>
                 </tbody>
	           </table> 
 </div>  
	 <div class="J_con" style="position:relative; padding-bottom:80px">
       		 <input name="latestCancelTime" type="hidden" id="latestCancelTime" value="0"/>
       		 <table class="e_table form-inline">
             <tbody>
             	<tr><td><h2 class="ml20">预付内容设置：</h2></td></tr>
             	<tr class="prePay">
                    <td class="e_label"><i class="cc1">*</i>退改类型：</td>
                     <td>
                      <select class="w10" name="cancelStrategy" id="cancelStrategy1">
                      		<option value="">请选择</option>
	                    	<option value="RETREATANDCHANGE">可退改</option>
	                    	<option value="UNRETREATANDCHANGE">不退不改</option>	                    
	                  </select>
                    </td>
                </tr>
                <tr class="prePay">
                     <td width="150"  class="e_label">预付最晚无损取消时间：</td>
                     <td id="lastCancelTime">
                   	  <select class="w10 mr10" name="lastCancelTime_Day">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="lastCancelTime_Hour">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>点
		                <select class="w10 mr10" name="lastCancelTime_Minute">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
		                <div class="e_error" style="display:none" id="lastCancelTimeError"><i class="e_icon icon-error"></i>请设置最晚无损取消时间</div>
                    </td>
                </tr>
                <tr class="prePay">
                     <td class="e_label">预付扣款类型：</td>
                     <td >
                      <select class="w10" change="deductTypeChange()" id="deductType1" name="deductType">
	                    	<option value="NONE">否</option>
	                    	<option value="FULL">全额</option>	                    	
	                    	<option value="FIRSTDAY">首日</option>
	                    	<option value="MONEY">固定金额</option>
	                    	<option value="PERCENT">百分比</option>
	                    </select>   
	                    <input type="hidden" id="deductValue" name="deductValue" />                
                     <input type="text" name="deductValueInput" value="${deductValue}" disabled="disabled" required=true  digits=true min=0/>
                     <div id="deductValueError" style="display:inline"></div>
                    </td>
                </tr>
                <tr class="prePay">
                    <td class="e_label">预付预授权限制：</td>
                     <td>
	                    <select class="w10" name="bookLimitType" id="bookLimitType1">
	                    	<option value="NONE">无限制</option>
	                    	<option value="PREAUTH">一律预授权</option>
	                    </select>
                    </td>
                </tr>
                <tr><td><h2 class="ml20">现付内容设置</h2></td></tr>
                <tr class="pay">
                    <td class="e_label">担保类型：</td>
                     <td>
                        <select class="w10" name="guarType">
                        	<option value="NONE">无</option>
	                    	<option value="CREDITCARD">信用卡</option>
	                    </select>
                    	
                    </td>
                </tr>
                 <tr class="pay">
                    <td class="e_label">预订限制：</td>
                     <td >
                      <select class="w10" name="bookLimitType" id="bookLimitType2">
	                    	<option value="NONE">无限制</option>
	                    	<option value="TIMEOUTGUARANTEE">超时担保</option>
	                    	<option value="ALLTIMEGUARANTEE">全程担保</option>
	                    	<option value="ALLGUARANTEE">一律担保</option>
	                    </select>
	                    <span class="cc3">即，是否需要担保，何种情况下需担保</span>
	                    <div class="e_error" style="display:none" id="bookLimitTypeError"><i class="e_icon icon-error"></i>请设置预定限制</div>
                    </td>
                </tr>
                <tr class="pay" id="latest">
                    <td class="e_label">保留时间：</td>
                     <td >
                      <select class="w10"  name="latestUnguarTime" id="latestUnguarTime">	                    	
	                    	 <#list 1..23 as i>
		                      <option value="${i}">${i}:00</option>
		                     </#list>
	                    </select>
	                    <span class="cc3">即，过了该时间必须担保</span>
	                    <div class="e_error" style="display:none" id="latestUnguarTimeError"><i class="e_icon icon-error"></i>请设置保留时间</div>
                    </td>
                </tr>
                 <tr class="pay">
                    <td class="e_label">预定限制_是否房量担保：</td>
                    <td>
                   <input class="quantityType" type="checkbox" onclick="check()" id="quantityType" name="quantityType">
                   </input>  
                     		需担保房量：                    
                      <select class="w10" id="guarQuantity"  name="guarQuantity">	                    	
	                    	 <#list 1..50 as i>
		                      <option value="${i}">${i}</option>
		                     </#list>
	                   </select>
	                    <span class="cc3">即，超出需担保房量，则提示用户担保</span>
                    </td>
                </tr>
                <tr class="pay">
                    <td class="e_label">全额/峰时担保扣款：</td>
                     <td >
                      <select class="w10" name="deductType" id="deductType2">
	                    	<option value="NONE">否</option>
	                    	<option value="FULL">全额</option>	                    
	                    	<option value="FIRSTDAY">首日</option>
	                    </select>
                    </td>
                </tr>
                <tr class="pay">
                    <td class="e_label"><i class="cc1">*</i>退改类型：</td>
                     <td >
                      <select class="w10" name="cancelStrategy" id="cancelStrategy">
                      		<option value="">请选择</option>
	                    	<option value="RETREATANDCHANGE">可退改</option>
	                    	<option value="UNRETREATANDCHANGE">不退不改</option>	                    
	                    </select>
                    </td>
                </tr>
                <tr>
                    <td class="e_label">担保最晚无损取消时间：</td>
                    <td id="lastCancelTime_1">
	                   <select class="w10 mr10" name="lastCancelTime_Day" disabled="disabled">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="lastCancelTime_Hour" disabled="disabled">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>时
		                <select class="w10 mr10" name="lastCancelTime_Minute" disabled="disabled">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
		                <span class="cc3">即，该时间之前为无损退款</span>
		                <div class="e_error" style="display:none" id="lastCancelTimeError"><i class="e_icon icon-error"></i>请设置担保最晚无损取消时间</div>
                    </td>
                </tr>
               
            </tbody>
        </table>
 </form>
		 </div>
 </div>  
 </div>
 </div>
  <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a class="btn" id="backToLastPageButton">返回上一步</a></div>
        </div>
 </div>
 </div>
 </#if>
<#include "/base/foot.ftl"/>
</body>
</html>
<script src="/vst_back/js/pandora-calendar.js"></script>

<script>
	
	$('.J_tip').lvtip({
                templete: 3,
                place: 'bottom-left',
                offsetX: 0,
                events: "live" 
            });

	var good = {};
	var specDate;
	//预定限制选择为为超时担保时，
	$("#bookLimitType2").bind("change",function(){		
			//预定限制选择为为超时担保时
			if($("#bookLimitType2").val()=="TIMEOUTGUARANTEE"){	
				$("#deductType2").find("option[value=NONE]").removeAttr("disabled");
				$("#deductType2").find("option[value=NONE]").attr("selected","selected");				
				$("#deductType2").find("option[value=FIRSTDAY]").removeAttr("disabled");				
				  $("#latest").show();	
			 //预定限制选择为为全程担保时
			}else if($("#bookLimitType2").val()=="ALLTIMEGUARANTEE"){
				$("#deductType2").find("option[value=FULL]").attr("selected","selected");		
				$("#deductType2").find("option[value=NONE]").attr("disabled", "disabled");		
				$("#deductType2").find("option[value=FIRSTDAY]").attr("disabled", "disabled");
				$("#latest").hide();						
			}else{
				$("#deductType2").find("option[value=NONE]").removeAttr("disabled");
				$("#deductType2").find("option[value=NONE]").attr("selected","selected");				
				$("#deductType2").find("option[value=FIRSTDAY]").removeAttr("disabled");
				$("#latest").hide();	
			}
		});	
	//预定限制_是否房量担保	
	function  check(){
	  if($("#quantityType").attr("checked")=="checked"){
	    $("#guarQuantity").removeAttr("disabled");
	  }else{
	    $("#guarQuantity").attr("disabled", "disabled");
	  }
	}	
	//预付扣款类型  --百分比 和金额
	$(".prePay").find("select[name=deductType]").bind("change",function(){
		if($(".prePay").find("select[name=deductType]").val()=="PERCENT"||$(".prePay").find("select[name=deductType]").val()=="MONEY"){
			$(".prePay").find("input[name=deductValueInput]").removeAttr("disabled");
			$("#deductValueError").empty().show();
		}else{
			$("#deductValueError").hide();
		  	$(".prePay").find("input[name=deductValueInput]").attr("disabled","disabled");		  
		}
	});
	//计算一
	$("#count_1").click(function(){
	     if($("#salePrice").val().length<=0||$("#commission").val().length<=0){
	     	$("#countError").attr("style","display:inline;color:red");
	     }else{
	    	$("#countError").attr("style","display:none");
	     }
		 var salePrice= $("#salePrice").val();//卖价
	 	 var commission= $("#commission").val();//佣金
	 	 $("#settlementPriceInput").val(salePrice-commission);
	});
	//计算二
	$("#count_2").click(function(){
		 if($("#salePrice_2").val().length<=0||$("#commissionRates").val().length<=0){
	     	$("#countError2").attr("style","display:inline;color:red");
	     }else{
	    	$("#countError2").attr("style","display:none");
	     }
		 var salePrice_2= $("#salePrice_2").val();//卖价
	 	 var commissionRates= 1-$("#commissionRates").val();//佣金
	 	 $("#settlementPriceInput").val(salePrice_2*commissionRates);
	});
	//计算三
	$("#count_3").click(function(){
		if($("#salePrice_3").val().length<=0||$("#servicePrice").val().length<=0||$("#commissionRates_3").val().length<=0){
	     	$("#countError3").attr("style","display:inline;color:red");
	     }else{
	    	$("#countError3").attr("style","display:none");
	     }
		 var salePrice= $("#salePrice_3").val();//卖价
	 	 var servicePrice=salePrice- $("#servicePrice").val();
	 	  var commissionRates= 1-$("#commissionRates_3").val();
	 	 $("#settlementPriceInput").val(servicePrice*commissionRates);
	});
	//计算四 
	$("#count_4").click(function(){
		if($("#salePrice_4").val().length<=0||$("#serviceRates").val().length<=0||$("#commissionRates_4").val().length<=0){
	     	$("#countError4").attr("style","display:inline;color:red");
	     }else{
	    	$("#countError4").attr("style","display:none");
	     }
		 var salePrice= $("#salePrice_4").val();//卖价
	 	 var servicePrice4=parseFloat(1)+parseFloat($("#serviceRates").val());//服务费率
	 	 var commissionRates= 1-$("#commissionRates_4").val();
	 	 $("#settlementPriceInput").val(salePrice/servicePrice4*commissionRates);
	});
	$("#backToLastPageButton").click(function(){
		window.history.go(-1);
	});
	
	//时间价格表的隐藏和显示
	$("#timePriceArrowView,#timePriceArrow").click(function(){
		var arrow = $("#timePriceArrow");
		if(arrow.is(".active")){
			arrow.removeClass("active");
			arrow.find("span").eq(0).html("展开");
			$("#timePriceDiv").show();
		}else {
			arrow.addClass("active");
			$("#timePriceDiv").hide();
			arrow.find("span").eq(0).html("关闭");
		}
	})
	//退改类型
	$("#cancelStrategy,#cancelStrategy1").bind("change",function(){
		checkCancelStrategy();
	});
	
	//检查退改类型
	function checkCancelStrategy(){
		//现付
		var cancelStrategy = $("#cancelStrategy").val();
		if($("#cancelStrategy").attr("disabled")=="disabled"||cancelStrategy==''||cancelStrategy=='UNRETREATANDCHANGE'){
			$("#lastCancelTime_1").find("select").attr("disabled","disabled");
		}else if(cancelStrategy=='RETREATANDCHANGE'){
			$("#lastCancelTime_1").find("select").removeAttr("disabled");
		}
		//预付
		var cancelStrategy1 = $("#cancelStrategy1").val();
		if($("#cancelStrategy1").attr("disabled")=="disabled"||cancelStrategy1==''||cancelStrategy1=='UNRETREATANDCHANGE'){
			$("#lastCancelTime").find("select").attr("disabled","disabled");
		}else if(cancelStrategy1=='RETREATANDCHANGE'){
			$("#lastCancelTime").find("select").removeAttr("disabled");
		}
	}
	
	$("#timePriceSaveButton").click(function(){
		
		//JQuery 自定义验证，销售价不能小于结算价
		jQuery.validator.addMethod("largeThan", function(value, element) {
		    return !(parseInt($(element).val()) < parseInt($("#settlementPriceInput").val()));
		 }, "销售价不能小于结算价");
	  
		if(!$("#timePriceForm").validate({
			rules : {
				startDate : {
					required : true
				}
				,
				endDate : {
					required : true
				}
				,
				priceInput: {
					largeThan : true,
					number:true,
					required: true,
					min:0
				}
				,deductValue: {
					required: true,
					min:0
				}
				,
				settlementPriceInput :{
					required: true,
					number:true,
					min:0
				},
				cancelStrategy : {
					required : true
				}
			},
			messages : {
				startDate : '请选择开始日期',
				endDate : '请选择结束日期',
				cancelStrategy : '请选择退改类型'
			}
		}).form()){
				return;
			}
		
		//把提前预定时间转换为分钟数	
		var day = $("select[name=aheadHour_day]").val() == "" ? 0 : parseInt($("select[name=aheadHour_day]").val());
		var hour = $("select[name=aheadHour_hour]").val() == "" ? 0 : parseInt($("select[name=aheadHour_hour]").val());
		var minute = $("select[name=aheadHour_minute]").val() == "" ? 0 : parseInt($("select[name=aheadHour_minute]").val());
		$("#aheadBookTime").val(day*24*60-hour*60-minute);
		
		//把最晚预定时间转化为分钟数
		var day1 = $("select[name=latestHoldTime_Day]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Day]").val());
		var hour1 = $("select[name=latestHoldTime_Hour]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Hour]").val());
		var minute1 = $("select[name=latestHoldTime_Minute]").val() == "" ? 0 : parseInt($("select[name=latestHoldTime_Minute]").val());
		$("#latestHoldTime").val(day1*24*60-hour1*60-minute1);
		
		//设置增减保留房的值
		$("input[name=increaseRadio]").each(function(){
			if($(this).attr("checked")=="checked"){
				$("input[name='increase']").val($(this).parent("label").next("select").val());
			}
		});
		
		//设置最晚无损取消时间
		var day2 = $("select[name=lastCancelTime_Day][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Day][disabled!=disabled]").val());
		var hour2 = $("select[name=lastCancelTime_Hour][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Hour][disabled!=disabled]").val());
		var minute2 = $("select[name=lastCancelTime_Minute][disabled!=disabled]").size() == 0 ? 0 : parseInt($("select[name=lastCancelTime_Minute][disabled!=disabled]").val());
		$("#latestCancelTime").val(day2*24*60-hour2*60-minute2);
		
		//判断是否设置了超时担保
		if($("#bookLimitType2").val()=="TIMEOUTGUARANTEE"){
			if($("select[name=latestUnguarTime][disabled!=disabled]").val()==0){
				$("#latestUnguarTimeError").show();
				return;
			}else {
				$("#latestUnguarTimeError").hide();
			}
		}
		//执行到此说明没有错误，隐藏所有Error标签
		$(".e_error").hide();
	
		//将元转换为分
		if($("#settlementPriceInput").val()!="")
		$("#settlementPrice").val(Math.round(parseFloat($("#settlementPriceInput").val())*100));
		if($("#priceInput").val()!="")
		$("#price").val(Math.round(parseFloat($("#priceInput").val())*100));
		//	预付扣款类型为金额，转换为分
		if($("#deductType1").val()=="MONEY"){			
		   $(".prePay").find("input[name=deductValue]").val(Math.round(parseFloat($(".prePay").find("input[name=deductValueInput]").val())*100));
		}else{
		  $(".prePay").find("input[name=deductValue]").val($(".prePay").find("input[name=deductValueInput]").val());		
		}
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/goods/timePrice/editGoodsTimePrice.do",
			data :　$("#timePriceForm").serialize(),
			dataType:'JSON',
			type: "POST",
			success : function(result){
				$.alert(result.message);
				$("input[type=radio][name=good]:checked").click();
				loading.close();
				//取消选中
				$("input[type='checkbox'][class='checkGoods']").removeAttr("checked");
			},
			error : function(){
				$.alert('服务器错误');
				loading.close();
			}
		})
	});
	
		//将非保留房属性设置为不可编辑状态
		$(".stockFlag").hide();
		$("input[name=stockFlag]").click(function(){
			if($(this).val()=="N")
				$(".stockFlag").hide();
			else
				$(".stockFlag").show();
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
		
		//disable预付
		disablePrePay();
		//disable现付
		disablePay();
		//隐藏标题
		$(".payTargetTitle").hide();
		//禁用预付款设置
		function disablePrePay(){			
			$(".prePay").find("input").not("input[name=deductValueInput]").attr("disabled","disabled");			
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
			$(".prePay").find("input").not("input[name=deductValueInput]").removeAttr("disabled");
			$(".prePay").find("select").removeAttr("disabled");
			checkCancelStrategy();
		}
		//启用现付设置
		function enablePay(){
			$(".pay").find("input").removeAttr("disabled")
			$(".pay").find("select").removeAttr("disabled");
			checkCancelStrategy();
			//预定限制是否房量限制
			 if($("#quantityType").attr("checked")=="checked"){
	        	 $("#guarQuantity").removeAttr("disabled");
	         	}else{
	         	$("#guarQuantity").attr("disabled", "disabled");
	        	}
			
			//超时担保
			if($("#bookLimitType2").val()=="TIMEOUTGUARANTEE"){									
			 	$("#latest").show();
			}else{
				$("#latest").hide();
			}
			
		}
		$(".checkGoods").change(function(){
			//如果不是退改策略则不设置该规则
			if($("input[name='type']").val()!="1") return;
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
		
		$("#search_button").click(function(){
			$("#searchForm").submit();
		});
            
        $(".J_tab").find("li").click(function () {
                var index = $(this).index(),
                    $J_con = $(".J_con"),
                    $li = $(".J_tab").find("li");
				
                $li.removeClass("active");
                $li.eq(index).addClass("active");
                $J_con.removeClass("active");
                $J_con.eq(index).addClass("active");
                //判断是不是从别的菜单切换到退改策略TAB
                 if($(this).attr("data")=="1"&&$("input[name='type']").val()!="1"){
                 	$("input[data=PAY]").removeAttr("checked");
                 	$("input[data=PREPAID]").removeAttr("checked");
                 	disablePay();
                 	disablePrePay();
                 	//显示预付/现付的标题
                 	$(".payTargetTitle").show();
                 }else {
                   //隐藏预付/现付的标题
                	$(".payTargetTitle").hide();
                 }
                
                //设置当前修改的类型
				$("input[name='type']").val($(this).attr("data"));
                return false;
         });
         
         	var template = {
                warp: '<div class="ui-calendar"></div>',
                calControl: '<span class="month-prev" {{stylePrev}} title="上一月">‹</span><span class="month-next" {{styleNext}} title="下一月">›</span>',
                calWarp: '<div class="calwarp clearfix">{{content}}</div>',
                calMonth: '<div class="calmonth">{{content}}</div>',
                calTitle: '<div class="caltitle"><span class="mtitle">{{month}}</span></div>',
                calBody: '<div class="calbox">' +
                            '<i class="monthbg">{{month}}</i>' +
                            '<table cellspacing="0" cellpadding="0" border="0" class="caltable">' +
                                '<thead>' +
                                    '<tr>' +
                                        '<th class="sun">日</th>' +
                                        '<th class="mon">一</th>' +
                                        '<th class="tue">二</th>' +
                                        '<th class="wed">三</th>' +
                                        '<th class="thu">四</th>' +
                                        '<th class="fri">五</th>' +
                                        '<th class="sat">六</th>' +
                                    '</tr>' +
                                '</thead>' +
                                '<tbody>' +
                                    '{{date}}' +
                                '</tbody>' +
                            '</table>' +
                        '</div>',
                weekWarp: '<tr>{{week}}</tr>',
                day: '<td {{week}} {{dateMap}} >' +
                        '<div {{className}}>' +
                            '<span class="calday">{{day}}</span>' +
                            '<span class="calinfo"></span>' +
                            '<div class="fill_data"></div>' +
                        '</div>' +
                     '</td>'
            };
         
           	// 填充日历数据
            function fillData() {
                var that = this,
                    url = "/vst_back/goods/timePrice/findGoodsTimePriceList.do";
				
				
                var month = that.options.date.getMonth();
                var year = that.options.date.getFullYear();
                var day = that.options.date.getDate();
                
                specDate = year+"-"+(month+1)+"-"+day;
                
                function setData(data) {
                    
                    if (data === undefined) {
                        return;
                    }


                    data.forEach(function (arr) {
                    
                        var $td = that.warp.find("td[date-map=" + arr.specDateStr + "]");
                            html = "";
                        html = '<ul>'+
                                    '<li><span class="cc3">售：</span>'+ (arr.price/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.settlementPrice/100).toFixed(2)+'</li>' +
                                    '<li class="mb10"><span class="cc3">提前：</span>1天19时29分</li>' +
                                    '<li><span class="cc3">保留：</span>4 <span class="cc3">增减：</span>8</li>' +
                                    '<li><span class="cc3">最晚：</span>1天19时29分</li>' +
                                    '<li class="mb10">可超卖/不可恢复</li>' +
                                    '<li><span class="cc3">预售：</span>1天19时29分</li>' +
                                    '<li><span class="cc3">无损：</span>1天19时29分</li>' +
                                    '<li><span class="cc3">峰值：</span>1天19时29分</li>' +
                                '</ul>';
                        var liArray = [];
                        //判断是否禁售
                        if(arr.onsaleFlag=='Y'){
                        	liArray.push('<li><span class="cc3"><span style="color:blue">可售</span></li>');
                        }else {
                        	liArray.push('<li><span class="cc3"><span style="color:red">禁售</span></li>');
                        }
                        //判断有无结/售数据
                        if(arr.price!=null&&arr.settlementPrice!=null){
                        	liArray.push('<li><span class="cc3">售：</span>'+ (arr.price/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.settlementPrice/100).toFixed(2)+'</li>');
                        }  
                        //判断有无早餐
                        if(arr.breakfast!=null){
                        	liArray.push('<li><span class="cc3">早：</span>'+ arr.breakfast+'</li>');
                        }
                        //判断有无提前预定数据
                        if(arr.aheadBookTime!=null){
                        	var time = minutesToDate(parseInt(arr.aheadBookTime));
                        	liArray.push('<li class="mb10"><span class="cc3">提前预定时间：</span>'+time+'</li>');
                        }      
                        //判断是不是保留房
                        if(arr.stockFlag == 'Y'){
                        	//设置保留房数
                        	var stock = arr.stock == null ? 0 : arr.stock
                        	//合同库存
                        	var totalStock = arr.totalStock == null ? 0  : arr.totalStock;
                        	liArray.push('<li><span class="cc3">保留房数：</span>'+stock+'('+totalStock+')</li>');
                        	//设置最晚预定时间
                        	if(arr.latestHoldTime!=null){
                        		var time = minutesToDate(parseInt(arr.latestHoldTime));
                        		liArray.push('<li class="mb10"><span class="cc3">最晚预定时间：</span>'+time+'</li>');
                        	}
                        	//保留房是否可恢复
                        	var restore = arr.restoreFlag=="Y" ? "可恢复" : "不可恢复";
                        	var overshell = arr.overshellFlag=="Y" ? "可超卖" : "不可超卖";
                			liArray.push('<li class="mb10"><span class="cc3">'+restore+'</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="cc3">'+overshell+'</span></li>');
                        }else if(arr.stockFlag == 'N'){
							liArray.push('<li><span class="cc3">非保留房</span></li>');                        
                        }         
                        
                        //退改类型
                    	if(arr.cancelStrategy!=null){
                    		if(arr.cancelStrategy=="RETREATANDCHANGE"){
                    			liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>可退改</li>');
                    		}
                    		if(arr.cancelStrategy=="UNRETREATANDCHANGE"){
                    			liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>不退不改</li>');
                    		}
                    	}
                                      
                        //判断是否是预付
                        if(arr.payTarget=="PREPAID"){
                        	//设置最晚取消时间
                        	if(arr.latestCancelTime!=null){
                        		var time = minutesToDate(parseInt(arr.latestCancelTime));
                        		liArray.push('<li class="mb10"><span class="cc3">最晚无损取消时间：</span>'+time+'</li>');
                        	}
                        	//预付扣款类型
                        	if(arr.deductType!=null){
                        		var deductValue =  arr.deductValue == null ? '' :  arr.deductValue;
                        		if(arr.deductType=="NONE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付扣款类型：</span>否&nbsp;&nbsp;'+deductValue+'</li>');
                        		}
                        		if(arr.deductType=="FULL"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付扣款类型：</span>全额&nbsp;&nbsp;'+deductValue+'</li>');
                        		}                        		
                        		if(arr.deductType=="FIRSTDAY"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付扣款类型：</span>首日&nbsp;&nbsp;'+deductValue+'</li>');
                        		}
                        		if(arr.deductType=="MONEY"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付扣款类型：</span>固定金额&nbsp;&nbsp;'+deductValue/100+'</li>');
                        		}
                        		if(arr.deductType=="PERCENT"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付扣款类型：</span>百分比&nbsp;&nbsp;'+deductValue+'</li>');
                        		}
                        	}
                        	//预付预授权限制
                        	if(arr.bookLimitType!=null){
                        		if(arr.bookLimitType=="NONE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付预授权限制：</span>无限制</li>');
                        		}
                        		if(arr.bookLimitType=="PREAUTH"){
                        			liArray.push('<li class="mb10"><span class="cc3">预付预授权限制：</span>一律预授权</li>');
                        		}
                        	}
                        }
                        //判断是否是现付
                         if(arr.payTarget=="PAY"){
                         	//担保类型
                         	if(arr.guarType=="CREDITCARD"){
                    			liArray.push('<li class="mb10"><span class="cc3">担保类型：</span>信用卡</li>');
                        	}
                         	//全额/峰时担保扣款
                         	if(arr.deductType!=null){
                        		if(arr.deductType=="NONE"){
                        			liArray.push('<li class="mb10"><span class="cc3">全额/峰时担保扣款：</span>否</li>');
                        		}
                        		if(arr.deductType=="FULL"){
                        			liArray.push('<li class="mb10"><span class="cc3">全额/峰时担保扣款：</span>全额</li>');
                        		}                        		
                        		if(arr.deductType=="FIRSTDAY"){
                        			liArray.push('<li class="mb10"><span class="cc3">全额/峰时担保扣款：</span>首日</li>');
                        		}
                        	}
                        	//担保最晚无损取消时间
                        	if(arr.latestCancelTime!=null){
                        		var time = minutesToDate(parseInt(arr.latestCancelTime));
                        		liArray.push('<li class="mb10"><span class="cc3">最晚无损取消时间：</span>'+time+'</li>');
                        	}
                        	//预订限制
                        	if(arr.bookLimitType!=null){
                        		if(arr.bookLimitType=="NONE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预订限制：</span>无限制</li>');
                        		}
                        		if(arr.bookLimitType=="TIMEOUTGUARANTEE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预订限制：</span>超时担保</li>');
                        			//保留时间
		                        	if(arr.latestUnguarTime!=null&&arr.latestUnguarTime!='0'){
		                        		liArray.push('<li class="mb10"><span class="cc3">保留时间：</span>'+arr.latestUnguarTime+':00</li>');
		                        	}
                        		}
                        		if(arr.bookLimitType=="ALLTIMEGUARANTEE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预订限制：</span>全程担保</li>');
                        		}
                        		if(arr.bookLimitType=="ALLGUARANTEE"){
                        			liArray.push('<li class="mb10"><span class="cc3">预订限制：</span>一律担保</li>');
                        		}
                        	}
                        	
                        	
                        	//预定限制_是否房量担保
                        	if(arr.guarQuantity!=null){
                        		liArray.push('<li class="mb10"><span class="cc3">需担保房量：</span>'+arr.guarQuantity+'</li>');
                        	}
                        	
                         }
                        if(arr.stockStatus=="NORMAL"){
                        	$td.find("span.calinfo").html("正常").addClass("cal_cc2");
                        }
                        if(arr.stockStatus=="LESS"){
                        	$td.find("span.calinfo").html("紧张").addClass("cal_cc1");
                        }
                         if(arr.stockStatus=="FULL"){
                        	$td.find("span.calinfo").html("满房").addClass("cal_cc3");
                        }
                        $td.find("div.fill_data").html("<ul>"+liArray.join('')+"</ul>");
                        
                    });

                }
                
                //将分钟数转换为天/时/分
                function minutesToDate(time){
                	var time = parseInt(time);
					var day=0;
					var hour=0;
					var minute=0;
					if(time >  0){
						day = Math.ceil(time/1440);
						if(time%1440==0){
							hour = 0;
							minute = 0;
						}else {
							hour = parseInt((1440 - time%1440)/60);
							minute = parseInt((1440 - time%1440)%60);
						}
						
					}else if(time < 0 ){
						time = -time;
						hour = parseInt(time/60);
						minute = parseInt(time%60);
					}
					if(hour<10)
						hour = "0"+hour;
					if(minute<10)
						minute = "0"+minute;
					return day+"天"+hour+"点"+minute+"分";
                }               
                $.ajax({
                    url: url,
                    type: "POST",
                    dataType: "JSON",
                    data : {suppGoodsId:good.goodsId,supplierId:good.supplierId,specDate:specDate},
                    success: function (json) {
                       setData(json);
                    },
                    error: function () { }
                });

            }
         
         $("input[type=radio][name=good]").click(function () {
         		var goodsId = $(this).val();
				var supplierId = $(this).attr("data");
				good.goodsId = goodsId;
				good.supplierId = supplierId;
                pandora.calendar({
                    sourceFn: fillData,
                    autoRender: true,
                    frequent: true,
                    showNext: true,
                    mos :0,
                    template: template,
                    target: $("#timePriceDiv")
                });
            }); 
         //如果传入了商品ID，则选中该商品
     	$("input[type=radio][name=good][value=${suppGoods.suppGoodsId}]").click();
     	$("input[type=radio][name=good][value=${suppGoods.suppGoodsId}]").attr("checked","checked");
     	
     	//设置右上角的说明
     	$("#showTips").bind("mouseover",function(){
     		$("#tips").show();
     	}).bind("mouseout",function(){
     		$("#tips").hide();
     	});
</script>
