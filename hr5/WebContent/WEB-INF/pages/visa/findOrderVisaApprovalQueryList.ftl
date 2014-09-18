<!DOCTYPE html>
<html>
<head>

<#import "/base/spring.ftl" as spring/>
<#include "/base/head_meta.ftl"/>
<#import "/base/pagination.ftl" as pagination>
</head>
<body>
<div id="logResultList">
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/visa/approval/findOrderVisaApprovalQueryList.do" method="post">
         
         <input type="hidden" name="searchOrderId" value="${RequestParameters.searchOrderId}">
       
         <table class="s_table">
            <tbody>
                <tr>
                
                 <td class="s_label">游客：</td>
                    <td class="w18">
                    	<select name="occupId" id="occupId" >
		                    <#list resultMap?keys as testKey>  
		                   	 <option value="${testKey}" <#if testKey==RequestParameters.occupId >selected</#if> >${resultMap[testKey]}</option>
		                    </#list>  
                        </select>
				</td>
				
				<#--
                <td class="s_label">游客：</td>
                    <td class="w18">
                   	<select name="searchPersonId" id="searchPersonId" >
	                	<#list ordPersonList as person>
	                		<#if person.personType =='TRAVELLER'>
	                		<option value="${person.ordPersonId!''}" <#if person.ordPersonId ==RequestParameters.searchPersonId >selected</#if> >${person.fullName!''}</option>
	                		</#if>
	                	</#list>
	            	</select>
				</td>
					
					
					<td class="s_label">签证商品：应该为签证材料去关联查询</td>
                    <td class="w18">
                   	<select name="suppGoodsId" id="suppGoodsId" >
	                	<#list visaOrderItemList as ordItem>
	                		<option value="${ordItem.suppGoodsId!''}" <#if ordItem.suppGoodsId==RequestParameters.suppGoodsId >selected</#if> >${ordItem.suppGoodsName!''}</option>
	                	</#list>
	            	</select>
					</td>
					-->
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                </tr>
            </tbody>
        </table>	
	</form>
</div>

<div class="iframe-content">  
 <#if detailList?size gt 0 >
 &nbsp;&nbsp; &nbsp;&nbsp;<span class="f14" style="color:#FF0000;">${visaApproval.name}</span>的签证材料明细：
 （所属人群-
 <#if bizVisaDocOccup??>
 ${bizVisaDocOccup.occupType}
 <#else>
 无
 </#if>
 ）
 
    <br/><br/>
    <strong>
 &nbsp;&nbsp; &nbsp;&nbsp;材料状态： 
  </strong>
      ${visaApproval.docStatusName}  
    <strong>
    &nbsp;&nbsp; &nbsp;&nbsp; 材料审核状态  ：
    </strong>
  ${visaApproval.apprStatusName}  &nbsp;&nbsp; &nbsp;&nbsp; 
  <strong>
  送/出签状态:
   </strong>
  ${visaApproval.visaStatusName}
</#if> 
 
     

    
    
   
    <table class="p_table table_center">
	<thead>
		<tr>
	        <th class="w8">材料名称</th>
	        <th class="w8">材料明细</th>
	        <th class="w8">审核状态</th>
	        <th class="w8">备注</th>
	    </tr>
	 </thead>
	<tbody>
		<#list detailList as detail>
		<tr>
				<td>${detail.title}</td>
				<td>${detail.content}</td>
				<td>
					<#if detail.apprStatus=='APPR_UN'>
	            		未审核
	            	<#elseif detail.apprStatus=='APPR_IN'>
	            		审核中
	            	<#elseif detail.apprStatus=='APPR_UNPASS'>
	            		审核不通过
	            	<#elseif detail.apprStatus=='APPR_PASS'>
	            		审核通过
	            	</#if>
				</td>
				<td>${detail.memo}</td>
		</tr>
		</#list>
   </tbody>
  </table>
    
    </br>
    
     <table class="p_table table_center">
	<thead>
		<tr>
	        <th class="w8">

保证金形式
</th>
	        <th class="w8">

开户银行
</th>
	        <th class="w8">保证金金额（单位：元）</th>
	        <th class="w8">

保证金状态
	        </th>
	    </tr>
	 </thead>
	<tbody>
		<#list visaApprovalDepositList as detail>
		<tr>
				<td>${detail.depositType}</td>
				<td>${detail.bank}</td>
				<td>
					${detail.amount/100.0}
				</td>
				<td>${detail.depStatus}</td>
		</tr>
		</#list>
   </tbody>
  </table>
  
</div><!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
//查询
$("#search_button").click(function(){
  			$.ajax({
  				url : '/vst_back/visa/approval/findOrderVisaApprovalQueryList.do',
  				type : 'POST',
  				data : $("#searchForm").serialize(),
  				success : function(res){
  					$("#logResultList").html(res);
  				}
  			});
  		});
  		
  		<#--
$("#search_button").click(function(){

	$("#searchForm").submit();
});
-->
</script>


