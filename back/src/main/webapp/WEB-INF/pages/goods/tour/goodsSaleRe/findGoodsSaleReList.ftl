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
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">打包</li>
        </ul>
</div>
<div class="iframe_content">
	<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
    <p class="pl15">注：保险，请勿选择，系统会自动调取最优保险方案</p>
    <p class="pl15"> 注，用户前台下单时，同产品下面的商品可以都选择</p>      
    </div>
    
    <div class="operate" style="margin-top:10px;margin-bottom:10px"><a class="btn btn_cc1" id="select">选择产品</a></div>
    <input type="hidden" id="mainProductId1" value="${prodProductId}">
<!-- 主要内容显示区域\\ -->
    <#if saleRelationList?? &&  saleRelationList?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                    <tr>
                	<th width="80px">产品类型</th>
                    <th>产品ID</th>
                    <th>产品名称</th>
                    <th>规格ID</th>
                    <th>规格</th>
                    <th>选择限制</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list saleRelationList as pgr> 
					<tr>
					<td>${pgr.category.categoryName!''}</td>
					<td>${pgr.product.productId!''} </td>
					<td><a target="_blank" href="/vst_back/prod/baseProduct/toUpdateProduct.do?productId=${pgr.product.productId!''}&categoryId=${pgr.category.categoryId!''}&categoryName=${pgr.category.categoryName!''}"> ${pgr.product.productName!''}</a></td>
					<td>${pgr.productBranch.productBranchId!''}</td>
					<td>${pgr.productBranch.branchName!''}</td>
					<td>
					<#if pgr.suppGoodsSaleRe.reType=='OPTIONAL'>
						任选
					<#elseif pgr.suppGoodsSaleRe.reType=='OPTION'>
					 	可选
					<#elseif pgr.suppGoodsSaleRe.reType=='AMOUNT'>	
						等量
					</#if>
					</td>
					<td class="oper">
					<a href="javascript:void(0);" class="delete" data=${pgr.suppGoodsSaleRe.reId}>删除</a>
					<a href="javascript:void(0);" class="editProp" data=${pgr.suppGoodsSaleRe.reId}>设置规则</a>
                    </td>
					</tr>
					</#list>
                </tbody>
            </table>
        
	</div><!-- div p_box -->
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关关联产品！</div>
    </#if>
<!-- //主要内容显示区域 -->
<div class="fl operate"><a href="javascript:void(0);"  class="showLogDialog btn btn_cc1" param="{'objectId':${prodProductId},'objectType':'PROD_PRODUCT_RELATION'}">操作日志</a> </div>
</div>

<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	var prodBranchSelectDialog;
	var goodsSaleUpdateDialog;
	//打开选择产品列表
	$("#select").click(function(){
		prodBranchSelectDialog = new xDialog("/vst_back/tour/goods/goods/showSuppGoodsSaleProductList.do",{},{title:"选择已有产品",width:"1000",height:"850"});
	});
	$(".delete").click(function(){
		var id = $(this).attr("data");
		$.confirm("确定删除吗?",function(){
			$.ajax({
				url : '/vst_back/tour/goods/goods/deleteGoodsSaleRe.do',
				data : {reId:id,prodProductId:$("#mainProductId1").val()},
				success : function(rs){
					if(rs=='success'){
						$.alert("删除成功",function(){
							window.location.reload();
						});
					}
				}
			})
		});
	});
	
	$(".editProp").click(function(){
		var id = $(this).attr("data");
		goodsSaleUpdateDialog = new xDialog("/vst_back/tour/goods/goods/toUpdateGoodsSaleRe.do",{"reId":id},{title:"设置规则",width:"1000",height:"600"});
	});
	
	if($("#isView",parent.top.document).val()=='Y'){
	$(".btn,.oper > a").remove();
}
</script>


