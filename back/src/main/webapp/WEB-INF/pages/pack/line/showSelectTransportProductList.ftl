<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:950px;">
<div class="iframe_content">
    <div class="p_box box_info">
	<form method="post" action='/vst_back/productPack/line/showSelectProductList.do' id="searchForm">
		<input type="hidden" id="groupId" name="groupId" value="${groupId }"/>
		<input type="hidden" id="groupType" name="groupType" value="TRANSPORT"/>
		<input type="hidden" id="redirectType" name="redirectType" value="${redirectType }"/>
		
        <table class="s_table">
            <tbody>
                <tr>
                	<td class="s_label">产品品类：</td>
                    <td class="w18">
                    	<select name="selectCategoryId" id="selectCategoryId">
			    					<option value="21"  <#if selectCategoryId==21>selected=selected</#if> >其它机票</option>
			    					<option value="23"   <#if selectCategoryId==23>selected=selected</#if> >其它火车票</option>
			    					<option value="25"  <#if selectCategoryId==25>selected=selected</#if> >其它巴士</option>
			    					<option value="27"  <#if selectCategoryId==27>selected=selected</#if>  >其它船票</option>
			        	</select>
                    </td>
                    <td class="s_label">产品名称：</td>
                    <td class="w18"><input type="text" name="productName" value="${productName}"></td>
                    <td class="s_label">产品ID：</td>
                    <td class="w18"><input type="text" name="productId" number="true" value="${productId}"></td>
                </tr>
                <tr>
                   <td class="s_label">出发地：</td>
					<td class="w18">
						<input type="text"  name="startDistrictName" id="bizDistrictName" value="${startDistrictName}"/>
						<input type="hidden" name="startDistrict" id="bizDistrictId"  value="${startDistrict}"/>
					</td>
					<td class=" operate mt10">目的地：</td>
					<td class="w18">
						<input type="text"   name="toDistrictName" id="destName" value="${toDistrictName}"/>
						<input type="hidden" name="toDistrict" id="destReId" value="${toDistrict}"/>
					</td>
					<td  class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a> </td>
					<td>&nbsp;</td>
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
                    <th>选择</th>
                	<th width="80px">品类</th>
                    <th>产品ID</th>
                    <th>是否参考信息</th>
                    <th>产品名称</th>
                    <th >规格</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as productBranch> 
					<tr>
					<td><input  type="${inputType }" name="branchIds" value="${productBranch.productBranchId!''}"/></td>
					<td>${productBranch.categoryName!''}</td>
					<td>${productBranch.productId!''} </td>
					<td><#if productBranch.product?? && productBranch.product.referFlag??&&productBranch.product.referFlag=='Y'>是<#else>否</#if></td>
					<td>
						<a style="cursor:pointer" 
							onclick="openProduct(${productBranch.productId!''},${productBranch.categoryId!''},'${productBranch.categoryName!''}')">
							${productBranch.productName!''}
						</a>
					</td>
					<td>${productBranch.branchName!''}</td>
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

 		<div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="saveDetail">加入打包</a></div>
        </div>
        
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
vst_pet_util.districtSuggest("#bizDistrictName", "#bizDistrictId");
vst_pet_util.districtSuggest("#destName", "#destReId");
$(function(){

	//查询
	$("#search_button").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$("#searchForm").submit();
	});
	
	//修改
	$("a.editProd").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data1");
		var categoryName = $(this).attr("categoryName");
		window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
		return false;
	});
	
	$("#saveDetail").bind("click",function(){
		var branchIds = "";
		$('input[name="branchIds"]:checked').each(function(){
			branchIds += $(this).val() + ",";
		});
		
		if(branchIds == null || branchIds.length == 0){
			$.alert("请选择产品....");
			return;
		}
		
		if(branchIds != null){
			branchIds = branchIds.substring(0,branchIds.length - 1);
			var groupId = $("#groupId").val();
			var groupType = $("#groupType").val();
			var selectCategoryId = $("#selectCategoryId").val();
			var postData = "groupId=" + groupId + "&groupType=" + groupType + "&branchIds=" + branchIds+ "&selectCategoryId=" + selectCategoryId;
			var loading = top.pandora.loading("正在努力保存中...");
			$.ajax({
				url : "/vst_back/productPack/line/addGroupDetail.do",
				type : "post",
				dataType : 'json',
				data : postData,
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						var packGroupDetail = {};
						packGroupDetail.groupId = result.attributes.groupId;
						packGroupDetail.groupType = result.attributes.groupType;
						packGroupDetail.selectCategoryId = result.attributes.selectCategoryId;
						packGroupDetail.detailIds = result.attributes.detailIds;
						parent.onSavePackGroupDetail(packGroupDetail);
					}
					if(result.code == "error"){
						$.alert(result.message);
					}
				},
				error : function(result) {
					loading.close();
					$.alert(result.message);
				}
			});
		}
	});
});


function openProduct(productId, categoryId, categoryName){
	window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
}
	
</script>
