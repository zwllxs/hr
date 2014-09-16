<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">地铁线路管理</a> &gt;</li>
            <li class="active">地铁线路列表</li>
        </ul>
</div>
<div class="iframe_content">   
<div class="p_box">
<form method="post" action='/vst_back/biz/trafficLine/findTrafficLineList.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">线路名称：</td>
                <td class="w18"><input type="text" name="trafficName" value="${trafficName!''}"></td>
                <td class="s_label">所属行政区域：</td>
                <td class="w18">
                	<input type="text" id="districtName" name="districtName" value="${districtName!''}" readonly="readonly" >
                    <input type="hidden" name="districtId" value="${districtId!''}"  id="districtId">
                </td>
                <td class="s_label">状态：</td>
                <td class="w18">
                <input type="checkbox" name="cancelFlags" value="Y" >有效
                <input type="checkbox" name="cancelFlags" value="N" >无效
                <input type="hidden" id="cancelFlag" name="cancelFlag" value="${cancelFlag!''}">
                </td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                 <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
</form>

</div>
	
<!-- 主要内容显示区域\\ -->
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
        	<th>地铁线路编号</th>
            <th>地铁线路名称</th>
            <th>所属行政区域</th>
            <th>包含站点</th>
            <th>地铁线路状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizTrafficLine> 
			<tr>
				<td>${bizTrafficLine.trafficId!''} </td>
				<td>${bizTrafficLine.trafficName!''} </td>
				<td>${bizTrafficLine.districtName!''} </td>
				<td>${bizTrafficLine.stations?size!''}个 </td>
				<td>
					<#if bizTrafficLine.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProp">有效</span>
					<#elseif bizTrafficLine.cancelFlag == "N">
						<span style="color:red" class="cancelProp">无效</span>
				    <#else>
				        <span style="color:red" class="cancelProp"></span>
					</#if>
				</td>
				<td class="oper">
	                <a href="javascript:void(0);" class="editProp" data=${bizTrafficLine.trafficId}>编辑</a>
	                <#if bizTrafficLine.cancelFlag == "Y" && bizTrafficLine.stations?size == 0> 
	                	 <a href="javascript:void(0);" class="cancelProp" data="N" trafficId=${bizTrafficLine.trafficId}>设为无效</a>
	                <#elseif bizTrafficLine.cancelFlag == "N">
	               		 <a href="javascript:void(0);" class="cancelProp" data="Y" trafficId=${bizTrafficLine.trafficId}>设为有效</a>
	                </#if>
	              </td>
				</tr>
			</#list>
        </tbody>
    </table>
	<#if pageParam.items?exists> 
		<div class="paging" > 
			${pageParam.getPagination()}
		</div> 
	</#if>

	</div><!-- div p_box -->
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var addDialog,updateDialog,districtSelectDialog;
var cancelflag = '${cancelFlag}';

        $('input[name="cancelFlags"]').each(function(){  
             if(cancelflag == 'nonull'){
                $(this).attr("checked",true);
             }else if($(this).val() == cancelflag){
                $(this).attr("checked",true);
             }
        });


function checkCancel(){
   var oo = $('input[name="cancelFlags"]:checked');
     if(oo.size()==0)
     {
        $("#cancelFlag").val("all");
     }else if(oo.size()==1){
        $("#cancelFlag").val(oo.val());
     }else{
        $("#cancelFlag").val("nonull");
     }
}

//选择行政区
function onSelectDistrict(params){
	if(params!=null){
		$("#districtName").val(params.districtName);
		$("#districtId").val(params.districtId);
	}
	districtSelectDialog.close();
}

//清除行政区域
function onClearDistrict(param) {
	$("#districtId").val('');
	$("#districtName").val('');
	districtSelectDialog.close();
}

//打开选择行政区窗口
$("#districtName").click(function(){
	districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});

//查询
$("#search_button").bind("click",function(){
	if(!$("#searchForm").validate().form()){
		return;
	}
	checkCancel();
	$("#searchForm").submit();
});

//新建
$("#new_button").bind("click",function(){
	var url = "/vst_back/biz/trafficLine/showAddTrafficLine.do";
	addDialog = new xDialog(url, {}, {title:"新增地铁线路",width:800});
});

//修改
$("a.editProp").bind("click",function(){
	var trafficId = $(this).attr("data");
	var url = "/vst_back/biz/trafficLine/showUpdateTrafficLine.do";
	updateDialog = new xDialog(url,{"trafficId":trafficId}, {title:"编辑地铁线路",width:800});
});

//设置为有效或无效
$("a.cancelProp").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var trafficId = entity.attr("trafficId");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
 	$.confirm(msg, function () {	
	$.ajax({
		url : "/vst_back/biz/trafficLine/modiTrafficLineFlag.do",
		type : "post",
		data : {"cancelFlag":cancelFlag,"trafficId":trafficId},
		success : function(result) {
			if (result.code == "success") {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
					}
				}});
			}else {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				}});
			}		
		}
	});
	});
});


</script>