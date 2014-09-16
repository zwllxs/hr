<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://pic.lvmama.com/min/index.php?f=/styles/v4/modules/dialog.css,/styles/v4/modules/calendar.css,/styles/v4/modules/tables.css" /> 
<#include "/base/head_meta.ftl"/>

<style>
.addTimePrice .calmonth .caltable td{ height:260px;}
</style>

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
	 							</#if>${suppGoods.goodsName}-
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
	 									<div class="tip-sharp tip-sharp-left"></div>
	 									商品无效
	 								</span>
 								</#if>
 							</label>
		 					<input type="hidden" id="supplierId" name="supplierId" value="${suppGoods.suppSupplier.supplierId}"/>
		 					<input type="hidden" id="suppGoodsId" name="suppGoodsId" value="${suppGoods.suppGoodsId}"/>
		 				</td>
				 	</tr>
		 		</table>
			 </div>
			  <div class="p_box box_info">
				<div class="title clearfix">
				    <h2 class="f16 fl" id="timePriceArrowView" style="cursor:pointer">时间价格表</h2>
				    <div id="timePriceArrow" class="J_date_more date_more active">
				    	<span>收起</span>
				    	<span style=" position:relative; top:8px; left:26px; float:left">
				    		<i class="ui-arrow-bottom blue-ui-arrow-bottom"></i>
				    	</span>
				    </div>
		        </div>
		 		<div id="timePriceDiv" class="time_price addTimePrice"></div>
			 </div>
			 <div class="p_box box_info">
			    <div class="price_content">
			     	<input type="hidden" name="type" value="0">
				     <div style="margin:-10px 0 0 20px">   
		           	 	<div class="p_date">
	                        <ul class="cal_range">
	                            <li><i class="cc1">*</i>日期范围:</li>
	                            <li>
	                            	<input type="text" name="startDate" errorEle="selectDate" class="Wdate" id="startDate" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'endDate\',{d:0});}'})" required/>
	                            </li>
	                            <li>-</li>
	                            <li>
	                            	<input type="text" name="endDate" errorEle="selectDate" class="Wdate" id="endDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDate\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'startDate\',{d:0});}'})" required/>
	                            </li>
								<div id="selectDateError" style="display:inline"></div>
	                            <li class="cc3">仅可操作两年内的时间</li>
	                        </ul>
	                        <ul class="app_week">
	                            <li><i class="cc1">*</i>适用星期:</li>
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
					 		<div class="title clearfix">
							    <h2 class="f16 fl" style="cursor:pointer;font-size:13px;">库存设置：</h2>
				        	</div>
				             <table width="800" class="e_table form-inline" style="width:900px;">
					             <tbody>
					                <tr>
					                	<td class="e_label" width="160"><i class="cc1">*</i>是否正常销售：</td>
					                	<td>
											<select name="onsaleFlag" id="onsaleFlag">
												<option value="Y">可售</option>
						                    	<option value="N">禁售</option>
						                    </select>                		
					                	</td>
					                </tr>             
					                 <tr>
					                    <td class="e_label"><i class="cc1">*</i>是否限制日库存：</td>
					                    <td rowspan="3" colspan="1">
					                    	<input type="radio" name="stockFlag" value="N" checked="checked"/>不限制日库存<br>
					                    	<input type="radio" name="stockFlag" value="Y"/>限制日库存
					                    	<table style="margin: -25px 0 0 120px;">
					                    		<tr name="stockFlagFixed">
					                    			<td class="e_label"><i class="cc1">*</i>总库存：</td>
					                    			<td>
					                    				<input type="text" name="totalStock" id="totalStock" disabled="disabled"/>
					                    				<span style="color:grey">为防止库存不同步，请不要直接修改库存。使用增减库存操作</span>
					                    			</td>
					                    		</tr>  
					                    		<tr name="stockFlagFixed">            		
					                    			<td class="e_label" >增减库存：</td>
					                    			<td>
								                    	<select id="operation" name="operation" class="w10">
										                      <option value="add">加</option>
										                      <option value="sub">减</option>
													    </select>				                    				
					                    				<input type="text" id="operationStock" name="operationStock" disabled="disabled"/>
					                    			</td>
					                    		</tr>
					                    		<tr  name="stockFlagFixed">
					                    			<td class="e_label"><i class="cc1">*</i>是否可超卖：</td>
					                    			<td>
								                    	<select name="oversellFlag" id="oversellFlag" class="w10">
										                      <option value="N">否</option>
										                      <option value="Y">是</option>
													    </select>
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
					                	<td class="e_label" width="160"><i class="cc1">*</i>市场价：</td>
					                	<td>
											<input type="text" name="showMarkerPrice" id="showMarkerPrice" required/>
											<input type="hidden" name="markerPrice" id="markerPrice"/>
					                	</td>
					                </tr>             
					             	<tr>
					                    <td class="e_label"><i class="cc1">*</i>结算价：</td>
					                    <td>
					                    	<input type="text" name="sPrice" id="showsettlementPrice" required/>
					                    	<input type="hidden" name="settlementPrice" id="settlementPrice"/>
					                    </td>
					                </tr>
					                 <tr>
					                    <td class="e_label"><i class="cc1">*</i>售价模式：
					                    	<input type="hidden" name="price" id="price"/>
					                    </td>
					                    <td rowspan="3" colspan="1">
					                    	<table style="margin: -2px 0 0 10px;">
					                    		<tr>
					                    			<td width="100">
					                    				<input type="radio" name="priceModel" checked="checked" value="FIRM_PRICE"/>固定价格
					                    			</td>
					                    			<td name="fixedPriceFixed"><i class="cc1">*</i>销售价：</td>
					                    			<td name="fixedPriceFixed">
					                    				<input type="text" name="showPrice" id="showPrice" required/>
					                    			</td>		                    			
					                    		</tr>
					                    		<tr>
					                    			<td>
					                    				<input type="radio" name="priceModel" value="PREMIUM"/>溢价
					                    			</td>
					                    			<td name="premiumFixed"  align="left">
					                    				<input type="radio" name="addType" value="FIXED_PRICE"/>固定加价：&nbsp;&nbsp;
					                    				<i id="addPriceNumber">*加价金额</i>
					                    			</td>
					                    			<td name="premiumFixed">
					                    				<input type="text" name="addPrice" number id="addPrice" disabled="disabled"/>
					                    			</td>
					                    		</tr>  
					                    		<tr>
					                    			<td>&nbsp;</td>                    		
					                    			<td name="makeupPriceFixed" align="left">
					                    				<input type="radio" name="addType" value="MAKEUP_PRICE"/>百分比加价：
					                    				<i id="addPricePercentage">*加价比例：</i>
					                    			</td>
					                    			<td name="makeupPriceFixed">
					                    				<input type="text" id="addScale" name="addScale" disabled="disabled"/>%
					                    			</td>
					                    		</tr>
					                    	</table>
					                    </td>
					                </tr>
					           </tbody>
				            </table>
		 					<div class="title clearfix">
							    <h2 class="f16 fl" style="cursor:pointer;font-size:13px;">时间限制：</h2>
				        	</div>			            
							<table style="margin-top: 10px;" cellpadding="2" cellspacing="2">
					             <tr>
					             	<td width="20">&nbsp;</td>
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
						                <span style="color:grey">&nbsp;如当天可预订，前台呈现：今天N点前，您可以预订当天（明天/后天）的票</span>
				                    </td>
				                </tr>
		           			</table>			            	            
			 			</div>
				 	</div>  
			 	</div>
			 </div>
			 <input type="hidden" name="addValue" id="addValue" required/> 
		 </form>
		 <div class="p_box box_info clearfix mb20">
	       <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a href="javascript:history.go(-1);" class="btn btn_cc1">返回上一步</a></div>
	     </div>
	 </div>
	<#include "/base/foot.ftl"/>
