<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">大交通</a> &gt;</li>
            <li><a href="#">航班/车次/班次信息</a> &gt;</li>
            <li class="active">信息维护</li>
        </ul>
</div>
<input type="hidden" id="prodProductId" value="${prodProductId}">
<div class="fl operate" style="margin-left:20px;margin-bottom:10px;"><a class="btn btn_cc1" id="new_button">添加火车</a></div>
<div class="iframe_content mt10">
 <!-- 主要内容显示区域\\ -->        
        <div class="p_box box_info">
            <table class="p_table table_center">
                <thead>
                    <tr>
                    	<th>类型</th>
                        <th>车次号</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                		<#if group?? &&group.prodTrafficTrainList?? && group.prodTrafficTrainList?size &gt; 0>
                		<#list group.prodTrafficTrainList as prodTrafficTrain>
						<tr>
							<td><#if prodTrafficTrain.tripType=='TO'>去程</#if><#if prodTrafficTrain.tripType=='BACK'>返程</#if></td>
							<td>
										<a href="javascript:void(0);" data="${prodTrafficTrain.trainNo}" class="trainInfo">${prodTrafficTrain.trainNo}</a>
						  </td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp" trainId='${prodTrafficTrain.trainId}' >编辑</a>
		                 	</td>
						</tr>
						</#list>
						 <#else>
						<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td></tr>
						</#if>
		    	</tbody>
            </table>
        </div>
 </div>
<!-- //主要内容显示区域 -->
<div name="template_train_wrapper" style="display:none">
	<div name="template_train" type="TRAIN" class="template" data="" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
		<input type="hidden" name="isFill">
		<input type="hidden" name="startStation">
		<input type="hidden" name="arriveStation">
		<table class="e_table form-inline" style="width:500px">
			<tr>
				<td class="e_label">始发站：</td>
				<td><input type="text" name="startStationName"></td>
				<td class="e_label">发车时间：</td>
				<td><input type="text" name="startStationTime"></td>
	        </tr>
	        <tr>
				<td class="e_label">到达站：</td>
				<td><input type="text" name="arriveStationName"></td>
				<td class="e_label">到站时间：</td>
				<td><input type="text" name="arriveStationTime"></td>
	        </tr>
	        <tr>
				<td class="e_label">行驶时长：</td>
				<td><input type="text" name="allTime"></td>
				<td class="e_label">车型：</td>
				<td><input type="text" name="trainType"></td>
	        </tr>
	        <tr>
	        	<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
				<td></td>
				<td class="e_label"></td>
				<td></td>
	        </tr>
		</table>
	</div>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var showAddTrafficTrainDetailDialog;
var showUpdateTrafficTrainDetailDialog;
  $("#new_button").click(function(){
			showAddTrafficTrainDetailDialog = new xDialog("/vst_back/prod/traffic/showAddTrafficTrainDetail.do",{productId:$("#prodProductId").val()},{title:"新增车次",width:400});	
	});
	
	$(".editProp").click(function(){
		var trainId = $(this).attr("trainId");
		showUpdateTrafficTrainDetailDialog = new xDialog("/vst_back/prod/traffic/showUpdateTrafficTrainDetail.do",{productId:$("#prodProductId").val(),"trainId":trainId},{title:"修改车次",width:400});	
	});
	
	$(".trainInfo").live("click",function(){
	   var data = $(this).attr("data");
		<#---获得父对象--->
		var parentObj = $("div[name=template_train_wrapper]");
		var trainNo = data;
		var startStation = parentObj.find("input[name=startStation]").val();
		var arriveStation = parentObj.find("input[name=arriveStation]").val();
		fillTrain(trainNo,startStation,arriveStation,function(res){
			console.debug(res);
			if(res==null || res==''){
				$.alert('无该班次,请重新查询');
				return;
			}
			parentObj.find("input[name=isFill]").val("T");
			parentObj.find("input[name=startStationName]").val(res.startTrainStop.stopStationString);
			parentObj.find("input[name=startStationTime]").val(res.startTrainStop.departureTime);
			parentObj.find("input[name=arriveStationName]").val(res.arriveTrainStop.stopStationString);
			parentObj.find("input[name=arriveStationTime]").val(res.startTrainStop.departureTime);
			parentObj.find("input[name=allTime]").val(res.costTimeString);
			parentObj.find("input[name=trainType]").val(res.trainTypeString);
			new xDialog(parentObj.html(),{},{title:"车次",width:400});
		});
	});
	
   function fillTrain(trainNo,startStation,arriveStation,fillData){
		var trainLoading;
		if(trainNo==''||trainNo==null){
			$.alert("请输入车次");
			return;
		}
		trainLoading = $.loading("正在查询车次信息");
		$.ajax({
				url : "/vst_back/prod/traffic/findTrain.do",
				type : "post",
				data : {"trainNo":trainNo,"startStation":startStation,"arriveStation":arriveStation},
				success : function(result) {
					fillData(result);
					trainLoading.close();
				},
				error : function(result) {
					trainLoading.close();
				}
		 });
	} 
</script>
