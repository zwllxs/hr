<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">线路</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">交通信息维护</li>
        </ul>
</div>
<div class="iframe_content mt10">
        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15"></p>
        </div>
        <div class="p_box box_info">
		<form action="/vst_back/prod/traffic/updateProdTraffic.do" method="post" id="dataForm">
		<input type="hidden" id="productId" name="productId" value="${productId!''}">
		<input type="hidden" id="trafficId" name="trafficId" value="<#if prodTraffic??>${prodTraffic.trafficId!''}</#if>">
        <table class="e_table form-inline" style="width:700px">
            <tbody>
            	<tr>
					<td class="e_label" width="200px"><i class="cc1">*</i>去程交通：</td>
					<td width="500px">
						<select id="toType" name="toType" class="w10" <#if prodTraffic??>disabled=disabled</#if> >
						<#list trafficTypeList as list>
		                      <option value=${list.code!''} <#if prodTraffic?? && prodTraffic.toType==list.code>selected=selected</#if> >${list.cnName!''}</option>
                        </#list>
						</select>
                    </td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>返程交通：</td>
					<td>
						<select id="backType" name="backType" class="w10" <#if prodTraffic??>disabled=disabled</#if> >
						<#list trafficTypeList as list>
		                      <option value=${list.code!''}  <#if prodTraffic?? && prodTraffic.backType==list.code>selected=selected</#if>  >${list.cnName!''}</option>
                        </#list>
						</select>
                    </td>
                </tr>
                <tr <#if prodTraffic==null || (prodTraffic?? && prodTraffic.backType!='BUS') >style="display:none"</#if> id="chooseFlag">
					<td class="e_label"><i class="cc1">*</i>巴士去程上车点是否下单可选：</td>
					<td>
						<input type="radio" name="chooseFlag" value="Y" checked=checeked  <#if prodTraffic?? && prodTraffic.chooseFlag=='Y'>checked=checeked</#if> >是
						<input type="radio" name="chooseFlag" value="N"  <#if prodTraffic?? && prodTraffic.chooseFlag=='N'>checked=checeked</#if> >否
						<i class="cc1">（注，下单可选，则用户下单可选上车点，并自动填充到订单备注）</i>
                    </td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>是否是参考信息：</td>
					<td>
						<input type="radio" name="referFlag" value="Y" checked=checeked <#if prodTraffic?? && prodTraffic.referFlag=='Y'>checked=checeked</#if> >是
						<input type="radio" name="referFlag" value="N" <#if prodTraffic?? && prodTraffic.referFlag=='N'>checked=checeked</#if> >否
						<i class="cc1">（注，参考信息，则前台会有对应的说明）</i>
                    </td>
                </tr>
                <tr>
                    <td class="e_label"><div class="fr operate"><a class="btn btn_cc1" id="save_button">保存</a></div></td>
                    <td><i class="cc1">（注，保存后不能修改）</i></td>
                </tr>
            </tbody>
        </table>
	</form>
