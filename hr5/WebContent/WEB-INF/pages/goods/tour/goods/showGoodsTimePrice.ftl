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
            <li>产品维护 </li>
            <li class="active">打包</li>
        </ul>
    </div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
		<#if categoryCode!='category_route_hotelcomb'>
        <p class="pl15">注，成人/儿童/房差，为自动新增，若最小最大起订量需要修改，请到“管理成人儿童房差”，里面修改</p>
        <p class="pl15"> 注，若成人/儿童/房差，维护了儿童价，请对你创建的升级、可换酒店，至少维护掉儿童价。。。不然，将会因为缺少儿童价，而前台不可售</p>
        <p class="pl15">注，婴儿、税金、自备签，为自动新增，若最小最大起订量需要修改，请到“管理附加”，里面修改</p>
        <p class="pl15">注，管理升级、管理可换+酒店，任何一项有具体商品后，不能维护另外一个</p>
        <p class="pl15">注，若某商品暂时不售，请到“管理成人儿童”、“管理附加”、“管理升级”、“管理可换+酒店”，里面设置无效</p>
        <p class="pl15">注，升级、可换-酒店，维护的是加价金额；且酒店维护的是区间段的总价，非每天的日价格。</p>
        </#if>
        <#if categoryCode=='category_route_hotelcomb'>
        <p class="pl15">注，修改套餐的商品信息，请到“管理套餐”里面维护</p>
        <p class="pl15">注，添加维护附加产品，请到“管理附加”里面维护</p>
 		</#if>
    </div>
