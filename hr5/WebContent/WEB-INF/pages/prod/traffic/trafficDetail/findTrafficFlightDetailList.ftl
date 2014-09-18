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
<div class="fl operate" style="margin-left:20px;margin-bottom:10px;"><a class="btn btn_cc1" id="new_button">添加航班</a></div>
<div class="iframe_content mt10">
 <!-- 主要内容显示区域\\ -->        
        <div class="p_box box_info">
            <table class="p_table table_center">
                <thead>
                    <tr>
                        <th>航班号</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <#if groupList?? && groupList?size &gt; 0>
                	<#list groupList as group>
                		<#if group.prodTrafficFlightList?? && group.prodTrafficFlightList?size &gt; 0>
                		<#assign hasBack=false>
                		<#list group.prodTrafficFlightList as prodTrafficFlight>
									<#if prodTrafficFlight.tripType=='BACK'>
											<#assign hasBack=true>
									</#if>
							</#list>
						<tr>
							<td>
							<#list group.prodTrafficFlightList as prodTrafficFlight>
										<#if prodTrafficFlight.tripType=='TO'>
												${prodTrafficFlight.flightNo}
										</#if>
							</#list>
							<#if hasBack==true>|</#if>
							<#list group.prodTrafficFlightList as prodTrafficFlight>
									<#if prodTrafficFlight.tripType=='BACK'>
												${prodTrafficFlight.flightNo}
									</#if>
							</#list>
							
						  </td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp" groupId='${group.groupId}' >编辑</a>
		                            <#if group.prodTrafficFlightList?? && group.prodTrafficFlightList?size &gt; 0>
		                            	<#if group.prodTrafficFlightList[0].tripType=='TO'>
											<#if group.prodTrafficFlightList[0].cancelFlag=='Y' >
													<a href="javascript:void(0);" class="cancelProp" data="N" groupId='${group.groupId}'>设为无效</a>
													<#else>
			                            			<a href="javascript:void(0);" class="cancelProp" data="Y" groupId='${group.groupId}'>设为有效</a>
											</#if>
										</#if>
									</#if>
		                 	</td>
						</tr>
						</#if>
						</#list>
                <#else>
					<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td></tr>
		    	</#if>
		    	</tbody>
            </table>
        </div>
 </div>
<!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var showAddTrafficFlightDetailDialog;
var showUpdateTrafficFlightDetailDialog;
  $("#new_button").click(function(){
			showAddTrafficFlightDetailDialog = new xDialog("/vst_back/prod/traffic/showAddTrafficFlightDetail.do",{productId:$("#prodProductId").val()},{title:"新增航班",width:400});	
	});
	
	$(".editProp").click(function(){
		var groupId = $(this).attr("groupId");
		showUpdateTrafficFlightDetailDialog = new xDialog("/vst_back/prod/traffic/showUpdateTrafficFlightDetail.do",{productId:$("#prodProductId").val(),"groupId":groupId},{title:"修改航班",width:400});	
	});
	
	//设置为有效或无效
		$("a.cancelProp").bind("click",function(){
			var entity = $(this);
			var cancelFlag = entity.attr("data");
			var groupId = entity.attr("groupId");
			$.ajax({
				url : "/vst_back/prod/traffic/updateFlightCancelFlag.do",
				type : "post",
				dataType:"JSON",
				data : {"cancelFlag":cancelFlag,"groupId":groupId},
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message,function(){
						if(cancelFlag == 'N'){
							entity.attr("data","Y");
							entity.text("设为有效");
						}else if(cancelFlag == 'Y'){
							entity.attr("data","N");
							entity.text("设为无效");
						}
					});
				}else {
					$.alert(result.message);
				}
				}
			});
		});
</script>
