
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body  style="min-height:500px;">
<div class="iframe_search">
<form method="post" action='/vst_back/biz/dict/findSelectDictList.do' id="searchForm">
<input type="hidden" name="dictDefId" value="${dictDefId!''}">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">名称：</td>
                <td class="w18"><input type="text" name="dictName" value="${dictName!''}"></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <input type="hidden" name="page" value="${page}">
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
             <th>选择</th>
             <th>ID</th>
             <th>名称</th>
            </tr>
        </thead>
        <tbody>
        	<#if pageParam??>
			<#list pageParam.items as bizDictExtend> 
			<tr>
			<td>
				<input type="radio" name="bizDicId">
				<input type="hidden" name="dictNameHide" value="${bizDictExtend.dictName!''}">
				<input type="hidden" name="dictIdHide" value="${bizDictExtend.dictId!''}">
				<input type="hidden" name="addFlagHide" value="${bizDictExtend.addFlag!''}">
			 </td>
			<td>${bizDictExtend.dictId!''}</td>
			<td>${bizDictExtend.dictName!''} </td>
			</tr>
			</#list>
        	</#if>
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
	var dict = {};
	dict.dictId = $("input[name='dictIdHide']",obj).val();
	dict.dictName = $("input[name='dictNameHide']",obj).val();
	dict.addFlag = $("input[name='addFlagHide']",obj).val();

	parent.onSelectDict(dict);
});
	
</script>