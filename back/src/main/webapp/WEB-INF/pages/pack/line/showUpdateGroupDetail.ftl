<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>

<!-- 编辑时设置初始化值 -->
<#assign price = '' />
<#assign priceType = '' />
<#if packDetail ??>
	<#assign price = packDetail.price />
	<#assign priceType = packDetail.priceType />
</#if>

<body>
<div class="iframe_content">
    <div class="p_box box_info">
	<form method="post" action='/vst_back/productPack/line/updateGroupDetail.do' id="dataForm">
		<input type="hidden" id="groupId" name="groupId" value="${groupId }"/>
		<input type="hidden" id="groupType" name="groupType" value="${groupType }"/>
		<input type="hidden" id="price" name="price" value="${price }"/>
		<input type="hidden" id="detailIds" name=detailIds value="${detailIds }"/>
		<input type="hidden" id="productId" name="productId"/>
	
        <table class="s_table">
            <tbody>
            	<tr>
            	  <td class="s_label" colspan="3">设置规则：</td>
            	  </tr>
                <tr>
                    <td class="w18"><input type="radio" id="profit" name="priceType" value="MAKEUP_PRICE" checked="checked"/>基于商品利润设置，利润的：</td>
                    <td class="s_label"><input type="text" id="makeUpPrice" name="makeUpPrice" number="true"  value="100"/>%</td>
                     <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="w18"><input type="radio" id="fix" name="priceType" value="FIXED_PRICE"/>基于结算价恒定，加价：</td>
                    <td class="s_label"><input type="text"  id="fixPrice" name="fixPrice" number="true" readonly="true" />元</td>
                    <td class=" operate mt10"> <a class="btn btn_cc1" id="updatePackDetail">保存设置</a> </td>
                </tr>
            </tbody>
            
        </table>	
		</form>
	</div>
<!-- 主要内容显示区域\\ -->
	已选择产品
    <#if packDetailList?? &&  packDetailList?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                	<th width="80px">产品类型</th>
                    <th>产品ID</th>
                    <th>产品名称</th>
                    <th >规格</th>
                    </tr>
                </thead>
                <tbody>
					<#list packDetailList as packDetail> 
						 <#if packDetail ?? && packDetail.prodProductBranch ??>
						 	<tr>
								<td>${packDetail.prodProductBranch.categoryName!''}</td>
								<td>${packDetail.prodProductBranch.productId!''}</td>
								<td>
									<a style="cursor:pointer" 
										onclick="openProduct(${packDetail.prodProductBranch.productId!''},${packDetail.prodProductBranch.categoryId!''},'${packDetail.prodProductBranch.categoryName!''}')">
										${packDetail.prodProductBranch.productName!''} 
									</a>
								 </td>
								<td>${packDetail.prodProductBranch.branchName!''}</td>
							</tr>
						 </#if>
					</#list>
                </tbody>
            </table>
	</div>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关选择产品！</div>
    </#if>
        
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
$(function(){
	$("#productId").val($("#productId",window.parent.document).val());
	
	$("input[name=priceType]").click(function(index,obj){
		if($(this).attr("checked") == "checked"){
			var id = $(this).attr("id");
			if(id=='profit'){
				$("#makeUpPrice").removeAttr("readonly");
				$("#fixPrice").attr("readonly","true");
				$("#fixPrice").val("");
			}
			if(id=='fix'){
				$("#fixPrice").removeAttr("readonly");
				$("#makeUpPrice").attr("readonly","true");
				$("#makeUpPrice").val("");
			}
		}
	});
	
	//设置修改单条记录时的价格规则
	if('${priceType}' != null && '${priceType}'.length > 0){
		if('${priceType}' == 'FIXED_PRICE'){
			$("#fix").attr("checked","checked");
			$("#fixPrice").val(parseFloat('${price}')/100);
			$("#fixPrice").removeAttr("readonly");
		}else if('${priceType}' == 'MAKEUP_PRICE'){
			$("#profit").attr("checked","checked");
			$("#makeUpPrice").val(parseFloat('${price}')/100);
			$("#makeUpPrice").removeAttr("readonly");
		}
	}
	
	$("#updatePackDetail").bind("click",function(){

		//验证
		if(!$("#dataForm").validate({
			rules : {},
			messages : {}
		}).form()){
			return;
		}
		
		var profit = $("#profit").attr("checked");
		if(profit){
			var makeUpPrice = $("#makeUpPrice").val();
			if(makeUpPrice == null || makeUpPrice == ''){
				$.alert("必须设置商品利润率");
				return;
			}else if(parseInt(makeUpPrice) < 0){
				$.alert("设置商品利润率非法");
				return;
			}else{
				var integerReg = /^(0|[1-9]\d*)$/;
				if(!integerReg.test(parseFloat(makeUpPrice))){
					$.alert("设置商品利润率非法(正整数)");
					return;
				}
			}
		}
		
		var profit = $("#fix").attr("checked");
		if(profit){
			var fixPrice = $("#fixPrice").val();
			if(fixPrice == null || fixPrice == '' ){
				$.alert("必须设置恒定加价");
				return;
			}else if(parseFloat(fixPrice) < 0){
				$.alert("设置恒定加价非法");
				return;
			}
		}
		
		$("input[name=priceType]").each(function(index, obj){
			if($(this).attr("checked") == "checked"){
				var id = $(this).attr("id");
				if(id=='profit'){
					$("#price").val($("#makeUpPrice").val());
				}
				if(id=='fix'){
					$("#price").val($("#fixPrice").val());
				}
			}
		});
		
		if($("#price").val() == null || $("#price").val() == ''){
			$.alert("请设置价格规则");
			return;
		}
		
		$("#price").val(Math.round(parseFloat($("#price").val())*100)); 
		
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/productPack/line/updateGroupDetail.do",
			type : "post",
			dataType : 'json',
			data : $("#dataForm").serialize(),
			success : function(result) {
				loading.close();
				if(result.code == "success"){
					parent.onUpdatePackGroupDetail();
				}
			},
			error : function(result) {
				loading.close();
				$.alert(result.message);
			}
		});
	});
});

function openProduct(productId, categoryId, categoryName){
	window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
}
	
	
</script>
