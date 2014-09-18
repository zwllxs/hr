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
            <p class="pl15">1.概念，规格，规格是用来挂商品的一个特殊属性，类似于衣服的XL、L、M，黄色、红色</p>
            <p class="pl15">2.概念，主次规格，主规格可单独销售、次规格为附属于主规格销售的一类商品</p>
            <p class="pl15">3.规格状态，规格若无效，则它下面的商品不能售卖。</p>
             <p class="pl15">4.如果需要的规格没有，请联系技术部增加。</p>
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
									<td>${productBranch.recommendLevel}</td>
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
		new xDialog(url,{},{title:"图片列表",iframe:true,width:800});
	});
	//修改
	$("a.editProp").bind("click",function(){
		var productBranchId = $(this).attr("data");
		var branchId = $(this).attr("data_proid");
		updateDialog = new xDialog("/vst_back/prod/prodbranch/showUpdateBranch.do",{"productBranchId":productBranchId , "branchId":branchId}, {title:"修改产品规格",width:900});
});

	// 设为有效/无效
	$("a.editFlag").bind("click",function(){
	 var productBranchId=$(this).attr("data");
	 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
	  $.get("/vst_back/prod/prodbranch/editFlag.do?productBranchId="+productBranchId+"&cancelFlag="+cancelFlag, function(result){
	
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
		addDialog = new xDialog("/vst_back/prod/prodbranch/showAddProductBranch.do",{"branchId":branchId , "productId":productId}, {title:"新增产品规格",width:900})
		});
</script>

