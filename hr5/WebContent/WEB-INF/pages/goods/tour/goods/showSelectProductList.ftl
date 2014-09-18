<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_content">
<input type="hidden" id="groupId" name="groupId" value="${groupId }"/>
<input type="hidden" id="groupType" name="groupType" value="${groupType }"/>
<input type="hidden" id="selectCategoryId" name="selectCategoryId" value="${selectCategoryId }"/>

<!-- 主要内容显示区域\\ -->
    <#if changeHotelList?? &&  changeHotelList?size &gt; 0>
    	<div class="p_box box_info">
    		<table class="p_table table_center">
                <thead>
                    <th>选择</th>
                    <th>酒店名称</th>
                    <th>房型</th>
                    <th>商品</th>
                    </tr>
                </thead>
                <tbody>
					<#list changeHotelList as changedHotel> 
					<tr>
					<td><input type="checkbox" name="branchIds" value="${changedHotel.productBranchId!''}"/></td>
					<td>${changedHotel.hotelName!''}</td>
					<td>${changedHotel.productBranchName!''} </td>
					<td>${changedHotel.suppGoodsName!''} </td>
					</tr>
					</#list>
                </tbody>
            </table>
		</div>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
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
$(function(){
	
	$("#saveDetail").bind("click",function(){
		var branchIds = "";
		$('input[name="branchIds"]:checked').each(function(){
			if($(this).val() != null && $(this).val() != ''){
				branchIds += $(this).val() + ",";
			}
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
	
</script>