<div class="p_box">
 </div>
  <div class="p_box box_info">
  		<div class="title clearfix">
			    <h2 class="f16 fl">查看时间价格表</h2>
			    <div class="fl operate" style="margin-left:100px;">
			    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local'>
			    <a class="btn btn_cc1 branch_btn" id="brandManager" branchCodeData='adult_child_diff' branchName='房差'>管理成人/儿童/房差</a>
			    </#if>
			    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
			    <a class="btn btn_cc1 branch_btn" id="brandManager" branchCodeData='upgrad' branchName='升级'>管理升级</a>
			    </#if>
			    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
			    <a class="btn btn_cc1 branch_btn" id="brandManager" branchCodeData='changed_hotel' branchName='可换酒店'>管理可换酒店</a>
			    </#if>
			    <#if categoryCode=='category_route_hotelcomb'>
			    <a class="btn btn_cc1 branch_btn" id="brandManager" branchCodeData='combo_dinner' branchName='套餐'>管理套餐</a>
			    </#if>
			    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local' || categoryCode=='category_route_hotelcomb'>
			    <a class="btn btn_cc1 branch_btn" id="brandManager" branchCodeData='addition' branchName='附加'>管理附加</a>
			    </#if>
			    </div>
        </div>
        <div class="title clearfix">
      	   <span> 选择商品(注，最多选择5个商品)</span>
        </div>
      
        <div class="p_box clearfix">
        	<form id="searchForm">
        	<input type="hidden" name="specDate" id="specDate1">
        	<#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local'>
	 		<div>成人儿童：
	 		<#assign adultChildGoods = goodsMap['adult_child_diff'] />
	 		<#if adultChildGoods??>
 			<label style="display:inline"><input type="checkbox" class="checkGoods" name="suppGoodsId" value="${adultChildGoods.suppGoodsId}"   data_name="${adultChildGoods.goodsName}" data_price_type="${adultChildGoods.priceType}" />${adultChildGoods.goodsName}</label>
	 		</#if>
	 		</div>
	 		 </#if>
	 		<#if categoryCode=='category_route_hotelcomb'>
	 		<div>套餐：
	 		<#assign comboDinnerList = goodsMap['combo_dinner'] />
	 		<#list comboDinnerList as comboDinnerGoods>
	 			<label style="display:inline"><input type="checkbox" class="checkGoods" name="suppGoodsId" value="${comboDinnerGoods.suppGoodsId}" data_name="${comboDinnerGoods.goodsName}" data_price_type="${comboDinnerGoods.priceType}"  />${comboDinnerGoods.goodsName}</label>
	 		</#list>
	 		</div>
	 		 </#if>
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local' || categoryCode=='category_route_hotelcomb'>
			<div>附加：
			<#assign additionList = goodsMap['addition'] />
	 		<#list additionList as additionGoods>
	 			<label style="display:inline"><input type="checkbox" class="checkGoods" name="suppGoodsId" value="${additionGoods.suppGoodsId}"  data_name="${additionGoods.goodsName}" data_price_type="${additionGoods.priceType}" />${additionGoods.goodsName}</label>
	 		</#list>
			</div>
			</#if> 
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
	 		<div>升级：
	 		<#assign upgradList = goodsMap['upgrad'] />
	 		<#list upgradList as upgradGoods>
	 			<label style="display:inline"><input type="checkbox" class="checkGoods" name="suppGoodsId" value="${upgradGoods.suppGoodsId}"  data_name="${upgradGoods.goodsName}" data_price_type="${upgradGoods.priceType}" />${upgradGoods.goodsName}</label>
	 		</#list>
	 		</div>
	 		</#if>
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
	 		<div>可换酒店：
	 		<#assign changedHotelList = goodsMap['changed_hotel'] />
	 		<#list changedHotelList as changedHotelGoods>
	 			<label style="display:inline"><input type="checkbox" class="checkGoods" name="suppGoodsId" value="${changedHotelGoods.suppGoodsId}"  data_name="${changedHotelGoods.goodsName}" data_price_type="${changedHotelGoods.priceType}" />${changedHotelGoods.goodsName}</label>
	 		</#list>
	 		</div>
	 		</#if>
	 		</form>
 		</div>
 		<div class="fl operate" style="margin-bottom:10px;"><a class="btn btn_cc1" id="search_button">查询</a></div>
 		<div id="timePriceDiv" class="time_price">
 			
 		</div>
 </div>
 <div class="p_box box_info">
 
 	<div class="price_tab">
        <ul class="J_tab ui_tab">
            <li class="active" data="0"><a href="javascript:;">设置价格/库存</a></li>
        </ul>
     </div>
     <div class="price_content">
     <div style="margin:-10px 0 0 20px">   
     
         <div class="title clearfix">
      	   <span> 选择商品</span>
        </div>
      
        <div class="p_box clearfix">
        	<#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local'>
		 		<div>成人儿童：
		 		<#assign adultChildGoods = goodsMap['adult_child_diff'] />
	 			<label style="display:inline"><input type="checkbox" class="checkGoods adult_child" name="suppGoodsIdList" value="${adultChildGoods.suppGoodsId}"  data_name="${adultChildGoods.goodsName}" data_price_type="${adultChildGoods.priceType}"/>${adultChildGoods.goodsName}</label>
		 		</div>
		 		<#assign mainProdBranchId = '${adultChildGoods.productBranchId}' />
		 		<#assign mainSuppGoodsId = '${adultChildGoods.suppGoodsId}' />
	 		 </#if>
	 		 
	 		<#if categoryCode=='category_route_hotelcomb'>
		 		<div>套餐：
		 		<#assign comboDinnerList = goodsMap['combo_dinner'] />
		 		<#list comboDinnerList as comboDinnerGoods>
		 			<label style="display:inline"><input type="checkbox" class="checkGoods comb_hotel" name="suppGoodsIdList" value="${comboDinnerGoods.suppGoodsId}"  data_name="${comboDinnerGoods.goodsName}" data_price_type="${comboDinnerGoods.priceType}" />${comboDinnerGoods.goodsName}</label>
		 			<#assign mainProdBranchId = '${comboDinnerGoods.productBranchId}' />
	 				<#assign mainSuppGoodsId = '${comboDinnerGoods.suppGoodsId}' />
		 		</#list>
	 			</div>
	 		 </#if>
	 		 
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom' || categoryCode=='category_route_local' || categoryCode=='category_route_hotelcomb'>
				<div>附加：
				<#assign additionList = goodsMap['addition'] />
		 		<#list additionList as additionGoods>
		 			<label style="display:inline"><input type="checkbox" class="checkGoods addition" name="suppGoodsIdList" value="${additionGoods.suppGoodsId}"  data_name="${additionGoods.goodsName}" data_price_type="${additionGoods.priceType}" />${additionGoods.goodsName}</label>
		 		</#list>
				</div>
			</#if> 
			
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
		 		<div>升级：
		 		<#assign upgradList = goodsMap['upgrad'] />
		 		<#list upgradList as upgradGoods>
		 			<label style="display:inline"><input type="checkbox" class="checkGoods upgrade" name="suppGoodsIdList" value="${upgradGoods.suppGoodsId}"   data_name="${upgradGoods.goodsName}" data_price_type="${upgradGoods.priceType}" />${upgradGoods.goodsName}</label>
		 		</#list>
		 		</div>
	 		</#if>
	 		
		    <#if categoryCode=='category_route_group' || categoryCode=='category_route_freedom'>
		 		<div>可换酒店：
		 		<#assign changedHotelList = goodsMap['changed_hotel'] />
		 		<#list changedHotelList as changedHotelGoods>
		 			<label style="display:inline"><input type="checkbox" class="checkGoods change_hotel" name="suppGoodsIdList" value="${changedHotelGoods.suppGoodsId}" data_name="${changedHotelGoods.goodsName}" data_price_type="${changedHotelGoods.priceType}"  />${changedHotelGoods.goodsName}</label>
		 		</#list>
		 		</div>
	 		</#if>
 		</div>
     
	 <div class="p_date">
	 	<form id="timePriceForm">
            <ul class="cal_range">
                <li><i class="cc1">*</i>日期范围:</li>
                <li><input type="text" name="startDate" errorEle="selectDate" class="Wdate" required=true id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /></li>
                <li>-</li>
                <li><input type="text" name="endDate" errorEle="selectDate" class="Wdate" required=true id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></li>
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
            <!--在这里构造提交数据-->
            <input type="hidden" name="isSetPrice">
            <input type="hidden" name="isSetStock">
            <input type="hidden" name="isSetAheadBookTime">
            <div style="display:none" id="timePriceFormContent">
            		
            </div>
            </form>
    </div>
     
        <div class="J_con active" style="position:relative; padding-bottom:80px">
        	<form id="timePriceFormInput">
			 <div><label class="checkbox"><input type="checkbox" class="checkGoods" id="isSetPrice" value="Y"/>设置价格：</label></div>
			 <div id="adult_child_price"></div>
			 <div id="addition_price"></div>
			 <div id="upgrade_price"></div>
			 <div id="change_price"></div>
	         <div><label class="checkbox"><input type="checkbox" class="checkGoods" id="isSetStock" value="Y"/>设置库存：</label></div>
	         <div id="adult_child_stock"></div>
			 <div id="addition_stock"></div>
			 <div id="upgrade_stock"></div>
			 <div id="change_stock"></div>
	        <div><label class="checkbox"><input type="checkbox" class="checkGoods" id="isSetAheadBookTime" value="Y"/>设置提前预定时间限制：</label></div>   
	        <div id="adult_child_time"></div>
			 <div id="addition_time"></div>
			 <div id="upgrade_time"></div>
			 <div id="change_time"></div>
			 </form>
        </table>
       		
		</div>
 </div>  
 </div>
 </div>
 <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a href="javascript:void(0);" style="margin-left:100px;" class="showLogDialog btn btn_cc1" param="{'objectId':${prodProductId},'objectType':'SUPP_GOODS_GOODS'}">操作日志</a></div>
        </div>
 </div>
 </div>
