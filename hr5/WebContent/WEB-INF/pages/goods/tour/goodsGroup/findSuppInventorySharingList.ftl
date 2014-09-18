<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">酒店</a> &gt;</li>
            <li><a href="#">商品维护</a> &gt;</li>
            <li class="active">库存共享</li>
        </ul>
</div>
<div class="iframe_content mt10">    
        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">注:</p>
         </div>  
        <div class="p_box box_info">
        <form method="post" action='/vst_back/goods/tour/goodsGroup/showSuppInventorySharingList.do' id="searchForm">
            <table class="e_table form-inline">
            <input  type="hidden" id="productId" name="productId" value="${productId}"/>
             <input  type="hidden" id="categoryId" name="categoryId" value="${categoryId}"/>
            <tbody>             
                    <tr>
                        <td style="width:80px" class="e_label">选择供应商：</td>
                        <td style="width:160px">
                            <select id="supplierId" name="supplierId"  style="width:260px">
                            	<#list suppSupplierList as suppSupplier>
								<option value="${suppSupplier.supplierId!''}"> ${suppSupplier.supplierName!''}</option>
                				</#list>
					        </select>
                        </td>
                        <td style="width:10px"></td>
                        <td>
							<div class="fl operate"><a class="btn btn_cc1" id="search_button">查询</a></div>
						</td> 
					  </tr> 
					  <tr>
					   <td colspan='2'></td>
					   </tr>
					                    
                </tbody>
            </table>
           </form> 
        </div>
 <!-- 主要内容显示区域\\ -->   
        <div class="p_box box_info">
            <div >       
                        <#list suppGoodsGroupList as suppGoodsGroup>                        
						<h2 class="f16 mb10" style="display:inline-block;">	共享组:</h2>${suppGoodsGroup.groupName}<a href="javascript:void(0);" class="editGoods" supplier="${suppGoodsGroup.supplierId}"  groupId="${suppGoodsGroup.groupId}">增加 </a>
						
						<table class="p_table table_center">
						  <thead>
							 <tr>
								<th>规格</th>
								<th>规格类型</th>
								<th>名称</th>
								<th>商品是否有效</th>
								<th>商品编号</th>
								<th>商品名</th>
								<th>操作</th>
							  </tr>
							 </thead> 
								<tr>
								<#list suppGoodsGroup.getSuppGoodsList() as suppGoods> 		
								<td>${suppGoods.bizBranch.branchName}</td>							    
								<#if suppGoods.bizBranch.attachFlag=="Y"><td>主规格</td></#if>
								<#if suppGoods.bizBranch.attachFlag=="N"><td> 次规格</td></#if>
								<td>${suppGoods.prodProductBranch.branchName}</td>	
								<#if suppGoods.cancelFlag=="Y"><td>有效</td></#if>
								<#if suppGoods.cancelFlag=="N"><td>无效</td></#if>								
								<td>${suppGoods.suppGoodsId}</td>	
								<td>${suppGoods.goodsName}</td>	
								<td><a href="javascript:void(0);" class="deleteGoods" groupId="${suppGoods.groupId}" supplierId="${suppGoods.supplierId}" suppGoodsId="${suppGoods.suppGoodsId}">删除</a></td>

								</tr>	
						      </#list> 
						       </table> 	
					     </#list>               
        </div>				
				
 </div>
 <div class="fl operate"><a class="btn btn_cc1" id="add_button">新增库存共享</a></div>
<!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>
<script>
		var selectGoodsDialog;	
		$(function(){
			$("#searchForm #supplierId").val("${supplierId!''}");
			$("input[type=checkbox]").each(function() {
				if ($(this).attr("checked") == "checked") {
					$(this).parent("td").parent("tr").find("select").removeAttr("disabled");
				}
			});
		});	
		//新增库存共享
		$("#add_button").bind("click",function(){
		if($("#supplierId").val()!=null && $("#supplierId").val()!=""){	
			selectGoodsDialog=new xDialog("/vst_back/goods/tour/goodsGroup/showAddInventorySharing.do",{supplierId:$("#supplierId").val(),productId:$("#productId").val()},{title:"新增库存共享",width:"800"});
		}else{
			alert("请先选择供应商！");
		}
		});
		
		//编辑库存共享
		$(".editGoods").bind("click",function(){		
			var groupId=$(this).attr("groupId");$(this).attr("groupId");
			var supplier=$(this).attr("supplier");;	
			if(groupId!=null && groupId!=""){	
				selectGoodsDialog=new xDialog("/vst_back/goods/tour/goodsGroup/showUpdateGoodsGroup.do",{supplierId:supplier,groupId:groupId,productId:$("#productId").val()},{title:"编辑库存共享",width:"800"});
			}
		});
		
		//查询
		$("#search_button").bind("click",function(){
		if($("#supplierId").val()!=null && $("#supplierId").val()!=""){
			$("#searchForm").submit();
		}else{
			alert("请先选择供应商！");
		}	
		});
		
		//根据goodsId删除商品
   $(".deleteGoods").bind("click", function() {	   		
   		var suppGoodsId =$(this).attr("suppGoodsId");
   		var supplierId = $(this).attr("supplierId");
   		var groupId = $(this).attr("groupId");
   		 $.confirm("请找供应商再确认下，是否需要调整该共享组里面的商品现有的库存", function () {
		$.ajax({
			url : "/vst_back/goods/tour/goodsGroup/deleteGoods.do",
			data : {goodsId:suppGoodsId,supplierId:supplierId,groupId:groupId},
			type : "POST",
			dataType : "JSON",
			success : function(result) {
				if (result.code == "success") {	
					$("#searchForm").submit();
					alert(result.message, function() {
					});
				} else {
					alert(result.message);
				}
			}
			});
		},"确认");
	return false;
	});	
</script>