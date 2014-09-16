<form action="#" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${supplier.supplierId}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label" nowrap="nowrap"><span class="notnull"></span>供应商名称：</td>
                <td>
                	${supplier.supplierName}
                </td>
                <td class="p_label" nowrap="nowrap"><span class="notnull"></span>供应商类型：</td>
                <td>
                	${supplier.supplierType!''}
                </td>
            </tr> 
			<tr>
				<td class="p_label"><span class="notnull"></span>所在地区：</td>
                <td>
                	${supplier.supplierDistrict!''}
                </td>
                <td class="p_label"><span class="notnull"></span>地址：</td>
                <td>
                	${supplier.address}
                </td>
            </tr>
            <tr>
                <td class="p_label"><span class="notnull"></span>电话：</td>
                <td>
                	${supplier.tel}
                </td>
                <td class="p_label">传真：</td>
                <td>
                	${supplier.fax}
                </td>
            </tr>
            <tr>
                <td class="p_label">网址：</td>
                <td>
                	${supplier.site}
                </td>
                <td class="p_label">邮编：</td>
                <td>
                	${supplier.zip}
                </td>
            </tr>
            
            <tr>
               
                <td class="p_label">父供应商：</td>
                <td>
                	${supplier.fatherSupplier!''}
                </td>
            </tr>
        </tbody>
    </table>
    <table class="p_table table_center">
                <thead>
                    <tr>
                   <th> 姓名</th>
                   <th>电话</th>
                    <th>手机</th>
                    <th>性别</th>
                    <th>职务</th>
                    <th>说明</th>
                    <th>email</th>
                    </tr>
                </thead>
                <tbody>
					<#list suppContactList as suppContact> 
					<tr>
					<td>${suppContact.name!''} </td>
					<td>${suppContact.tel!''} </td>
					<td>${suppContact.mobile!''} </td>
					<td><#if suppContact.sex == "MAN">先生<#else>女士 </#if> </td>
					<td>${suppContact.job!''} </td>
					<td>${suppContact.personDesc!''} </td>
					<td>${suppContact.email!''} </td>
					
					</tr>
					</#list>
					 <TR>
  <TD COLSPAN ="7">
  	 <a class="btn btn_cc1" id="closeLog" >关闭</a>
  	
  </TD>
  </TR>
                </tbody>
     </table>
</form>

<script type="text/javascript">

         $("#closeLog").bind("click",function(){
         
         	viewSupplierDialog.close();
         });
 </script>