<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<#import "/base/spring.ftl" as s/>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li>促销&gt;</li>
            <li class="active">促销维护 &gt;</li>
            <li class="active">优惠方案</li>
        </ul>
</div>
<div style="color:red;padding-left:30px;">
	注，仅针对某个品类的促销，则可选择的商品只能是这个品类的商品<br/>
	
	注，优惠条件、优惠方案设置后，除“分销商做删除添加”，其他均不能变更。若填写有误，则关闭该促销活动，重新创建一个
	<br/>
	注，若优惠条件，优惠方案，不能满足你的要求。。。请联系技术部，帮你添加对应的条件、方案
</div>
<form action="/vst_back/prom/promotion/savePromResult.do" method="post" id="dataForm">
		<input type="hidden" name="promPromotionId" value="${promPromotion.promPromotionId}">
		<input type="hidden" name="promResultId" value="${promResult.promResultId}">
       <div id="conditionDiv" style="padding-left:30px;">
       		<input type="hidden" id="ruleValue" name="ruleValue" value="${promPromotion.ruleValue}">
       		<div class="title">
				<h2 class="f16">优惠条件</h2>
			</div>
			<input type="radio" name="ruleType" controlName="advance" value="AHEAD_X_DAY" <#if promPromotion.ruleType == 'AHEAD_X_DAY'>checked="checked"</#if> >提前X天预订
			<div id="advanceDiv" style="padding-left:20px;display: none;">
				请输入提前预订的天数<input type="text" id="advanceNum" name="advanceNum" value="${promPromotion.ruleValue}" onchange="changRuleValue(this.value);" required>&nbsp;&nbsp;注，天数必须>=0
			</div>
			<br/>
			<input type="radio" name="ruleType" controlName="continuous" value="CONTINUITY_X_DAY" <#if promPromotion.ruleType == 'CONTINUITY_X_DAY'>checked="checked"</#if> >连住X晚起<span style="color:red;">——仅酒店商品可用</span>
			<div id="continuousDiv"  style="padding-left:20px;display: none;">
				请输入连住的晚数<input type="text" id="continuousNum" name="continuousNum" value="${promPromotion.ruleValue}" onchange="changRuleValue(this.value);" required>&nbsp;&nbsp;注，晚数必须>0
			</div>
			<br/>
			<input type="radio" name="ruleType" controlName="everyContinuous" value="PER_CONTINUITY_X_DAY" <#if promPromotion.ruleType == 'PER_CONTINUITY_X_DAY'>checked="checked"</#if> >每连住X晚起<span style="color:red;">——仅酒店商品可用</span>
			<div id="everyContinuousDiv"  style="padding-left:20px;display: none;">
				请输入每连住的晚数<input type="text" id="everyContinuousNum" name="everyContinuousNum" value="${promPromotion.ruleValue}" onchange="changRuleValue(this.value);" required>&nbsp;&nbsp;注，晚数必须>0
			</div>
         </div>
        <br/>
         <div id="resultDiv"  style="padding-left:30px;">
	         <div class="title">
				<h2 class="f16">优惠方案</h2>
			 </div>
			<input type="radio" name="resultType" controlName="abateAPrice" value="REDUCE_PRICE" <#if promResult.resultType == 'REDUCE_PRICE'>checked="checked"</#if> > 降价类优惠方案
			 <div id="abateAPriceDiv"  style="padding-left:20px;display: none;">
			 	<input type="hidden" id="hotelNights" name="hotelNights" value="${promResult.hotelNights}">
			 	<input type="radio" name="resultSecondType" value="PER_NIGHT"  controlName="perNight" <#if promResult.resultSecondType == 'PER_NIGHT'>checked="checked"</#if> >符合优惠条件的商品，每间晚优惠X
				<div id="perNightDiv" style="padding-left:20px;display: none;">
					<div id="perNightDiv_common">
					</div>
				</div>
				<br/>
				<input type="radio" name="resultSecondType" value="LAST_X_NIGHT" controlName="lastXNight" <#if promResult.resultSecondType == 'LAST_X_NIGHT'>checked="checked"</#if> >符合优惠条件的商品，最后X晚优惠Y
				<div id="lastXNightDiv" style="padding-left:20px;display: none;">
					最后几晚：<input type="text" id="lastXNight" name="lastHotelNights" value="${promResult.hotelNights}" onchange="changhotelNights(this.value);" required>&nbsp;&nbsp;注，晚数必须>0
					<div id="lastXNightDiv_common">
					</div>
				</div>
				<br/>
				<input type="radio" name="resultSecondType" value="FROM_X_NIGHT" controlName="fromXNight" <#if promResult.resultSecondType == 'FROM_X_NIGHT'>checked="checked"</#if> >符合优惠条件的商品，第X晚及以后优惠Y
				<div id="fromXNightDiv" style="padding-left:20px;display: none;">
					第几晚及以后：<input type="text" id="fromXNight" name="fromHotelNights" value="${promResult.hotelNights}"  onchange="changhotelNights(this.value);" required>&nbsp;&nbsp;注，晚数必须>0
					<div id="fromXNightDiv_common">
					</div>
				</div>
			 </div>
			 <br/>
		</div>
        <br/>
        <div class="p_box box_info clearfix mb20"  style="padding-left:30px;">
            <div class="fl operate"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
        </div>
