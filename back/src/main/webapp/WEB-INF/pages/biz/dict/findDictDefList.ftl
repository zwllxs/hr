<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">字典定义管理</a> &gt;</li>
        <li class="active">字典定义列表</li>
    </ul>
</div>

<div class="iframe_search">
<form method="post" action='/vst_back/biz/dict/findDictDefList.do' id="searchForm">
    <table class="s1_table form-inline">
        <tbody>
            <tr>
                <td class="s_label">字典定义名称：</td>
                <td class="w18"><input type="text" name="dictDefName" value="${bizDictDef.dictDefName}"></td>
                <td class="s_label">字典定义类型：</td>
                <td class="w18"><select name="dictType">
				  	<option value="">请选择</option>
				  	<#list dictTypeList as dictTypeEnum>
	                    <option value="${dictTypeEnum.code}" 
	                    	<#if bizDictDef.dictType == dictTypeEnum.code>selected</#if>
	                    >${dictTypeEnum.cnName}</option>
				  	</#list>
                	</select>
                </td>
                <td class="s_label">状态：</td>
                <td class="w18"><select name="cancelFlag">
				  	<option value="" <#if bizDictDef.cancelFlag == ''>selected</#if> >不限</option>
                    <option value="Y" <#if bizDictDef.cancelFlag == 'Y'>selected</#if> >有效</option>
                    <option value="N" <#if bizDictDef.cancelFlag == 'N'>selected</#if> >无效</option>
                </select></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增字典定义</a></td>
                 <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>
	</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<div class="iframe-content mt20">   
    <div class="p_box">
		<table class="p_table table_center">
	        <thead>
	            <tr>
	            	<th>编号</th>
	                <th>字典定义名称</th>
	                <th>字典定义类型</th>
	                <th>字典代码</th>
	                <th>状态</th>
	                <th>操作</th>
	            </tr>
	        </thead>
	        <tbody>
				<#list pageParam.items as bizDictDef> 
					<tr> 
						<td>${bizDictDef.dictDefId!''} </td>
						<td>${bizDictDef.dictDefName!''} </td>
						<td>${bizDictDef.cnDictType!''} </td>
						<td>${bizDictDef.dictCode!''} </td>
						<td>
							<#if bizDictDef.cancelFlag == 'Y'>
								<span style="color:green" class="cancelProp">有效</span>
							<#else>
								<span style="color:red" class="cancelProp">无效</span>
							</#if> 
						</td>
						<td class="oper">
							<a class="editDictDef" href="javascript:;" data="${bizDictDef.dictDefId!''}" >编辑</a>
							<a href="javascript:;"  class="editFlag" data1="${bizDictDef.dictDefId!''}" data2="${bizDictDef.cancelFlag}">${(bizDictDef.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
							<#if bizDictDef.cancelFlag == 'Y'>
								<a class="addDict" href="javascript:;"  data1="${bizDictDef.dictDefId!''}" data2="${bizDictDef.dictDefName!''}">新增字典</a>
							</#if>
							<#if bizDictDef.dictType == 'DICT_TYPE_BUSINESS' && bizDictDef.cancelFlag == 'Y'>
								<a class="editDictPropDefList" href="javascript:void(0);" data="${bizDictDef.dictDefId!''}">编辑属性定义</a>
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

var updateDialog;
function okfunc(){ 
    alert("保存成功");
	window.location.reload();
}
	
//编辑属性
$("a.editDictPropDefList").bind("click",function(){
	var dictDefId = $(this).attr("data");
	var url = "/vst_back/biz/dictPropDef/findDictPropDefList.do";
	dictPropDefListDialog = new xDialog(url,{dictDefId:dictDefId},{title:"属性定义列表",width:1000});
});
$(function(){
	$("#search_button").bind("click",function(){
		$("#searchForm").submit();
	});
	
	//新增字典定义
	$("#new_button").bind("click",function(){
		dialog("/vst_back/biz/dict/showAddDictDef.do", "新增字典定义", 600, "auto", function(){
			//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			$.ajax({
				url : "/vst_back/biz/dict/addDictDef.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
		},"保存"); 
		return false;
	});
	
	//修改字典定义
	$("a.editDictDef").bind("click",function(){
	     var dictDefId=$(this).attr("data");
	     var url = "/vst_back/biz/dict/showAddDictDef.do";
	     updateDialog = new xDialog(url,{"dictDefId":dictDefId}, {title:"修改字典定义",width:600,height:"auto",ok:function(){
			if(!$("#dataForm").validate().form()){
				return false;
			}
			var resultCode; 
			$.confirm("确认修改吗 ？", function () {
				$.ajax({
					url : "/vst_back/biz/dict/updateDictDef.do",
					type : "post",
					async: false,
					data : $("#dataForm").serialize(),
					dataType:'JSON',
					success : function(result) {
		   				 if(result.code=="success"){
							updateDialog.close();
							confirmAndRefresh(result);
						}else {
							$.alert(result.message);
				   		}
					}
				});
			});
			if(resultCode !=='success') return false;     	
	     },
  		okValue:"保存"
	     });
	});
	     
	//新增字典
	$("a.addDict").bind("click",function(){
	    var dictDefId=$(this).attr("data1");
	    var dictDefName=$(this).attr("data2");
	    var url = "/vst_back/biz/dict/showAddDict.do?dictDefId="+dictDefId;
	    dialog(url, "新增字典", 650, "auto", function(){
	    	//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			 $.ajax({
				url : "/vst_back/biz/dict/addDict.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
    	},"保存");
    	return false;
	});
	
	//设置是否有效
	$("a.editFlag").bind("click",function(){
		 var dictDefId=$(this).attr("data1");
		 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
		 var url = "/vst_back/biz/dict/editDictDefFlag.do?dictDefId="+dictDefId+"&cancelFlag="+cancelFlag+"&newDate="+new Date();
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
		 $.confirm(msg, function () {
			  $.get(url, function(data){
			        alert("设置成功");
					$("#searchForm").submit();
		       });
	       });
	});

	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}
	} 
});

</script> 

