<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">签证管理</a> &gt;</li>
            <li class="active">签证材料管理</li>
        </ul>
</div>
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/visa/visaDoc/findBizVisaDocList.do"  method="post">
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
                <td class="w10 s_label">签证国家/地区：</td>
                <td class="w15">
                <input type="text" id="country" name="country" value="${bizVisaDoc.country!''}">
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
                <td class="w10 s_label">送签城市：</td>
                <td class="w15">
                    <select class="w15" name="city">
                    	<option value="" selected="">全部</option>
						<#list vistCityList as bizDict>
		                    <option value=${bizDict.dictId} <#if bizVisaDoc!=null && bizVisaDoc.city==bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
					  	</#list>
                    </select>
                </td>
                <td class="s_label">产品状态：</td>
                <td class="w18">
                	<select name="cancelFlag">
        				<option value="">不限</option>
                    	<option value='Y'<#if bizVisaDoc!=null && bizVisaDoc.cancelFlag == 'Y'>selected</#if>>有效</option>
                    	<option value='N'<#if bizVisaDoc!=null && bizVisaDoc.cancelFlag == 'N'>selected</#if>>无效</option>
                	</select>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class=" operate mt10">
                   	<a class="btn btn_cc1" id="search_button">查询</a>
                    <a class="btn btn_cc1" id="new_button">新增</a>
                </td>
			</tr>
		</table>
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<#if pageParam??>
    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                	<tr>
	                	<th>签证材料ID</th>
	                    <th>签证材料名称</th>
	                	<th>签证国家/地区</th>
	                    <th>签证类型</th>	                    
	                    <th>送签城市</th>	                    
	                    <th>状态</th>	                    
	                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as bizVisaDoc> 
						<tr>
							<td>${bizVisaDoc.docId!''} </td>
							<td>${bizVisaDoc.docName!''} </td>
							<td>${bizVisaDoc.country!''} </td>
							<td><#list vistTypeList as bizDict>
		                    		<#if bizVisaDoc.visaType==bizDict.dictId>${bizDict.dictName}</#if>
					  			</#list></td>
							<td><#list vistCityList as bizDict>
		                    		<#if bizVisaDoc.city==bizDict.dictId>${bizDict.dictName}</#if>
					  			</#list></td>
							<td><#if bizVisaDoc.cancelFlag == "Y"> 
								<span style="color:green" class="cancelProd">有效</span>
								<#else>
								<span style="color:red" class="cancelProd">无效</span>
								</#if>
							</td>
							<td>
								<a href="javascript:void(0);" class="update" data=${bizVisaDoc.docId}>修改</a>
								<a href="javascript:void(0);" class="edit" data=${bizVisaDoc.docId}>编辑签证材料</a>
								<#if bizVisaDoc.cancelFlag == "Y"> 
	                            <a href="javascript:void(0);" class="cancelProd" data="N" docId=${bizVisaDoc.docId}>设为无效</a>
	                            <#else>
	                            <a href="javascript:void(0);" class="cancelProd" data="Y" docId=${bizVisaDoc.docId}>设为有效</a>
	                             </#if>
	                            <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${bizVisaDoc.docId},'objectType':'VISA_DOCUMNET'}">操作日志</a>
							</td>
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
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关签证材料，重新输入相关条件查询！</div>
    </#if>
    </#if>
</div>
<!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
vst_pet_util.visaCountrySuggest("#country","#country");
	$(function(){
		
		//查询
		$("#search_button").click(function(){
			if(!$("#searchForm").validate().form()){
				return;
			}
			$("#searchForm").submit();
		});
		
		//跳转到签证材料信息页面
		$("#new_button").bind("click",function(){
			addBizVisaDoc = new xDialog("/vst_back/visa/visaDoc/showBizVisaDoc.do",{}, {title:"新增签证材料",width:600});	 
		});	
		
		//跳转到签证材料信息页面
		$(".update").bind("click",function(){
		    var docId =$(this).attr("data");
			updateBizVisaDoc = new xDialog("/vst_back/visa/visaDoc/showBizVisaDoc.do",{docId:docId}, {title:"修改签证材料",width:600});	 
		});	
			
//设置为有效或无效
	$("a.cancelProd").bind("click",function(){
		var entity = $(this);
		var cancelFlag = entity.attr("data");
		var docId = entity.attr("docId");
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/visa/visaDoc/cancelBizVisaDoc.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"docId":docId},
			success : function(result) {
			if (result.code == "success") {
				$.alert(result.message,function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProd",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProd",entity.parents("tr")).css("color","green").text("有效");
					}
				});
			}else {
				$.alert(result.message);
			}
			}
		});
		});
	});
			
	//签证材料
	$(".edit").bind("click",function(){
		var entity = $(this);
		var docId = entity.attr("data");
		location.href="/vst_back/visa/visaDoc/showBizVisaDocOccup.do?docId="+docId;
		
	});
			
			
			
			
			
	});
	
</script>
