
<body>
<#--页面导航-->
<div id="logResultList" class="divClass">
 <table class="p_table table_center" >

  
    <thead>
        <tr>
              <TR>
				<th  nowrap="nowrap">出发日期</th>
				<th  nowrap="nowrap">成人市场价</th>
				<th  nowrap="nowrap">成人销售价</th>
				<th  nowrap="nowrap">成人结算价</th>
				<th  nowrap="nowrap">儿童市场价</th>
				<th  nowrap="nowrap">儿童销售价</th>
				<th  nowrap="nowrap">儿童结算价</th>
				<th  nowrap="nowrap">是否可售</th>
				<th  nowrap="nowrap">库存类型</th>
				<th  nowrap="nowrap">退改类型</th>
				
				
			</TR>
        </tr>
    </thead>
    <tbody>
     
    	<#list resultList  as timePrice>
		    <TR>
			<TD>${timePrice.specDate?string('yyyy-MM-dd')} </TD>
			<TD>${timePrice.auditMarketPrice/100!''}</TD>
			<TD>${timePrice.auditPrice/100!''}</TD>
			<TD>${timePrice.auditSettlementPrice/100!''}</TD>
			<TD>${timePrice.childMarketPrice/100!''}</TD>
			<TD>${timePrice.childPrice/100!''}</TD>
			<TD>${timePrice.childSettlementPrice/100!''}</TD>
			<TD>
			<#if timePrice.onsaleFlag=='Y'>
			 可售
			<#else>
			不可售
			</#if>
			</TD>
			<TD>${timePrice.stockType!''}</TD>
			<td>
			<#if timePrice.cancelStrategy == 'MANUALCHANGE'>人工退改</#if> 
			<#if timePrice.cancelStrategy =='UNRETREATANDCHANGE'>不退不改</#if>
			</td>
			</TR>
	   </#list>
   
                
    </tbody>
   
    <#--分页标签
   <TR>
  <TD COLSPAN ="6">
   <@pagination.paging pageParam true "#logResultList"/>
  
  <@pagination.paging pageParam>
 </@pagination.paging>
  </TD>
  </TR>
   -->
 
</table>
</div>
<#--页脚-->
<#include "/base/foot.ftl"/>
</body>
