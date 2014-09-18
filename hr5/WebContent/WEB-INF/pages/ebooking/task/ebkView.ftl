<#import "/base/spring.ftl" as spring/>
<!DOCTYPE html>
<html>
<head>
<title>订单管理-订单查看</title>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="wrap">
    <p class="einfo">
        <span class="eitem">订单号：
        <b>
           <#list ebkTask.ebkCertif.ebkCertifItemList as item>
	        		${item.orderId!''}
	       </#list>
        </b>
      </span>
    </p>

        <div class="main_order_info">
            <table>
                <tr>
                    <td class="label">客户姓名：</td>
                    <td>${personNames}<span class="ml10">共<i class="orange">${personSize}</i>人</span></td>
                </tr>
                <tr>
                    <td class="label">住店日期：</td>
                    <td><span class="orange">${ebkTask.visitTime?string('yyyy-MM-dd')} 至 ${ebkTask.leaveTime?string('yyyy-MM-dd')}（共${dateDay}晚）</span></td>
                </tr>
                <tr>
                    <td class="label">预订房型：</td>
                    <td><#list ebkTask.ebkCertif.ebkCertifItemList as item>
			        		${item.suppGoodsName!''} 
			        	</#list> ${ebkTask.quantity}间 
                        <#list ebkTask.ebkCertif.ebkCertifItemList as item>
			        		<span class="orange">
			        			<#if item_index == 0>
			        				<#if item.resourceSendfaxFlag == 'Y'>
			        					(保留房)
			        				</#if>
			        			</#if>
		        			</span>
			        	 </#list> 
                   </td>
                </tr>
                <tr>
                    <td class="label vtop">房价：</td>
                    <td>
                    <span class="mr10">
                   <#list ebkTask.ebkCertif.ebkCertifItemList as item>
							<#if item_index == 0>
								<#list item.ebkCertifTimePriceList as timePrice>
					        		<span class="mr10">
					        			${timePrice.visitTime?string('yyyy-MM-dd')}至${timePrice.leaveTime?string('yyyy-MM-dd')}
				        			</span>
			                    	<span class="mr10">
			                    	<#if ebkTask.ebkCertif?? && ebkTask.ebkCertif.paymentTarget == 'PAY'>
						                <#if timePrice.priceYuan??>RMB ${timePrice.priceYuan?string("0.##")}</#if>
						            <#elseif ebkTask.ebkCertif?? && ebkTask.ebkCertif.paymentTarget == 'PREPAID'>
						                <#if timePrice.settlementPriceYuan??>RMB ${timePrice.settlementPriceYuan?string("0.##")}</#if>
						            </#if>
			                    	</span>
		            	  				<#if timePrice.breakfast gt 0 >
											（含早${timePrice.breakfast}份）
										<#else>
											（不含早）
										</#if>	 
			                    	<br>
			                    </#list>
			                </#if>  
		        		</#list>         
                    </span>
                    </td>
                </tr>
                <tr>
                    <td class="label vtop">付款方式：</td>
                    <td>
                    <span class="mr20">${ebkTask.ebkCertif.paymentCN}</span>
                    	共计 <span class="orange">
                    		<#if ebkTask.ebkCertif?? && ebkTask.ebkCertif.paymentTarget == 'PAY'>
                    			RMB ${ebkTask.ebkCertif.sumPrice?string("0.##")}
                    		<#elseif ebkTask.ebkCertif?? && ebkTask.ebkCertif.paymentTarget == 'PREPAID'>
                    			RMB ${ebkTask.ebkCertif.sumSettlementPrice?string("0.##")}
                    		</#if>
                    		</span> 元（含服务费）<span class="tip-icon tip-icon-warning ml20"></span>
                    		 此价格为结算价，不要向客人透露，否则由此造成的损失由酒店承担
                    </td>
                </tr>
                <tr>
                    <td class="label vtop">特殊要求：</td>
                    <td>
                      	<#list ebkTask.ebkCertif.ebkCertifItemList as item>
							${item.faxMemo}
		        		</#list>   
                    </td>
                </tr>
                <tr>
                    <td class="label"></td>
                    <td></td>
                </tr>
            </table>
             <div class="solid_line mt10 mb10"></div>
             <table>
	                <tr>
	                    <td class="label">确认结果：</td>
	                    <td>
	                    	<b class="red">
								${ebkTask.ebkCertif.zhCertificateTypeStatus}	                    	
							</b>
						</td>
	                </tr>
	                <tr>
	                    <td class="label">确认人：</td>
	                    <td>
	                    	${ebkTask.ebkCertif.confirmUserName}
	                    </td>
	                </tr>
	                <tr>
	                    <td class="label">确认时间：</td>
	                    <td>
	                    	${ebkTask.ebkCertif.confirmDate}
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="label">酒店预订号：</td>
	                    <td>
	                    	  	<#list ebkTask.ebkCertif.ebkCertifItemList as item>
		                			<#if item_index == 0> 
		                				${item.supplierNo}
		                			</#if>
	                		    </#list> 
								<span style="font-family:Arial;font-size:13px;font-weight:normal;font-style:normal;text-decoration:none;color:#333333;">
								</span>
	                    </td>
	                </tr>
	                
	                <#if actionType =='process'>
	                <tr>
	                <td class="label">预订确认：</td>
	                <td>
	                <#if ebkTask.ebkCertif.certifStatus =='CREATE' && ebkTask.ebkCertif.certifType != 'ENQUIRY' && ebkTask.ebkCertif.certifType != 'CANCEL'>
	                     <span class="mr20">
	                    	 ${ebkTask.ebkCertif.zhCertificateTypeStatus} 
	                     </span>
	                </#if>
	                </td>
	                </tr>
	                </#if>
	                <tr>
	                    <td class="label vtop">确认备注：</td>
	                    <td>
	                    ${ebkTask.ebkCertif.memo}
                        </td>
	                </tr>
             </table>
        </div>
     </div>
        
<#include "/base/foot.ftl"/>
</body>
</html>