<#include "/base/foot.ftl"/>
<div id="templateDiv" style="display:none">
	 <!-- 多价格价格 --> 
	<div id="multiple_price_template">
		<table   class="e_table form-inline" style="width:900px;" goodsId="">
             <tbody>
                <tr>
	                <td width="150px">{{}}（成人价）</td>
		            <td width="300px"><label style="display:inline"><input type="checkbox" class="saleAble" name="adult"/>禁售</label></td>
		            <td width="150px">{{}}（儿童价）</td>
		            <td width="300px"><label style="display:inline"><input type="checkbox" class="saleAble" name="child"/>禁售</label></td>
                </tr>
                <tr>
	                <td class="e_label">销售价：</td>
		            <td><input type="text"  name="auditPrice{index}" data="auditPrice" class="adult" /></td>
               		<td class="e_label">销售价：</td>
		            <td><input type="text"  name="childPrice{index}" data="childPrice" class="child" /></td>
                </tr>
                <tr>
	                <td class="e_label">结算价：</td>
                    <td><input type="text"  name="auditSettlementPrice{index}" data="auditSettlementPrice" class="adult" /></td>
               		<td class="e_label">结算价：</td>
                    <td><input type="text"  name="childSettlementPrice{index}" data="childSettlementPrice" class="child" /></td>
                </tr>
                 <tr>
	                <td width="150px">{{}}（单房差）</td>
	                <td colspan="3"><label style="display:inline"><input type="checkbox" class="saleAble" name="gag"/>禁售</label></td>
                 </tr>
                 <tr>
	                <td class="e_label">销售价：</td>
		            <td><input type="text" notvalidate="Y"  name="gapPrice{index}" data="gapPrice" class="gag" /></td>
                 </tr>
                 <tr>
	                <td class="e_label">结算价：</td>
		            <td><input type="text" notvalidate="Y"  name="grapSettlementPrice{index}" data="grapSettlementPrice" class="gag"/></td>
                 </tr>
	            </tbody>
       </table>
	</div>
	
	<!-- 单价格 --> 
	<div id="single_price_template">
		<table  class="e_table form-inline" style="width:320px;" goodsId="">
             <tbody>
                <tr>
	                <td width="150px">{{}}</td>
		            <td width="170px"><label style="display:inline"><input type="checkbox" class="saleAble" name="adult"/>禁售</label></td>
                </tr>
                <tr>
	                <td class="e_label">销售价：</td>
		            <td><input type="text" name="auditPrice_{index}" data="auditPrice" class="adult" /></td>
                </tr>
                <tr>
	                <td class="e_label">结算价：</td>
                    <td><input type="text" name="auditSettlementPrice_{index}" data="auditSettlementPrice" class="adult" /></td>
                </tr>
	            </tbody>
       </table>
	</div>
       
        <!-- 多价格库存 --> 
       <div id="multiple_stock_template">
       <table  class="e_table form-inline" style="width:600px" goodsId="">
             <tbody>
             	<tr><td colspan="2">{{}}</td></tr>
                <tr>
                    <td width="150" class="e_label"><label class="radio"><input type="radio" class="typeSelect"  name="stockType" checked="checked" value="INQUIRE_NO_STOCK"/>现询-未知库存</label></td>
               		<td width="450"></td>
                </tr>
                <tr>
                    <td class="e_label"><label class="radio"><input type="radio" class="typeSelect"   name="stockType" value="INQUIRE_WITH_STOCK"/>现询-已知库存</label></td>
                	<td></td>
                </tr>
                <tr>
                    <td class="e_label">日库存量：</td>
                	<td>
                	<div>
                	<input type="radio" class="stockSetType"   name="stockSetType_{index}" value="increase" checked="checked"/>增加
                	<input type="text"  name="stockIncrease_{index}" errorEle="selectDateIncrease{index}" disabled="disabled" />人(不含婴儿)
                	<div id="selectDateIncrease{index}Error" style="display:inline"></div>
                	</div>
                	<div style="margin-top:5px;">
                	<input type="radio" class="stockSetType"   name="stockSetType_{index}" value="decrease"/>减少</label>
                	<input type="text"  name="stockDecrease_{index}" errorEle="selectDateDecrease{index}" disabled="disabled" />人(不含婴儿)
                	<div id="selectDateDecrease{index}Error" style="display:inline"></div>
                	</div>
                	</td>
                </tr>
                <tr>
                    <td class="e_label">是否可超卖：</td>
                	<td>
                	<select class="w10" name="oversellFlag" disabled="disabled">
	                    	<option value="Y">可超卖</option>
	                    	<option value="N">不可超卖</option>
	                 </select></td>
                </tr>
                <tr>
                    <td class="e_label"><label class="radio" style="padding-right:21px;"><input type="radio" class="typeSelect"  name="stockType" value="CONTROL"/>切位/库存</label></td>
                	 <td></td>
                </tr>
                <tr>
                    <td class="e_label">日库存量：</td>
                	<td>
                	<div>
                	<input type="radio" class="stockSetType"   name="stockSetType1_{index}" value="increase" checked="checked"/>增加</label>
                	<input type="text"  name="stockIncrease1_{index}" errorEle="selectDateIncrease1{index}" disabled="disabled" />人(不含婴儿)
                	<div id="selectDateIncrease1{index}Error" style="display:inline"></div>
                	</div>
                	<div style="margin-top:5px;">
                	<input type="radio" class="stockSetType"   name="stockSetType1_{index}" value="decrease"/>减少</label>
                	<input type="text"  name="stockDecrease1_{index}" errorEle="selectDateDecrease1{index}" disabled="disabled" />人(不含婴儿)
                	<div id="selectDateDecrease1{index}Error" style="display:inline"></div>
                	</div>
                	</td>
                </tr>
                <tr>
                    <td class="e_label">是否可超卖：</td>
                	<td>
                	<select class="w10" name="overshellFlag" disabled="disabled">
	                    	<option value="Y">可超卖</option>
	                    	<option value="N">不可超卖</option>
	                    </select></td>
                </tr>
                 </tbody>
	           </table> 
	        </div>  
	         
	        <!-- 提前预定时间 -->  
	        <div id="ahead_time_template">
	        <table class="e_table form-inline" goodsId="">
             <tbody>
             	<tr><td colspan="2">{{}}</td></tr>
             	<tr>
                    <td width="150" class="e_label">提前预定时间：</td>
                    <td>
                    	<input type="hidden"  name="aheadBookTime" id="aheadBookTime">
                    	<select class="w10 mr10" name="aheadBookTime_day">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="aheadBookTime_hour">
		                      <#list 0..23 as i>
		                      <option value="${i}" <#if i==10>selected=selected</#if> >${i}</option>
		                      </#list>
		                </select>点
		                <select class="w10 mr10" name="aheadBookTime_minute">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>分
                    </td>
                </tr>
            </tbody>
            </table> 
            </div>