</div>
<div id="trafficDiv">
	<div class="fl operate"><a class="btn btn_cc1" id="add_button">添加交通信息</a><a class="btn btn_cc1" href="/vst_back/biz/flight/findFlightList.do" target="_blank">维护航班</a><a class="btn btn_cc1" href="/vst_back/biz/train/findTrainList.do" target="_blank">维护火车</a></div>
	<div style="clear:both"></div>
	<div id="trafficContentDiv" style="width:700px;">
		<#if prodTrafficGroupList?? && prodTrafficGroupList?size &gt; 0 >
			<#assign index = 0/>
			<#if prodTraffic?? && prodTraffic.toType=='FLIGHT'>
				<#assign to_traffic_name = '飞机'/>
			</#if>
			<#if prodTraffic?? && prodTraffic.toType=='TRAIN'>
				<#assign to_traffic_name = '火车'/>
			</#if>
			<#if prodTraffic?? && prodTraffic.toType=='BUS'>
				<#assign to_traffic_name = '汽车'/>
			</#if>
			<#if prodTraffic?? && prodTraffic.backType=='FLIGHT'>
				<#assign back_traffic_name = '飞机'/>
			</#if>
			<#if prodTraffic?? && prodTraffic.backType=='TRAIN'>
				<#assign back_traffic_name = '火车'/>
			</#if>
			<#if prodTraffic?? && prodTraffic.backType=='BUS'>
				<#assign back_traffic_name = '汽车'/>
			</#if>
			<#list prodTrafficGroupList as ptg>
				<#assign index = index + 1/>
				<div name="template_traffic" type="TRAFFIC" class="template" data="${ptg.groupId}" style="border:1px solid #cccccc;padding:20px;margin-top:20px;">
				<div name="head" style="height:30px;margin-bottom:10px;">
					<span style="font-size:15px;font-weight:900">交通信息${index}</span>
					<span class="fr operate"><a class="btn btn_cc1" name="delete_traffic">删除交通信息</a></span>
				</div>
				<div name="to" style="padding-bottom:10px;border-bottom:1px solid #cccccc" class="to">
					<div name="head" style="height:30px;margin-bottom:10px;">
						<span style="font-size:12px;font-weight:900">去程${to_traffic_name}</span>
						<div class="fr operate"><a class="btn btn_cc1" name="to_transfer">添加中转${to_traffic_name}</a></div>
					</div>
					<div name="content">
						<#---创建去程信息--->
						<#if ptg??>
							<#---创建去程飞机--->
							<#if ptg?? && ptg.prodTrafficFlightList?size &gt; 0>
								<#list ptg.prodTrafficFlightList as flight>
									<#if flight.tripType == 'TO'>
										<div name="template_flight" type="FLIGHT" class="template"  data="${flight.flightId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<input type="hidden" name="isFill" value="T">
											<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>航班号:<input type="text" name="flightNo" value="${flight.flightNo}"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_flight">补全</a></span> </div>
											<table class="e_table form-inline" style="width:500px">
												<tr>
													<td class="e_label">始发地：</td>
													<td><input type="text" name="startDistrict"></td>
													<td class="e_label">目的地：</td>
													<td><input type="text" name="arriveDistrict"></td>
										        </tr>
										        <tr>
													<td class="e_label">起飞机场：</td>
													<td><input type="text" name="startAirport"></td>
													<td class="e_label">起飞时间：</td>
													<td><input type="text" name="startTime"></td>
										        </tr>
										        <tr>
													<td class="e_label">降落机场：</td>
													<td><input type="text" name="arriveAirport"></td>
													<td class="e_label">降落时间：</td>
													<td><input type="text" name="arriveTime"></td>
										        </tr>
										        <tr>
													<td class="e_label">飞行时长：</td>
													<td><input type="text" name="flightTime"></td>
													<td class="e_label">机型：</td>
													<td><input type="text" name="airplaneString"></td>
										        </tr>
										        <tr>
													<td class="e_label">经停：<input type="checkbox"></td>
													<td></td>
													<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
													<td></td>
										        </tr>
											</table>
										</div>
									</#if>
								</#list>
							</#if>
							<#---创建去程火车--->
							<#if ptg?? && ptg.prodTrafficTrainList?size &gt; 0>
								<#list ptg.prodTrafficTrainList as train>
									<#if train.tripType == 'TO'>
										<div name="template_train" type="TRAIN" class="template"  data="${train.trainId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<input type="hidden" name="startStation" value="${train.startDistrict}">
											<input type="hidden" name="arriveStation" value="${train.endDistrict}">
											<input type="hidden" name="isFill" value="T">
											<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>车次:<input type="text" name="trainNo" value="${train.trainNo}" style="width:80px;margin-right:10px;"><i class="cc1">*</i>始发地:<input type="text" name="startStationSearch" value="${train.startDistrictString}" style="width:80px;margin-right:10px;"><i class="cc1">*</i>目的地:<input type="text" name="arriveStationSearch" style="width:80px;" value="${train.endDistrictString}"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_train">补全</a></span></div>
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
									</#if>
								</#list>
							</#if>
							<#---创建去程客车--->
							<#if ptg?? && ptg.prodTrafficBusList?size &gt; 0>
								<#list ptg.prodTrafficBusList as bus>
									<#if bus.tripType == 'TO'>
										<div name="template_bus" type="BUS" class="template" data="${bus.busId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<table class="e_table form-inline" style="width:500px">
												<tr>
													<td class="e_label"><i class="cc1">*</i>上车点：</td>
													<td><input type="text" name="adress" value="${bus.adress}"></td>
													<td class="e_label"><i class="cc1">*</i>发车时间：</td>
													<td><input type="text" name="startTime" value="${bus.startTime}"></td>
										        </tr>
										        <tr>
													<td class="e_label">备注：</td>
													<td colspan="3"><input type="text" name="memo" style="width:405px;" value="${bus.memo}"></td>
										        </tr>
										        <tr>
										        	<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
													<td></td>
													<td class="e_label"></td>
													<td></td>
										        </tr>
											</table>
										</div>
									</#if>
								</#list>
							</#if>
						</#if>
					</div>
				</div>
				<div name="back" style="margin-top:20px;" class="back">
					<div name="head" style="height:30px;margin-bottom:10px;">
						<span style="font-size:12px;font-weight:900">返程${back_traffic_name}</span>
						<div class="fr operate"><a class="btn btn_cc1" name="back_transfer">添加中转${back_traffic_name}</a></div>
					</div>
					<div name="content">
						<#---创建返程信息--->
						<#if ptg??>
							<#---创建返程飞机--->
							<#if ptg?? && ptg.prodTrafficFlightList?size &gt; 0>
								<#list ptg.prodTrafficFlightList as flight>
									<#if flight.tripType == 'BACK'>
										<div name="template_flight" type="FLIGHT" class="template"  data="${flight.flightId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<input type="hidden" name="isFill" value="T">
											<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>航班号:<input type="text" name="flightNo" value="${flight.flightNo}"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_flight">补全</a></span> </div>
											<table class="e_table form-inline" style="width:500px">
												<tr>
													<td class="e_label">始发地：</td>
													<td><input type="text" name="startDistrict"></td>
													<td class="e_label">目的地：</td>
													<td><input type="text" name="arriveDistrict"></td>
										        </tr>
										        <tr>
													<td class="e_label">起飞机场：</td>
													<td><input type="text" name="startAirport"></td>
													<td class="e_label">起飞时间：</td>
													<td><input type="text" name="startTime"></td>
										        </tr>
										        <tr>
													<td class="e_label">降落机场：</td>
													<td><input type="text" name="arriveAirport"></td>
													<td class="e_label">降落时间：</td>
													<td><input type="text" name="arriveTime"></td>
										        </tr>
										        <tr>
													<td class="e_label">飞行时长：</td>
													<td><input type="text" name="flightTime"></td>
													<td class="e_label">机型：</td>
													<td><input type="text" name="airplaneString"></td>
										        </tr>
										        <tr>
													<td class="e_label">经停：<input type="checkbox"></td>
													<td></td>
													<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
													<td></td>
										        </tr>
											</table>
										</div>
									</#if>
								</#list>
							</#if>
							<#---创建返程火车--->
							<#if ptg?? && ptg.prodTrafficTrainList?size &gt; 0>
								<#list ptg.prodTrafficTrainList as train>
									<#if train.tripType == 'BACK'>
										<div name="template_train" type="TRAIN" class="template"  data="${train.trainId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<input type="hidden" name="startStation" value="${train.startDistrict}">
											<input type="hidden" name="arriveStation" value="${train.endDistrict}">
											<input type="hidden" name="isFill" value="T">
											<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>车次:<input type="text" name="trainNo" value="${train.trainNo}" style="width:80px;margin-right:10px;"><i class="cc1">*</i>始发地:<input type="text" name="startStationSearch" value="${train.startDistrictString}" style="width:80px;margin-right:10px;"><i class="cc1">*</i>目的地:<input type="text" name="arriveStationSearch" style="width:80px;" value="${train.endDistrictString}"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_train">补全</a></span></div>
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
									</#if>
								</#list>
							</#if>
							<#---创建返程客车--->
							<#if ptg?? && ptg.prodTrafficBusList?size &gt; 0>
								<#list ptg.prodTrafficBusList as bus>
									<#if bus.tripType == 'BACK'>
										<div name="template_bus" type="BUS" class="template" data="${bus.busId}" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
											<table class="e_table form-inline" style="width:500px">
												<tr>
													<td class="e_label"><i class="cc1">*</i>上车点：</td>
													<td><input type="text" name="adress" value="${bus.adress}"></td>
													<td class="e_label"><i class="cc1">*</i>发车时间：</td>
													<td><input type="text" name="startTime" value="${bus.startTime}"></td>
										        </tr>
										        <tr>
													<td class="e_label">备注：</td>
													<td colspan="3"><input type="text" name="memo" style="width:405px;" value="${bus.memo}"></td>
										        </tr>
										        <tr>
										        	<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
													<td></td>
													<td class="e_label"></td>
													<td></td>
										        </tr>
											</table>
										</div>
									</#if>
								</#list>
							</#if>
						</#if>
					</div>
				</div>
			  </div>
			</#list>
		</#if>
		
		
	</div>
