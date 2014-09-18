<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px;">
<div class="iframe_search">
<form method="post" action='/vst_back/biz/category/selectBizPropPoolList.do' id="searchForm">
        <table class="s_table">
            <tbody>
           		 <tr>
           		 	 <input type="hidden" name="categoryId" id="categoryId" value="${categoryId!''}">
	                 <input type="hidden" name="branchId" id="branchId" value="${branchId!''}">
	                 <input type="hidden" name="groupId" id="groupId" value="${groupId!''}">
	                 <input type="hidden" name="propType" value="${bizPropPool.propType!''}">
	                 <input type="hidden" name="callback" id="callback" value="${callback!''}">
           		 </tr>
                <tr>
                    <td class="s_label">属性名：</td>
                    <td class="w18"><input type="text" name="propName" value="${bizPropPool.propName!''}"></td>
                    <td class="s_label">属性CODE：</td>
                    <td class="w18"><input type="text" name="propCode" value="${bizPropPool.propCode!''}"></td>
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                </tr>
            </tbody>
        </table>	
		</form>
    </div>
    
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                     	<th><input type="checkbox" id="allBizPropPoolSelectHead" onClick="selectAll('allBizPropPoolSelectHead')"/>全选</th>
	                	<th>属性编号</th>
	                	<th>属性类型</th>
	                    <th>属性名称</th>
	                    <th>属性Code</th>
	                    <th>录入方式</th>
	                    <th>属性描述</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as bizPropPool> 
					<tr>
						<td>
							<input type="checkbox" id="checkBox${bizPropPool_index}"  value="${bizPropPool.propId!''}" />
						</td>
						<td>${bizPropPool.propId!''} </td>
						<td>
							<#if bizPropPool.propType == 'category'>品类属性
							<#elseif bizPropPool.propType == 'branch'>规格属性
							</#if> 
						</td>
						<td>${bizPropPool.propName!''} </td>
						<td>${bizPropPool.propCode!''} </td>
						<td>${bizPropPool.inputTypeName!''} </td>
						<td>${bizPropPool.propDesc!''} </td>
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
<div class="operate"><a class="btn btn_cc1"  id="selectButton">确定</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	//查询
	$("#search_button").click(function(){
		$("#searchForm").submit();
	});

//"确定"提交
$("#selectButton").bind("click",function(){

	var radio  = $("input:checkbox:checked");
	if(radio.size()==0){
		alert("请选择属性");
		return;
	}
	//遍历选择的ITem对象
	var batchPropIds = "";
	 $("input:checkbox:checked").each(function(i){
	 	  if(this.id != "allBizPropPoolSelectHead"){
	 		 batchPropIds += this.value + ",";
	 	  }
     });
    var resultCode;
	var groupId = $("#groupId").val();
	var branchId = $("#branchId").val();
	var categoryId = $("#categoryId").val();
	var param = "?batchPropIds="+ batchPropIds + "&categoryId="+categoryId+ "&groupId="+groupId+"&branchId="+branchId;
	var url = "/vst_back/biz/category/addProp.do"+ param;
	$.ajax({
		url : url,
		type : "post",
		async: false,
		dataType:'JSON',
		success : function(result) {
		   if (result.code == "success") {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
					var callback = $("#callback").val();
				    //返回父窗口函数
				    <#if callback??>
						  parent.${callback}();
					</#if>
				}});
			}else {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				}});
			}
		}
	});
     
});
</script>

<script>
  //选择所有记录
 function selectAll(id)
{
	if($("#" + id).attr("checked")=="checked")
	{
		for(var i = 0; i < 10; i++)
		{
			if($("#checkBox"+i) != null)
			{
				$("#checkBox"+i).attr("checked",true);
			}
		}
	}
	else if($("#" + id).attr("checked")!="checked")
	{
		for(var i = 0; i < 10; i++)
		{
			if($("#checkBox"+i) != null)
			{
				$("#checkBox"+i).attr("checked",false);
			}
		}
	}
}
</script>