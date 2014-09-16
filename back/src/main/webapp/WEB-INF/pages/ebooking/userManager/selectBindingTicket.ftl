<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
<form method="post" action='/vst_back/ebooking/userManager/selectBindingTicket.do' id="searchForm">

	<input type="hidden" name="userId"  id="userId" value="${userId}"/>
	<input type="hidden" name="supplierId" value="${supplierId}"/>
	<input type="hidden" name="toBindingGoods" value="${toBindingGoods}"/>
	<input type="hidden" name="selectSuppGoodsId" value="${selectSuppGoodsId}"/>
 
    <table class="s_table">
        <tbody>
            <tr>
            	<td class="s_label">产品编号：</td>
                <td class="w18"><input type="text" name="productId" value="${productId!''}" number=true></td>
            	<td class="s_label">品类：</td>
                <td class="w18">
                	<select name="categoryId">
                		<option value="">请选择</option>
                    	<option value="11" <#if categoryId == 11>selected</#if>>景区门票</option>
                    	<option value="13" <#if categoryId == 13>selected</#if>>组合套餐票 </option>
                    	<option value="12" <#if categoryId == 12>selected</#if>>其他票</option>
                	</select>
                </td>
              </tr>
              <tr>
                <td class="s_label">产品名称：</td>
                <td class="w18"><input type="text" name="productName" value="${productName!''}"></td>
                
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                 <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
	</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th><input type="checkbox" name="allSelect" >全选</th>
        	<th>产品ID</th>
            <th>产品名称</th>
            <th>商品ID</th>
            <th>商品名称</th>
            </tr>
        </thead>
        <tbody>
        	<#if pageParam != null>
				<#list pageParam.items as suppGoodsEbkBindVO> 
					<tr>
					<td>
						<input type="checkbox" name="suppGoodsId" value="${suppGoodsEbkBindVO.suppGoodsId!''}" data="${suppGoodsEbkBindVO.reId}">
					 </td>
					<td>${suppGoodsEbkBindVO.productId!''} </td>
					<td>${suppGoodsEbkBindVO.productName!''} </td>
					<td>${suppGoodsEbkBindVO.suppGoodsId!''} </td>
					<td>${suppGoodsEbkBindVO.goodsName!''} </td>
					</tr>
				</#list>
			</#if>
        </tbody>
    </table>
     <table class="co_table">
        <tbody>
            <tr>
                 <td class="s_label">
                 	<#if pageParam != null && pageParam.items?exists> 
						<div class="paging" > 
						${pageParam.getPagination()}
						</div> 
					</#if>
                 </td>
            </tr>
        </tbody>
    </table>	
</div><!--p_box-->
	<#if toBindingGoods == 'Y'>
		<button class="pbtn pbtn-small btn-ok" style="float:left;margin-top:20px;" id="addButton">批量绑定</button>
	<#else>
		<button class="pbtn pbtn-small btn-ok" style="float:left;margin-top:20px;" id="delButton">批量删除</button>
	</#if>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button class="pbtn pbtn-small btn-ok" style="float:left;margin-top:20px;" id="cancelButton">取消</button>
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
//设置checkbox选择,全选 
$("input[type=checkbox][name=allSelect]").click(function(){ 
	if(this.checked){
		  $("input[type=checkbox][name='suppGoodsId']").attr("checked",true);
	  }else{
		  $("input[type=checkbox][name='suppGoodsId']").attr("checked",false);
	  }
});

//查询
$("#search_button").bind("click",function(){
    if(!$("#searchForm").validate().form()){
		return;
	}
	$("#searchForm").submit();
});
 
$("#addButton").bind("click",function(){
	var selectSuppGoodsId=",";
	$("input[type='checkbox'][name=suppGoodsId]").each(function(){
	     if($(this).attr("checked")=='checked'){
	         selectSuppGoodsId = selectSuppGoodsId + $(this).val() + ",";
	     }
	});
	if(selectSuppGoodsId == ","){
		alert("请选择需要绑定的商品");
		return;
	}
	$("#addButton").attr("disabled","disabled");
	
	var userId = $("#userId").val();
	
	$.ajax({
		url : "/vst_back/ebooking/userManager/addBindingTicket.do",
		type : "post",
		data : {"userId":userId, "selectSuppGoodsId":selectSuppGoodsId},
		success : function(result) {
			$("#addButton").hide();
			confirmAndRefresh(result);
		}
	});
});

$("#delButton").bind("click",function(){

	var selectReId=",";
	$("input[type='checkbox'][name=suppGoodsId]").each(function(){
	     if($(this).attr("checked")=='checked'){
	         selectReId = selectReId + $(this).attr("data") + ",";
	     }
	});
	if(selectReId == ","){
		alert("请选择解除绑定的商品");
		return;
	}
	var userId = $("#userId").val();
	$("#delButton").attr("disabled","disabled");
	$.ajax({
		url : "/vst_back/ebooking/userManager/delBindingTicket.do",
		type : "post",
		data : {"selectReId":selectReId},
		success : function(result) {
			$("#delButton").hide();
			confirmAndRefresh(result);
		}
	});
});

$("#cancelButton").bind("click",function(){
	parent.selectUserBindingTicketDialog.close();
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			parent.selectUserBindingTicketDialog.close();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$.alert(result.message);
		}});
	}
};
</script>