</div>
<#---用于提交的表单--->
<form id="saveForm">
	
</form>
<div id="template" style="display:none">
 <#---交通组模板--->
	<div name="template_traffic_wrapper">
	   <div name="template_traffic" type="TRAFFIC" data="" class="template" style="border:1px solid #cccccc;padding:20px;margin-top:20px;">
				<div name="head" style="height:30px;margin-bottom:10px;">
					<span style="font-size:15px;font-weight:900">{{traffic_title}}</span>
					<span class="fr operate"><a class="btn btn_cc1" name="delete_traffic">删除交通信息</a></span>
				</div>
				<div name="to" style="padding-bottom:10px;border-bottom:1px solid #cccccc" class="to">
					<div name="head" style="height:30px;margin-bottom:10px;">
						<span style="font-size:12px;font-weight:900">去程{{to_traffic_name}}</span>
						<div class="fr operate"><a class="btn btn_cc1" name="to_transfer">添加中转{{to_traffic_name}}</a></div>
					</div>
					<div name="content">
					</div>
				</div>
				<div name="back" style="margin-top:20px;" class="back">
					<div name="head" style="height:30px;margin-bottom:10px;">
						<span style="font-size:12px;font-weight:900">返程{{back_traffic_name}}</span>
						<div class="fr operate"><a class="btn btn_cc1" name="back_transfer">添加中转{{back_traffic_name}}</a></div>
					</div>
					<div name="content">
					</div>
				</div>
		</div>
    </div>
 
 <#---飞机模板--->
