
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body  style="min-height:500px;">
<div class="iframe_search">
<form method="post" action='/vst_back/visa/visaDoc/selectBizVisaDocList.do' id="searchForm">
<input type="hidden" name="dictDefId" value="${dictDefId!''}">
    <table class="s_table">
			<tr>
			 	<td class="w10 s_label">签证材料名称：</td>
                <td class="w15">
                    <input type="text" name="docName" value="${bizVisaDoc.docName!''}">
                </td>
                <td class="w10 s_label">签证材料ID：</td>
                <td class="w15">
                    <input type="text" name="docId" value="${bizVisaDoc.docId!''}" number="true" >
                </td>
                 <td class="s_label">签证材料状态：</td>
                <td class="w18">
                	<select name="cancelFlag">
        				<option value="">不限</option>
                    	<option value='Y' <#if bizVisaDoc!=null && bizVisaDoc.cancelFlag == 'Y'>selected</#if>>有效</option>
                    	<option value='N' <#if bizVisaDoc!=null && bizVisaDoc.cancelFlag == 'N'>selected</#if>>无效</option>
                	</select>
                </td>
			</tr>
			<tr> 
				<td class="w10 s_label">签证国家/地区：</td>
                <td class="w15"><input type="text" name="country" value="${bizVisaDoc.country!''}"></td>
				
                <td class="w10 s_label">送签城市：</td>
                <td class="w15">
                    <select class="w15" name="city">
                    	<option value="" selected="">全部</option>
						<#list vistCityList as bizDict>
		                    <option value=${bizDict.dictId} <#if bizVisaDoc!=null && bizVisaDoc.city==bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
					  	</#list>
                    </select>
                </td>
                 <td class="w10 s_label">签证类型：</td>
                <td class="w15">
                    <select class="w15" name="visaType">
                    	<option value="" selected="">全部</option>
						 <#list vistTypeList as bizDict>
		                    <option value=${bizDict.dictId} <#if bizVisaDoc!=null && bizVisaDoc.visaType==bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
					  	</#list>
                    </select>
                </td>
			</tr>
			<tr>
			 	<td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class=" operate mt10">
                   	<a class="btn btn_cc1" id="search_button">查询</a>
                </td>
			</tr>
		</table>
	</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<#if pageParam??>
<#if pageParam.items?? &&  pageParam.items?size &gt; 0>
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
		<thead>
        	<tr>
        		<th></th>
            	<th>签证材料ID</th>
                <th>签证材料名称</th>
            	<th>签证国家/地区</th>
                <th>签证类型</th>	                    
                <th>送签城市</th>	
                <th>签证状态</th>   
            </tr>
        </thead>
        <tbody>
				<tbody>
					<#list pageParam.items as bizVisaDoc> 
						<tr>
							<td><input type="radio" name="docId">
							<input type="hidden" name="docIdHide" value="${bizVisaDoc.docId!''}">
							<input type="hidden" name="docNameHide" value="${bizVisaDoc.docName!''}">
							<input type="hidden" name="docCountryHide" value="${bizVisaDoc.country!''}">
							<input type="hidden" name="visaTypeHide" value="${bizVisaDoc.visaType!''}">
							</td>
							<td>${bizVisaDoc.docId!''} </td>
							<td>${bizVisaDoc.docName!''} </td>
							<td>${bizVisaDoc.country!''} </td>
							<td><#list vistTypeList as bizDict>
		                    		<#if bizVisaDoc.visaType==bizDict.dictId>${bizDict.dictName}</#if>
					  			</#list></td>
							<td><#list vistCityList as bizDict>
		                    		<#if bizVisaDoc.city==bizDict.dictId>${bizDict.dictName}</#if>
					  			</#list></td>
					  		<td>
					  			<#if bizVisaDoc!=null && bizVisaDoc.cancelFlag == 'Y'>有效<#else>无效</#if>
					  		</td>
						</tr>						
					</#list>
                </tbody>
           </table>
     <table class="co_table">
        <tbody>
            <tr>
                 <td class="s_label">
                 	<#if pageParam?? && pageParam.items?exists> 
						<div class="paging" > 
						${pageParam.getPagination()}
						</div> 
					</#if>
                 </td>
            </tr>
        </tbody>
    </table>	
	</div><!--p_box-->
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关签证材料，重新输入相关条件查询！</div>
    </#if>
    </#if>	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});

$("input[type='radio']").bind("click",function(){
	var obj = $(this).parent("td");
	var doc = {};
	doc.docId = $("input[name='docIdHide']",obj).val();
	doc.docName = $("input[name='docNameHide']",obj).val();
	doc.docCountry = $("input[name='docCountryHide']",obj).val();
	doc.docVisaType = $("input[name='visaTypeHide']",obj).val();
	doc.docVisaTypeName = $(this).parents("tr").children("td:nth-child(4)").text();
	doc.docCity = $(this).parents("tr").children("td:nth-child(5)").text();

	parent.onSelectDoc(doc);
});
	
</script>