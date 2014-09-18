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
		  	 <div class="tiptext tip-warning cc5">
				<span class="tip-icon tip-icon-warning"></span>友情提示：
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
			
			<#--所有商品 start-->
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
			 <#--所有商品 end-->
			 
			 <#--时间价格表展示start-->
			 <div class="p_box box_info">
			  		<div class="title clearfix">
						    <h2 class="f16 fl" id="timePriceArrowView" style="cursor:pointer">时间价格表</h2>
						    <div id="timePriceArrow" class="J_date_more date_more active"><span>收起</span><span style=" position:relative; top:8px; left:26px; float:left"><i class="ui-arrow-bottom blue-ui-arrow-bottom"></i></span></div>
			                <span class="J_tip fr cc3" id="showTips"><i class="J_tip icon-remind" ></i> 查看说明</span> 
			         </div>
		             <div style="width:300px;background:#ffffe0;border:1px solid #ff8801;position:absolute;right:0px;display:none;padding:10px;z-index:100" id="tips">
		                	售：销售价</br>结：结算价</br>提前：提前预定时间</br>价格</br>库存</br></br>退改</br>退改规则：人工退改
		             </div>
			 		<div id="timePriceDiv" class="time_price">
			 			
			 		</div>
			 </div>
			 <#--时间价格表展示 end-->
			
			 
			<#--时间价格表设置 start-->
			 <#if suppGoods.suppSupplier.apiFlag == 'N'>
				
			 </#if>
			 <div class="p_box box_info">
			 	<#--设置tab start-->
			 	<div class="price_tab">
			        <ul class="J_tab ui_tab">
			            <li class="active" data="0"><a href="javascript:;">设置价格</a></li>
			            <#--<li data="3"><a href="javascript:;">设置库存</a></li>-->
			           	<#--<li data="1"><a href="javascript:;">设置退改规则</a></li>-->
			        </ul>
			     </div>
			     <#--设置tab end-->
			 	<div class="price_content">
				  <form id="timePriceForm">
				     <input type="hidden" name="type" value="0">
				     
				     <#--所有商品展示start-->
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
				            	 <div class="p_date" style="padding-left:40px">
				                        <ul class="cal_range">
				                            <li><i class="cc1">*</i>日期范围:</li>
				                            <li><input type="text" name="startDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /></li>
				                            <li>-</li>
				                            <li><input type="text" name="endDate" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></li>
				                            <li class="cc3">仅可操作两年内的时间</li>
				                            <div id="selectDateError" style="display:inline"></div>
				                        </ul>
				                        <ul class="app_week">
				                            <li>适用日期:</li>
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
						                <td class="e_label"><i class="cc1">*</i>市场价：</td>
					                    <td><input type="hidden" id="marketPrice" name="marketPrice" /><input type="text" id="marketPriceInput" name="marketPriceInput" number=true  min=0/>
					               </tr>
					             	 <tr>
						                <td  width="100px;" class="e_label"><i class="cc1">*</i>销售价：</td>
							            <td><input type="hidden" id="price" name="price" /><input type="text" id="priceInput" name="priceInput" number=true  min=0/></td>
					                </tr>
					                <tr>
						                <td class="e_label"><i class="cc1">*</i>结算价：</td>
					                    <td><input type="hidden" id="settlementPrice" name="settlementPrice" /><input type="text" id="settlementPriceInput" name="settlementPriceInput" number=true  min=0/>
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
					<#--所有商品展示end-->
				 </form>
				</div>
			 </div>  
		</div>
	  	<div class="p_box box_info clearfix mb20">
		            <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a class="btn" id="backToLastPageButton">返回上一步</a></div>
		</div> 
	 <#--时间价格表设置end-->
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
			arrow.find("span").eq(0).html("关闭");
			$("#timePriceDiv").show();
		}else {
			arrow.addClass("active");
			$("#timePriceDiv").hide();
			arrow.find("span").eq(0).html("展开");
		}
	})
	
	//保存设置
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
				marketPriceInput :{
					required: true,
					number:true,
					min:0
				}
				,
				priceInput: {
					largeThan : true,
					number:true,
					required: true,
					min:0
				}
				,
				settlementPriceInput :{
					required: true,
					number:true,
					min:0
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
		$("#aheadBookTime").val(day*24*60-hour*60-minute);
			
		//将元转换为分
		if($("#settlementPriceInput").val()!="")
		$("#settlementPrice").val(Math.round(parseFloat($("#settlementPriceInput").val())*100));
		
		if($("#priceInput").val()!="")
		$("#price").val(Math.round(parseFloat($("#priceInput").val())*100));
		
		if($("#marketPriceInput").val() != ""){
			$("#marketPrice").val(Math.round(parseFloat($("#marketPriceInput").val())*100));
		}
		
		var loading = top.pandora.loading("正在努力保存中...");
		 
		 $.ajax({
			url : "/vst_back/visa/goods/timePrice/editGoodsSimpleTimePrice.do",
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
        	url = "/vst_back/visa/goods/timePrice/findGoodsTimePriceList.do";
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
                                    '<li><span class="cc3">市：</span>'+ (arr.marketPrice/100).toFixed(2) +'<span class="cc3">售：</span>'+ (arr.price/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.settlementPrice/100).toFixed(2)+'</li>' +
                                    '<li class="mb10"><span class="cc3">提前：</span>1天19时29分</li>'
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
                        	liArray.push('<li><span class="cc3">市：</span>'+ (arr.marketPrice/100).toFixed(2) +'<span class="cc3">售：</span>'+ (arr.price/100).toFixed(2) +' <span class="cc3">结：</span>'+(arr.settlementPrice/100).toFixed(2)+'</li>');
                        }
                        
                        //判断有无提前预定数据
                        if(arr.aheadBookTime!=null){
                        	var time = minutesToDate(parseInt(arr.aheadBookTime));
                        	liArray.push('<li class="mb10"><span class="cc3">提前预定时间：</span>'+time+'</li>');
                        }
                        //库存
                    	liArray.push('<li class="mb10"><span class="cc3">库存类型：</span>无限库存</li>');
                        //退改规则
                    	liArray.push('<li class="mb10"><span class="cc3">退改类型：</span>人工退改</li>');
                    	
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
    
    //商品选中单击事件  
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