<div name="template_flight_wrapper">
 <div name="template_flight" type="FLIGHT" class="template" data=""  style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
 	<input type="hidden" name="isFill">
	<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>航班号:<input type="text" name="flightNo"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_flight">补全</a></span> </div>
	<table class="e_table form-inline" style="width:500px">
		<tr>
			<td class="e_label">始发地：</td>
			<td><input type="text" name="startDistrict"></td>
			<td class="e_label">目的地：</td>
			<td><input type="text" name="arriveDistrict"></td>
        </tr>
        <tr>
			<td class="e_label">起飞机场：</td>
			<td><input type="text" name="startAirport"></td>
			<td class="e_label">起飞时间：</td>
			<td><input type="text" name="startTime"></td>
        </tr>
        <tr>
			<td class="e_label">降落机场：</td>
			<td><input type="text" name="arriveAirport"></td>
			<td class="e_label">降落时间：</td>
			<td><input type="text" name="arriveTime"></td>
        </tr>
        <tr>
			<td class="e_label">飞行时长：</td>
			<td><input type="text" name="flightTime"></td>
			<td class="e_label">机型：</td>
			<td><input type="text" name="airplaneString"></td>
        </tr>
        <tr>
			<td class="e_label">经停：<input type="checkbox" name="stop"></td>
			<td></td>
			<td class="e_label"><div class="fl operate"><a class="btn btn_cc1" name="delete_transfer">删除</a></div></td>
			<td></td>
        </tr>
	</table>
 </div>
