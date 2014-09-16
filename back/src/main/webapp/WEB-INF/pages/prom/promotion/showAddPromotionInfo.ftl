<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li>促销&gt;</li>
            <li class="active">促销维护 &gt;</li>
            <li class="active">基本信息</li>
        </ul>
</div>
<form action="/vst_back/prom/promotion/savePromotionInfo.do" method="post" id="dataForm">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label" style="width:120px;">促销编号：</td>
                	<td >
                		<input type="hidden" name="promPromotionId" value="${promPromotion.promPromotionId}">
                		${promPromotion.promPromotionId}
                	</td>
                </tr>
				<tr>
                	<td class="p_label" style="width:120px;" >促销名称[<i class="cc1">*</i>]：</td>
                    <td >
                    	<input type="text" name="title" value="${promPromotion.title}" <#if promPromotion?? && promPromotion.promPromotionId??>readonly="readonly"</#if> required>
                    	&nbsp;&nbsp;&nbsp;<span style="color:#999999;">促销名称，在前后台均会呈现</span>
                    </td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" >供应商CODE：</td>
                    <td >
                    	<input type="text" name="code" readonly="readonly" value="${promPromotion.code}">
                    </td>
                </tr>
               	<tr>
					<td class="p_label" style="width:120px;" <#if promPromotion?? && promPromotion.promPromotionId??>readonly="readonly"</#if> >是否排它[<i class="cc1">*</i>]：</td>
					<td >
						<select name="exclusive" <#if promPromotion?? && promPromotion.promPromotionId??>disabled="disabled"</#if> required>
            	 			<option value="Y" <#if promPromotion?? && promPromotion.exclusive=='Y'>selected</#if>>是</option>
	                    	<#--<option value="N" <#if promPromotion?? && promPromotion.exclusive=='N'>selected</#if>>否</option>-->
			        	</select>&nbsp;&nbsp;&nbsp;<span style="color:#999999;">即，用户是否可以同时与其他促销共享</span>
                   	</td>
                </tr>
                <tr>
                	<td class="p_label" style="width:120px;" >时间类型[<i class="cc1">*</i>]：</td>
                    <td >
                    	<select name="timeType" <#if promPromotion?? && promPromotion.promPromotionId??>disabled="disabled"</#if> required>
            	 			<option value="TIME_VISIT_DATE" <#if promPromotion?? && promPromotion.timeType=='TIME_VISIT_DATE'>selected</#if>>入住/游玩日期</option>
	                    	<option value="TIME_AT_HOTEL" <#if promPromotion?? && promPromotion.timeType=='TIME_AT_HOTEL'>selected</#if>>在店日期</option>
			        	</select>
						<div style="color:red;">
						（注，入住/游玩时间，代表购买的产品只要在该时间范围里面，即有可能享受优惠）
							<br/>
						（注，在店时间，仅酒店类使用，代表购买的酒店只要在店时间任何一天符合要求，即有可能享受优惠）
						</div>
                    </td>
                </tr>
                <tr>
					<td class="p_label" style="width:120px;">开始时间[<i class="cc1">*</i>]：</td>
					<td >
						 <input type="text" name="beginTime" value="<#if promPromotion?? && promPromotion.beginTime??>${promPromotion.beginTime?string('yyyy-MM-dd')}</#if>" errorEle="selectDate" class="W8 Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" />
                    </td>
                </tr>
                <tr>
					<td class="p_label" style="width:120px;">结束时间[<i class="cc1">*</i>]：</td>
					<td >
						 <input type="text" name="endTime" value="<#if promPromotion?? && promPromotion.endTime??>${promPromotion.endTime?string('yyyy-MM-dd')}</#if>" errorEle="selectDate" class="W8 Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" />
                    </td>
                </tr> 
            </tbody>
        </table>
        <br/>
        <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
            <div class="fl operate"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
        </div>
</form>
<#include "/base/foot.ftl"/>
</body>
</html>
<script> 
	var preferentialSchemesDialog;
	$("#save").click(function(){
		var title=$("input[type=text][name=title]").val();
		if($.trim(title)==""){
			$.alert("请输入促销名称");
			return false;
		}
		var beginTime=$("input[type=text][name=beginTime]").val();
		if($.trim(beginTime)==""){
			$.alert("请输入开始时间");
			return;
		}
		var endTime=$("input[type=text][name=endTime]").val();
		if($.trim(endTime)==""){
			$.alert("请输入结束时间");
			return;
		}
		$.ajax({
				url : "/vst_back/prom/promotion/savePromotionInfo.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					if(!result.success){
				 		$.alert(result.message);
				 	}else{
					 	//为子窗口设置promPromotionId
						$("input[name='promPromotionId']").val(result.attributes.promPromotionId);
						//为父窗口设置promPromotionId
						$("#promPromotionId",window.parent.document).val(result.attributes.promPromotionId);
						$("#title",window.parent.document).val(result.attributes.title);
						parent.checkAndJump();
						//promotionInfoDialog.close();
				 	}
					
				}
			});
	});
	$("#saveAndNext").click(function(){
		var title=$("input[type=text][name=title]").val();
		if($.trim(title)==""){
			$.alert("请输入促销名称");
			return false;
		}
		var beginTime=$("input[type=text][name=beginTime]").val();
		if($.trim(beginTime)==""){
			$.alert("请输入开始时间");
			return;
		}
		var endTime=$("input[type=text][name=endTime]").val();
		if($.trim(endTime)==""){
			$.alert("请输入结束时间");
			return;
		}
		$.ajax({
				url : "/vst_back/prom/promotion/savePromotionInfo.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					if(!result.success){
				 		$.alert(result.message);
				 	}else{
					 	//为子窗口设置promPromotionId
						$("input[name='promPromotionId']").val(result.attributes.promPromotionId);
						//为父窗口设置promPromotionId
						$("#promPromotionId",window.parent.document).val(result.attributes.promPromotionId);
						$("#title",window.parent.document).val(result.attributes.title);
						$(".pg_title").html("维护，促销编号("+result.attributes.promPromotionId+"),促销名称："+result.attributes.title);
						//preferentialSchemesDialog = new xDialog("/vst_back/prom/promotion/showAddPreferentialSchemes.do",{"promPromotionId":result.attributes.promPromotionId},{title:"添加优惠方案",width:600,height:600});
						parent.refreshIframeMain("/vst_back/prom/promotion/showAddPreferentialSchemes.do?promPromotionId="+result.attributes.promPromotionId)
						//promotionInfoDialog.close();
				 	}
				}
			});
	});
</script>
