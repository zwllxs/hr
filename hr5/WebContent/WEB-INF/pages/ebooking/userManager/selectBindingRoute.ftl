<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
<form method="post" action='/vst_back/ebooking/userManager/selectBindingRoute.do' id="searchForm">

    <input type="hidden" name="userId"  id="userId" value="${userId}"/>
    <input type="hidden" name="supplierId" value="${supplierId}"/>
    <input type="hidden" name="toBindingRoute" value="${toBindingRoute}"/>
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
                        <#list bizCategories as category>
                            <#if category.categoryId == categoryId>
                                <option value="${category.categoryId!''}" selected="selected">${category.categoryName!''}</option>
                            <#else>
                                <option value="${category.categoryId!''}">${category.categoryName!''}</option>
                            </#if>
                        </#list>
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
            </tr>
        </thead>
        <tbody>
            <#if pageParam != null>
                <#list pageParam.items as route> 
                    <tr>
                    <td>
                        <#if toBindingRoute == "Y">
                            <input type="checkbox" name="productId" productId="${route.productId!''}">
                        <#else>
                            <input type="checkbox" name="productId" productId="${route.productId!''}" reId="${route.reId!''}">
                        </#if>
                     </td>
                    <td>${route.productId!''} </td>
                    <td>${route.productName!''} </td>
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
    <#if toBindingRoute == 'Y'>
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
//全选 
$("input[type=checkbox][name=allSelect]").click(function(){ 
    if(this.checked){
          $("input[type=checkbox][name='productId']").attr("checked",true);
      }else{
          $("input[type=checkbox][name='productId']").attr("checked",false);
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
    var selectedProductId=",";
    $("input[type='checkbox'][name=productId]").each(function(){
         if($(this).attr("checked")=='checked'){
        	 selectedProductId = selectedProductId + $(this).attr('productId') + ",";
         }
    });
    if(selectedProductId == ","){
        alert("请选择需要绑定的线路");
        return;
    }
    $("#addButton").attr("disabled","disabled");
    
    var userId = $("#userId").val();
    
    $.ajax({
        url : "/vst_back/ebooking/userManager/addBindingRoute.do",
        type : "post",
        data : {"userId":userId, "selectedProductId":selectedProductId},
        success : function(result) {
            $("#addButton").hide();
            confirmAndRefresh(result);
        }
    });
});

$("#delButton").bind("click",function(){

    var selectedReId=",";
    $("input[type='checkbox'][name=productId]").each(function(){
         if($(this).attr("checked")=='checked'){
        	 selectedReId = selectedReId + $(this).attr("reId") + ",";
         }
    });
    if(selectedReId == ","){
        alert("请选择解除绑定的路线");
        return;
    }
    var userId = $("#userId").val();
    $("#delButton").attr("disabled","disabled");
    $.ajax({
        url : "/vst_back/ebooking/userManager/delBindingRoute.do",
        type : "post",
        data : {"selectedReId":selectedReId},
        success : function(result) {
            $("#delButton").hide();
            confirmAndRefresh(result);
        }
    });
});

$("#cancelButton").bind("click",function(){
    parent.selectUserBindingRouteDialog.close();
});

function confirmAndRefresh(result){
    if (result.code == "success") {
        pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
            parent.selectUserBindingRouteDialog.close();
        }});
    }else {
        pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
            $.alert(result.message);
        }});
    }
};
</script>


