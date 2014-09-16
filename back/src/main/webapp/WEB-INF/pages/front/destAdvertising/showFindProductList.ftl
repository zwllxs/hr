<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<#--页眉-->
<!--<#import "/base/spring.ftl" as spring/>
<#import "/base/pagination.ftl" as pagination>
-->
<#--页面导航-->
<div class="p_box box_info">
	<form method="post" action='/vst_back/front/destAdvertising/findProductList.do' id="searchForm">
    	<table class="s_table">
        <tbody>
            <tr>
                 <td class="s_label">品类:
    				<#list bizCategoryList as bizCategory> 
	                     <#if categoryId == bizCategory.categoryId>${bizCategory.categoryName!''}</#if>
	                </#list>
	                <input type="hidden" name="categoryIds" value="${categoryIds!''}">
				</td>
                <td class="s_label">产品ID：</td>
                <td class="w18"><input type="text" name="productId" value="${productId!''}" number="true" ></td>
                <td class="s_label">产品名称：</td>
                <td class="w18"><input type="text" name="productName" value="${productName!''}"></td>
                <td class=" operate mt10">
               		<a class="btn btn_cc1" id="search_button">查询</a> 
                </td>
               <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
	</form>
</div>

<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th>选择</th>
        	<th>产品编号</th>
            <th>产品名称</th>
            </tr>
        </thead>
        <tbody>
        	  <#if pageParam?? && pageParam.items?? && pageParam.items?size &gt; 0>
                    <#list pageParam.items  as prod>
	                    <tr>
	                        <td class="w10">
	                        	<input type="radio" name="productId" value="${prod.productId!''}">
								<input type="hidden" name="productNameHide" value="${prod.productName!''}">
								<input type="hidden" name="productIdHide" value="${prod.productId!''}">
	                        </td>
	                        <td class="w10 text_left">${prod.productId}</td>
	                        <td class="text_left">${prod.productName}</td>
	                    </tr>
                    </#list>
                <#else>
                	<tr class="table_nav"><td colspan="4"><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td>	</tr>
                </#if>
        </tbody>
    </table>
     <table class="co_table">
        <tbody>
            <tr>
                 <td class="s_label">
                 	<#if pageParam.items?exists> 
						<div class="paging" > 
						${pageParam.getPagination()}
						</div> 
					</#if>
                 </td>
            </tr>
        </tbody>
    </table>	
	</div><!--p_box-->
	
</div><!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var newProds = window.parent.prods;
var newProd;
if(typeof(newProds) != "undefined"){
	var newProd = newProds.split(',');
}

//排除所有已有的产品
$("input[type='radio']").each(function(){
    if (typeof(newProds) != "undefined" && newProds.length > 0){
	   if($.inArray($(this).val(), newProd)>-1)
	   {
	       //$(this).attr("checked",true);
	   } 
	}
});

//查询
$("#search_button").bind("click",function(){
    if(!$("#searchForm").validate().form()){
		return;
	}
	$("#searchForm").submit();
});

$("input[type='radio']").bind("click",function(){
	var obj = $(this).parent("td");
	var prod = {};
	prod.productId = $("input[name='productIdHide']",obj).val();
    prod.productName = $("input[name='productNameHide']",obj).val();
	parent.onSelectProd(prod);
});

</script>
