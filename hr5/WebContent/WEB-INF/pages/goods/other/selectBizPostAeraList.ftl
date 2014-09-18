<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                    <th></th>
                	<th>编号</th>
                    <th>收件地名称</th>
                    <th>包含地区</th>
                    </tr>
                </thead>
                <tbody>
					<#list bizPostAeraList as bizPostAera> 
					<tr>
						<td><input type="radio" name="bizPostAera">
						<input type="hidden" name="areaId" value="${bizPostAera.areaId!''}">
						<input type="hidden" name="areaName" value="${bizPostAera.areaName!''}">
						<input type="hidden" name="districtArea" value="${bizPostAera.districtArea!''}">
						</td>
						<td>${bizPostAera.areaId!''}</td>
						<td>${bizPostAera.areaName!''} </td>
						<td>${bizPostAera.districtNameStr!''} </td>
				   </tr>
					</#list>
                </tbody>
            </table>
			 
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	//选择一个Item
	$("input[type='radio']").bind("click",function(){
	var radio  = $("input:radio:checked");
	if(radio.size()==0){
		alert("请选择收件地");
		return;
	}
		var obj = radio.parent("td");
		var bizPostAera = {};
		bizPostAera.areaId = $("input[name='areaId']",obj).val();
    	bizPostAera.areaName = $("input[name='areaName']",obj).val();
    	bizPostAera.districtArea = $("input[name='districtArea']",obj).val();

	    //传递选择的bizPostAera对象回传给父窗口函数
	    <#if callback??>
			parent.${callback}(bizPostAera);
		<#else>
			parent.onSelectBizPostAera(bizPostAera);
		</#if>
});
</script>
