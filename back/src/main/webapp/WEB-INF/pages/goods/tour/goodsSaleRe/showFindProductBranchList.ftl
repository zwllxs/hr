<#--页眉-->
<#import "/base/spring.ftl" as spring/>
<#import "/base/pagination.ftl" as pagination>
<#--页面导航-->
<div class="p_box box_info">
	<form method="post"  id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                	<td class="s_label">品类：</td>
                    <td class="w18"><select name="categoryId">
                    	<option value="11">门票</option>
                    	<option value="12">其它票</option>
                    	<option value="16">当地游</option>
                    	<option value="21">其它机票</option>
                    	<option value="23">其它火车票</option>
                    	<option value="25">其它巴士</option>
                    	<option value="27">其它船票</option>
                    </select></td>
                    <td class="s_label">产品名称：</td>
                    <td class="w18"><input type="text" name="productName" value="${productName!''}"></td>
                    <td class="s_label">产品ID：</td>
                    <td class="w18"><input type="text" name="productId" value="${productId!''}" number="true" ></td>
                    <td class=" operate mt10">
                   	<a class="btn btn_cc1" id="search_button">查询</a> 
                    </td>
                </tr>
            </tbody>
        </table>	
		</form>
</div>
<form id="dataForm">
<input type="hidden" name="mainProductId" id="mainProductId">
<div class="p_box" id="logResultList">
            <table class="p_table table_center product">
                <thead> 
                    <tr class="noborder">
                        <th class="w10">产品类型</th>
                        <th class="w10 text_left">产品ID</th>
                        <th class="text_left">产品名称</th>       
                        <th class="text_left">规格</th>   
                    </tr>
                </thead>
                <tbody>
                    <#if pageParam?? && pageParam.items?? && pageParam.items?size &gt;  0>
                    <#list pageParam.items  as prod>
                    <tr>
                        <td class="w10"></td>
                        <td class="w10 text_left">${prod.productId}</td>
                        <td class="text_left">${prod.productName}</td>
                        <td class="w10"></td>       
                    </tr>
                    </#list>
                    <#else>
                    <tr class="table_nav"><td colspan="4"><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td>	</tr>
                    </#if>
                </tbody>
            </table>
            <#if pageParam?? && pageParam.items?? && pageParam.items?size &gt;  0>
            <div class="pages darkstyle">	
            	<@pagination.paging pageParam true "#logResultList"/>
			 </div>
		 </#if>
  </div>
   </form>
  <div class="operate">
  	<a class="btn btn_cc1" id="save_addition">添加到附加</a> 
  </div>
  <script>
  		$("#search_button").click(function(){
  			$.ajax({
  				url : '/vst_back/tour/goods/goods/suppGoodsSaleProductList.do',
  				type : 'POST',
  				data : $("#searchForm").serialize(),
  				success : function(res){
  					$("#logResultList").html(res);
  				}
  			});
  		});
  		
  		//设置week选择,全选
		$("input[type=checkbox][name=All]").live("click",function(){
			if($(this).attr("checked")=="checked"){
				$("input[type=checkbox][name=productBranchIds]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=productBranchIds]").removeAttr("checked");
			}
		})
		
		
		 //设置week选择,单个元素选择
		$("input[type=checkbox][name=productBranchIds]").live("click",function(){
			if($("input[type=checkbox][name=productBranchIds]").size()==$("input[type=checkbox][name=productBranchIds]:checked").size()){
				$("input[type=checkbox][name=All]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=All]").removeAttr("checked");
			}
		});
		
		//保存添加到附加
		$("#save_addition").click(function(){
			if($("input[type=checkbox][name=productBranchIds]:checked").size()==0){
				$.alert("请选择规格");
				return;
			}else {
				//保存
				$("#mainProductId").val($("#mainProductId1").val());
				$.ajax({
  				url : '/vst_back/tour/goods/goods/saveGoodsSaleRe.do',
  				type : 'POST',
  				async : false,
  				data : $("#dataForm").serialize(),
  				success : function(message){
  					prodBranchSelectDialog.close();
  					goodsSaleUpdateDialog = pandora.dialog({
					wrapClass: "dialog-big",
					width: 1000,
					height: 600,
					title : "设置规则",
					content : message
				});
  				}
  			});
			}
		});
  </script>