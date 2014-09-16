<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="/vst_back/css/xhpanel.css" type="text/css"/>
</head>
<body>
<div>
</div>
    <div class="iframe_header">
        <i class="icon-home ihome"></i>
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">维护组件</a> &gt;</li>
            <li class="active">房态控制</li>
        </ul>
    </div>
    <div class="iframe_search">
    	<input type="hidden" name="apiFlag" id="apiFlag">
    	<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">仅可查找的供应商为非对接类型的</p>          
       		 <p class="pl15">行政区划、酒店名称、酒店编号至少填写一个</p> 
        </div>
    	<form method="post" action='/vst_back/goods/house/findHouseControlProductList.do' id="searchForm">
	        <table class="s_table form-inline">
	            <tbody>
	            	<tr>
		                <td class="w1"></td>
		                <td>
		                    <label><i class="cc1">*</i>起始日期：<input errorEle="searchValidate" type="text" name="startDate" class="Wdate w110" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" value="<#if houseControlQueryVO.startDate??>${houseControlQueryVO.startDate?string("yyyy-MM-dd")}</#if>">　</label>
		                    <label><i class="cc1">*</i>结束日期：<input errorEle="searchValidate" type="text" name="endDate" class="Wdate w110" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" value="<#if houseControlQueryVO.endDate??>${houseControlQueryVO.endDate?string("yyyy-MM-dd")}</#if>">　</label>
		                    <label><i class="cc1"></i>行政区划：<input errorEle="searchValidate" class="w110" name="districtName" id="districtName" type="text" readonly=readonly value="${houseControlQueryVO.districtName}"><input type="hidden" class="w110" id="districtId" name="districtId" value="${houseControlQueryVO.districtId}">　</label>
		      				<label><i class="cc1"></i> 供应商： 
		     			  <input type="text" errorEle="searchValidate"  class="searchInput" name="supplierName" id="supplierName" value="${houseControlQueryVO.supplierName}" >
                			<input errorEle="searchValidate" type="hidden" value="${houseControlQueryVO.supplierId}" name="supplierId" id="supplierId" >
		     			 </label><br>
		                    <label>酒店名称：<input class="w110" type="text" name="productName" id="productName" value="${houseControlQueryVO.productName}">　</label>
		                    <label>酒店编号：<input class="w110" type="text" name="productId" id="productId" value="${houseControlQueryVO.productId}">　</label>
		                    <span class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></span>
		                    <div id="searchValidateError" style="display:inline"></div>
		                </td>
	            	</tr>
	        	</tbody>
	        </table>
        </form>
       
    </div>
    
    <div class="iframe_content">
     <#if pageParam??&&pageParam.items??>
	 <#list pageParam.items as houseControlProduct> 
	     <#list houseControlProduct.suppliers as supplier>
        <div id="xhousing" class="xhousing">
            <div class="xhousingitem J_itemauto">
                <div class="xhtitle-outer">
                    <div class="fixedbox J_fixed">

                        <div class="xhtitle">
                            <span class="fr">
                                <i class="linkitem">[<a href="javascript:void(0);" class="houseTypeProp" data=${houseControlProduct.productId}>房型推荐级别</a>]</i>
                                <i class="linkitem">[<a href="#">酒店信息</a>]</i>
                                <i class="linkitem">[<a href="javascript:void(0);" class="houseStatus" productName=${houseControlProduct.productName} productId="${houseControlProduct.productId}" supplierId="${supplier.supplierId}" supplierName="${supplier.supplierName}" apiFlag="${houseControlQueryVO.apiFlag}" cancelFlag="${houseControlProduct.cancelFlag}"  >确认房态</a>]</i>
                                <i class="linkitem">[<a href="javascript:void(0);" class="houseContactProp" data=${houseControlProduct.productId}  data1=${houseControlQueryVO.supplierId}>酒店联系方式</a>]</i>
                            </span>
                            <h4><i class="fnb"><#if houseControlQueryVO.apiFlag=='Y'>对接<#else>非对接</#if> </i> <a href="#">${houseControlProduct.productName}</a> <small>[${supplier.supplierName}]</small></h4>
                            <input type="hidden" productId="${houseControlProduct.productId}" supplierId="${supplier.supplierId}" supplierName="${supplier.supplierName}" class="productData">
                        </div><!--//.xhtitle-->
                        <span class="xhprev disabled">‹</span>
                        <span class="xhnext">›</span>
                        <table class="xhlist table-full">
                            <thead>
                                <tr>
                                    <td class="xboxleft">
                                    <div class="xhname"></div></td>
                                    <td class="xboxright xboxtitle">
                                        <div class="xbox">
                                            <ul class="xulist">
                                            	<#if dateList??>
                                            		<#list dateList as dateWeek>
                                                		<li>${dateWeek.day?string("yyyy-MM-dd")}(${dateWeek.week})</li>
                                                	</#list>
                                                </#if>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div><!--//.fixedbox-->
                </div>
                <div class="xhlistbox">
                    <div class="xhlistbox-item">
                        <table class="xhlist table-full">
                            <tbody id="product_${supplier.supplierId}" >
                            <input type="hidden" supplierId="${supplier.supplierId}" supplierName="${supplier.supplierName}"/>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div><!--//.xhousingitem-->
             </#list>
            </#list>
            </#if>
        </div>
    </div>

     <#if pageParam!=null&&pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
					</div> 
	</#if>
    
   
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
     //   vst_pet_util.commListSuggest("#supplierName", "input[name=supplierId]",'/vst_back/supp/supplier/searchSupplierList.do?apiFlag=Y"');
	vst_pet_util.commListSuggest("#supplierName", "#supplierId","/vst_back/supp/supplier/searchSupplierList.do?apiFlag=N", '${suppJsonList}');
	
		var districtSelectDialog,selectSupplierDialog;
		//行政区选择回调函数
		function onSelectDistrict(params){
			if(params!=null){
				$("#districtName").val(params.districtName);
				$("#districtId").val(params.districtId);
			}
			districtSelectDialog.close();
		}
		
		//打开选择行政区窗口
		$("#districtName").click(function(){
			districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1100",height:'600'});
		});
		
		//供应商选择后的回调函数
		function onSelectSupplier(params){
			if(params!=null){
				$("#supplierName").val(params.supplierName);
				$("#supplierId").val(params.supplierId);
				$("#apiFlag").val(params.apiFlag);
			}
			//关闭供应商列表
			selectSupplierDialog.close();
		}
	
		//打开选择供应商列表
		//$("#supplierName").click(function(){
		//	var url = "/vst_back/supp/supplier/selectSupplierList.do?callback=onSelectSupplier";
		//	selectSupplierDialog = new xDialog(url,{},{title:"选择供应商",iframe:true,width:"1000",height:600});
		//});
	
		$("#search_button").click(function(){
			if(!$("#searchForm").validate({
				rules : {
				startDate : {
					required : true
				}
				,
				endDate : {
					required : true
				}
				//,				
				//supplierName:{
					//required : true
				//}				
			},
			messages : {
				startDate : '请选择开始日期',
				endDate : '请选择结束日期',				
				supplierName:'请选择供应商'
				
			}
			}).form()){return;}
			//行政区划、酒店名称、酒店ID至少填写一个
			if($("#searchForm #districtName").val()=="" && $("#searchForm #productName").val()=="" && $("#searchForm #productId").val()==""){
				alert("行政区划、酒店名称、酒店ID至少填写一个");
				return false;
			}
			$("#searchForm").submit();
			
		});
	
	function formatTime(time){
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
		
	$(document).ready(function(){
	 
     	//产品载入结束后，开始载入商品信息
		//显示loading
		
		
		//创建li
		var liArray = [];
		<#if dateList??>
    		<#list dateList as dateWeek>
    			var li = '<li style="width: 303px;" day="${dateWeek.day?string("yyyy-MM-dd")}" >'+
    				     '<p>'+
    				     '</p>'+
    				    '</li>';
					liArray.push(li);   
    		</#list>
		</#if>
		//创建tr 显示模板
		var template = '<tr>'+
			   	  	     '<td class="xboxleft">'+
			   	  	       '<div class="xhname">{{productBranchName}}<br>{{goodsName}}{{payTarget}}<br><a class="showTimePrice" href="javascript:void(0);" productId={{productId}} branchId={{branchId}} suppGoodsId={{suppGoodsId}} supplierId={{supplierId}} supplierName={{supplierName}}>价格</a>　<a href="javascript:void(0);" class="houseStatus" suppGoodsId={{suppGoodsId}}>确认房态</a></div>'+
	   	 	     	    '</td>'+
	   	 	     	    '<td class="xboxright xboxcontent">'+
	   	 	     	       '<div class="xbox">'+
	   	 	     	           '<ul class="xulist">'+
	   	 	     	                liArray.join("")+
	   	 	     	           '</ul>'+
	   	 	     	    	'</div>'+
	   	 	     	    '</td>'+
			   	       '</tr>'; 
		  	    
		$(".xhtitle .productData").each(function(){
			var productId = $(this).attr("productId");
			var supplierId = $(this).attr("supplierId");
			var supplierName = $(this).attr("supplierName");
			var startDate = $("input[name=startDate]").val();
			var endDate = $("input[name=endDate]").val();
			$.ajax({
				url: "/vst_back/goods/house/findHouseControlGoodsList.do",
                type: "POST",
                dataType: "JSON",
                data : {productId:productId,supplierId:supplierId,supplierName:supplierName,startDate:startDate,endDate:endDate},
                success: function (json) {
                  setData(json);
                },
                error:function(meg){
                
                }  
			});
		});
		
		//设置data
		function setData(dataArray){
			var trArray = [];
			if(dataArray!=null&&dataArray.length>0){
				for(var i = 0; i < dataArray.length; i++){
					var goods = dataArray[i];
					var timePriceArray = goods.houseControlGoodsTimePriceVOList;
					var temp = template;
					  //填充行数据
					  //填充产品规格
					  temp = temp.replace("{{productBranchName}}",goods.productBranchName);
					  //填充产品名称
					  temp = temp.replace("{{goodsName}}",goods.goodsName);
					  //填充产品ID
					  temp = temp.replace("{{productId}}",goods.productId);
					  //填充规格ID
					  temp = temp.replace("{{branchId}}",goods.branchId);
					  //填充商品ID
					  temp = temp.replace(/{{suppGoodsId}}/g,goods.suppGoodsId);
					    //填充供应商ID
					  temp = temp.replace("{{supplierId}}",goods.supplierId);
					    //填充供应商名称
					  temp = temp.replace("{{supplierName}}",goods.supplierName);
					  //预付现付
					  var target = '';
					  if(goods.payTarget=='PREPAID'){
					  	target = '[预付]';
					  }else if(goods.payTarget=='PAY'){
					  	target = '[现付]';
					  }
					  //填充支付方式
					  temp = temp.replace("{{payTarget}}",target);
					  var $template = $(temp).appendTo("#product_"+goods.supplierId);
					  //打开房态设置
					  $template.find(".houseStatus").bind("click",function(){
					  		var li = $(this).parents("div.xhousingitem").find("i.linkitem").eq(2).find("a.houseStatus");
					  		var cancelFlag = li.attr("cancelFlag")
					  		if(cancelFlag!='Y'){
					  			$.alert("产品不可用");
					  			return;
					  		}
					  		var productId = li.attr("productId");
					  		var productName = li.attr("productName");
							var districtName = $("#districtName").val();
							var suppGoodsId = $(this).attr("suppGoodsId");
					  		if(li.attr("supplierId")!=null){
					  		var supplierId = li.attr("supplierId");
					  		var supplierName = li.attr("supplierName");
					  		houseStatusDialog = new xDialog("/vst_back/goods/house/showHouseStatus.do",{suppGoodsId:suppGoodsId,productId:productId,supplierId:supplierId,productName:productName,supplierName:supplierName,districtName:districtName},{title:"确认房态",width:800,beforeunload:function(){$("#searchForm").submit();}});
					  		
					  		}else{
					  		houseStatusDialog = new xDialog("/vst_back/goods/house/showHouseStatus.do",{suppGoodsId:suppGoodsId,productId:productId,productName:productName,districtName:districtName},{title:"确认房态",width:800,beforeunload:function(){$("#searchForm").submit();}});
					  		
					  		}
							
						
					  });
					  
					  //打开价格设置
					 $template.find(".showTimePrice").click(function(){
							var productId = $(this).attr("productId");
							var branchId = $(this).attr("branchId");
							var suppGoodsId = $(this).attr("suppGoodsId");
		                    var supplierId = $(this).attr("supplierId");
		                    var supplierName = $(this).attr("supplierName");
				            if(supplierId!=null){
						     window.open("/vst_back/goods/timePrice/showGoodsTimePrice.do?suppGoodsId="+suppGoodsId+"&prodProduct.productId="+productId+"&prodProductBranch.bizBranch.branchId="+branchId+"&suppSupplier.supplierId="+supplierId+"&suppSupplier.supplierName="+supplierName);
							}else{							
							window.open("/vst_back/goods/timePrice/showGoodsTimePrice.do?suppGoodsId="+suppGoodsId+"&prodProduct.productId="+productId+"&prodProductBranch.bizBranch.branchId="+branchId);
							}
							
						});
					  
					  //设置时间价格
					  if(timePriceArray!=null&&timePriceArray.length>0){
					  		for(var j=0;j<timePriceArray.length;j++){
					  			var arr = timePriceArray[j];
					  			var specDate = arr.dateStr;

		  			 	var liArray = [];
		  			 	//判断FreeSale
		  			 	var freeSaleFlag = arr.freeSaleFlag == 'Y' ? 'FreeSale' : '';
		  			 	var stockStatus = arr.stockStatusName == null ? "" : arr.stockStatusName;
                        //判断是否禁售  
                        if(arr.onsaleFlag=='Y'){
                    		//    去掉可售禁售字段
                       	liArray.push('&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue">'+freeSaleFlag+'</span></i>&nbsp;&nbsp;&nbsp;&nbsp;'+stockStatus+'</span><br/>');
                        }else {
                        //   去掉可售禁售字段
                       	liArray.push('&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue">'+freeSaleFlag+'</span></i>&nbsp;&nbsp;&nbsp;&nbsp;'+stockStatus+'</span><br/>');
                        }
                        //判断有无提前预定数据
                        if(arr.aheadBookTime!=null){
                        	var time = formatTime(parseInt(arr.aheadBookTime));
                        	liArray.push('<span class="textitem"><i class="cc3">提前预定时间：</i>'+time+'</span><br/>');
                        }      
                        //判断是不是保留房
                        if(arr.stockFlag == 'Y'){
                        	//设置保留房数
                        	var stock = arr.stock == null ? 0 : arr.stock
                        	//合同库存
                        	var totalStock = arr.totalStock == null ? 0  : arr.totalStock;
                        	liArray.push('<span class="textitem"><i class="cc3">保留房数：</i>'+stock+'('+totalStock+')</span><br/>');
                        	//设置最晚预定时间
                        	if(arr.latestHoldTimeForView!=null){
                        		liArray.push('<span class="textitem"><i class="cc3">最晚预定时间：</i>'+arr.latestHoldTimeForView+'</span><br/>');
                        	}
                        	//保留房是否可恢复
                        	var restore = arr.restoreFlag=="Y" ? "可恢复" : "不可恢复";
                        	var overshell = arr.overshellFlag=="Y" ? "可超卖" : "不可超卖";
                			liArray.push('<span class="textitem"><i class="cc3">'+restore+'</i>&nbsp;&nbsp;&nbsp;&nbsp;<i class="cc3">'+overshell+'</i></span><br/>');
                        }else {
                        	liArray.push('<span class="textitem"><i class="cc3">非保留房</i></span><br/>');       
                        }               
                        
                         //退改类型
                    	if(arr.cancelStrategy!=null){
                    		if(arr.cancelStrategy=="RETREATANDCHANGE"){
                    			liArray.push('<span class="textitem"><i class="cc3">退改类型:</i>可退改</span><br/>');
                    		}
                    		if(arr.cancelStrategy=="UNRETREATANDCHANGE"){
                    			liArray.push('<span class="textitem"><i class="cc3">退改类型:</i>不退不改</span><br/>');
                    		}
                    	}
                        
                        //判断是否是预付
                        if(goods.payTarget=="PREPAID"){
                        	//设置最晚取消时间
                        	if(arr.latestCancelTime!=null){
                        		var time = formatTime(parseInt(arr.latestCancelTime));
                        		liArray.push('<span class="textitem"><i class="cc3">最晚无损取消时间：</i>'+time+'</span><br/>');
                        	}
                        	//预付扣款类型
                        	if(arr.deductType!=null){
                        		var deductValue =  arr.deductValue == null ? '' :  arr.deductValue;
                        		if(arr.deductType=="NONE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>否&nbsp;&nbsp;'+deductValue+'</span><br/>');
                        		}
                        		if(arr.deductType=="FULL"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>全额&nbsp;&nbsp;'+deductValue+'</span><br/>');
                        		}
                        		if(arr.deductType=="PEAK"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>峰值&nbsp;&nbsp;'+deductValue+'</span><br/>');
                        		}
                        		if(arr.deductType=="FIRSTDAY"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>首日&nbsp;&nbsp;'+deductValue+'</span><br/>');
                        		}
                        		if(arr.deductType=="MONEY"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>固定金额&nbsp;&nbsp;'+deductValue/100+'</span><br/>');
                        		}
                        		if(arr.deductType=="PERCENT"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付扣款类型：</i>百分比&nbsp;&nbsp;'+deductValue+'</span><br/>');
                        		}
                        	}
                        	//预付预授权限制
                        	if(arr.bookLimitType!=null){
                        		if(arr.bookLimitType=="NONE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付预授权限制：</i>无限制</span><br/>');
                        		}
                        		if(arr.bookLimitType=="PREAUTH"){
                        			liArray.push('<span class="textitem"><i class="cc3">预付预授权限制：</i>一律预授权</span><br/>');
                        		}
                        	}
                        }
                        //判断是否是现付
                         if(goods.payTarget=="PAY"){	
                         	//担保类型
                         	if(arr.guarType=="CREDITCARD"){
                    			liArray.push('<span class="textitem"><i class="cc3">担保类型：</i>信用卡</span><br/>');
                        	}
                         	//全额/峰时担保扣款
                         	if(arr.deductType!=null){
                        		if(arr.deductType=="NONE"){
                        			liArray.push('<span class="textitem"><i class="cc3">全额/峰时担保扣款：</i>否</span><br/>');
                        		}
                        		if(arr.deductType=="FULL"){
                        			liArray.push('<span class="textitem"><i class="cc3">全额/峰时担保扣款：</i>全额</span><br/>');
                        		}
                        		if(arr.deductType=="PEAK"){
                        			liArray.push('<span class="textitem"><i class="cc3">全额/峰时担保扣款：</i>峰值</span><br/>');
                        		}
                        		if(arr.deductType=="FIRSTDAY"){
                        			liArray.push('<span class="textitem"><i class="cc3">全额/峰时担保扣款：</i>首日</span><br/>');
                        		}
                        	}
                        	//担保最晚无损取消时间
                        	if(arr.latestCancelTime!=null){
                        		var time = formatTime(parseInt(arr.latestCancelTime));
                        		liArray.push('<span class="textitem"><i class="cc3">最晚无损取消时间：</i>'+time+'</span><br/>');
                        	}
                        	//预订限制
                        	if(arr.bookLimitType!=null){
                        		if(arr.bookLimitType=="NONE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预订限制：</i>无限制</span><br/>');
                        		}
                        		if(arr.bookLimitType=="TIMEOUTGUARANTEE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预订限制：</i>超时担保</span><br/>');
                        			//保留时间
                        			if(arr.latestUnguarTime!=null&&arr.latestUnguarTime!='0'){
                        				liArray.push('<span class="textitem"><i class="cc3">保留时间：</i>'+arr.latestUnguarTime+':00</span><br/>');
                        			}
                        		}
                        		if(arr.bookLimitType=="ALLTIMEGUARANTEE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预订限制：</i>全程担保</span><br/>');
                        		}
                        		if(arr.bookLimitType=="ALLGUARANTEE"){
                        			liArray.push('<span class="textitem"><i class="cc3">预订限制：</i>一律担保</span><br/>');
                        		}
                        	}
                        	
                        	
                        	//预定限制_是否房量担保
                        	if(arr.guarQuantity!=null){
                        		liArray.push('<span class="textitem"><i class="cc3">需担保房量：</i>'+arr.guarQuantity+'</span><br/>');
                        	}
                         }
                            //日志
                        	liArray.push('<span class="textitem"><i class="cc3">[<a href="javascript:void(0);" class="showLogDialog" param="{\'objectId\':'+goods.suppGoodsId+',\'objectType\':\'SUPP_GOODS_GOODS\',\'logType\':\'SUPP_GOODS_GOODS_TIME\'}">日志</a>]</i></span><br/>');
					  				
				     		//填充content
				     		$template.find("li[day="+specDate+"]").find("p").append(liArray.join(''));
					  		}
					  		$(window).resize(); 
					  } 	   
				}
			}
		}
	});
	
	var houseTypeDialog,houseContactDialog,houseStatusDialog;
	//房型推荐级别
	$("a.houseTypeProp").bind("click",function(){
		var productId = $(this).attr("data");
		houseTypeDialog = new xDialog("/vst_back/goods/house/showUpdateHouseType.do?productId="+productId,{},{title:"房型推荐级别",width:800,hight:600});
	});


	//酒店联系方式
	$("a.houseContactProp").bind("click",function(){
		var productId = $(this).attr("data");
		if($(this).attr("data1")!=null){
		  var supplierId = $(this).attr("data1");
		  	houseContactDialog = new xDialog("/vst_back/goods/house/findHouseContact.do?productId="+productId+"&supplierId="+supplierId,{},{title:"联系方式",width:800,hight:600,scrolling:"yes"});
		  
		}else{
		houseContactDialog = new xDialog("/vst_back/goods/house/findHouseContact.do?productId="+productId,{},{title:"联系方式",width:800,hight:600,scrolling:"yes"});
		
		}
      
	});
	
	//确认房态
	$("a.houseStatus").bind("click",function(){
		var cancelFlag = $(this).attr("cancelFlag")
  		if(cancelFlag!='Y'){
  			$.alert("产品不可用");
  			return;
  		}
		var productId = $(this).attr("productId");
		var supplierId = $(this).attr("supplierId");
		var productName = $(this).attr("productName");
		var supplierName = $(this).attr("supplierName");
		var districtName = $("#districtName").val();
		houseStatusDialog = new xDialog("/vst_back/goods/house/showHouseStatus.do",{productId:productId,supplierId:supplierId,productName:productName,supplierName:supplierName,districtName:districtName},{title:"确认房态",width:800,beforeunload:function(){$("#searchForm").submit();}});
	});
	
</script>


