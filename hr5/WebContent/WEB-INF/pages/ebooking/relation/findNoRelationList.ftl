<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">EBOOKING</a> &gt;</li>
            <li><a href="/vst_back/ebooking/relation/findNoRelationList.do">未关联供应商数据查询</a> &gt;</li>
        </ul>
</div>
 	<div class="price_tab">
        <ul class="J_tab ui_tab">  
            <li <#if tabNo==null || tabNo==1>class="active"</#if>><a href="javascript:;" name="tabChange" data=0>未关联供应商产品查询</a></li>
            <li <#if tabNo?? && tabNo==2>class="active"</#if>><a href="javascript:;" name="tabChange" data=1>未关联供应商审核查询</a></li>
            <li <#if tabNo?? && tabNo==3>class="active"</#if>><a href="javascript:;" name="tabChange" data=2>未关联供应商订单查询</a></li>
        </ul>
     </div>
<div class="iframe_search">
		<table class="s_table">
		<form method="post" action='/vst_back/ebooking/relation/findNoRelationList.do' id="searchForm1">
			<tr name="showflag1">
				<input type="hidden" name="tabNo" value="${tabNo!''}">
			   	   <td class="s_label">产品ID：</td>
                   <td class="w18"><input type="text" class="input-text" name="productId" value="${ebkSuperProd.productId!''}"></td>
 				   <td class="s_label">产品名称：</td>
                   <td class="w18"><input type="text" class="input-text" name="productName" value="${ebkSuperProd.productName!''}"></td>
                   <td class="s_label">供应商ID：</td>
                   <td class="w18"><input type="text" class="input-text" name="supplierId" value="${ebkSuperProd.supplierId!''}"></td>
				   <td><a class="btn btn_cc1" id="search_button1">查询</a></td>
			</tr>
		</form>
		<form method="post" action='/vst_back/ebooking/relation/findNoRelationList.do' id="searchForm2">
			<tr name="showflag2">
				<input type="hidden" name="tabNo" value="${tabNo!''}">
 				   <td class="s_label">产品名称：</td>
                   <td class="w18"><input type="text" class="input-text" name="productName" value="${ebkProdApply.productName!''}"></td>
                   <td class="s_label">供应商ID：</td>
                   <td class="w18"><input type="text" class="input-text" name="supplierId" value="${ebkProdApply.supplierId!''}"></td>
				   <td><a class="btn btn_cc1" id="search_button2">查询</a></td>
			</tr>
		</form>
		<form method="post" action='/vst_back/ebooking/relation/findNoRelationList.do' id="searchForm3">
			<tr name="showflag3">
				<input type="hidden" name="tabNo" value="${tabNo!''}">
 				   <td class="s_label">订单号：</td>
                   <td class="w18"><input type="text" class="input-text" name="orderId" value="${ebkTask.orderId!''}"></td>
                   <td class="s_label">客人姓名：</td>
                   <td class="w18"><input type="text" class="input-text" name="travellerName" value="${ebkTask.travellerName!''}"></td>
                   <td class="s_label">供应商ID：</td>
                   <td class="w18"><input type="text" class="input-text" name="ebkCertif.supplierId" <#if ebkTask.ebkCertif??>value="${ebkTask.ebkCertif.supplierId!''}"</#if>></td>
				   <td><a class="btn btn_cc1" id="search_button3">查询</a></td>
			</tr>
		</form>
		</table>
		</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
		    <#if pageParamProduct?? && pageParamProduct.items?? &&  pageParamProduct.items?size &gt; 0>
			<table class="p_table table_center">
                <thead>
                 	<tr>
                	<th>产品ID</th>
                    <th>产品名称</th>
                    <th>供应商ID</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParamProduct.items as prod> 
					<tr>
					<td>${prod.productId!''}</td>
                    <td>${prod.productName!''}</td>
                    <td>${prod.supplierId!''}</td>
					</#list>
                </tbody>
            </table>
		    </#if>
  			<#if pageParamProduct?? && pageParamProduct.items?exists> 
					<div class="paging" > 
					${pageParamProduct.getPagination()}
					</div> 
			</#if>
			<#if pageParamApply?? && pageParamApply.items?? &&  pageParamApply.items?size &gt; 0>
            <table class="p_table table_center">
                <thead>
                 	<tr>
                	<th>变更编号</th>
                    <th>产品名称</th>
                    <th>供应商ID</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParamApply.items as apply> 
					<tr>
					<td>${apply.applyId!''}</td>
                    <td>${apply.productName!''}</td>
                    <td>${apply.supplierId!''}</td>
					</#list>
                </tbody>
            </table>
            </#if>
  			<#if pageParamApply?? && pageParamApply.items?exists> 
					<div class="paging" > 
					${pageParamApply.getPagination()}
					</div> 
			</#if>
			<#if pageParamOrder?? && pageParamOrder.items?? &&  pageParamOrder.items?size &gt; 0>
            <table class="p_table table_center">
                <thead>
                 	<tr>
                	<th>订单号</th>
                    <th>客人姓名</th>
                    <th>供应商ID</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParamOrder.items as task> 
					<tr>
					<td><#list task.ebkSuperTaskItems as item>
	                		${item.orderId!''}
	                	</#list></td>
	                <td>${task.travellerName!''}</td>
                    <td>${task.supplierId!''}</td>
					</#list>
                </tbody>
            </table>
		    </#if>
  			<#if pageParamOrder?? && pageParamOrder.items?exists> 
					<div class="paging" > 
					${pageParamOrder.getPagination()}
					</div> 
			</#if>
	</div><!-- div p_box -->
