<#--页眉-->
<#import "/base/spring.ftl" as spring/>
<#import "/base/pagination.ftl" as pagination>
<#--页面导航-->
<div class="p_box" id="logResultList">
        <table class="p_table table_center product">
            <thead> 
                    <tr class="noborder">
                	<th class="w10"><input type="checkbox" class="checkbox_top" name="All"></th>
                    <th class="w10">产品类型</th>
                    <th class="w10 text_left">产品ID</th>
                    <th class="text_left">产品名称</th>       
                    <th class="text_left">规格</th>   
                </tr>
            </thead>
            <tbody>
               
                <#if pageParam?? && pageParam.items?? && pageParam.items?size &gt;  0>
                <#list pageParam.items  as ppb>
                <tr>
                	<td class="w10" align="center"><input type="checkbox" class="checkbox_top" name="productBranchIds" value="${ppb.productBranchId}"></td>
                    <td class="w10">${ppb.product.bizCategory.categoryName}</td>
                    <td class="w10 text_left">${ppb.product.productId}</td>
                    <td class="text_left">${ppb.product.productName}</td>
                    <td class="w30">${ppb.branchName}</td>       
                </tr>
                </#list>
                <#else>
                <tr class="table_nav"><td colspan="5"><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td>	</tr>
                </#if>
            </tbody>
        </table>
        <#if pageParam?? && pageParam.items?? && pageParam.items?size &gt;  0>
        <div class="pages darkstyle">	
        	<@pagination.paging pageParam true "#logResultList"/>
		 </div>
	 </#if>
  </div>