</form>
<div id="resultDemo"  style="display: none;">
	优惠：<input type="radio" name="amountType" controlName="amountFixed" value="AMOUNT_FIXED" <#if promResult.amountType != 'AMOUNT_PERCENT'>checked="checked"</#if> >固定金额<input type="text" id="amountFixed" name="fixedAmountYuan" value="<#if promResult??&&promResult.fixedAmountYuan??>${promResult.fixedAmountYuan?string('#0.00')}</#if>"> <input type="radio" controlName="amountPercent" name="amountType" value="AMOUNT_PERCENT" <#if promResult.amountType == 'AMOUNT_PERCENT'>checked="checked"</#if> >百分比<input type="text" id="amountPercent" name="rateAmount" value="${promResult.rateAmount}">
	<br/>
	针对价格类型：<input type="radio" name="priceType" value="SUPPLIER_TYPE" <#if promResult.priceType != 'DISTRIBUTOR_TYPE'>checked="checked"</#if> >供应商价格 <input type="radio" name="priceType" value="DISTRIBUTOR_TYPE" <#if promResult.priceType == 'DISTRIBUTOR_TYPE'>checked="checked"</#if> >分销商销售价 
	<a href="javascript:void(0);" id="selectGoods" <#if promResult.priceType != 'DISTRIBUTOR_TYPE'> style="display: none;"</#if> onclick="selectDistributor();">选择分销商</a>
	<table id="distributorTb" class="p_table form-inline">
        <tbody>
        	<#list distributorList as distributor > 
					<tr>
					<td width='40'>
						<input type='hidden' name='distributorIds' value='${distributor.distributorId!''}' />
						<a href='javascript:void(0);'  onclick='removeTr(this);'>删除</a>
					</td>
					<td>${distributor.distributorName!''} </td>
					</tr>
			</#list>
        </tbody>
    </table>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	var promotionGoodsDialog;
	var selectDistributorDialog;
	$(document).ready(function(){
		var condition=$("input[type=radio][name=ruleType]:checked").attr("controlName");
		$("#"+condition+"Div").show();
		var resultParent=$("input[type=radio][name=resultType]:checked").attr("controlName");
		$("#"+resultParent+"Div").show();
		var abateAPrice=$("input[type=radio][name=resultSecondType]:checked").attr("controlName");
		$("#"+abateAPrice+"Div_common").html($("#resultDemo").html());
		$("#"+abateAPrice+"Div").show();
		$("input[type=radio][name=ruleType]").change(function(){
			$("input[type=radio][name=ruleType]").each(function(){
				var id=$(this).attr("controlName");
				if($(this).attr("checked")=="checked"){
	    			 $("#"+id+"Div").show();
		    	}else{
	    			 $("#"+id+"Div").hide();
		    	}
			});
			
			bindPriceTypeEveal();
		});
		
		$("input[type=radio][name=resultType]").change(function(){
			$("input[type=radio][name=resultType]").each(function(){
				var id=$(this).attr("controlName");
				if($(this).attr("checked")=="checked"){
	    			 $("#"+id+"Div").show();
		    	}else{
	    			 $("#"+id+"Div").hide();
		    	}
			});
			
			bindPriceTypeEveal();
		});
		
		$("input[type=radio][name=resultSecondType]").change(function(){
			$("input[type=radio][name=resultSecondType]").each(function(){
				var id=$(this).attr("controlName");
				if($(this).attr("checked")=="checked"){
	    			 $("#"+id+"Div_common").html($("#resultDemo").html());
	    			 $("#"+id+"Div").show();
		    	}else{
		    		 $("#"+id+"Div_common").html("");
	    			 $("#"+id+"Div").hide();
		    	}
			});
			bindPriceTypeEveal();
		});
		 
		function LockPageElement(){
			var promResultId=$("#promResultId",window.parent.document).val();
			if(promResultId!=""){
				$("input[type=radio]").each(function(){
					if($(this).attr("checked")=="checked"){
	    			 	$(this).removeAttr("disabled");
			    	}else{
			    		 $(this).attr("disabled","disabled");
			    	}
					
				});
				$("input[type=text]").each(function(){
					 $(this).attr("readonly","readonly");
				});
				//$("#save").css("display","none");
				//$("#saveAndNext").css("display","none");
			}
		}
		LockPageElement();
		
	});
	function bindPriceTypeEveal(){
		$("input[type=radio][name=priceType]").change(function(){
			var value=$("input[type=radio][name=priceType]:checked").val();
			 if(value=="DISTRIBUTOR_TYPE"){
	    			 $("#selectGoods").show();
		    	}else{
	    			 $("#selectGoods").hide();
		    	}
		});
	}
	$("#save").click(function(){
		
		//表单验证
		if(!checkParam()){
			return;
		}
		
		$.ajax({
				url : "/vst_back/prom/promotion/savePromResult.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
				 	if(!result.success){
				 		$.alert(result.message);
				 	}else{
					 	//为父窗口设置promResultId
						$("#promResultId",window.parent.document).val(result.attributes.promResultId);
						parent.refreshIframeMain("/vst_back/prom/promotion/showAddPreferentialSchemes.do?promPromotionId="+result.attributes.promPromotionId+"&promResultId="+result.attributes.promResultId);
				 	}
				}
			});
	});
	$("#saveAndNext").click(function(){
		
		//表单验证
		if(!checkParam()){
			return;
		}
		
		$.ajax({
				url : "/vst_back/prom/promotion/savePromResult.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
				 	if(!result.success){
				 		$.alert(result.message);
				 	}else{
					 	//为父窗口设置promResultId
						$("#promResultId",window.parent.document).val(result.attributes.promResultId);
						parent.refreshIframeMain("/vst_back/prom/promotion/showAddPromotionGoods.do?promPromotionId="+result.attributes.promPromotionId);
						//promotionGoodsDialog = new xDialog("/vst_back/prom/promotion/showAddPromotionGoods.do",{"promPromotionId":result.attributes.promPromotionId},{title:"添加促销商品",width:500,height:500});
						//preferentialSchemesDialog.close();
				 	}
				}
			});
	});
	
	function checkParam(){
		var conditionLength=$("input[type=radio][name=ruleType]:checked").length;
		if(conditionLength<=0){
			$.alert("请选择一种优惠条件");
	 		return false;
		}
		var condition=$("input[type=radio][name=ruleType]:checked").attr("controlName");
		$("#"+condition+"Day").show();
		var num=$("#"+condition+"Num").val();
		var integerReg = "^[0-9]*[1-9][0-9]*$";
		if(!num.match(integerReg)&&condition!="advance"){
			$.alert("请输入正确的优惠条件(数字大于0)");
	 		return false;
		}else if(!num.match("^\\d+$")&&condition=="advance"){
			$.alert("请输入正确的优惠条件(数字>=0)");
	 		return false;
		}
	 	
	 	var resultTypeLength=$("input[type=radio][name=resultType]:checked").length;
		if(resultTypeLength<=0){
			$.alert("请选择一种优惠方案");
	 		return false;
		}
		
		var resultSecondTypeLength=$("input[type=radio][name=resultSecondType]:checked").length;
		if(resultSecondTypeLength<=0){
			$.alert("请选择一种优惠方案");
	 		return false;
		}
		var secondType= $("input[type=radio][name=resultSecondType]:checked").attr("controlName");
		var secondTypeNum=$("#"+secondType).val();
	 	if((secondType=="lastXNight"||secondType=="fromXNight")
	 		&&(!secondTypeNum.match(integerReg)||(secondTypeNum>num&&condition!="advance"))){
	 		$.alert("请输入正确的晚数值(正整数且必须不大于连住的晚数)");
	 		return false;
	 	}
		
		var amountTypeLength=$("input[type=radio][name=amountType]:checked").length;
		if(amountTypeLength<=0){
			$.alert("请选择一种优惠(固定金额/百分比)");
	 		return false;
		}
		var amountType=$("input[type=radio][name=amountType]:checked").attr("controlName");
		var amountTypeNum=$("#"+amountType).val();
		var amountReg =/^[ + ] ?(0\.\d+) |([1-9][0-9]*(\.\d+)?)$/;
	 	if(!amountTypeNum.match(amountReg)){
	 		$.alert("请输入正确固定金额/百分比(值大于0)");
	 		return false;
	 	}
		var priceTypeLength=$("input[type=radio][name=priceType]:checked").length;
		if(amountTypeLength<=0){
			$.alert("请选择一种针对价格类型(供应商/分销商)");
	 		return false;
		}
		return true;
	}
	
	function changRuleValue(obj){
		$("input[type=hidden][name=ruleValue]").val(obj);
	}
	function changhotelNights(obj){
		$("input[type=hidden][name=hotelNights]").val(obj);
	}
	
	//选择分销商
	function selectDistributor(){
			$.ajax({
						type: "POST",
						url: "/vst_back/dist/distributor/selectDistributor.do",
						success: function (data) {
							$.dialog({
				                width: 500,
				                title: "选择分销商",
				                content: data,
				                ok: function(){
				                	$("input[type=checkbox][name=distributorCk]:checked").each(function(){
										var id=$(this).val();
										var name=$(this).attr("showName");
										var flagContent= true;
										 $("#distributorTb input[type=hidden][name=distributorIds]").each(function(){
										 	 if($(this).val()==id){
										 	 	flagContent=false
										 	 	return false;
										 	 }
										 });
										 if(flagContent){
										 	$("#distributorTb tbody").append("<tr><td width='40'><input type='hidden' name='distributorIds' value='"+id+"' /><a href='javascript:void(0);'  onclick='removeTr(this);'>删除</a></td><td>"+name+"</td></tr>");
										 }
									});
				                },
				                cancel: true,
				                okValue: "确认",
				                cancelValue: "返回"
				            });
						}
					});
	}
	/**
	 * 移除一行
	 **/
	function removeTr(obj){
		if(confirm('是否确认删除分销商？若删除会去除该分销商已经关联的商品'))
		$(obj).parent().parent().remove();
	}
</script>
