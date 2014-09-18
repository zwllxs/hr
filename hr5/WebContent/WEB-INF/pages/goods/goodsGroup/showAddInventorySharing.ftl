<div class="iframe_content mt10">       
        <div class="p_box box_info">        
        <form method="post" action="#" id="searchForm">
        <input type="hidden" id="supplierId" name="supplierId" value="${supplierId}">
        <input type="hidden" id="productId" name="productId" value="${productId}">
            <table class="p_table table_center">           
               <thead>
                    <tr>
                        <th></th>
                        <th>规格</th>
                        <th>主次</th>
                        <th>名称</th>
                        <th>商品名称</th>                       
                    </tr>
                </thead>
                <tbody>
                	<#list suppGoodsList as suppGoods> 
						<tr>						
						    <td><input type="checkbox" name="suppGoodsId" value="${suppGoods.suppGoodsId}"></td>
						    <#if suppGoods!=null&&suppGoods.bizBranch!=null&&suppGoods.bizBranch.branchName!=null>
						    <td>${suppGoods.bizBranch.branchName}</td>
						    </#if>
						     <#if suppGoods!=null&&suppGoods.bizBranch!=null&&suppGoods.bizBranch.attachFlag=="Y">
							<td>主规格</td>
							</#if>
							<#if suppGoods!=null&&suppGoods.bizBranch!=null&&suppGoods.bizBranch.attachFlag=="N">
							<td> 次规格</td>
							</#if>
							<td>${suppGoods.prodProductBranch.branchName!''} </td>
							<td>${suppGoods.goodsName} </td>						
                       </tr>
                    </#list>   
                </tbody>
            </table>
        </div>
         <div class="fl operate"><a class="btn btn_cc1" id="save_button">保存</a></div>
  </div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
		//保存
		$("#save_button").bind("click",function(){		 
			var str=new Array();//定义数组
			var tcheck=$("input:checked").each(function(){
				str.push($(this).val());//勾选的Id加入到数组中
			});
			if(str.lenght<1){
			alert("请选择需要共享库存的商品!");
			return;
			}
			var supplierId=$("#supplierId").val();
			var productId=$("#productId").val();
			$.ajax({
				url : "/vst_back/goods/goodsGroup/AddInventorySharing.do",
				type : "post",
				traditional:true,
				data:{goodsId:str,supplierId:supplierId,productId:productId},
				success : function(result) {
				if (result.code == "success") {				  
					selectGoodsDialog.close();
					 alert(result.message);
					$("#searchForm").submit();
			     } else {
				    alert(result.message);
			     }
				
			  }
	    });
	});
		
</script>