</body>
</html>
	<script src="/vst_back/js/pandora-calendar.js"></script>
<script>

pandora.calendar({
        trigger: ".J_calendar",
        triggerClass: "J_calendar",
        startDelayDays: 0, // 在开始的基础上叠加天数 配合fatalism一起使用
        fatalism: 730,
        template: {
            warp: '<div class="ui-calendar ui-calendar-mini" style="width:240px; height:260px;"></div>',
            calControl: '<span class="month-prev" {{stylePrev}} title="上一月">‹</span><span class="month-next" {{styleNext}} title="下一月">›</span>',
            calWarp: '<div class="calwarp clearfix">{{content}}</div>',
            calMonth: '<div class="calmonth" style="width:240px;">{{content}}</div>',
            calTitle: '<div class="caltitle"><span class="mtitle">{{month}}</span></div>',
            calBody: '<div class="calbox">' +
                        '<i class="monthbg">{{month}}</i>' +
                        '<table cellspacing="0" cellpadding="0" border="0" class="caltable" style="width:200px;">' +
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
                    '<div {{className}}>{{day}}</div>' +
                 '</td>'
        }
    });	
	
	$('.J_tip').lvtip({
                templete: 3,
                place: 'bottom-left',
                offsetX: 0,
                events: "live" 
            });

	var good = {};
	var specDate;
	// 隐藏溢价
	$('td[name=premiumFixed]').hide();
	$('td[name=makeupPriceFixed]').hide();
	// 限制日库存
	$('tr[name=stockFlagFixed]').hide();
	
	$("#timePriceSaveButton").click(function(){
	
		if($("input[name=startDate]").val()>$("input[name=endDate]").val()){
			$.alert("开始日期不能大于结束日期！");
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
	
		// 验证正整数
		var rq = /^[0-9]*[1-9][0-9]*$/;
		//验证小数位数
		var req = /^[1-9]{1}\d*(\.\d{1,2})?$/;
		// 自助校验	
		var validateBool = true;
		// 框架校验
		var jqVlidate = true; 
		
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
				startDate : {
					required : true
				}
				,
				endDate : {
					required : true
				}
				,
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
				sPrice :{
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
				}
				,addScale :{
					isMinus : true,
					isNum1 : true,
					required: true,
					min:0,
					max:9999999999
				}
				,addPrice :{
					isMinus : true,
					isNum1 : true,
					required: true,
					min:0,
					max:9999999999
				}
			},
			messages : {
				startDate : '请选择日期',
				endDate : '请选择日期',
				cancelStrategy : '请选择退改类型'
			}
		}).form()){
			jqVlidate = false;
		}     	
		
		if(!validateBool || !jqVlidate){
			return;
		}		
		
		//把提前预定时间转换为分钟数	
		var day = $("select[name=aheadHour_day]").val() == "" ? 0 : parseInt($("select[name=aheadHour_day]").val());
		var hour = $("select[name=aheadHour_hour]").val() == "" ? 0 : parseInt($("select[name=aheadHour_hour]").val());
		var minute = $("select[name=aheadHour_minute]").val() == "" ? 0 : parseInt($("select[name=aheadHour_minute]").val());
		$("#aheadBookTime").val(day*24*60-hour*60-minute);
		
     	// 计算结算价
     	operationAddType();

		//执行到此说明没有错误，隐藏所有Error标签
		$(".e_error").hide(); 
	
		//将元转换为分
		// 市场价
		if($("#showMarkerPrice").val()!=""){
			$("#markerPrice").val(Math.round(parseFloat($("#showMarkerPrice").val())*100));
		}
		// 结算价
		if($("#showsettlementPrice").val()!=""){
			$("#settlementPrice").val(Math.round(parseFloat($("#showsettlementPrice").val())*100));
		}	
		
		// 加价值
		if($("#addPrice").val()!=""){
			$("#addValue").val(Math.round(parseFloat($("#addPrice").val())*100));
		}
		if($("#addScale").val()!=""){
			$("#addValue").val(Math.round(parseFloat($("#addScale").val())*100));
		}		
		
		var iPrice = parseFloat($("#price").val());// 售价
		var sPrice = parseFloat($("#settlementPrice").val()); // 结算价 
		if((sPrice-iPrice)>0){
			$.alert('售价不能小于结算价!!');
			return;
		}	

		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/ticket/goods/timePrice/editGoodsAddTimePrice.do",
			data :$("#timePriceForm").serialize(),
			dataType:'JSON',
			success : function(result){
				loading.close();
				$.alert(result.message,function(){
					$('#operationStock').val('0');
					$("#timePriceArrowView,#timePriceArrow").click();				
				});
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
		
		//隐藏标题
		$(".payTargetTitle").hide();
		
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
                    url = "/vst_back/ticket/goods/timePrice/findGoodsAddTimePriceList.do";
				
				
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
                        
                        // 是否限制日库存
                        var stockFlag = arr.stockFlag;
                        if(stockFlag!=null){
                        	if(stockFlag=='Y'){
                        		liArray.push('<li><span class="cc3">限制日库存');
		                        // 日总库存
		                        if(arr.totalStock!=null){
		                        	var totalStock = arr.totalStock; 
		                        	liArray.push('&nbsp;<span class="cc3">日总库存：</span>'+totalStock);                        
		                        }                        	
		                        // 日剩余库存
		                        if(arr.stock!=null){
		                        	var stock = arr.stock; 
		                        	liArray.push('&nbsp;<span class="cc3">剩余库存：</span>'+stock);
		                        } 
		                        //判断是否超卖
		                        var oversellFlag = arr.oversellFlag;
		                        if(oversellFlag=='Y'){
		                        	liArray.push('&nbsp;<span class="cc3"><span style="color:blue">可超卖</span>');
		                        }else {
		                        	liArray.push('&nbsp;<span class="cc3"><span style="color:red">不可超卖</span>');
		                        }
		                        liArray.push('</li>');		                                                  	
                        	}else{
                        		liArray.push('<li><span class="cc3"><span style="color:blue">不限制日库存</span></li>');
                        	}
                        }
                        
                        //判断有无结/售数据
                        if(arr.price!=null&&arr.settlementPrice!=null){
                        	liArray.push('<li>'+'<span class="cc3">市：</span>'+(arr.markerPrice/100).toFixed(2)+'<span class="cc3">&nbsp;售：</span>'+ (arr.price/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.settlementPrice/100).toFixed(2)+'</li>');
                        }  
     
                        //判断有无提前预定数据
                        if(arr.aheadBookTime!=null){
                        	var time = minutesToDate(parseInt(arr.aheadBookTime));
                        	liArray.push('<li class="mb10"><span class="cc3">提前预定时间：</span>'+time+'</li>');
                        }      
                            
                        //退改类型
                    	if(arr.cancelStrategy!=null){
                    		if(arr.cancelStrategy=="MANUALCHANGE"){
                    			liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>有损退改</li>');
		                    	if(arr.latestCancelTime!=null){
		                         	var time = minutesToDate(parseInt(arr.latestCancelTime));
		                        	liArray.push('<li class="mb10"><span class="cc3">最晚无损退改时间：</span>'+time+'</li>');
		                    	} 
                    		}else if(arr.cancelStrategy=="UNRETREATANDCHANGE"){
                    			liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>不可退改</li>');
                    		}else if(arr.cancelStrategy=="RETREATANDCHANGE"){
                    			liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>随时退</li>');
                    		}
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
				
				 
				
         		var goodsId = $('#suppGoodsId').val();
				var supplierId = $('#supplierId').val();
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
     	
     	// 设置[是否限制库存]单选按钮事件
     	$("input[type=radio][name=stockFlag]").bind('click',function(){
     		 var obj = $(this);
     		 if(obj.attr('checked')=='checked'){
				setStockFlag(obj);
     		 }
     	});
     	
     	// 设置[售价模式]单选按钮事件
     	$("input[type=radio][name=priceModel]").bind('click',function(){
      		var obj = $(this);
     		if(obj.attr('checked')=='checked'){
     			 setPriceModel($(this));
     		}
     	});
     	
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
     		 	$('#addScale').next("div").remove();	
     		 	$('#addScale').removeAttr("required");     		 		
     		 	$('#addScale').val(""); 
     		 	
     		 	// 隐藏百分比加价
     		 	$('#addPricePercentage').hide();
     		 	$('td[name=makeupPriceFixed]').eq(1).hide();
     		 	// 显示固定加价
     		 	$('td[name=premiumFixed]').show();
     		 	$('#addPriceNumber').show();
     		 			
			 }else{
			 	// 百分比加价
			 	// 加价金额
     		 	$('#addPrice').removeAttr("required");
     		 	$('#addPrice').attr("disabled","disabled"); 
     		 	$('#addPrice').next("div").remove();	
     		 	$('#addPrice').val(""); 
     		 	// 加价比例	
     		 	$('#addScale').removeAttr("disabled");
     		 	$('#addScale').attr("required",true); 
     		 	
     		 	// 隐藏百分比加价
     		 	$('#addPriceNumber').hide();
     		 	$('td[name=premiumFixed]').eq(1).hide();
     		 	// 显示固定加价
     		 	$('td[name=makeupPriceFixed]').show();
     		 	$('#addPricePercentage').show();
			 }
     	}
     	
     	// 设置[是否限制库存]样式
     	function setStockFlag(obj){
     		 var stockFlag = obj.val();
     		 // Y:限制日库存 N:不限制日库存
     		 if(stockFlag=='N'){
     		 	// 日库存
     		 	$('#totalStock').attr("disabled","disabled");
     		 	$('#totalStock').next("div").remove();	
     		 	$('#totalStock').removeAttr("required");	
     		 	$('#totalStock').val("");	
     		 	// 增减库存数
     		 	$('#operationStock').attr("disabled","disabled");	
     		 	$('#operationStock').val("");
     		 	// 隐藏限制日库存输入框
     		 	$('tr[name=stockFlagFixed]').hide();
     		 }else{
     		 	// 日库存
     		 	$('#totalStock').removeAttr("disabled");
     		 	$('#totalStock').attr("required",true);
     		 	// 增减库存数
     		 	$('#operationStock').removeAttr("disabled");
     		 	// 显示限制日库存输入框
     		 	$('tr[name=stockFlagFixed]').show();     		 	
     		 }     		
     	}
     	
     	// 设置[售价模式]样式
     	function setPriceModel(obj){
			var priceModel = obj.val();
     		 // 固定价格
     		 if(priceModel=='FIRM_PRICE'){
     		 	// 销售价
     		 	$('#showPrice').removeAttr("disabled");
     		 	$('#showPrice').attr("required",true);
     		 	
     		 	// 加价金额
     		 	$('#addPrice').attr("disabled","disabled");	
     		 	$('#addPrice').next("div").remove();	
     		 	$('#addPrice').removeAttr("required");	
     		 	$('#addPrice').val("");
     		 	
     		 	// 加价比例
     		 	$('#addScale').attr("disabled","disabled");
     		 	$('#addScale').next("div").remove();	
     		 	$('#addScale').removeAttr("required");
     		 	$('#addScale').val("");
     		 	
     		 	// 加价类型
     		 	$("input[type=radio][name=addType]").each(function(){
     		 		$(this).removeAttr("checked");
     		 	});
     		 	
     		 	// 显示固定加价、百分比加价
     		 	$('td[name=premiumFixed]').hide();
     		 	$('td[name=makeupPriceFixed]').hide();
				// 隐藏销售价
     		 	$('td[name=fixedPriceFixed]').show();
     		 	
     		 }else{
     		 	// 溢价
     		 	// 显示固定加价、百分比加价
     		 	$('td[name=premiumFixed]').show();
     		 	$('td[name=makeupPriceFixed]').eq(0).show();
     		 	
				// 隐藏销售价
     		 	$('td[name=fixedPriceFixed]').hide();
     		 	$('td[name=makeupPriceFixed]').eq(1).hide();
     		 	$('#addPricePercentage').hide();
     		 	
     		 	
     		 	// 销售价
     		 	$('#showPrice').removeAttr("required");
     		 	$('#showPrice').attr("disabled","disabled");
     		 	$('#showPrice').next("div").remove();
     		 	$('#showPrice').val("");

     		 	//加价类型
     		 	$("input[type=radio][name=addType]").each(function(i){
     		 		if(i==0){
     		 			$(this).attr("checked",true);
		     		 	// 加价金额
		     		 	$('#addPrice').removeAttr("disabled");
		     		 	$('#addPrice').attr("required",true);     		 			
     		 		}
     		 	});	 	
     		 }     		
     	} 
     	
     	// 根据销售模式计算销售价
     	function operationAddType(){
	     	$("input[type=radio][name=priceModel]").each(function(){
	     		 var obj = $(this);
	     		 if(obj.attr('checked')){
					 var settlementPrice = parseFloat($('#showsettlementPrice').val());// 结算价
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
					
					 $('#price').val(Math.round(parseFloat(price*100)));      		 	
	     		 }
	     	});      		
     	}  	
</script>
