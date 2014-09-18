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
 <form id="timePriceForm">         
 <div class="p_box clearfix">
 		<table class="e_table">
 				<#if goodsList??>
 				<#assign index=0>
 				<#list goodsList as good>
 				<#if index%5==0><tr></#if>
	 				<td>
	 					<label class="radio"><input type="radio" name="timePriceList[0].suppGoodsId" value="${good.suppGoodsId}" data="${suppGoods.suppSupplier.supplierId}"  class="good" /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}<#if good.cancelFlag!='Y'><span class="poptip-mini poptip-mini-warning"><div class="tip-sharp tip-sharp-left"></div>-商品无效</span></#if></label>
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
 <#if suppGoods.suppSupplier.apiFlag == 'N'>
 <div class="p_box box_info">
 	<input type="hidden" name="timePriceList[0].auditPrice" id="auditPrice"/>
 	<input type="hidden"  name="timePriceList[0].auditSettlementPrice" id="auditSettlementPrice"/>
 	<input type="hidden"   name="timePriceList[0].childPrice" id="childPrice" />
 	<input type="hidden"   name="timePriceList[0].childSettlementPrice" id="childSettlementPrice" />
 	<input type="hidden"   name="timePriceList[0].stock" id="stock" />
 	<div class="price_tab">
        <ul class="J_tab ui_tab">
            <li class="active" data="0"><a href="javascript:;">设置价格/库存/退改</a></li>
        </ul>
     </div>
     <div class="price_content">
     <input type="hidden" name="type" value="0">
     <div style="margin:-10px 0 0 20px">   
            	 <div class="p_date">
                        <ul class="cal_range">
                            <li><i class="cc1">*</i>日期范围:</li>
                            <li><input type="text" name="startDate" errorEle="selectDate" required class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /></li>
                            <li>-</li>
                            <li><input type="text" name="endDate" errorEle="selectDate" required class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></li>
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
            <div><label style="font-size:15px;margin-top:10px;margin-bottom:10px;">设置价格：</label></div>
            <div id="multiple_price_template">
			<table   class="e_table form-inline" style="width:900px;" goodsId="">
             <tbody>
                <tr>
	                <td width="50px" style="text-align:center">成人</td>
	                <td class="e_label" style="text-align:left">销售价：<input type="text"    name="auditPrice" class="adult" required=true number=true min=0/></td>
	                <td class="e_label" style="text-align:left">结算价：<input type="text"    name="auditSettlementPrice" class="adult" required=true number=true min=0/></td>
		            <td><label style="display:inline"><input type="checkbox" class="saleAble" name="adult"/>禁售</label></td>
		            <td width="150px;"><div id="auditError" style="display:inline"></div>	</td>
                </tr>
                <tr>
                	<td width="50px"  style="text-align:center">儿童</td>
               		<td class="e_label" style="text-align:left">销售价：<input type="text"    name="childPrice" class="child" required=true number=true min=0 /></td>
                    <td class="e_label" style="text-align:left">结算价：<input type="text"    name="childSettlementPrice" class="child" required=true number=true min=0 /></td>
		            <td><label style="display:inline"><input type="checkbox" class="saleAble" name="child"/>禁售</label></td>
		            <td width="150px;"><div id="childError" style="display:inline">
		            </td>
                </tr>
	            </tbody>
		       </table>
		      <div><label style="font-size:15px;margin-top:10px;margin-bottom:10px;">设置库存：</label></div>
		     <table  class="e_table form-inline" style="width:600px" goodsId="">
             <tbody>
             	<tr><td colspan="2"></td></tr>
                <tr>
                    <td width="150" class="e_label"><label class="radio"><input type="radio" class="typeSelect"  name="timePriceList[0].stockType" checked="checked" value="INQUIRE_NO_STOCK"/>不限日库存</label></td>
               		<td width="450"></td>
                </tr>
                <tr>
                    <td class="e_label"><label class="radio"><input type="radio" class="typeSelect"   name="timePriceList[0].stockType" value="CONTROL"/>限制日库存</label></td>
                	<td></td>
                </tr>
                <tr>
                    <td class="e_label">日库存量：</td>
                	<td>
                	<div>
                	<input type="radio" class="stockSetType"   name="stockSetType" value="increase" checked="checked"/>增加</label>
                	<input type="text"  errorEle="stock" class="stock"  name="stock"  disabled=disabled/>
                	</div>
                	<div style="margin-top:5px;">
                	<input type="radio" class="stockSetType"   name="stockSetType" value="decrease"/>减少</label>
                	<input type="text"  errorEle="stock" class="stock" name="stock1"  disabled=disabled/>
                	</div>
                	</td>
                </tr>
                <tr>
                    <td class="e_label">是否可超卖：</td>
                	<td>
                	<select class="w10" name="timePriceList[0].oversellFlag">
	                    	<option value="Y">可超卖</option>
	                    	<option value="N">不可超卖</option>
	                 </select></td>
                </tr>
                <tr>
                    <td class="e_label"><label class="radio" style="padding-right:21px;"><input type="radio" class="typeSelect"  name="timePriceList[0].stockType" value="INQUIRE_WITH_STOCK"/>现询库存</label></td>
                	 <td></td>
                </tr>
                 </tbody>
	           </table> 
		      
		     <div><label style="font-size:15px;margin-top:10px;margin-bottom:10px;">设置提前预定时间：</label></div>  
		    <table class="e_table form-inline" goodsId="">
             <tbody>
             	<tr><td colspan="2"></td></tr>
             	<tr>
                    <td width="150" class="e_label">提前预定时间：</td>
                    <td>
                    	<input type="hidden"  name="timePriceList[0].aheadBookTime" id="aheadBookTime">
                    	<select class="w10 mr10" name="aheadBookTime_day">
		                      <#list 0..50 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>天
		                <select class="w10 mr10" name="aheadBookTime_hour">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
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
 	</div>
 </form>
		 </div>
 </div>  
 </div>
 </div>
  <div class="p_box box_info clearfix mb20">
            <div class="fl operate" style="margin-left:20px;"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a class="btn" id="backToLastPageButton">返回上一步</a></div>
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
	
	
	$("#timePriceSaveButton").click(function(){
		var timePriceFormValidate = $("#timePriceForm").validate();
		//JQuery 自定义验证，销售价不能小于结算价
		jQuery.validator.addMethod("largeThan", function(value, element) {
		    return !(parseInt($(element).val()) < parseInt($("#settlementPriceInput").val()));
		 }, "销售价不能小于结算价");
		 
		 jQuery.validator.addMethod("isNum", function(value, element) {
		    var num = /^[1-9]{0}\d*(\.\d{1,2})?$/;
		    return this.optional(element) || (num.test(value));       
		 }, "价格只能为整数或者最多两位小数");
		 
	   //添加库存验证
	    $("input[name=stockSetType]").each(function(){
	   		$(this).closest("div").find(".stock").rules("remove");
	   });
	   $("input[name=stockSetType]:checked").each(function(){
	   		$(this).closest("div").find(".stock").rules("add",{required : true, number:true ,min:0,messages : {min:'库存必须大于等于0'}});
	   });
	   //添加价格验证
	   $(".adult,.child").each(function(){
	   		$(this).rules("add",{isNum:true,messages : {min:'请填写整数或者两位小数'}});
	   });
	  
		if(!timePriceFormValidate.form()){
				return;
			}
		//设置form表单提交数据
		//成人价
		var adultPriceInput = $("input[name='auditPrice']");
		if(adultPriceInput.attr("disabled")!="disabled"){
			$("#auditPrice").val(parseInt(adultPriceInput.val()*100));
		}else {
			$("#auditPrice").val("");
		}
		//成人结算价
		var auditSettlementPriceInput = $("input[name='auditSettlementPrice']");
		if(auditSettlementPriceInput.attr("disabled")!="disabled"){
			$("#auditSettlementPrice").val(parseInt(auditSettlementPriceInput.val()*100));
		}else{
			$("#auditSettlementPrice").val("");
		}
		//儿童价
		var childPriceInput = $("input[name='childPrice']");
		if(childPriceInput.attr("disabled")!="disabled"){
			$("#childPrice").val(parseFloat(childPriceInput.val()*100));
		}else {
			$("#childPrice").val("");
		}
		//儿童结算价
		var childSettlementPriceInput = $("input[name='childSettlementPrice']");
		if(childSettlementPriceInput.attr("disabled")!="disabled"){
			$("#childSettlementPrice").val(parseFloat(childSettlementPriceInput.val()*100));
		}else {
			$("#childSettlementPrice").val("");
		}
		//库存
		$("input[name=stockSetType]:checked").each(function(){
			var type = $(this).val();
	   		var stock = $(this).closest("div").find(".stock");
	   		if(stock.attr("disabled")!="disabled"){
	   				if(type=="increase"){
	   					$("#stock").val(stock.val());
	   				}else {
	   					$("#stock").val(-parseInt(stock.val()));
	   				}
	   		}
	   });
	   
		$("#stock").val();
		//把提前预定时间转换为分钟数	
		var day = $("select[name=aheadBookTime_day]").val() == "" ? 0 : parseInt($("select[name=aheadBookTime_day]").val());
		var hour = $("select[name=aheadBookTime_hour]").val() == "" ? 0 : parseInt($("select[name=aheadBookTime_hour]").val());
		var minute = $("select[name=aheadBookTime_minute]").val() == "" ? 0 : parseInt($("select[name=aheadBookTime_minute]").val());
		$("#aheadBookTime").val(day*24*60-hour*60-minute);
		
		//执行到此说明没有错误，隐藏所有Error标签
		$(".e_error").hide();
	
		//将元转换为分
		if($("#settlementPriceInput").val()!="")
		$("#settlementPrice").val(Math.round(parseFloat($("#settlementPriceInput").val())*100));
		if($("#priceInput").val()!="")
		$("#price").val(Math.round(parseFloat($("#priceInput").val())*100));

		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/goods/traffic/timePrice/editGoodsTimePrice.do",
			data :　$("#timePriceForm").serialize(),
			dataType:'JSON',
			type: "POST",
			success : function(result){
				$.alert(result.message);
				$("input[type=radio][name=good]:checked").click();
				loading.close();
				$("input[class=good]:checked").click();
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
		
		$("#search_button").click(function(){
			$("#searchForm").submit();
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
                    url = "/vst_back/goods/traffic/timePrice/findGoodsTimePriceList.do";
				
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
                                '</ul>';
                        var liArray = [];
                        //判断有无结/售数据
                        if(arr.auditPrice!=null&&arr.auditSettlementPrice!=null){
                        	liArray.push('<li><span class="cc3">成人 售：</span>'+ (arr.auditPrice/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.auditSettlementPrice/100).toFixed(2)+'</li>');
                        }else {
                        	liArray.push('<li><span class="cc3">成人：</span>禁售</li>');
                        }  
                        if(arr.childPrice!=null&&arr.childSettlementPrice!=null){
                        	liArray.push('<li><span class="cc3">儿童 售：</span>'+ (arr.childPrice/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.childSettlementPrice/100).toFixed(2)+'</li>');
                        } else {
                        	liArray.push('<li><span class="cc3">儿童：</span>禁售</li>');
                        } 
                        
                        if(arr.stockType!=null){
                        	var stockTypeName = arr.stockType == 'INQUIRE_NO_STOCK' ? '不限日库存' : arr.stockType == 'CONTROL' ? '限制日库存' :  arr.stockType == 'INQUIRE_WITH_STOCK' ? '现询库存' : '';
                        	if(arr.stockType=='CONTROL'){
                        		var oversaleName  = arr.oversellFlag == 'Y' ? '可超卖' : '不可超卖';
                        		liArray.push('<li><span class="cc3">'+stockTypeName+'</span>         '+arr.stock+'   '+oversaleName+'</li>');
                        	}else {
                        		liArray.push('<li><span class="cc3">'+stockTypeName+'</span></li>');
                        	}
                        }
                        
                        //判断有无提前预定数据
                        if(arr.aheadBookTime!=null){
                        	var time = minutesToDate(parseInt(arr.aheadBookTime));
                        	liArray.push('<li class="mb10"><span class="cc3">提前预定时间：</span>'+time+'</li>');
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
         
         $("input[type=radio][class=good]").click(function () {
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
     	
     	$(".saleAble").bind("click",function(){
     		var that = $(this);
     		if($(this).attr("checked")=='checked'){
     				that.closest("tr").find("input[type='text']").attr("disabled","disabled");
     		}else {
     			that.closest("tr").find("input[type='text']").removeAttr("disabled");
     		}
     	});
     	
     	
		$(".typeSelect").bind("click",function(){
     			var that = $(this);
	     		if((that.attr("checked")=="checked")&&that.val()=="CONTROL"){
	     			$(".stock").removeAttr("disabled");
	     		}else {
	     			$(".stock").attr("disabled","disabled");
	     		}
     	});
</script>
