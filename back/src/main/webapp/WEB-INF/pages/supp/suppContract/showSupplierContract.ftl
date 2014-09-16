<form action="#" method="post" id="contractAddForm">
	<span>供应商信息：</span>
        <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label" style="width:120px;">供应商名称：</td>
                <td style="width:270px;">
                	${suppSupplier.supplierName}" 
                </td>
                <td class="p_label" style="width:120px;" >供应商类型：</td>
                <td>${suppSupplier.supplierTypeCN}</td>
            </tr> 
			<tr>
				<td class="p_label">所在地区：</td>
                <td>
                ${district}
                </td>
                <td class="p_label">地址：</td>
                <td>
                	${suppSupplier.address}
                </td>
            </tr>
            <tr>
                <td class="p_label">电话：</td>
                <td>
             	 ${suppSupplier.tel}
                </td>
                <td class="p_label">传真：</td>
                <td>
                	${suppSupplier.fax}
                </td>
            </tr>
            <tr>
                <td class="p_label">网址：</td>
                <td>
                	${suppSupplier.site}
                </td>
                <td class="p_label">邮编：</td>
                <td>
                ${suppSupplier.zip}
                </td>
            </tr>
            <tr>
                <td class="p_label">法定代表人：</td>
                <td>
                	${suppSupplier.legalRep}
                </td>
                <td class="p_label">旅行社许可证：</td>
                <td>
              	  ${suppSupplier.permit}
                </td>
            </tr>
            <tr>
                <td class="p_label">父供应商：</td>
                <td>
                    ${fSupplier}
                </td>
            </tr>
        </tbody>
        </table>
      
	  <span>合同基本信息</span>
    	<table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label" style="width:120px;" >名称：</td>
                <td style="width:270px;">
               		${suppContract.contractName}
                </td> 
                <td class="p_label" style="width:120px;" >合同编号：</td>
                <td>
                	${suppContract.contractNo}
                 </td>
            </tr> 
			<tr>
				<td class="p_label">合同类型：</td>
                 <td>${suppContract.contractTypeCN}</td>
                <td class="p_label">有效期：</td>
                <td>
                	${suppContract.startTime?string("yyyy-MM-dd")}&nbsp;-&nbsp;
                	${suppContract.endTime?string("yyyy-MM-dd")}
				</td>
            </tr>
            <tr>
                <td class="p_label">签署日期：</td>
                <td>
                ${suppContract.signTime?string("yyyy-MM-dd")}
                </td>
                <td class="p_label">经办人：</td>
                <td>
                	${operatorUser}
                </td>
            </tr>
            <tr>
                <td class="p_label">产品经理：</td>
                <td>
                    ${managerUser}
                </td>
                <td class="p_label">会计主体：</td>
                 <#if accSubject=="JOYU"> <td>景域文化传播有限公司</td>
                 <#elseif accSubject=="LVMAMA_XINGLV"> <td>驴妈妈兴旅国际旅行社有限公司</td>
                 <#elseif accSubject=="LVMAMAM_INTERNATIONAL"> <td>驴妈妈国际旅行社有限公司</td>
                 <#elseif accSubject=="LVMAMA"> <td>驴妈妈旅游网</td>
                 <#elseif accSubject=="LVMAMAM_INTERNATIONAL_HUANGSHAN"> <td>上海驴妈妈国际旅行社有限公司黄山分公司</td>
                 <#elseif accSubject=="LVMAMAM_INTERNATIONAL_SANYA"> <td>上海驴妈妈国际旅行社有限公司三亚分公司</td>
                 <#elseif accSubject=="LVMAMA_XINGLV_CHENGDU"> <td>上海驴妈妈兴旅国际旅行社有限公司成都分公司</td>
                  <#elseif accSubject=="LVMAMA_XINGLV_BEIJING"> <td>上海驴妈妈兴旅国际旅行社有限公司北京分公司</td>
                  <#elseif accSubject=="LVMAMA_XINGLV_GUANGZHOU"> <td>上海驴妈妈兴旅国际旅行社有限公司广州分公司</td>
                  <#elseif accSubject=="LVMAMA_XINGLV_HANGZHOU"> <td>上海驴妈妈兴旅国际旅行社有限公司杭州分公司</td>
                  <#else> <td></td>
                 </#if>
            </tr>
        </tbody>
        </table>
        
      <span>变更及补充单</span>
         <table class="p_table form-inline">
            <thead>
            	<th>类型</th>
            	<th>变更内容说明</th>
            	<th>录入时间</th>
            	<th>变更副本</th>
            </thead> 
            <tbody>
            <#list suppContractChangeList as suppContractChange> 
	             <tr>
		             <td class="p_label" style="width:120px;" >${suppContractChange.changeTypeCN}</td>
		           	 <td style="width:270px;">${suppContractChange.changeDesc}</td>	
		           	 <#if suppContractChange??&&suppContractChange.createTime??><td>${suppContractChange.createTime?string("yyyy-MM-dd")}</td>
		           	 <#else><td></td>
		           	 </#if>
		           	 <td>
						<#if suppContractChange.attachment??><a href="/vst_back/pet/ajax/file/downLoad.do?fileId=${suppContractChange.attachment}">下载变更附件 </a>
		           	 	</#if>		           	 
		           	 </td>	
	             </tr>
            </#list>
            </tbody>
        </table>
        
     <span> 结算</span>
    	<table class="p_table form-inline">
        <tbody>   
            <tr>	
            	 <td class="p_label" style="width:120px;" >结算方名称：</td>
                <td>
                 <#if suppSettleRule.settleName!=null>${suppSettleRule.settleName}</#if>		           	
                </td>				
                <td class="p_label" style="width:120px;" >开户名称：</td>
                <td style="width:270px;">
                 <#if suppSettleRule.accountName!=null>${suppSettleRule.accountName}</#if>                    
                </td>
            </tr> 
            <tr>	
             	<td class="p_label" style="width:120px;" >开户银行：</td>
                <td>
                 <#if suppSettleRule.accountBank!=null>${suppSettleRule.accountBank}</#if>		           	
                </td>				
                <td class="p_label">开户账户：</td>
                <td>
                 <#if suppSettleRule.accountNo!=null>${suppSettleRule.accountNo}</#if>	           	
                </td>     
            </tr> 
			 <tr>					
                <td class="p_label">支付宝账号：</td>
                <td>
                 <#if suppSettleRule.alipayNo!=null>${suppSettleRule.alipayNo}</#if>	           	
                </td>
                <td class="p_label">支付宝用户名：</td>
                <td>
                 <#if suppSettleRule.alipayName!=null>${suppSettleRule.alipayName}</#if>	           	
                </td>
            </tr> 
             <tr>					
                <td class="p_label">我方结算主体：</td>                    
                  	 <#if lvAccSubject=="DEFAULT"> <td>上海景域文化传播有限公司</td>
                     <#elseif lvAccSubject=="LVMAMA"> <td>上海驴妈妈国际旅行社有限公司</td>
                     <#elseif lvAccSubject=="LVMAMAXINGLV"> <td>上海驴妈妈兴旅国际旅行社有限公司</td>
                      <#else> <td></td>
                     </#if> 
                 <td class="p_label"></td> <td></td>      
            </tr> 
            <tr>					
                <td class="p_label">结算周期：</td> 
	                <#if suppSettleRule.settlementPeriod=="PER_WEEK"> <td>周结</td>
	                <#elseif suppSettleRule.settlementPeriod=="PERMONTH"> <td>月结</td>
	                <#elseif suppSettleRule.settlementPeriod=="PERQUARTER"> <td>季结</td>
	                <#elseif suppSettleRule.settlementPeriod=="PER_HALF_MONTH"> <td>半月结</td>
	               	 <#else><td> 单结提前${suppSettleRule.settleCycle} 天</td>
	                </#if> 
                <td class="p_label"></td> <td></td> 
            </tr> 
            <tr>					
                <td class="p_label">结算方式：</td>  
                <#if settleType=="SETTLEMENT_PRICE"> <td>按结算价</td><#else> <td>返佣</td></#if>
                <td class="p_label"></td> <td></td> 
            </tr>       
            <tr>
            	<td class="p_label">其它：</td>   
            </tr>
            <tr>
                 <td class="p_label">类型：</td> 
                 <#if ruleType == "PERSON"><td>个人</td> <#else><td>公司</td></#if>   
                 <td class="p_label"></td> <td></td> 
           </tr>                
           <tr>                   
                <td class="p_label">付款方式：</td>                     
                 <#if payType=="MONEY"> <td>现金</td><#else> <td>转账</td></#if>
                <td class="p_label"></td> <td></td> 
            </tr>
            <tr>                   
               <td class="p_label"> 联行号：</td>                     
                <td>
              		 <#if suppSettleRule.unionBankNo!=null>${suppSettleRule.unionBankNo}</#if>                      
                </td>
               <td class="p_label"></td> <td></td>                  
            </tr>  
             <tr>                   
               <td class="p_label"> 财务联系人：</td>                     
                <td colspan="3">
                     <div class="suppliersContacList">
                     <#list contactlist as contact> 
                        <span><input type='hidden' name='pids' value='${contact.personId}'>姓名：${contact.name} &nbsp;性别：<#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if>&nbsp;电话：${contact.tel}&nbsp;<a href= 'javascript:delContact("${contact.personId}");' id='a_${contact.personId}' class='delContact'></a></span><br>
                     </#list>
                     </div>
                </td>
            </tr>               
        </tbody>
        </table>
        
	
</form>
	<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="contractSaveButton">关闭</button>
<script> 
var selectSupplierDialog;

$("#contractSaveButton").bind("click", function() {
	showContractDialog.close();
});
</script>
