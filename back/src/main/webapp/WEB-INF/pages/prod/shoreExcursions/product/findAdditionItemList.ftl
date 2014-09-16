<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">产品管理</a> &gt;</li>
            <li class="active">附加项目产品列表</li>
        </ul>
</div>
<div class="iframe_content">
	
    
    <div class="p_box box_info">
	<form method="post" action='/vst_back/prod/shoreExcursions/findAdditionItemList.do' id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                    <td class="s_label">附加项目名称：</td>
                    <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}"></td>
                    <td class="s_label">产品编号：</td>
                    <td class="w18"><input type="text" name="productId" value="${prodProduct.productId!''}" number="true" ></td>
					<td class="s_label">目的地：</td>
                    <td class="w18">
                    <input type="text" name="bizDistrict.districtName" value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtName!''}</#if>"></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                	<td class="s_label">附加项目子品类：</td>
                    <td class="w18">
                    
                    	 <select name="bizCategory.categoryId">
                    	 			<option value="">不限</option>
				    				<#list bizCategoryList as bizCategory> 
					                    	<option value=${bizCategory.categoryId!''} <#if prodProduct.bizCategory!=null && prodProduct.bizCategory.categoryId == bizCategory.categoryId>selected</#if> >${bizCategory.categoryName!''}</option>
					                </#list>
			        	</select>
			        	
                    </td>
                 	<td class="s_label">产品状态：</td>
                    <td class="w18">
                    	<select name="cancelFlag">
                    		<option value="">不限</option>
			                    	<option value='Y'<#if prodProduct.cancelFlag == 'Y'>selected</#if>>有效</option>
			                    	<option value='N'<#if prodProduct.cancelFlag == 'N'>selected</#if>>无效</option>
                    	</select>
                    </td>
                    <td class="s_label">
					产品经理：
					</td>
                    <td class="w18">
                     <input type="text" name="managerName"  id="managerName" value="${RequestParameters.managerName}"   >
                     <input type="hidden" name="managerId" id="managerId"  value="${prodProduct.managerId}" >
                    </td>
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10">
                    
                    <a class="btn btn_cc1" id="search_button">查询</a> 
                    <a class="btn btn_cc1" id="new_button">新增</a></td>
                  
                </tr>
                
            </tbody>
        </table>	
		</form>
	</div>
<!-- 主要内容显示区域\\ -->
    <#if pageParam??>
    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                    <tr>
                	<th>附加项目ID</th>
                    <th>附加项目名称 </th>
                    <th>所属附加子品类</th>
                    <th>产品经理</th>
                    <th>产品状态</th>
                     
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as product> 
					<tr>
					<td>${product.productId!''} </td>
					<td>${product.productName!''} </td>
					<td><#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if><#if product.bizCategory ?? && product.bizCategory.cancelFlag == 'N'><span class="notnull">[无效]</span></#if></td>
					
					<td>${product.managerName}</td>
					<td>
						<#if product.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProd">有效</span>
						<#else>
						<span style="color:red" class="cancelProd">无效</span>
						</#if>
					</td>
					
					<td class="oper">
					
                            <a href="javascript:void(0);" class="editProd" data="${product.productId}" categoryName="<#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if>" data1="<#if product.bizCategory ??>${product.bizCategory.categoryId!''}</#if>">
                            	编辑</a>
                              <a href="javascript:void(0);" class="showLogDialog" param="{'parentId':${product.productId},'parentType':'PROD_PRODUCT'}">操作日志</a> 
                            <#if product.cancelFlag == "Y"> 
                            <a href="javascript:void(0);" class="cancelProd" data="N" productId=${product.productId}>设为无效</a>
                            <#else>
                            <a href="javascript:void(0);" class="cancelProd" data="Y" productId=${product.productId}>设为有效</a>
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
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
    </#if>
    </#if>
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
$(function(){


	//查询
	$("#search_button").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#searchForm").submit();
	});
	
	//新建
	$("#new_button").bind("click",function(){
		//打开弹出窗口
		window.open("/vst_back/prod/shoreExcursions/showProductMaintain.do?productId=");
		/**
		if($("#categoryId").val()!=null){	
		new xDialog("/vst_back/prod/shoreExcursions/showAddProduct.do",{categoryId:$('#categoryId').val()},{title:"新增产品",width:800,ok:function(){
			//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			
			$.ajax({
				url : "/vst_back/prod/product/addProduct.do",
				type : "post",
				dataType : 'json',
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
		},okValue:"保存"});
		}else{
			$.alert("请先添加品类！");
		}	
		*/
	});
	
	//修改
	$("a.editProd").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data1");
		var categoryName = $(this).attr("categoryName");
		window.open("/vst_back/prod/shoreExcursions/showProductMaintain.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
		return false;
	});
	
	
	
//设置为有效或无效
	$("a.cancelProd").bind("click",function(){
		var entity = $(this);
		var cancelFlag = entity.attr("data");
		var productId = entity.attr("productId");
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/prod/shoreExcursions/cancelProduct.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"productId":productId},
			success : function(result) {
			if (result.code == "success") {
				$.alert(result.message,function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProd",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProd",entity.parents("tr")).css("color","green").text("有效");
					}
				});
			}else {
				$.alert(result.message);
			}
			}
		});
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
				$.alert(result.message);
			}});
		}
	};
	
	
</script>