</div>
 <#---火车模板--->
<div name="template_train_wrapper" >
	<div name="template_train" type="TRAIN" class="template" data="" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
		<input type="hidden" name="isFill">
		<input type="hidden" name="startStation">
		<input type="hidden" name="arriveStation">
		<div style="padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #cccccc"><i class="cc1">*</i>车次:<input type="text" name="trainNo" style="width:80px;margin-right:10px;"><i class="cc1">*</i>始发地:<input type="text" name="startStationSearch" style="width:80px;margin-right:10px;"><i class="cc1">*</i>目的地:<input type="text" name="arriveStationSearch" style="width:80px;"> <span class="operate" style="margin-left:20px;"><a class="btn btn_cc1" name="fill_train">补全</a></span></div>
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
<#---汽车模板--->
	<div name="template_bus_wrapper">
		<div name="template_bus" type="BUS" class="template" data="" style="margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #cccccc">
			<table class="e_table form-inline" style="width:500px">
				<tr>
					<td class="e_label"><i class="cc1">*</i>上车点：</td>
					<td><input type="text" name="adress"></td>
					<td class="e_label"><i class="cc1">*</i>发车时间：</td>
					<td><input type="text" name="startTime"></td>
		        </tr>
		        <tr>
					<td class="e_label">备注：</td>
					<td colspan="3"><input type="text" name="memo" style="width:405px;"></td>
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
</div>
<div class="fl operate" style="margin-top:20px;margin-bottom:20px;"><a class="btn btn_cc1" id="save_traffic_detail">保存交通信息</a></div>
</div>
<#include "/base/foot.ftl"/>
<script>
	vst_pet_util.commListSuggest($("input[name='startStationSearch']"),$("input[name='startStationSearch']").parents(".template").find("input[name='startStation']"),'/vst_back/prod/traffic/searchTrainStationList.do','');
	vst_pet_util.commListSuggest($("input[name='arriveStationSearch']"),$("input[name='arriveStationSearch']").parents(".template").find("input[name='arriveStation']"),'/vst_back/prod/traffic/searchTrainStationList.do','');
