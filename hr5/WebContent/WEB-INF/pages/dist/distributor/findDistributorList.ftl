<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">分销商管理</a> &gt;</li>
            <li class="active">分销商列表</li>
        </ul>
</div>


<div class="iframe_search">
<form method="post" action='/vst_back/dist/distributor/findDistributorList.do' id="searchForm">
        <table class="s_table">
           <tbody>
                <tr>
                    <td class="s_label">分销商名称：</td>
                    <td class="w18"><input type="text" name="distributorName" value="${distributor.distributorName!''}"></td>
                    <td class="s_label">分销商状态：</td>
                       <td class="w18">
                    	<select name="cancelFlag">
                    	<option value="">不限</option>
	                    		<option value="Y" <#if distributor.cancelFlag =="Y">selected="selected" </#if>>开启</option>
	                    		<option value="N" <#if distributor.cancelFlag =="N">selected="selected" </#if>>禁用</option>
                    	</select>
                    </td>
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                    <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                </tr>
            </tbody>
        </table>	
		</form>
    </div>
      
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">  
<#if pageParam.items?? &&  pageParam.items?size &gt; 0>  
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                	<th>分销商ID</th>
                	<th>分销商名称</th>
                    <th>分销商状态</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as distributor > 
					<tr>
					<td>${distributor.distributorId!''} </td>
					<td>${distributor.distributorName!''} </td>
					<td><#if distributor.cancelFlag == 'Y'>开启</#if> <#if distributor.cancelFlag == 'N'>禁用</#if></td>
					
					
					<td class="oper">
                            <a href="javascript:void(0);" class="editProp" data=${distributor.distributorId!''} >编辑</a>
                            <a href="javascript:void(0);" class="editPro" data=${distributor.distributorId!''} >商品列表</a>
                            <a href="javascript:void(0);"  class="editFlag" data="${distributor.distributorId!''}" data2="${distributor.cancelFlag}">${(distributor.cancelFlag=='N')?string("开启", "禁用")}</a>					
                            <a href="javascript:void(0);" class="cancelProp" data=${distributor.distributorId!''}>操作日志</a>
                            
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
	
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关分销商，重新输入相关条件查询！</div>
    </#if>
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	//查询
	$("#search_button").bind("click",function(){
		$("#searchForm").submit();
	});
	
	
		//新增
	$("#new_button").bind("click",function(){
		dialog("/vst_back/dist/distributor/showAddDistributor.do", "新增分销商", 800, "auto",function(){
		
		//验证
		if(!$("#dataForm").validate().form()){
			return false;
		}
        var resultCode;
		$.ajax({
			url : "/vst_back/dist/distributor/addDistributor.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			success : function(result) {
			    resultCode=result.code;
				confirmAndRefresh(result);
			}
		});
		if(resultCode !=="success") return false;
	},"保存");
});
	
	//修改
	$("a.editProp").bind("click",function(){
		var distributorId = $(this).attr("data");
		dialog("/vst_back/dist/distributor/showUpdateDistributor.do?distributorId="+distributorId, "编辑分销商基本信息", 800, "auto" ,function(){
			if(!$("#dataForm").validate().form()){
			return false;
		}
        var resultCode;
        $.confirm("确认修改吗 ？", function () {
		$.ajax({
			url : "/vst_back/dist/distributor/updateDistributor.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			success : function(result) {
			    resultCode=result.code;
				confirmAndRefresh(result);
			}
		});
		});
		if(resultCode !=="success") return false;
	},"保存");
	});
	
	// 设为有效/无效
	$("a.editFlag").bind("click",function(){
	 var distributorId=$(this).attr("data"),
	 	 cancelFlag=$(this).attr("data2") == "N" ? "Y": "N",
	 	 msg = cancelFlag === "N" ? "禁用分销商 ？<p>[禁用后,该分销商所有接口请求，都将被屏蔽]</p>" : "开启分销商 ？<p>[开启后，将开放对该分销商的接口请求]</p>";
	 
	  $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/dist/distributor/editFlag.do",
			type : "get",
			async: false,
			data : {distributorId : distributorId , cancelFlag : cancelFlag },
			dataType:'JSON',
			success : function(result) {
				 confirmAndRefresh(result);
			}
	  });
   });
	   return false;
});
	 
	
	
	//商品列表
	
	$("a.editPro").bind("click",function(){
		var distributorId = $(this).attr("data");
		location.href="/vst_back/dist/distributorGoods/findDistributorGoodsList.do?distributorId="+distributorId
		}
	);
	
	
	
	
	//确定并刷新
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				location.reload();
			}});
		}else {
			$.alert(result.message);
		}
	}
	
</script>
