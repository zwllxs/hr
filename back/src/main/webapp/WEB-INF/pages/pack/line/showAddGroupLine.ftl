<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="/vst_back/css/calendar.css" type="text/css"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</head>

<body>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>插入时间段</div>
       <div class="p_box box_info p_line">
       <form action="/vst_back/productPack/line/addGroup.do" method="post" id="dataForm">
       		<input type="hidden"  name="productId" id="productId"  value="${productId }"/>
       		<input type="hidden"  name="groupType" id="groupType"  value="${groupType }"/>
       		<input type="hidden"  name="selectCategoryId" id="selectCategoryId"  value="${selectCategoryId }"/>
       		
            <div class="box_content">
	            <table class="e_table form-inline" >
					   <tr >
		                	<td class="e_label" style="text-align: left;">产品品类</td>
		                    <td style="text-align: left;">
		                    	<select name="categoryId" id="categoryId"  readonly = "true">
								  	<#list bizCategoryList as list>
								  		<#if selectCategoryId == list.categoryId>
					                    	<option value="${list.categoryId}" selected>${list.categoryName}</option>
					                    </#if>
								  	</#list>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组时间限制</td>
		                    <td style="text-align: left;">
		                    	<select name="dateType" id="dateType" readonly = "true">
		                    			<#if selectCategoryId == '16'>
		                    				<option value="DATERANGESELECT" selected>区间日期，可选</option>
		                    			<#else>
		                    				<option value="NODATESELECT" selected>指定日期，不可选</option>
		                    			</#if>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组可添加产品数量限制</td>
		                    <td style="text-align: left;">
		                    	<select name="selectType" id="selectType" readonly = "true">
		                    		<#if selectCategoryId == '15' || selectCategoryId == '18'>
		                    			<option value="ONE" selected>只能添加一个产品</option>
		                    		<#else>
		                    			 <option value="NOLIMIT" selected>无限制</option>
		                    		</#if>
							  	</select>
		                    </td>
		                </tr>           	
	            </table>
            </div>
            
            <div class="box_content">
	            	<table class="e_table form-inline">
		             		<tbody>
		             			 <tr >
		             			 	<input type="hidden"  name="prodPackageGroupLine.startDay" id="lineStartDay" />
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>出游时间选择：</td>
			             			<td style="text-align: left;" id="travleTimeTD" >
			             				第
				                   </td>
			                   </tr>
			                    <tr>
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>行程天数：</td>
			             			<td style="text-align: left;" id="travelDaysTD">
			             				<select id="travelDays" name="prodPackageGroupLine.travelDays" required='true' ></select>
				                    </td><div id="travelDaysTDError"></div>
			             		</tr>
			             		 <tr>
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>入住晚数：</td>
			             			<td style="text-align: left;" id="stayDaysTD" required='true' >
			             				<select id="stayDays" name="prodPackageGroupLine.stayDays"></select>
				                    </td><div id="stayDaysTDError"></div>
			             		</tr>
			             		 <tr id="hotelComb1" style="display: none">
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>成人数：</td>
			             			<td style="text-align: left;" id="adultTD">
			             				<select id="adult" name="prodPackageGroupLine.adult" required='true' ></select>
				                    </td><div id="adultTDError"></div>
			             		</tr>
			             		 <tr id="hotelComb2" style="display: none">
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>儿童数：</td>
			             			<td style="text-align: left;" id="childTD">
			             				<select id="child" name="prodPackageGroupLine.child" required='true' ></select>
				                    </td><div id="childTDError"></div>
			             		</tr>
			             		<tr>
			             			<td colspan="2" class="e_label" style="text-align: left;">备注信息，(注，用途，业务后台备忘录该组的一些特征使用，eg三亚的酒店)</td>
			             		</tr>
			             		<tr>
			             			<td colspan="2" style="text-align: left;">
				                    	<label>
				                    		<textarea class="w35 textWidth"  name="prodPackageGroupLine.remark" id="remark" maxlength="25" style="width:500px; height:80px"></textarea>
				                    	</label>
				                    </td>	
			                   </tr>
		             		</tbody>
		             	</table>
            </div>
            </form>
        </div>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">确认并保存</a></div>
        </div>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
$(function(){
	var selectCategoryId = $("#selectCategoryId").val();
	//当地游
	if(selectCategoryId == '16'){
		//入住晚数
		$("#stayDays").append("<option value='0>0</option>");
	}
	
	var routeNum = "${routeNum}";
	if(routeNum != null && routeNum != ''){
		for(var index = 0 ; index < parseInt(routeNum); index ++){
			if(selectCategoryId == '16'){
				$("#travleTimeTD").append("<input type='checkbox' class='w35' style='width:30px' required='true' name='travleTime' value='" + (index + 1)+ "' />" + (index + 1));
			}else{
				$("#travleTimeTD").append("<input type='radio' class='w35' style='width:30px' required='true' name='travleTime' value='" + (index + 1)+ "' />" + (index + 1));				
			}
			
			//添加行程天数
			$("#travelDays").append("<option value='" + (index + 1) + "'>" + (index + 1) + "</option>");
			
		}
		$("#travleTimeTD").append("&nbsp;&nbsp;天<div class='e_error' id='travleTimeError'/>");
	}
	
	var stayNum = "${stayNum}";
	if(stayNum != null && stayNum != ''){
		if(selectCategoryId != '16'){
			for(var index = 0 ; index < parseInt(stayNum) + 1; index ++){
				//入住晚数
				$("#stayDays").append("<option value='" + index + "'>" + index + "</option>");
			}
		}else{
			//入住晚数
			$("#stayDays").append("<option value='0'>0</option>");
		}
	}
	
	if(selectCategoryId == '17'){
		for(var index = 0 ; index < 41;index ++){
			$("#adult").append("<option value='" + index + "'>" + index + "</option>");
			$("#child").append("<option value='" + index + "'>" + index + "</option>");
		}
		
		/* $("#hotelComb1").css("display", "");
		$("#hotelComb2").css("display", ""); */
		$("#hotelComb1").show();
		$("#hotelComb2").show();
	}
	
	$(".textWidth[maxlength]").each(function(){
		var	maxlen = $(this).attr("maxlength");
		if(maxlen != null && maxlen != ''){
			var l = maxlen*12;
			if(l >= 700) {
				l = 700;
			} else if (l <= 200){
				l = 200;
			} else {
				l = 400;
			}
			$(this).width(l);
		}
		$(this).keyup(function() {
			vst_util.countLenth($(this));
		});
	});
	
});

$("#save").bind("click",function(){
	
	 var lineStartDay = '';
	 $('input[name="travleTime"]:checked').each(function(){
		  lineStartDay += $(this).val()+',';
	 }); 
	 
	 if(lineStartDay != null){
		 lineStartDay = lineStartDay.substring(0,lineStartDay.length - 1);
	 }
	  
	$("#lineStartDay").val(lineStartDay);
	
	 //验证
	if(!$("#dataForm").validate({
		rules : {},
		messages : {}
	}).form()){
		return;
	}
	
	$.ajax({
		url : "/vst_back/productPack/line/addGroup.do",
		type : "post",
		dataType : 'json',
		async: false,
		data : $("#dataForm").serialize(),
		success : function(result) {
			if(result.code == "success"){
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
					var packGroup = {};
					packGroup.groupId = result.attributes.groupId;
					packGroup.groupType = result.attributes.groupType;
					packGroup.selectCategoryId = $("#selectCategoryId").val();
					parent.onSavePackGroup(packGroup);
				}});
			}else if(result.code == "error"){
				$.alert(result.message);
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown,exc) {
		}
	})
	
});
</script>