<div>
</body>
</html>
<script src="/vst_back/js/pandora-calendar.js"></script>

<script>
/**
 * 验证结算价必须小于销售价
 */
jQuery.validator.addMethod("compareToPrice", function(value, element) {
    //获得当前元素所在td的索引
    var index = $(element).parent("td").index();
    var priceElement = $(element).parents("tr").prev("tr").find("td").eq(index).find("input");
    return this.optional(element) || (parseFloat(value) <= parseFloat(priceElement.val()));
 }, "");
 
  jQuery.validator.addMethod("isNum", function(value, element) {
		    var num = /^[1-9]{0}\d*(\.\d{1,2})?$/;
		    return this.optional(element) || (num.test(value));       
}, "价格只能为整数或者最多两位小数");
	
	var good = {};
	var globalIndex = 0;
	var specDate;
	$("#backToLastPageButton").click(function(){
		window.history.go(-1);
	});
	
	//为禁售绑定事件
	$(".saleAble").live('click',function(){
		var that = $(this);
		var claszz = that.attr("name");
		$(this).parents("tr").nextAll("tr").find("input").each(function(){
			if(that.attr("checked")!='checked'){
				if($(this).is("."+claszz))
					$(this).removeAttr("disabled");
			}else {
				if($(this).is("."+claszz))
				$(this).attr("disabled","disabled");
			}
			
		});
	});
	
	$(".typeSelect").live('click',function(){
		var that = $(this);
		//首先将其他所有的置为disabled
		$(this).parents("table").find("input[type=text],select").attr("disabled","disabled");
		if(that.val()=='INQUIRE_WITH_STOCK' || that.val()=='CONTROL'){
			$(this).parents("tr").nextAll("tr").eq(0).find("input").removeAttr("disabled");
			$(this).parents("tr").nextAll("tr").eq(1).find("select").removeAttr("disabled");
		}
	});
	
	//商品点击事件
	$(".adult_child,.comb_hotel,.addition,.upgrade,.change_hotel").click(function(){
		var that = $(this);
		var name = that.attr("data_name");
		var priceType = that.attr("data_price_type");
		var goodsId = that.val();
		//首先判断是选中还是取消
		if(that.attr("checked")!='checked'){
			//如果是取消，则执行删除模板操作
			deleteTemplate(goodsId);
			return;
		}
		
		//设置价格模板
		var priceTemplate = '';
		if(priceType=="SINGLE_PRICE"){
			priceTemplate = '<div goodsId='+goodsId+' class="priceDiv">'+ $("#single_price_template").html()+'</div>';
		}else if(priceType=="MULTIPLE_PRICE"){
			priceTemplate = '<div goodsId='+goodsId+' class="priceDiv">'+ $("#multiple_price_template").html()+'</div>';
		}else {
			alert("该商品未设置价格类型!");
			return;
		}
		//为模板设置商品名称
		priceTemplate = priceTemplate.replace(/{{}}/g,name);
		priceTemplate = priceTemplate.replace(/{index}/g,globalIndex);
		
		//设置库存模板
		var stockTemplate = '';
		stockTemplate = '<div goodsId='+goodsId+' class="stockDiv">'+ $("#multiple_stock_template").html()+'</div>';
		//为模板设置商品名称
		stockTemplate = stockTemplate.replace(/{{}}/g,name);
		//修改模板radio name(防止冲突)
		stockTemplate = stockTemplate.replace(/stockType/g,'stockType'+globalIndex);
		//修改库存name
		stockTemplate = stockTemplate.replace(/{index}/g,globalIndex);
		
		//设置提前预定时间模板
		var aheadBookTimeTemplate = '';
		aheadBookTimeTemplate = '<div goodsId='+goodsId+' class="timeDiv">'+ $("#ahead_time_template").html()+'</div>';
		//为模板设置商品名称
		aheadBookTimeTemplate = aheadBookTimeTemplate.replace(/{{}}/g,name);
		
		//如果是成人儿童房差
		if(that.is(".adult_child")){
		 //设置模板
			setAdultChildTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate);
		//如果是	套餐
		}else if(that.is(".comb_hotel")){
			setAdultChildTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate);
		//如果是附加
		}else if(that.is(".addition")){
			setAdditionTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate);
		//如果是升级
		}else if(that.is(".upgrade")){
			setUpgradeTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate);
		//如果是可换酒店
		}else if(that.is(".change_hotel")){
			setChangeTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate);
		}
		globalIndex++;
	});
	
	//设置成人儿童模板
	function setAdultChildTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate){
		//设置价格模板
		var size = $("#adult_child_price").find("div[goodsId="+goodsId+"]").size();
		if(size == 0){
			$("#adult_child_price").append(priceTemplate);
		}
		//设置库存模板
		var stockSize = $("#adult_child_stock").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#adult_child_stock").append(stockTemplate);
		}
		//设置提前预定时间模板
		var timeSize = $("#adult_child_time").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#adult_child_time").append(aheadBookTimeTemplate);
		}
	}
	
	//设置升级
	function setUpgradeTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate){
		//设置价格模板
		var size = $("#upgrade_price").find("div[goodsId="+goodsId+"]").size();
		if(size == 0){
			$("#upgrade_price").append(priceTemplate);
		}
		//设置库存模板
		var stockSize = $("#upgrade_stock").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#upgrade_stock").append(stockTemplate);
		}
		//设置提前预定时间模板
		var timeSize = $("#upgrade_time").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#upgrade_time").append(aheadBookTimeTemplate);
		}
	}
	
	//设置可换
	function setChangeTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate){
		//设置价格模板
		var size = $("#change_price").find("div[goodsId="+goodsId+"]").size();
		if(size == 0){
			$("#change_price").append(priceTemplate);
		}
		//设置库存模板
		var stockSize = $("#change_stock").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#change_stock").append(stockTemplate);
		}
		//设置提前预定时间模板
		var timeSize = $("#change_time").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#change_time").append(aheadBookTimeTemplate);
		}
	}
	
	//设置附加模板
	function setAdditionTemplate(goodsId,priceTemplate,stockTemplate,aheadBookTimeTemplate){
		//设置价格模板
		var size = $("#addition_price").find("div[goodsId="+goodsId+"]").size();
		if(size == 0){
			$("#addition_price").append(priceTemplate);
		}
		//设置库存模板
		var stockSize = $("#addition_stock").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#addition_stock").append(stockTemplate);
		}
		//设置提前预定时间模板
		var timeSize = $("#addition_time").find("div[goodsId="+goodsId+"]").size();
		if(stockSize == 0){
			$("#addition_time").append(aheadBookTimeTemplate);
		}
	}
	
	//删除模板
	function deleteTemplate(goodsId){
		$("div[goodsid="+goodsId+"]").remove();
	}
	
	//设置价格表单数据
	function setPriceFormData(){
		$(".priceDiv").each(function(i){
	    	var that = $(this);
	    	//创建商品Id
	    	$("#timePriceFormContent").append('<input type="hidden" name="timePriceList['+i+'].suppGoodsId" value="'+that.attr("goodsId")+'">');
	    	that.find("input").each(function(){
	    		var clone = $(this).clone();
	    		var name = clone.attr("data");
	    		clone.attr("name","timePriceList["+i+"]."+name);
	    		if(clone.val()!=""){
		    		clone.val(parseInt(clone.val()*100)); 
		    		$("#timePriceFormContent").append(clone);
	    		}
	    	});
	    });
	}
	
	//设置库存表单数据
	function setStockFormData(){
		$(".stockDiv").each(function(i){
	    	var that = $(this);
	    	that.find("input[type=radio][class=typeSelect]").each(function(){
	    		if($(this).attr("checked")=='checked'){
	    			var value = $(this).val();
	    			var clone = $(this).clone();
    				clone.attr("name","timePriceList["+i+"].stockType");
    				$("#timePriceFormContent").append(clone);
	    			//如果是现询-已知库存	或者是切位库存
	    			if(value=='INQUIRE_WITH_STOCK' || value=='CONTROL'){
	    				var stockInputType = $(this).closest("tr").nextAll("tr").eq(0).find("input[class='stockSetType']:checked");
	    				//获得库存input
	    				var stockInput = stockInputType.next("input");
	    				var clone1 = stockInput.clone();
	    				//获得库存的类型
	    				if(stockInputType.val()=='increase'){
	    				
	    				}else if(stockInputType.val()=='decrease'){
	    					clone1.val(-clone1.val());
	    				}
	    				clone1.attr("name","timePriceList["+i+"].stock");
    					$("#timePriceFormContent").append(clone1);
    					var obj2 = $(this).closest("tr").nextAll("tr").eq(1).find("select");
    					var clone2 = obj2.clone();
	    				clone2.attr("name","timePriceList["+i+"].oversellFlag");
	    				clone2.val(obj2.val());
    					$("#timePriceFormContent").append(clone2);
	    			}
	    		}
	    	});
	    });
	}
	
	//设置提前预定时间表单数据
	function setAheadBookTimeFormData(){
		$(".timeDiv").each(function(i){
		    var that = $(this);
		    //把提前预定时间转换为分钟数	
			var day = parseInt(that.find("select[name=aheadBookTime_day]").val());
			var hour = parseInt($("select[name=aheadBookTime_hour]").val());
			var minute = parseInt($("select[name=aheadBookTime_minute]").val());
		    $("#timePriceFormContent").append('<input type="hidden" name="timePriceList['+i+'].aheadBookTime" value="'+(day*24*60-hour*60-minute)+'">');	
	    });
	}
	
	//设置选项
	function setTimeUpdateType(){
		if($("#isSetPrice").attr("checked")=="checked"){
	    	$("input[name=isSetPrice]").val("Y");
	    }else {
	    	$("input[name=isSetPrice]").val("N");
	    }
	    if($("#isSetStock").attr("checked")=="checked"){
	    	$("input[name=isSetStock]").val("Y");
	    }else {
	    	$("input[name=isSetStock]").val("N");
	    }
	    if($("#isSetAheadBookTime").attr("checked")=="checked"){
	    	$("input[name=isSetAheadBookTime]").val("Y");
	    }else {
	    	$("input[name=isSetAheadBookTime]").val("N");
	    }
	}
	
	//设置验证子项
	function setIsOrNotValidate(){
		//如果选择了设置价格
		if($("#isSetPrice").attr("checked")=="checked"){
	    	$("#adult_child_price,#addition_price,#upgrade_price").find("input[type=text]").each(function(){
	    		if($(this).attr("notvalidate")!="Y"){
	    				$(this).rules("add",{required : true, number : true,isNum:true , min : 0,messages : {min:'价格必须大于等于0',isNum:'价格格式不正确'}});
	    		}
	    	});
	    	//添加销售价结算价验证
	    	$("#adult_child_price,#addition_price,#upgrade_price").find("input[name*='SettlementPrice']").each(function(){
	    		$(this).rules("add",{compareToPrice : true,messages : {compareToPrice:'结算价不能大于销售价'}});
	    	});
	    }else {
	    	$("#adult_child_price,#addition_price,#upgrade_price,#change_price").find("input[type=text]").each(function(){
	    		$(this).rules("remove");
	    	});
	    }
	   
	    //如果选择了设置库存
	    if($("#isSetStock").attr("checked")=="checked"){
	    	$("#adult_child_stock,#addition_stock,#upgrade_stock,#change_stock").find("input[type=text]").each(function(){
	    		//判断有没有选择库存设置类型
	    		if($(this).prev(".stockSetType").attr("checked")=="checked"){
	    			$(this).rules("add",{required : true, number:true ,min:0,messages : {min:'库存必须大于等于0'}});
	    		}else {
	    			$(this).rules("remove");
	    		}
	    	});
	    }else {
	    	$("#adult_child_stock,#addition_stock,#upgrade_stock,#change_stock").find("input[type=text]").each(function(){
	    		$(this).rules("remove");
	    	});
	    }
	    
	   
	}
	
	$("#timePriceSaveButton").click(function(){
	 var priceValidate = $("#timePriceFormInput").validate();
	 var formValidate =  $("#timePriceForm").validate()
	 
	 if($("input[type=checkbox][name=weekDay]:checked").size()==0){
	 	$.alert("请选择适用日期");
	 	return;
	 }
	 
	  //清空验证信息
	  formValidate.resetForm();
	  priceValidate.resetForm();
	  //验证日期
	  if(!formValidate.form()){
		  return;
	   }
	   setIsOrNotValidate();
	  //验证必填数据
	  if(!priceValidate.form()){
		  return;
	   }
	
		//构造Form提交数据
		$("#timePriceFormContent").empty();
		//设置价格表单
	    setPriceFormData();
	    //设置库存表单
	    setStockFormData();
	    //设置提前预定时间
	    setAheadBookTimeFormData();
	    //设置选项
	    setTimeUpdateType();
	    //设置产品ID
	    $("#timePriceFormContent").append('<input type="hidden" value="${prodProductId}" name="prodProductId">')
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/tour/goods/timePrice/editGoodsTimePrice.do",
			data :　$("#timePriceForm").serialize(),
			dataType:'JSON',
			type: "POST",
			success : function(result){
				$.alert(result.message);
				loading.close();
			},
			error : function(){
				$.alert('服务器错误');
				loading.close();
			}
		})
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
                    url = "/vst_back/tour/goods/timePrice/findGoodsTimePriceList.do";
				
				
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
                        var suppGoodsId = arr.suppGoodsId;
                        var priceType = $("input[value="+suppGoodsId+"]").attr("data_price_type");
                        var goodsName = $("input[value="+suppGoodsId+"]").attr("data_name");
                        var liArray = [];
                        liArray.push('<li><span class="cc3">'+goodsName+'</span></li>');
                        //设置价格
                        //如果是多价格
                        if(priceType=='MULTIPLE_PRICE'){
                        	var auditPrice = arr.auditPrice;
                        	var auditSettlementPrice = arr.auditSettlementPrice;
                        	var childPrice = arr.childPrice;
                        	var childSettlementPrice = arr.childSettlementPrice;
                        	var gapPrice = arr.gapPrice;
                        	var grapSettlementPrice = arr.grapSettlementPrice;
                        	
                        	if(auditPrice==null)
                        		adultString = "<span style='color:red'>禁售</span>";
                        	else
                        		adultString = "售:"+(auditPrice/100).toFixed(2)+"结:"+(auditSettlementPrice/100).toFixed(2);
                        		
                        	if(childPrice==null)
                        		childString = "<span style='color:red'>禁售</span>";
                        	else
                        		childString = "售:"+(childPrice/100).toFixed(2)+"结:"+(childSettlementPrice/100).toFixed(2);
                        		
                    		if(gapPrice==null)
                        		gapString = "<span style='color:red'>禁售</span>";
                        	else
                        		gapString = "售:"+(gapPrice/100).toFixed(2)+"结:"+(grapSettlementPrice/100).toFixed(2);
                        		
                        	liArray.push('<li><span class="cc3">成人价：</span>'+ adultString +' <span class="cc3">儿童价：</span>'+childString+' <span class="cc3">房差：</span>'+gapString+'</li>');
                        }else if(priceType=='SINGLE_PRICE'){
                        	var auditPrice = arr.auditPrice;
                        	var auditSettlementPrice = arr.auditSettlementPrice;
                        	if(auditPrice==null)
                        		adultString = "<span style='color:red'>禁售</span>";
                        	else
                        		adultString = "售:"+(auditPrice/100).toFixed(2)+"结:"+(auditSettlementPrice/100).toFixed(2);
                        	
                        	liArray.push('<li><span class="cc3"></span>'+ adultString +'</li>');
                        }
                       var aheadBookTime = ''; 
                       if(arr.aheadBookTime!=null){
                       		aheadBookTime =  minutesToDate(arr.aheadBookTime);
                       		aheadBookTime = '提前'+aheadBookTime;
                       }
                       
                       //设置库存
                       if(arr.stockType=='INQUIRE_NO_STOCK'){
                       	 liArray.push('<li><span class="cc3"></span>现询(未知库存)&nbsp;&nbsp;'+aheadBookTime+'</li>');
                       }else if(arr.stockType=='INQUIRE_WITH_STOCK'){
                         var stock = arr.stock;
                         var oversellFlag = arr.oversellFlag == 'Y' ? '可超'  : '不可超';
                       	 liArray.push('<li><span class="cc3"></span>现询('+stock+')&nbsp;&nbsp;'+oversellFlag+'&nbsp;&nbsp;'+aheadBookTime+'</li>');
                       }else if(arr.stockType=='CONTROL'){
                         var stock = arr.stock;
                         var oversellFlag = arr.oversellFlag == 'Y' ? '可超'  : '不可超';
                         liArray.push('<li><span class="cc3"></span>切位('+stock+')&nbsp;&nbsp;'+oversellFlag+'&nbsp;&nbsp;'+aheadBookTime+'</li>');
                       }else {
                       	 liArray.push('<li><span class="cc3"></span>'+aheadBookTime+'</li>');
                       }
                        $td.find("div.fill_data").append("<ul>"+liArray.join('')+"</ul>");
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
                
                $("#specDate1").val(specDate);
                $.ajax({
                    url: url,
                    type: "POST",
                    dataType: "JSON",
                    data : $("#searchForm").serialize(),
                    success: function (json) {
                       setData(json);
                    },
                    error: function () { }
                });

            }
            
         
         $("#search_button").click(function () {
         		//判断数量是否小于等于5个
         		var size = $("input[type=checkbox]:checked","#searchForm").size();
         		if(size == 0){
         			$.alert('请选择商品');
         			return;
         		}
         		if(size > 5){
         			$.alert("最多选择5个商品，当前选择数量"+size);
         			return;
         		}
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
            
		    //规格管理页面
         $("a.branch_btn").bind("click",function(i){
         		var productId = "${prodProductId!''}";
				var branchCode = $(this).attr("branchCodeData");
				
				if(branchCode=='adult_child_diff'){
					addDialog = new xDialog("/vst_back/tour/goods/goods/showUpdateSuppGoods.do?productId="+productId,{}, {title:"修改商品",width:900,height:800,iframe:true})
					return;
				}
				var branchName = $(this).attr("branchName");
				var categoryId = "${categoryId!''}";
				var mainProdBranchId = "${mainProdBranchId!''}";
				var mainSuppGoodsId = "${mainSuppGoodsId!''}";
				if(mainSuppGoodsId == '' || mainProdBranchId == ''){
					alert("请先新增主规格或主商品");
					return;
				}
				var isPass = true;
				//如果是升级或者可换，则先进行检查
				if(branchCode == 'upgrad' || branchCode=='changed_hotel'){
					$.ajax({
						url : '/vst_back/packageTour/prod/prodbranch/checkProductBranch.do',
						type : "post",
						data : { "branchCode" : branchCode,"productId" : productId , "categoryId" : categoryId},
						async: false,
						success : function(result){
							if(result=='error')
								isPass = false;
						},
						error :function(result){
						
						}
					});
				}
				
				if(!isPass){
					$.alert('升级和可换酒店为互斥模式');
					return;
				}
				
				if((categoryId == '15' || categoryId == '18') && branchCode=='changed_hotel'){
					var url="/vst_back/productPack/line/showChangeHotelList.do?branchCode=" + branchCode+"&productId=" + productId +"&categoryId=" + categoryId
								+"&mainProdBranchId=" + mainProdBranchId;
					addDialog = new xDialog(url,{},{title:"管理"+ branchName,iframe:true,width:"1094px",height:"800px"});
				}else{
					var url = "/vst_back/packageTour/prod/prodbranch/findProductBranchList.do?branchCode=" + branchCode + "&productId=" + productId + "&categoryId=" + categoryId + "&mainProdBranchId=" + mainProdBranchId;
					addDialog = new xDialog(url,{}, {title:"管理"+ branchName,iframe:true,width:1100,height:650})
				}
				
		});
		
function reload() {
	addDialog.close();
	window.location.reload();
};
	if($("#isView",parent.document).val()=='Y'){
		$("#timePriceSaveButton").remove();
	}

</script>
