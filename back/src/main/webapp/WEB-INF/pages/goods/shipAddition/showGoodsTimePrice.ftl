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
<#--
<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
        <p class="pl15">1.可以查询的供应商为在“供应商合同关联”里面维护的供应商</p>
        <p class="pl15">2.可查询的商品，为当前产品下，供应商关联的当前规格的所有商品</p>
        <p class="pl15">3.可设置的为，有效的商品</p>
    </div>
    -->
<div class="p_box">
<form method="post" action='/vst_back/goods/shipAddition/showGoodsTimePrice.do' id="searchForm">
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
		<h2 class="f16" style="display:inline">商品销售信息查询</h2>
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
            </div>
             <div style="width:300px;background:#ffffe0;border:1px solid #ff8801;position:absolute;right:0px;display:none;padding:10px;z-index:100" id="tips">
                	<#---->
                	市：市场价</br>售：销售价</br>结：结算价</br>
                	
                	
             </div>
 		<div id="timePriceDiv" class="time_price">
 			
 		</div>
 </div>
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
               
                <#if perPayList??>
							<#assign index=0>
		 					<#list perPayList as good>
 							<#if index%5==0><tr></#if>
								<td>
			 					<label class="checkbox">
				 					<input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index}]" value="${good.suppGoodsId}" data="${good.payTarget}" 
				 					<#if good.cancelFlag!='Y'||good.prodProductBranch.cancelFlag!='Y'>disabled=disabled</#if> />
				 					<#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-
				 					<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}-
				 					<#if good.payTarget=="PREPAID">[预付]</#if>&nbsp;&nbsp;
				 					<#--
				 					<#if good.hasTimePriceFlag!="Y">
				 					<span style="color:red">[未设置]</span>
			 						</#if>
			 						-->
			 					</label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==perPayList?size></tr></#if>
			 				</#list>
		 		</#if>
		 		
           		<#if payList??>
							<#assign index=0>
		 					<#list payList as good>
 							<#if index%5==0><tr></#if>
								<td>
			 					<label class="checkbox"><input type="checkbox" class="checkGoods" name="suppGoodsIdList[${index+perPayList?size}]" value="${good.suppGoodsId}" data="${good.payTarget}" <#if good.cancelFlag!='Y'||good.prodProductBranch.cancelFlag!='Y'>disabled=disabled</#if> /><#if good.prodProductBranch.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.prodProductBranch.branchName}-<#if good.cancelFlag!='Y'><span style="color:red">[无效]</span></#if>${good.goodsName}-<#if good.payTarget=="PAY">[现付]</#if>&nbsp;&nbsp;
			 					<#--
			 					<#if good.hasTimePriceFlag!="Y"><span style="color:red">[未设置]</span></#if>
			 					-->
			 					</label>
								</td>
							<#assign index = index+1>
	 						<#if index%5==0||index==payList?size></tr></#if>
			 				</#list>
		 		</#if>
                </tbody>
                </table>
            	 <div class="p_date">
                        <ul class="cal_range">
                            <li><i class="cc1">*</i>出发日期:</li>
                             <li>
                            <input type="text" name="specDate" required=true id="specDate" class="Wdate" id="defaultInput" onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd'})">
                            </li>
                            
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
             <table class="p_table table_center" >
					    <thead>
					        <tr>
					              <TR>
					               <th  style="width:80px;">成人市场价</th>
									<th  style="width:80px;" >成人销售价</th>
									<th  style="width:80px;" >成人结算价</th>
									<th  style="width:80px;">儿童市场价</th>
									<th  style="width:80px;" >儿童销售价</th>
									<th  style="width:80px;" >儿童结算价</th>
								</TR>
					        </tr>
					        
					    </thead>
					    <tbody>
							    <TR>
								<TD>
								<input type="text" errorEle="price" class="price" name="price1" style="width:50px;" required=true number=true> 
								<input type="hidden"  style="width:80px;" name="auditMarketPrice" id="auditMarketPrice" value="" number="true" required=true>
								</TD>
								<TD>
								<input type="text" errorEle="price" class="price" name="price2" style="width:50px;" required=true number=true> 
								<input type="hidden"   style="width:80px;" name="auditPrice"  id="auditPrice" value="" number="true" required=true>
								</TD>
								<TD>
								<input type="text" errorEle="price" class="price" name="price3" style="width:50px;" required=true number=true> 
								<input type="hidden"   style="width:80px;" name="auditSettlementPrice"  id="auditSettlementPrice" value="" number="true" required=true>
								</TD>
								<TD>
								<input type="text" errorEle="price" class="price" name="price4" style="width:50px;"  number=true> 
								<input type="hidden"   style="width:80px;"  name="childMarketPrice"  id="childMarketPrice" value="" number="true" >
								</TD>
								<TD>
								<input type="text" errorEle="price" class="price" name="price5" style="width:50px;"   number=true> 
								<input type="hidden"  style="width:80px;" name="childPrice"  id="childPrice" value="" number="true" >
								</TD>
								<TD>
								<input type="text" errorEle="price" class="price" name="price6" style="width:50px;"  number=true> 
								<input type="hidden"   style="width:80px;"  name="childSettlementPrice"  id="childSettlementPrice" value="" number="true" >
								</TD>
								</TR>
					    </tbody>
					</table>  
 			 </div>
	
 	<div class="J_con" style="position:relative; padding-bottom:80px">
 	<#--
        	<ul class="cal_range">
	            <li><i class="cc1">*</i>出发日期:</li>
	            <li><i class="cc1"> 
	                <select name="bizCategory.categoryId">
	            	 			<option value="">不限</option>
	    				<#list bizCategoryList as bizCategory> 
		                    	<option value=${bizCategory.categoryId!''} <#if prodProduct.bizCategory!=null && prodProduct.bizCategory.categoryId == bizCategory.categoryId>selected</#if> >${bizCategory.categoryName!''}</option>
		                </#list>
		        	</select>
	        	</li>
        	</ul>
        -->	
        	<ul class="cal_range">
	            <li><i class="cc1">*</i>库存类型:</li>
	            <li><input type="radio" name="stockType" id="stockType" checked="checked" value="FREESALE">FreeSale</li>
        	</ul>
        	
 	</div>  
	 <div class="J_con" style="position:relative; padding-bottom:80px">
			 <ul class="cal_range">
	            <li><i class="cc1">*</i>退改类型:</li>
	            <li><i class="cc1"> 
	               <select class="w10" name="cancelStrategy" id="cancelStrategy1">
	                    	<option value="MANUALCHANGE">人工退改</option>
	                    	<option value="UNRETREATANDCHANGE">不退不改</option>	                    
	                  </select>
	        	</li>
        	</ul>
	</div>
 </form>	
 </div>  
 </div>
 </div>
  <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a class="btn" id="backToLastPageButton">返回上一步</a></div>
        </div>
 </div>
 </div>
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
	
	
	      	
       $("#cancelFlag").change(function(){
			$("#cancelFlag1").val($(this).val());
			$("#searchForm").submit();
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
	
	
	$("#timePriceSaveButton").click(function(){
		
		
		//JQuery 自定义验证，销售价不能小于结算价
		/**
		jQuery.validator.addMethod("largeThan", function(value, element) {
		    return !(parseInt($(element).val()) < parseInt($("#auditSettlementPrice").val()));
		 }, "销售价不能小于结算价");
		 
		 */
		 
		 
		if(!$("#timePriceForm").validate({
			
				
		}).form()){
				return false;
			}
		//执行到此说明没有错误，隐藏所有Error标签
		$(".e_error").hide();
		
		
		
		//将价格转为分 
		$(".price").each(function(){ 
		var price = $(this).val(); 
		$(this).next("input").val(parseInt(price*100)); 
		})
		
		
		var auditMarketPrice=$("#auditMarketPrice").val();
		var auditPrice=$("#auditPrice").val();
		var auditSettlementPrice=$("#auditSettlementPrice").val();
		var childMarketPrice=$("#childMarketPrice").val();
		var childPrice=$("#childPrice").val();
		var childSettlementPrice=$("#childSettlementPrice").val();
		
		/**
		if(auditMarketPrice<auditPrice || auditPrice<auditSettlementPrice)
		{
			$.alert('成人市场价必须大于等于成人销售价，成人销售价必须大于等于成人结算价');
			return;
		}
		
		if(childMarketPrice<childPrice || childPrice<childSettlementPrice)
		{
			$.alert('儿童市场价必须大于等于儿童销售价，儿童销售价必须大于等于儿童结算价');
			return;
		}
		
		*/
		
		
		
		
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/goods/shipAddition/editGoodsTimePrice.do",
			data :　$("#timePriceForm").serialize(),
			dataType:'JSON',
			type: "POST",
			success : function(result){
				$.alert(result.message);
				
				//window.location.reload();
				
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
                 	//$("input[data=PAY]").removeAttr("checked");
                 	//$("input[data=PREPAID]").removeAttr("checked");
                 	//显示预付/现付的标题
                 	//$(".payTargetTitle").show();
                 }else {
                   //隐藏预付/现付的标题
                	//$(".payTargetTitle").hide();
                 }
                
                //设置当前修改的类型
				$("input[name='type']").val($(this).attr("data"));
                return false;
         });
         
         
           	
         
         
 		$("input[type=radio][name=good]").click(function () {
         		var goodsId = $(this).val();
				var supplierId = $(this).attr("data");
				good.goodsId = goodsId;
				good.supplierId = supplierId;
				
				$("#timePriceDiv").html("");
	         	var data="suppGoodsId="+goodsId+"&suppilerId="+supplierId;
	         	//alert(data);
	         	$.post("/vst_back/goods/shipAddition/findSuppSingleTimePriceList.do",
				   data,
				   function(result){
				   
				   $("#timePriceDiv").html(result);
				  
				});	
				
            }); 
            
     	//设置右上角的说明
     	$("#showTips").bind("mouseover",function(){
     		$("#tips").show();
     	}).bind("mouseout",function(){
     		$("#tips").hide();
     	});
</script>
