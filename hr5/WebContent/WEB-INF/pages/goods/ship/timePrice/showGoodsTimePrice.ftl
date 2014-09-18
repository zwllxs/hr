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
<form method="post" action='/vst_back/ship/goods/timePrice/showGoodsTimePrice.do' id="searchForm">
		<input type="hidden" name="prodProduct.productId" value="${suppGoods.prodProduct.productId!''}" />
		<input type="hidden" name="prodProductBranch.bizBranch.branchId" value="${suppGoods.prodProductBranch.bizBranch.branchId!''}" />
		<input type="hidden" name="suppSupplier.supplierName" value="${suppGoods.suppSupplier.supplierName!''}" />
		<input type="hidden" name="suppSupplier.supplierId" value="${suppGoods.suppSupplier.supplierId!''}" />
		<input type="hidden" id="cancelFlag1" name="cancelFlag" value="${cancelFlag}" />
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
		<h2 class="f16" style="display:inline">商品销售信息查询 </h2>
		<select id="cancelFlag">
                				<option value="">不限</option>
		                    	<option value='Y'<#if cancelFlag == 'Y'>selected</#if>>有效</option>
		                    	<option value='N'<#if cancelFlag == 'N'>selected</#if>>无效</option>
                	</select>
             </div>
 <div class="p_box clearfix">
 		<table class="e_table">
 				<#if goodsList??>
 				<#assign index=0>
 				<#list goodsList as good>
 				<#if index%5==0><tr></#if>
	 				<td>
	 					<label class="radio"><input type="radio" name="good" value="${good.suppGoodsId}" data="${suppGoods.suppSupplier.supplierId}" /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}<#if good.cancelFlag!='Y'><span class="poptip-mini poptip-mini-warning"><div class="tip-sharp tip-sharp-left"></div>商品无效</span></#if></label>
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
            </div>
 		<div id="timePriceDiv" class="time_price">
 			
 		</div>
 </div>
 <#if suppGoods.suppSupplier.apiFlag == 'N'>
 <div class="p_box box_info">
 
 	<div class="price_tab">
        <ul class="J_tab ui_tab">
            <li class="active" data="0"><a href="javascript:;">设置价格</a></li>
            <li data="3"><a href="javascript:;">设置库存</a></li>
            <li data="1"><a href="javascript:;">设置退改规则</a></li>
        </ul>
     </div>
     <div class="price_content">
     <form id="timePriceForm">
     <input type="hidden" name="type" value="0">
     <div style="margin:-10px 0 0 20px">   
     <table class="e_table form-inline">
       <tbody>
       	<#assign index=0>
		<#list goodsList as good>
		<#if index%5==0><tr></#if>
			<td>
			<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index}]" value="${good.suppGoodsId}" data="${good.payTarget}" <#if good.cancelFlag!='Y'||good.prodProductBranch.cancelFlag!='Y'>disabled=disabled</#if> /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}&nbsp;&nbsp;</label>
			</td>
		<#assign index = index+1>
		<#if index%5==0||index==goodsList?size></tr></#if>
		</#list>
        </tbody>
        </table>
    	 <div class="p_date">
                <ul class="cal_range">
                    <li><i class="cc1">*</i>出发日期:</li>
                    <li><input type="text" required name="specDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}'})" /></li>
                    <div id="selectDateError" style="display:inline"></div>
                </ul>
         </div>
     
             <div class="J_con active" style="position:relative; padding-bottom:80px">
			 <input type="hidden" name="supplierId" value="<#if suppGoods.suppSupplier??>${suppGoods.suppSupplier.supplierId}</#if>">
             <div class="p_date">
                 <ul class="cal_range" style="margin-top:10px;margin-bottom:10px;">
                    <li><i class="cc1">*</i>是否可售:</li>
                    <li><select name="onsaleFlag">
                    		<option value="Y">是</option>
                    		<option value="N">否</option>
                    	</select>
                	</li>
                </ul>
         	</div>
             <table class="p_table table_center">
             <tbody>
             	<tr>
                    <td>第1、2人市场价</td>
                    <td>第1、2人销售价</td>
                    <td>第1、2人结算价</td>
                    <td>第3、4人市场价</td>
                    <td>第3、4人销售价</td>
                    <td>第3、4人结算价</td>
                    <td>第3、4人儿童市场价</td>
                    <td>第3、4人儿童销售价</td>
                    <td>第3、4人儿童结算价</td>
                </tr>
                <tr>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price" style="width:50px;" required=true number=true> 
                    	<input type="hidden" name="fstMarketPrice" >
                    </td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price1" style="width:50px;" required=true number=true> 
                    	<input type="hidden" name="fstPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price2" style="width:50px;" required=true number=true> 
                    	<input type="hidden" name="fstSettlementPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price3" style="width:50px;" number=true> 
                    	<input type="hidden" name="secMarketPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price4" style="width:50px;" number=true> 
                    	<input type="hidden" name="secPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price5" style="width:50px;" number=true> 
                    	<input type="hidden" name="secSettlementPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price6" style="width:50px;" number=true> 
                    	<input type="hidden" name="childMarketPrice">
                	</td>
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price7" style="width:50px;" number=true> 
                    	<input type="hidden" name="childPrice">
                	</td> 
                    <td align="center">
                    	<input type="text" errorEle="price" class="price" name="price8" style="width:50px;" number=true> 
                    	<input type="hidden" name="childSettlementPrice">
                	</td>
                </tr>
	            </tbody>
           </table>
           <div id="priceError" style="display:inline"></div>
 	</div>
	
 	<div class="J_con" style="position:relative; padding-bottom:80px">
        	<table class="e_table form-inline">
             <tbody>
                <tr>
                    <td width="90" class="e_label">库存类型<i class="cc1">*</i>	：</td>
                    <td>
                    	<label class="radio mr10"><input type="radio" name="stockType" value="CONTROLLABLE" id="stockType" >控位</label>
                        <label class="radio"><input type="radio" name="stockType" id="stockType" value="INQUIRY" checked="checked">现询</label>
                    </td>
                </tr>
                <tr class="stockType">
                    <td class="e_label">日库存数：</td>
                    <td><input type="hidden" name="increase" value="0"/>
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
		                </select></td>
                </tr>
                </tbody>
	           </table> 
 </div>  
	 <div class="J_con" style="position:relative; padding-bottom:80px">
       		 <table class="e_table">
             <tbody>
             	<tr>
                    <td width="90" class="e_label"><i class="cc1">*</i>退改规则类型：</td>
                     <td>
                      <label class="radio mr10"><input type="radio" name="cancelStrategy" value="UNRETREATANDCHANGE" >不退不改</label>
                      <label class="radio"><input type="radio" name="cancelStrategy"  value="MANUALCHANGE" checked="checked" >人工退改</label>
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
	
	$(".stockType").hide();
	$("input[name=stockType]").click(function(){
		if($(this).val()=="CONTROLLABLE")
			$(".stockType").show();
		else
			$(".stockType").hide();
	});
	
	$('.J_tip').lvtip({
                templete: 3,
                place: 'bottom-left',
                offsetX: 0,
                events: "live" 
            });

	var good = {};
	var specDate;
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
	
	
	$("#timePriceSaveButton").click(function(){
	
		if(!$("#timePriceForm").validate({
			rules : {
				price : {
					required : true
				},
				price1 : {
					required : true
				},
				price2 : {
					required : true
				}
			},
			messages : {
				price : '请填写第1、2人市场价',
				price1 : '请填写第1、2人销售价',
				price2 : '请填写第1、2人结算价'
			}
		}).form()){
				return;
			}
		
		//将价格转为分	
		$(".price").each(function(){
			var price = $(this).val();
			$(this).next("input").val(price*100);
		})	
		
		$("input[name=increaseRadio]").each(function(){
		if($(this).attr("checked")=="checked"){
			$("input[name='increase']").val($(this).parent("label").next("select").val());
		}
		});
		
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/ship/goods/timePrice/editGoodsTimePrice.do",
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
	
		
		$("#cancelFlag").change(function(){
			$("#cancelFlag1").val($(this).val());
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
                
                $("input[name='type']").val($(this).attr("data"));
                return false;
         });
         
         $("input[type=radio][name=good]").click(function () {
         		var goodsId = $(this).val();
				var supplierId = $(this).attr("data");
				good.goodsId = goodsId;
				good.supplierId = supplierId;
                $.ajax({
                    url: '/vst_back/ship/goods/timePrice/findGoodsTimePriceList.do',
                    type: "POST",
                    dataType: "JSON",
                    data : {suppGoodsId:good.goodsId,supplierId:good.supplierId,specDate:'2014-03-19'},
                    success: function (json) {
                    	//添加头部
                       	var table = '<table id="timePriceTable" class="p_table table_center">'
					             +'<tbody>'
					             	+'<tr>'
					             		+'<td>出发日期</td>'
					                    +'<td>第1、2人市场价</td>'
					                    +'<td>第1、2人销售价</td>'
					                    +'<td>第1、2人结算价</td>'
					                    +'<td>第3、4人市场价</td>'
					                    +'<td>第3、4人销售价</td>'
					                    +'<td>第3、4人结算价</td>'
					                    +'<td>第3、4人儿童市场价</td>'
					                    +'<td>第3、4人儿童销售价</td>'
					                    +'<td>第3、4人儿童结算价</td>'
					                    +'<td>是否可售</td>'
					                    +'<td>库存</td>'
					                    +'<td>退改类型</td>'
					                +'</tr>'
						            +'</tbody>'
					          	    +'</table>';
            				$("#timePriceDiv").empty().append(table);
                       if(json!=null && json !=""){
                       		for(var i=0;i<json.length;i++){
                       			var arr = json[i];
                       			var tr = [];
                       			tr.push('<tr>');
                       			tr.push('<td>'+arr.specDateStr+'</td>');
                       			//第1、2人市场价
                       			if(arr.fstMarketPrice!=null){
                       				tr.push('<td>'+(arr.fstMarketPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第1、2人销售价
                       			if(arr.fstPrice!=null){
                       				tr.push('<td>'+(arr.fstPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第1、2人结算价
                       			if(arr.fstSettlementPrice!=null){
                       				tr.push('<td>'+(arr.fstSettlementPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人市场价
                       			if(arr.secMarketPrice!=null){
                       				tr.push('<td>'+(arr.secMarketPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人销售价
                       			if(arr.secPrice!=null){
                       				tr.push('<td>'+(arr.secPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人结算价
                       			if(arr.secSettlementPrice!=null){
                       				tr.push('<td>'+(arr.secSettlementPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人儿童市场价
                       			if(arr.childMarketPrice!=null){
                       				tr.push('<td>'+(arr.childMarketPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人儿童销售价
                       			if(arr.childPrice!=null){
                       				tr.push('<td>'+(arr.childPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//第3、4人儿童结算价
                       			if(arr.childSettlementPrice!=null){
                       				tr.push('<td>'+(arr.childSettlementPrice/100).toFixed(2)+'</td>');
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//是否可售
                       			if(arr.onsaleFlag=='Y'){
                       				tr.push('<td>可售</td>');
                       			}else {
                       				tr.push('<td>不可售</td>');
                       			}
                       			
                       			//判断库存类型
                       			if(arr.stockType!=null){
                       				var totalStock = arr.totalStock == null ? "0" : arr.totalStock;
                       				if(arr.stockType=='CONTROLLABLE'){
                       					tr.push('<td>库存类型:控位</br>剩余库存:'+arr.stock+'</br>日库存:'+totalStock+'</td>');
                       				}
                       				if(arr.stockType=='INQUIRY'){
                       					tr.push('<td>库存类型:现询</td>');
                       				}
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			//判断退改类型
                       			if(arr.cancelStrategy!=null){
                       				if(arr.cancelStrategy=='MANUALCHANGE'){
                       					tr.push('<td>人工退改</td>');
                       				}
                       				if(arr.cancelStrategy=='UNRETREATANDCHANGE'){
                       					tr.push('<td>不退不改</td>');
                       				}
                       			}else {
                       				tr.push('<td></td>');
                       			}
                       			tr.push('</tr>');
                       			$("#timePriceTable").find("tbody").append(tr.join(''));
                       		}
                       }
                    },
                    error: function () { }
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
