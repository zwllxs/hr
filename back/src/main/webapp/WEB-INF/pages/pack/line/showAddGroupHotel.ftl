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
		                    	 <select name="categoryId" id="categoryId" readonly = "true">
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
					                    <option value="NODATERANGESELECT" selected>区间日期，不可选</option>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组可添加产品数量限制</td>
		                    <td style="text-align: left;">
		                    	<select name="selectType" id="selectType" readonly = "true">
					                    <option value="NOLIMIT" selected>无限制</option>
							  	</select>
		                    </td>
		                </tr>           	
	            </table>
            </div>
            
            <div class="box_content">
	            	<table class="e_table form-inline">
		             		<tbody>
		             			 <tr >
			             			<td class="e_label" style="text-align: left;"><i class="cc1">*</i>入住时间选择：</td>
			             			<td style="text-align: left;">
			             				<input type="hidden"  name="prodPackageGroupHotel.stayDays" id="stayDays"  />
				                    		第<input type="text" class="w35" style="width:30px" name="startDay" id="startDay" number="true" required=true />
				                    		晚 —— 第
				                    		<input type="text" class="w35" style="width:30px" name="endDay" id="endDay" number="true" required=true />
				                    		晚
				                    	<div id="stayDaysError"></div>
				                    </td>	
			                   </tr>
			                    <tr>
			             			<td colspan="2" class="e_label" style="text-align: left;">备注信息，(注，用途，业务后台备忘录该组的一些特征使用，eg三亚的酒店)</td>
			             		</tr>
			             		<tr>
			             			<td colspan="2" style="text-align: left;">
				                    	<label>
				                    		<textarea class="w35 textWidth"  name="prodPackageGroupHotel.remark" id="remark" maxlength="25" style="width:500px; height:80px"></textarea>
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
	
	 //验证
	if(!$("#dataForm").validate({
		rules : {},
		messages : {}
	}).form()){
		return;
	}
	
	//填充入住时间
	var startDay = $("#startDay").val();
	var endDay = $("#endDay").val();
	if(startDay != null && endDay != null){
		var start = parseInt(startDay);
		var end = parseInt(endDay);
		if(start < 1 || end < 1 ){
			$.alert("输入入住晚数非法");
			return;
		}
		
		if(start > end){
			$.alert("入住截止时间不能大于入住时间");
			return;
		}
		
		var stayNum = '${stayNum }';
		if(end > parseInt(stayNum)){
			$.alert("输入入住晚数不能大于产品入住晚数");
			return;
		}
	}
	
	var stayDays = "";
	if(startDay != null && endDay != null){
		for(var index = parseInt(startDay);index <= parseInt(endDay); index++){
			stayDays += index + ",";
		}
	}
	$("#stayDays").val(stayDays.substring(0,stayDays.length - 1));
	
	var loading = top.pandora.loading("正在努力保存中...");
	//设置附加属性的值
	$.ajax({
		url : "/vst_back/productPack/line/addGroup.do",
		type : "post",
		dataType : 'json',
		data : $("#dataForm").serialize(),
		success : function(result) {
			loading.close();
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
		error : function(result) {
			loading.close();
			$.alert(result.message);
		}
	}); 
});
</script>