</div>
<!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
$(function(){
		<#if  tabNo?? && tabNo==2>
		$("tr[name='showflag1']").hide();
		$("tr[name='showflag2']").show();
		$("tr[name='showflag3']").hide();
		<#elseif  tabNo?? && tabNo==3>
		$("tr[name='showflag1']").hide();
		$("tr[name='showflag2']").hide();
		$("tr[name='showflag3']").show();
		<#else>
		$("tr[name='showflag1']").show();
		$("tr[name='showflag2']").hide();
		$("tr[name='showflag3']").hide();
		</#if>
		
		//tab切换
		$("a[name=tabChange]").click(function(){
			$("input[name='productId']").val('');
			$("input[name='productName']").val('');
			$("input[name='supplierId']").val('');
			$("input[name='orderId']").val('');
			$("input[name='ebkCertif.supplierId']").val('');
			if($(this).attr("data")==0){
				$("input[name=tabNo]").val('1');
				$(this).parent().next().removeClass();
				$(this).parent().next().next().removeClass();
				$(this).parent().addClass('active');
				$("tr[name='showflag1']").show();
				$("tr[name='showflag2']").hide();
				$("tr[name='showflag3']").hide();
				$(".p_box").hide();
			}else if($(this).attr("data")==1){
				$("input[name=tabNo]").val('2');
				$(this).parent().next().removeClass();
				$(this).parent().prev().removeClass();
				$(this).parent().addClass('active');
				$("tr[name='showflag1']").hide();
				$("tr[name='showflag2']").show();
				$("tr[name='showflag3']").hide();
				$(".p_box").hide();
			}else{
				$("input[name=tabNo]").val('3');
				$(this).parent().prev().removeClass();
				$(this).parent().prev().prev().removeClass();
				$(this).parent().addClass('active');
				$("tr[name='showflag1']").hide();
				$("tr[name='showflag2']").hide();
				$("tr[name='showflag3']").show();
				$(".p_box").hide();
			}
		})
		
		
			//查询
	$("#search_button1").bind("click",function(){
		if(!$("#searchForm1").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("input[name=tabNo]").val('1');
		$("#searchForm1").submit();
	});
	
	$("#search_button2").bind("click",function(){
		if(!$("#searchForm2").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("input[name=tabNo]").val('2');
		$("#searchForm2").submit();
	});
	
	$("#search_button3").bind("click",function(){
		if(!$("#searchForm3").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("input[name=tabNo]").val('3');
		$("#searchForm3").submit();
	});
});
</script>
