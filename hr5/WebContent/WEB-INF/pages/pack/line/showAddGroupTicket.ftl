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
					                    <option value="DATERANGESELECT" selected>区间日期，可选</option>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组可添加产品数量限制</td>
		                    <td style="text-align: left;">
		                    	<select name="selectType" id="selectType" readonly = "true">
					                    <option value="NOLIMIT" >无限制</option>
							  	</select>
		                    </td>
		                </tr>           	
	            </table>
            </div>
            
            <div class="box_content">
	            	<table class="e_table form-inline">
		             		<tbody>
		             			 <tr >
		             			 	<input type="hidden"  name="prodPackageGroupTicket.startDay" id="startDay"  />
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>出游时间选择：</td>
			             			<td style="text-align: left;" id="startDayTD">
			             				第
				                    </td>	
				                   </td>
			                   </tr>
			                    <tr>
			             			<td colspan="2" class="e_label" style="text-align: left;">备注信息，(注，用途，业务后台备忘录该组的一些特征使用，eg三亚的酒店)</td>
			             		</tr>
			             		<tr>
			             			<td colspan="2" style="text-align: left;">
				                    	<label>
				                    		<textarea class="w35 textWidth"  name="prodPackageGroupTicket.remark" id="remark" maxlength="25" style="width:500px; height:80px"></textarea>
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
	var routeNum = "${routeNum}";
	if(routeNum != null && routeNum != ''){
		for(var index = 0 ; index < parseInt(routeNum); index ++){
			$("#startDayTD").append("&nbsp;&nbsp;<input type='checkbox' class='w35' style='width:30px' required='true' name='startDayTD' value='" + (index + 1)+ "' />" + (index + 1));
		}
		$("#startDayTD").append("&nbsp;&nbsp;天<div class='e_error' id='startDayTDError'/>");
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
	
	var startDays = '';
	$('input[name="startDayTD"]:checked').each(function(index,obj){
		if($(obj).val() != ''){
			startDays += $(obj).val() + ',';
		}
	});
	
	if(startDays != null && startDays.length > 0){
		$("#startDay").val(startDays.substring(0,startDays.length - 1));
	}
	
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
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown,exc) {
		}
	})
});
</script>