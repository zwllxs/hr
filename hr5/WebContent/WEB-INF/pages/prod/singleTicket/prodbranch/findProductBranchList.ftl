<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">产品规格管理</a> &gt;</li>
            <li class="active">产品规格列表</li>
        </ul>
</div>



<div class="iframe_search">
<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">1.景区中的门票、游玩项目、餐饮、交通、演出等收费的项目作为规格；</p>
            <p class="pl15">2.当套餐商品中包含该规格时，可以调取规格信息，呈现在前台。</p>
</div>
<div class="p_box box_info clearfix">
            <h2 class="f16 mb10">新增产品规格</h2>
            <div class="add_pf">
                <ul>
                	<#list branchList as branch>
                		<li><a href="javascript:void(0);" data="${branch.branchId}">${branch.branchName}</a></li>
	                </#list>
                </ul>
            </div>
</div>

      
<!-- 主要内容显示区域\\ -->
				<div>
	                	<form method="post" action='/vst_back/singleTicket/prod/prodbranch/findProductBranchList.do' id="searchForm">
	                	<input type="hidden" name="productId" value="${productId}"/>
	                	<input type="hidden" name="categoryId" value="${categoryId}"/>
                    	</form>
            	</div>
                <#if prodProductBranchMap??> 
	                <#list prodProductBranchMap?keys as testKey>
	                	<#assign prodProductBranchList=prodProductBranchMap[testKey] >    
	                	<div class="p_box box_info">
            			<div class="f16 mb10">${testKey?substring(1,testKey?length)}</div>
            			<table class="p_table table_center">
				                <thead>
				                    <tr>
				                	<th>编号</th>
				                	<th>名称</th>
				                	<th>状态</th>
				                    <th>主/次规格</th>
				                    <th>推荐级别</th>
				                    <th>操作</th>
				                    </tr>
				                </thead>
				                <tbody>
									<#list prodProductBranchList as productBranch > 
									<tr>
									<td>${productBranch.productBranchId!''} </td>
									<td>${productBranch.branchName!''}</td>
									<td><#if productBranch.cancelFlag == 'Y'><span style="color:green" class="cancelProp">有效</span></#if> <#if productBranch.cancelFlag == 'N'><span style="color:red" class="cancelProp">无效</span></#if></td>
									<td><#if productBranch.bizBranch.attachFlag == 'Y'>主规格</#if> <#if productBranch.bizBranch.attachFlag == 'N'>次规格</#if></td>					
									<td>${productBranch.recommendLevel!''}</td>
									<td class="oper">
				                            <a href="javascript:void(0);" class="editProp" data=${productBranch.productBranchId!''} data_proid=${productBranch.branchId!''}>编辑</a>
				                            <a href="javascript:void(0);" class="editFlag" data=${productBranch.productBranchId!''} data2="${productBranch.cancelFlag}">${(productBranch.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
				                            <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${productBranch.productBranchId!''},'objectType':'PROD_PRODUCT_BRANCH'}">操作日志</a>
				                            <a href="javascript:void(0);" class="showPhoto" data=${productBranch.productBranchId} parentId=${productBranch.productId} logType="PROD_PRODUCT_BRANCH_CHANGE">图片</a>
				                        </td>
									</tr>
									<tr id ></tr>
									</#list>
				                </tbody>
				            </table>
            			</div>
					</#list>
				</#if>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</body>
</html>



<script>
	$(".J_list",window.parent.document).find("li").removeClass("active");
	$("#productBranch",window.parent.document).parent("li").addClass("active");

var addDialog,updateDialog;
	// Comphoto
	$("a.showPhoto").bind("click",function(){
		var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+$(this).attr("data")+"&parentId="+$(this).attr("parentId")+"&objectType=PRODUCT_BRANCH_ID&logType="+$(this).attr("logType");
		new xDialog(url,{},{title:"图片列表",iframe:true,width:"885px",height:"1000px"});
	});
	//修改
	$("a.editProp").bind("click",function(){
		var productBranchId = $(this).attr("data");
		var branchId = $(this).attr("data_proid");
		var categoryId = ${categoryId!''}; 
		updateDialog = new xDialog("/vst_back/singleTicket/prod/prodbranch/showUpdateBranch.do",{"productBranchId":productBranchId , "branchId":branchId, "categoryId":categoryId}, {title:"修改产品规格",width:900});
});


    $("#cancelFlag").change(function(){
    	$("#searchForm").submit();
    });

	// 设为有效/无效
	$("a.editFlag").bind("click",function(){
	 var productBranchId=$(this).attr("data");
	 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
	  $.get("/vst_back/singleTicket/prod/prodbranch/editFlag.do?productBranchId="+productBranchId+"&cancelFlag="+cancelFlag, function(result){
	
       confirmAndRefresh(result);
       });
       });
});
	
	
	//确定并刷新
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				location.reload();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	}


//新建

	$("li a").bind("click",function(){
		var branchId = $(this).attr("data");
		var productId = ${productId!''}; 
		var categoryId = ${categoryId!''}; 
		addDialog = new xDialog("/vst_back/singleTicket/prod/prodbranch/showAddProductBranch.do",{"branchId":branchId , "productId":productId, "categoryId":categoryId}, {title:"新增产品规格",width:900})
		});
</script>

