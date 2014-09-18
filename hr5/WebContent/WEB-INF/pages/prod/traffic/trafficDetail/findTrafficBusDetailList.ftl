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
<div class="fl operate" style="margin-left:20px;margin-bottom:10px;"><a class="btn btn_cc1" id="new_button">添加车次</a></div>
<div class="iframe_content mt10">
 <!-- 主要内容显示区域\\ -->        
        <div class="p_box box_info">
            <table class="p_table table_center">
                <thead>
                    <tr>
                    	<th>类型</th>
                        <th><#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if></th>
                        <th><#if type=='category_traffic_bus_other'>上船<#else>上船</#if>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                		<#if group?? && group.prodTrafficBusList?? && group.prodTrafficBusList?size &gt; 0>
                		<#list group.prodTrafficBusList as prodTrafficBus>
						<tr>
							<td><#if prodTrafficBus.tripType=='TO'>去程</#if><#if prodTrafficBus.tripType=='BACK'>返程</#if></td>
							<td>
										${prodTrafficBus.adress}
						  </td>
						  <td>
										${prodTrafficBus.startTime}
						  </td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp" busId='${prodTrafficBus.busId}' >编辑</a>
		                            <a href="javascript:void(0);" class="delete" busId='${prodTrafficBus.busId}' >删除</a>
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

<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var showAddTrafficTrainDetailDialog;
var showUpdateTrafficTrainDetailDialog;
  $("#new_button").click(function(){
			showAddTrafficTrainDetailDialog = new xDialog("/vst_back/prod/traffic/showAddTrafficBusDetail.do",{productId:$("#prodProductId").val()},{title:"新增车次",width:500});	
	});
	
	$(".editProp").click(function(){
		var busId = $(this).attr("busId");
		showUpdateTrafficTrainDetailDialog = new xDialog("/vst_back/prod/traffic/showUpdateTrafficBusDetail.do",{productId:$("#prodProductId").val(),"busId":busId},{title:"修改车次",width:500});	
	});
	
	$(".delete").click(function(){
		var busId = $(this).attr("busId");
		$.confirm('确认删除?',function(){
				$.ajax({
					url : "/vst_back/prod/traffic/deleteTrafficBusDetail.do",
					type : "post",
					dataType:"JSON",
					data : {"busId":busId},
					success : function(result) {
					if (result.code == "success") {
						$.alert(result.message,function(){
							$("#traffic",parent.document).parent("li").trigger("click");
						});
					}else {
						$.alert(result.message);
					}
					}
			});
		
		});
	
	});
</script>
