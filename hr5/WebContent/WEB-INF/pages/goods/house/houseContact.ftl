<div class="iframe-content">  
<div class="f14"><strong>联系方式</strong></div>

<div class="f14"><strong>酒店联系方式</strong></div>
<div class="f14">电话：${houseTel}&nbsp;传真：${houseFax}</div>

<div class="f14"><strong>供应商合同负责</strong></div>
<div class="f14">产品经理：${managerName}</div>

<div class="f14"><strong>供应商联系人</strong></div>
  
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                	<th>联系人</th>
                	<th>电话</th>
                    <th>性别</th>
                    <th>手机</th>
                    <th>说明</th>
                    <th>职务</th>
                    <th>email</th>
                    <th>地址</th>
                    <th>其它联系方式</th>
                    </tr>
                </thead>
                <tbody>
					<#list contactList as contact > 
					<tr>
					<td>${contact.name!''} </td>
					<td>${contact.tel!''} </td>
					<td><#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if> </td>
					<td>${contact.mobile!''} </td>
					<td>${contact.personDesc!''} </td>
					<td>${contact.job!''} </td>
					<td>${contact.email!''} </td>
					<td>${contact.address!''} </td>
					<td>${contact.otherAddress!''} </td>
					</tr>
					</#list>
                </tbody>
            </table>
       
	</div><!-- div p_box -->

	
</div>


