<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<div class="iframe_search">
<form method="post" action='/vst_back/supp/supplier/selectSupplierList.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">供应商名称：</td>
                <td class="w18">
                <!--<input type="text" name="supplierName" value="${supplierName!''}">-->
                <input type="text" class="searchInput" name="supplierName" id="supplierName" value="${supplierName!''}" required=true>
                </td>
                <td class="s_label">供应商地区：</td>
                <td class="w18"><input type="text" name="supplierDistrict" value="${supplierDistrict!''}"></td>
                <td class="s_label">供应商ID：</td>
                <td class="w18"><input type="text" name="supplierId" value="${supplierId!''}"></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
            </tr>
        </tbody>
    </table>	
	</form>
</div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th>选择</th>
        	<th>编号</th>
            <th>供应商名称</th>
            <th>供应商地区</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as supplier> 
			<tr>
				<td>
					<input type="radio" name="supplier">
					<input type="hidden" name="supplierId" value="${supplier.supplierId!''}">
					<input type="hidden" name="supplierName" value="${supplier.supplierName!''}">
					<input type="hidden" name="supplierType" 
						<#list supplierTypeList as supplierType>
		            		<#if supplier.supplierType == supplierType.code>value="${supplierType.cnName!''}"</#if>
		            	</#list>
					/>
					<input type="hidden" name="tel" value="${supplier.tel!''}">
					<input type="hidden" name="supplierDistrict" value="<#if supplier.supplierDistrict??>${supplier.supplierDistrict!''}</#if>">
					<input type="hidden" name="address" value="${supplier.address!''}">
					<input type="hidden" name="zip" value="${supplier.zip!''}">
					<input type="hidden" name="site" value="${supplier.site!''}">
					<input type="hidden" name="fax" value="${supplier.fax!''}">
					<input type="hidden" name="legalRep" value="${supplier.legalRep!''}">
					<input type="hidden" name="apiFlag" value="${supplier.apiFlag!''}">
					<input type="hidden" name="permit" value="${supplier.permit!''}">
					<input type="hidden" name="fatherSupplier" value="<#if supplier.fatherSupplier??>${supplier.fatherSupplier!''}</#if>">
					</td>
				<td>${supplier.supplierId!''} </td>
				<td>${supplier.supplierName!''}<#if supplier.apiFlag=='Y'>[对接]<#else>[非对接]</#if> </td>
				<td><#if supplier.supplierDistrict??>${supplier.supplierDistrict!''}</#if> </td>
			</tr>
			</#list>
        </tbody>
    </table>
    
	 <#if pageParam.items?exists> 
			<div class="paging" > 
				${pageParam.getPagination()}
			</div> 
     </#if>
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<div class="operate"><a class="btn btn_cc1"  id="selectButton">确定</a></div>

<#include "/base/foot.ftl"/>
</body>
</html>

<script>
//vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');
vst_pet_util.commListSuggest("#supplierName", "#supplierId",'/vst_back/supp/supplier/searchSupplierList.do');

$("#search_button").click(function(){
	$("#searchForm").submit();
});

//选择一个Item
$("#selectButton").bind("click",function(){
	var radio  = $("input:radio:checked");
	
	if(radio.size()==0){
		alert("请选择供应商");
		return;
	}
	var obj = radio.parent("td");
	var supplier = {};
	supplier.supplierId = $("input[name='supplierId']",obj).val();
    supplier.supplierName = $("input[name='supplierName']",obj).val();
    supplier.tel = $("input[name='tel']",obj).val();
    supplier.supplierDistrict = $("input[name='supplierDistrict']",obj).val();
    supplier.address = $("input[name='address']",obj).val();
    supplier.zip = $("input[name='zip']",obj).val();
    supplier.site = $("input[name='site']",obj).val();
    supplier.fax = $("input[name='fax']",obj).val();
    supplier.legalRep = $("input[name='legalRep']",obj).val();
    supplier.apiFlag = $("input[name='apiFlag']",obj).val();
    supplier.fatherSupplier = $("input[name='fatherSupplier']",obj).val();
    supplier.supplierType = $("input[name='supplierType']",obj).val();
    supplier.permit = $("input[name='permit']",obj).val();
    
    //传递选择的supplier对象回传给父窗口函数
    <#if callback??>
		parent.${callback}(supplier);
	<#else>
		parent.onSelectSupplier(supplier);
	</#if>
});
</script>