</script>
</body>
</html>
<script>
	var loading;
	<#if prodTraffic==null>
	$("#save_button").bind("click",function(){
		$.confirm("确认保存?，保存后不能修改哦",function(){
			loading = $.loading("正在保存");
			$.ajax({
				url : "/vst_back/prod/traffic/saveProdTraffic.do",
				type : "post",
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					if(result=='success'){
						$.alert('保存成功',function(){
							window.location.reload();
						});
					}else {
						$.alert('保存失败');
					}
				},
				error : function(result) {
					loading.close();
					$.alert('服务器错误');
				}
			});
		});
	});
	
	</#if>
	
	$("#backType").change(function(){
		if($(this).val()=='BUS'){
			$("#chooseFlag").show();
			$("#chooseFlag input").removeAttr("disabled");
		}else {
			$("#chooseFlag").hide();
			$("#chooseFlag input").attr("disabled","disabled");
		}
	});
	
	<#---转换交通工具名称--->
	function getTrafficName(type){
		return type == 'FLIGHT' ? '飞机' : type == 'TRAIN' ? '火车' : type == 'BUS' ? '汽车' : ''; 
	}
	
	<#---根据类型返回模板--->
	function getTrafficTemplate(type){
		var template = '';
		if(type=='FLIGHT'){
			return $("div[name=template_flight_wrapper]").html();
		}else if(type=='TRAIN'){
			return $("div[name=template_train_wrapper]").html();
		}else if(type=='BUS'){
			return $("div[name=template_bus_wrapper]").html();
		}
	}
	
	<#---为删除模板绑定事件--->
	$("a[name=delete_traffic]","#trafficContentDiv").live("click",function(){
		var that = $(this);
		var deleteLoading;
		$.confirm("确定要删除吗?",function(){
			var id = that.closest(".template").attr("data");
			var type = that.closest(".template").attr("type");
			if(id==''){
				that.closest("div.template").remove();
				return;
			}
			deleteLoading = $.loading("正在删除...");
			$.ajax({
				url : "/vst_back/prod/traffic/deleteProdTrafficDetail.do",
				type : "post",
				data : {"id":id,"type":type},
				success : function(result) {
					if(result.code=='success'){
						$.alert('删除成功');
						that.closest("div.template").remove();
					}else {
						$.alert('删除失败');
					}
					deleteLoading.close();
				},
				error : function(result) {
					deleteLoading.close();
				}
			})
		})
	});
	
	function bindEvents(template){
		<#---火车绑定地标查询事件--->
		bindQueryStation(template);
	}
	
	<#---火车绑定地标查询事件--->
	function bindQueryStation(template){
		var startStationSearch = template.find("input[name='startStationSearch']");
		if(startStationSearch.size()>0){
			vst_pet_util.commListSuggest(startStationSearch,startStationSearch.parents(".template").find("input[name='startStation']"),'/vst_back/prod/traffic/searchTrainStationList.do','');
		}
		var arriveStationSearch = template.find("input[name='arriveStationSearch']");
		if(arriveStationSearch.size()>0){
			vst_pet_util.commListSuggest(arriveStationSearch,arriveStationSearch.parents(".template").find("input[name='arriveStation']"),'/vst_back/prod/traffic/searchTrainStationList.do','');
		}
	}
	
	<#---添加交通信息--->
	$("#add_button").click(function(){
		//首先判断基本信息是否已经保存
		if($("#trafficId").val()==''){
			$.alert('请先保存交通基本信息');
			return;
		}
		//首先获得去程和返程的信息
		var to_type = $("#toType").val();
		var back_type = $("#backType").val();
		<#---获得交通组模板--->
		var traffic_template = $("div[name=template_traffic_wrapper]").html();
		<#---设置交通组title--->
		var index = $("#trafficDiv").find("div[name=template_traffic]").size()+1;
		var traffic_title = '交通信息'+index;
		var to_traffic_name = getTrafficName(to_type);
		var back_traffic_name = getTrafficName(back_type);
		<#---设置交通组title--->
		traffic_template = traffic_template.replace(/{{traffic_title}}/g,traffic_title);
		<#---设置交通组去程名称--->
		traffic_template = traffic_template.replace(/{{to_traffic_name}}/g,to_traffic_name);
		<#---设置交通组返程名称--->
		traffic_template = traffic_template.replace(/{{back_traffic_name}}/g,back_traffic_name);
		<#---封装为JQUERY对象--->
		var traffic_template_obj = $(traffic_template);
		<#---设置去程模板--->
		var to_template = getTrafficTemplate(to_type);
		var back_template = getTrafficTemplate(back_type);
		traffic_template_obj.find("div[name=to]").find("div[name=content]").append(to_template);
		<#---设置返程模板--->
		traffic_template_obj.find("div[name=back]").find("div[name=content]").append(back_template);
		<#---绑定模板事件--->
		bindEvents(traffic_template_obj);
		<#---添加交通组--->
		$("#trafficContentDiv").append(traffic_template_obj);
	});
	
	<#---填充航班信息--->
	function fillFlight(flightNo,fillData){
		var flightLoading;
		if(flightNo==''||flightNo==null){
			$.alert("请输入航班号");
			return;
		}
		flightLoading = $.loading("正在查询航班信息");
		$.ajax({
				url : "/vst_back/prod/traffic/findFlight.do",
				type : "post",
				data : {"flightNo":flightNo},
				success : function(result) {
					fillData(result);
					flightLoading.close();
				},
				error : function(result) {
					flightLoading.close();
				}
		 });
	} 
	
	<#---填充火车信息--->
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
	
	<#---为按钮补全飞机绑定事件--->
	$("a[name=fill_flight]","#trafficContentDiv").live("click",function(){
		<#---获得父对象--->
		var parentObj = $(this).closest(".template");
		var flightNo = parentObj.find("input[name=flightNo]").val();
		fillFlight(flightNo,function(res){
			console.debug(res);
			if(res==null || res==''){
				$.alert('无该航班,请重新查询');
				return;
			}
			
			parentObj.find("input[name=isFill]").val("T");
			parentObj.find("input[name=startDistrict]").val(res.startDistrictString);
			parentObj.find("input[name=arriveDistrict]").val(res.arriveDistrictString);
			parentObj.find("input[name=startAirport]").val(res.startAirportString);
			parentObj.find("input[name=startTime]").val(res.startTime);
			parentObj.find("input[name=arriveAirport]").val(res.arriveAirportString);
			parentObj.find("input[name=arriveTime]").val(res.arriveTime);
			parentObj.find("input[name=flightTime]").val(res.flightTime);
			parentObj.find("input[name=airplaneString]").val(res.airplaneString);
			if(res.stopCount!='0')
			parentObj.find("input[name=stop]").attr("checked","checked");
			
		});
	});
	<#---自动点一下--->
	$("a[name=fill_flight]","#trafficContentDiv").click();
	
	<#---为按钮补全火车绑定事件--->
	$("a[name=fill_train]","#trafficContentDiv").live("click",function(){
		<#---获得父对象--->
		var parentObj = $(this).closest(".template");
		var trainNo = parentObj.find("input[name=trainNo]").val();
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
		});
	});
	$("a[name=fill_train]","#trafficContentDiv").click();
	
	<#---为添加中转按钮绑定事件--->
	$("a[name=to_transfer]","#trafficContentDiv").live("click",function(){
		var to_type = $("#toType").val();
		var to_template = getTrafficTemplate(to_type);
		<#---封装为JQUERY对象--->
		var template = $(to_template);
		bindQueryStation(template);
		$(this).parents("div.to").find("div[name=content]").append(template);
		
	});
	
	$("a[name=back_transfer]","#trafficContentDiv").live("click",function(){
		var back_type = $("#backType").val();
		var back_template = getTrafficTemplate(back_type);
		<#---封装为JQUERY对象--->
		var template = $(back_template);
		bindQueryStation(template);
		var obj = $(this).parents("div.back").find("div[name=content]").append(template);
	});
	
	<#---为删除中转按钮绑定事件--->
	$("a[name=delete_transfer]","#trafficContentDiv").live("click",function(){
		<#---只有当前交通工具大于1才可以删除--->
		var size = $(this).parents("div[name=content]").find("div.template").size();
		if(size==1){
			$.alert("最后一个不能删除");
			return;
		}
		var that = $(this);
		var deleteLoading;
		$.confirm("确定要删除吗?",function(){
			var id = that.closest(".template").attr("data");
			var type = that.closest(".template").attr("type");
			if(id==''){
				that.closest("div.template").remove();
				return;
			}
			deleteLoading = $.loading("正在删除...");
			$.ajax({
				url : "/vst_back/prod/traffic/deleteProdTrafficDetail.do",
				type : "post",
				data : {"id":id,"type":type},
				success : function(result) {
					if(result.code=='success'){
						$.alert('删除成功');
						that.closest("div.template").remove();
					}else {
						$.alert('删除失败');
					}
					deleteLoading.close();
				},
				error : function(result) {
					deleteLoading.close();
				}
			})
		})
	});
	
	<#---构建提交对象--->
	$("#save_traffic_detail").click(function(){
		if($("#trafficContentDiv").find("div").size()==0){
			$.alert("请先添加交通信息!");
			return;
		}
	
		var saveLoading ;
		
		var msg = '确认保存吗 ？';	
	 if(refreshSensitiveWord($("input[type='text'],textarea"))){
		 	 msg = '内容含有敏感词,是否继续?';
		 }
		
	   $.confirm(msg,function(){
	   
	    saveLoading = $.loading("正在保存....");
		$("#saveForm").empty();
		try{
			$("div[name='template_traffic']").each(function(groupIndex){
				var that = $(this);
				var to_type = $("#toType").val();
				var back_type = $("#backType").val();
				<#---构建去程对象--->
				var toContent = that.find("div.to");
				if(to_type=='FLIGHT'){
					createFlightObjects(groupIndex,toContent,'TO',0);
				}else if(to_type=='TRAIN'){
					createTrainObjects(groupIndex,toContent,'TO',0);
				}else if(to_type=='BUS'){
					createBusObjects(groupIndex,toContent,'TO',0);
				}
				var backContent = that.find("div.back");
				<#---构建返程对象--->
				if(back_type=='FLIGHT'){
					createFlightObjects(groupIndex,backContent,'BACK',toContent.find(".template").size());
				}else if(back_type=='TRAIN'){
					createTrainObjects(groupIndex,backContent,'BACK',toContent.find(".template").size());
				}else if(back_type=='BUS'){
					createBusObjects(groupIndex,backContent,'BACK',toContent.find(".template").size());
				}
			});
		}catch(e){
			$.alert(e);
			saveLoading.close();
			return;
		}
		<#---提交数据--->
			$.ajax({
				url : "/vst_back/prod/traffic/editProdTrafficDetail.do",
				type : "post",
				data : $("#saveForm").serialize(),
				success : function(result) {
					$.alert(result.message);
					saveLoading.close();
				},
				error : function(result) {
					$.alert(result.message);
					saveLoading.close();
				}
			 });
		});
	});
	
	<#---构建飞机对象--->
	function createFlightObjects(groupIndex,content,tripType,baseIndex){
		content.find("div[name=template_flight]").each(function(index){
			var that = $(this);
			var productId = $("#productId").val();
			var flightNo = that.find("input[name='flightNo']").val();
			var isFill = that.find("input[name='isFill']").val();
			if(isFill!='T'){
				throw '请使用[补全],补全航班信息';
			}
			var flightId = that.attr("data");
			var groupId = that.closest("div[name='template_traffic']").attr("data");
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].groupId" value="'+groupId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficFlightList['+(index+baseIndex)+'].flightId" value="'+flightId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficFlightList['+(index+baseIndex)+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficFlightList['+(index+baseIndex)+'].tripType" value="'+tripType+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficFlightList['+(index+baseIndex)+'].flightNo" value="'+flightNo+'">');
		});
	}
	
	<#---构建火车对象--->
	function createTrainObjects(groupIndex,content,tripType,baseIndex){
		content.find("div[name=template_train]").each(function(index){
			var that = $(this);
			var productId = $("#productId").val();
			var trainNo = that.find("input[name='trainNo']").val();
			var isFill = that.find("input[name='isFill']").val();
			if(isFill!='T'){
				throw '请使用[补全],补全车次信息';
			}
			var startStation = that.find("input[name='startStation']").val();
			var arriveStation = that.find("input[name='arriveStation']").val();
			var trainId = that.attr("data");
			var groupId = that.closest("div[name='template_traffic']").attr("data");
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].groupId" value="'+groupId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].trainId" value="'+trainId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].tripType" value="'+tripType+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].trainNo" value="'+trainNo+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].startDistrict" value="'+startStation+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficTrainList['+(index+baseIndex)+'].endDistrict" value="'+arriveStation+'">');
		});
	}
	
	<#---构建汽车对象--->
	function createBusObjects(groupIndex,content,tripType,baseIndex){
		content.find("div[name=template_bus]").each(function(index){
			var that = $(this);
			var productId = $("#productId").val();
			var adress = that.find("input[name='adress']").val();
			var startTime = that.find("input[name='startTime']").val();
			if(adress==''){
				throw '请填写上车点';
			}
			if(startTime==''){
				throw '出发时间';
			}
			var memo = that.find("input[name='memo']").val();
			var busId = that.attr("data");
			var groupId = that.closest("div[name='template_traffic']").attr("data");
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].groupId" value="'+groupId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].busId" value="'+busId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].productId" value="'+productId+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].tripType" value="'+tripType+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].adress" value="'+adress+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].startTime" value="'+startTime+'">');
			$("#saveForm").append('<input type="hidden" name="prodTrafficGroupList['+groupIndex+'].prodTrafficBusList['+(index+baseIndex)+'].memo" value="'+memo+'">');
		});
	}
	refreshSensitiveWord($("input[type='text'],textarea"));
	if($("#isView",parent.document).val()=='Y'){
		$("#add_button,#save_traffic_detail,#save_button").remove();
	}
</script>
