<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">EBOOKING</a> &gt;</li>
            <li class="active">审核列表</li>
        </ul>
</div>
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/ebooking/apply/findEbookingApplyList.do"  method="post">
		<table class="s_table">
			<tr>
				<tr>
                    <td class="s_label">供应商名称：</td>
                    <td><input type="text" placeholder="请输入供应商名称" class="searchInput" name="supplierName" id="supplierName" <#if ebkProdApply??>value="${ebkProdApply.supplierName!''}"</#if>>
                	    <input type="hidden"  name="supplierId" id="supplierId" <#if ebkProdApply != null && ebkProdApply.supplierId != null>value="${ebkProdApply.supplierId!''}"</#if>>
                    </td>
                    <td class="s_label">产品名称：</td>
                    <td><input type="text" name="productName" value="${ebkProdApply.productName!''}" ></td>
					<td class="s_label">提交时间：</td>
                    <td colspan='3'><input type="text" <#if ebkProdApply.startDate??> value="${ebkProdApply.startDate?string('yyyy-MM-dd')}"</#if> name="startDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true})" />
					--<input type="text" <#if ebkProdApply.endDate??> value="${ebkProdApply.endDate?string('yyyy-MM-dd')}"</#if> name="endDate" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></td>
                </tr>
                <tr>
                    <td class="s_label">变更编号：</td>
                    <td><input type="text" name="applyId" value="${ebkProdApply.applyId!''}"></td>
                    <td class="s_label">提交人：</td>
                    <td><input type="text" name="createUser" value="${ebkProdApply.createUser!''}" ></td>
                    <td class="s_label">审核状态：</td>
                    <td><select name="auditStatus" id="auditStatus">
                   			<option value=""></option>
		            		<#list auditStatusList as list>
					            <option value="${list.code!''}" <#if ebkProdApply.auditStatus?? && ebkProdApply.auditStatus==list.code>  selected </#if>>${list.cnName!''}</option>
					        </#list>
                		</select>
                    </td>
					<td class="s_label">内容维护人员：</td>
					<td>
						<input type="text" name="contentManagerName" id="contentManagerName" value="${ebkProdApply.contentManagerName}" placeholder="请输入维护人员" >
                    	<input type="hidden" value="${ebkProdApply.contentManagerId}" name="contentManagerId" id="contentManagerId" >
                   	</td>
                </tr>
                <tr>
                	<td class="s_label">审核时间：</td>
                    <td colspan='3'><input type="text" <#if ebkProdApply.auditStartDate??> value="${ebkProdApply.auditStartDate?string('yyyy-MM-dd')}"</#if> name="auditStartDate" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true})" />
					--<input type="text" <#if ebkProdApply.auditEndDate??> value="${ebkProdApply.auditEndDate?string('yyyy-MM-dd')}"</#if> name="auditEndDate" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></td>
                	<td colspan='3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                	<td><a class="btn btn_cc1" id="search_button">查询</a></td>
                </tr>
			</tr>
		</table>
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
	                	<th>变更编号</th>
	                    <th>产品名称</th>
	                	<th>变更类目</th>
	                    <th>供应商名称</th>	                    
	                    <th>提交时间</th>	                    
	                    <th>提交人</th>
	                    <th>审核时间</th>	                    
	                    <th>审核人</th>	                 
	                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					 <#list pageParam.items as apply> 
						<tr>
						<td>${apply.applyId!''}</td>
	                    <td>${apply.productName!''}</td>
	                    <td><#list applyTypeList as list>
					           <#if apply.applyType?? && list.code==apply.applyType>${list.cnName!''}</#if>
					        </#list></td>
					    <td>${apply.supplierName!''}</td>
	                    <td>${apply.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
	                    <td>${apply.createUser!''}</td>
	                    <td>${apply.auditTime?string('yyyy-MM-dd HH:mm:ss')}</td>
	                    <td>${apply.auditUserName!''}</td>
	                    <td><#if apply.auditStatus=="PENDING_AUDIT"><a href="/vst_back/ebooking/apply/editEbookingPriceList.do?applyId=${apply.applyId!''}" name="apply">审核</a></#if> 
	                    	<a href="/vst_back/ebooking/apply/showEbookingPriceList.do?applyId=${apply.applyId!''}" name="showApply">查看</a></td>
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
</div>
<!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.commListSuggest("#supplierName", "#supplierId",'/vst_back/supp/supplier/searchSupplierList.do');

	$(function(){
		//查询
		$("#search_button").bind("click",function(){
			if(!$("#searchForm").validate().form()){
					return false;
				}
			$(".iframe-content").empty();
			$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
			$("#searchForm").submit();
		});	
	});
	
</script>
