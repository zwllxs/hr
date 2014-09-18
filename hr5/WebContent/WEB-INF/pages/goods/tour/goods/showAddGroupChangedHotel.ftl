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
       		<input type="hidden"  name="categoryId" id="categoryId"  value="${selectCategoryId }"/>
       		<input type="hidden"  name="selectCategoryId" id="selectCategoryId"  value="${selectCategoryId }"/>
            <div class="box_content">
            	<table class="e_table form-inline">
             		<tbody>
	             		<tr>
	             			<td class="e_label" style="text-align: left; width: 150px">注：此处的时间，仅是说明，不将日期加入计算</td>
	             		</tr>
             			 <tr >
	             			<td style="text-align: left;">
	             				<input type="hidden"  name="prodPackageGroupHotel.stayDays" id="stayDays"  />
		                    		第<input type="text" class="w35" style="width:30px" name="stayDay" id="startDay" number="true" required=true />
		                    		晚 —— 第
		                    		<input type="text" class="w35" style="width:30px" name="stayDay" id="endDay" number="true" required=true />
		                    		晚
		                    	<div id="stayDayError"></div>
		                    </td>	
	                   </tr>
             		</tbody>
	             </table>
            </div>
            </form>
        </div>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">确认</a></div>
        </div>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>

<script>

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