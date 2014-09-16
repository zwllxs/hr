<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">

<form method="post" action='/vst_back/biz/category/findBizPropPoolList.do' id="dataForm">
    <table class="s_table">
        <tbody>
        	<tr>
                <input type="hidden" name="page" value="${page}">
                <td class="s_label">属性名：</td>
                <td class="w18"><input type="text" name="propName" value="${bizPropPool.propName!''}"></td>
                <td class="s_label">属性CODE：</td>
                <td class="w18"><input type="text" name="propCode" value="${bizPropPool.propCode!''}"></td>
                <td class="s_label">属性类型：</td>
                <td class="w18">
                    <select name="propType">
                    	<option  value="" <#if bizPropPool.propType == ''>selected</#if>>不限</option>
					    <option  value="category" ${(bizPropPool.propType== "category")?string("selected", "")}>品类属性</option>
					    <option  value="branch" ${(bizPropPool.propType== "branch")?string("selected", "")}>规格属性</option>
		            </select>
	            </td>
                
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
            </tr>
            <tr>
				<td class=" operate mt10"><a class="btn btn_cc1" data="" id="addButton">添加属性</a></td>
			</tr>
        </tbody>
    </table>	
</form>

<table class="p_table table_center">
    <thead>
        <tr>
    	<th>编号</th>
    	<th>属性类型</th>
		<th>属性名</th>
		<th>属性Code</th>
        <th>排序值</th>
		<th>录入方式</th>
		<th>数据源</th>
		<th>默认值</th>
		<th>是否必填</th>
		<th>说明文字</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
    	<#list pageParam.items as bizPropPool> 
		<tr>
			<td>${bizPropPool.propId!''} </td>
			<td>
				<#if bizPropPool.propType == 'category'>品类属性
				<#elseif bizPropPool.propType == 'branch'>规格属性
				</#if> 
			</td>
			<td>${bizPropPool.propName!''}</td>
			<td>${bizPropPool.propCode!''}</td>
			<td>${bizPropPool.seq!''} </td>
			<td>${bizPropPool.inputTypeName!''}</td>
			<td>${bizPropPool.dataFromName!'无'}</td>
			<td>${bizPropPool.propDefault!''}</td>
			<td>${(bizPropPool.nullFlag=='N')?string("否", "是")}</td>
			<td>${bizPropPool.propDesc!''}</td>
			<td class="oper">
                <a class="editProp" href="javascript:void(0);" data="${bizPropPool.propId!''}">编辑</a>
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
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
//查询
$("#search_button").click(function(){
	$("#dataForm").submit();
});
	
$().ready(function() {

//添加属性
$("#addButton").bind("click",function(){
    var url="/vst_back/biz/category/showBizPropPool.do?operate=add";
	dialog(url, "新增属性池", 800, "auto",function(){
	
	 if(!$("#dataForm").validate().form()){
			return false;
	}
	var resultCode;
		$.ajax({
			url : "/vst_back/biz/category/addBizPropPool.do",
			type : "post",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			dataType:'JSON',
			success : function(result) {
			   resultCode=result.code;
			   confirmAndRefresh(result);
			}
		});
		
		if(resultCode !=='success') return false;
	},"保存");
	
});
	
//修改属性池
$("a.editProp").bind("click",function(){
    var propId=$(this).attr("data");
    var url="/vst_back/biz/category/showBizPropPool.do?operate=update&propId="+propId;
    
	dialog(url, "修改属性池", 800, "auto",function(){
	
		//提交要释放该属性(必填项)
		if(!$("#dataForm").validate().form()){
			return false;
		}
		$("#propType,#propCode,#inputType,#defaultRadio,#defaultInput,#sourceRadio,#suggestText").attr("disabled",false);
		 var resultCode;
		$.ajax({
			url : "/vst_back/biz/category/updateBizPropPool.do",
			type : "post",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			dataType:'JSON',
			success : function(result) {
			resultCode=result.code;
			confirmAndRefresh(result);
			}
		});
		
		if(resultCode !=='success') return false;
	},"保存");
	
	return false;
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		    var url = "/vst_back/biz/category/findBizPropPoolList.do";
		    $("#dataForm").attr("url",url);
  			$("#dataForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
};
});

</script>

