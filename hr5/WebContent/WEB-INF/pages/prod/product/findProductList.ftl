<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">产品管理</a> &gt;</li>
            <li class="active">产品列表</li>
        </ul>
</div>
<div class="iframe_content">
	<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
    <p class="pl15">1.品类名字后面显示“无效”，表示该品类已经不能做新产品增加。</p>
    <p class="pl15">2. 可售是指，产品有效、规格有效，且规格下属有有效的商品，且该商品在当前时间往后至少有一天有价格库存</p>      
    </div>
    
    <div class="p_box box_info">
	<form method="post" action='/vst_back/prod/product/findProductList.do' id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                    <td class="s_label">产品名称：</td>
                    <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}"></td>
                    <td class="s_label">产品ID：</td>
                    <td class="w18"><input type="text" name="productId" value="${prodProduct.productId!''}" number="true" ></td>
					<td class="s_label">行政区划：</td>
                    <td class="w18">
                    <input type="text" name="bizDistrict.districtName" value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtName!''}</#if>"></td>
                   <td class="s_label">产品状态：</td>
                    <td class="w18">
                    	<select name="cancelFlag">
                    		<option value="">不限</option>
			                    	<option value='Y'<#if prodProduct.cancelFlag == 'Y'>selected</#if>>有效</option>
			                    	<option value='N'<#if prodProduct.cancelFlag == 'N'>selected</#if>>无效</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                 	<td class="s_label">是否可售：</td>
                    <td class="w18">
                            <select name="saleFlag">
                    	 			<option value="">不限</option>
			                    	<option value='Y' <#if prodProduct.saleFlag == 'Y'>selected</#if> >是</option>
			                    	<option value='N' <#if prodProduct.saleFlag == 'N'>selected</#if> >否</option>
			        	</select>
                    </td>
                    <td class="s_label">审核状态：</td>
                    <td class="w18">
                    	<select name="auditStatus">
                    		<option value="">不限</option>
                    		<#list auditTypeList as audit>
                    			<option value="${audit.code}" <#if prodProduct?? && prodProduct.auditStatus==audit.code>selected=selected </#if>  >${audit.cnName}</option>
                    		</#list>
                    	</select>
                    </td>
                    <td class="s_label">产品品类：</td>
                    <td class="w18">
                    	 <select name="bizCategory.categoryId">
                    	 			<option value="">不限</option>
		    				<#list bizCategoryList as bizCategory> 
			                    	<option value=${bizCategory.categoryId!''} <#if prodProduct.bizCategory!=null && prodProduct.bizCategory.categoryId == bizCategory.categoryId>selected</#if> >${bizCategory.categoryName!''}</option>
			                </#list>
			        	</select>
					</td>
					<td class="s_label">商品ID：</td>
					<td class="w18"><input type="text" name="goodsId" value="${goodsId!''}" number="true"></td>
                </tr>
                <tr>
                    <td class="s_label">产品经理：</td>
                    <td class="w18"><input type="text" id="productManagerName" name="productManagerName" value="${productManagerName!''}"><input type="hidden" id="productManagerId" name="productManagerId" value="${productManagerId!''}"></td>
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10">
                    <@mis.checkPerm permCode="3523" >
                    </@mis.checkPerm >
                    <a class="btn btn_cc1" id="search_button">查询</a> 
                    <@mis.checkPerm permCode="3524" >
                        <a class="btn btn_cc1" id="new_button">新增</a>
                    </@mis.checkPerm >
                    </td>
                </tr>
            </tbody>
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
                	<th width="80px">品类</th>
                    <th>产品ID</th>
                    <th>产品名称</th>
                    <th>产品状态</th>
                    <th>是否可售</th>
                    <th>审核状态</th>
                     <th>推荐级别</th>
                    <th>行政区划</th>
                    <th width="350px">操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as product> 
					<tr sensitive="${product.senisitiveFlag}">
					<td><#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if><#if product.bizCategory ?? && product.bizCategory.cancelFlag == 'N'><span class="notnull">[无效]</span></#if></td>
					<td>${product.productId!''} </td>
					<td>${product.productName!''} </td>
					<td>
						<#if product.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProd">有效</span>
						<#else>
						<span style="color:red" class="cancelProd">无效</span>
						</#if>
					</td>
					<td><#if product.saleFlag =="Y">是<#else>否</#if></td>
					<td>
						<#if product.auditStatus??>
						<#list auditTypeList as audit>
                    			 <#if product?? && product.auditStatus==audit.code>${audit.cnName}</#if>
                    	</#list>
                    	</br>
                    	<#if product.senisitiveFlag=='Y'><span style="color:red">(有敏感词)</span></#if>
                    	</#if>
					</td>
					<td>${product.recommendLevel}</td>
					<td><#if product.bizDistrict??>${product.bizDistrict.districtName!''}</#if></td>
					<td class="oper">
						<#--只针对线路品类-->
						<#if product.auditStatus?? && (product.auditStatus=='AUDITTYPE_BACK_QA' || product.auditStatus=='AUDITTYPE_BACK_BUSINESS') && product.hasAuditCategory>
							<a href="javascript:void(0);" class="commitAudit" currentAuditType="${product.auditStatus}" data=${product.productId} categoryId=${product.bizCategory.categoryId} >提交审核</a>
						<#elseif product.auditStatus?? && (product.auditStatus=='AUDITTYPE_TO_QA'||product.auditStatus=='AUDITTYPE_TO_BUSINESS') && product.hasAuditCategory> 
							<a href="javascript:void(0);" class="cancelAudit" currentAuditType="${product.auditStatus}" data=${product.productId} categoryId=${product.bizCategory.categoryId} >撤销审核</a>
						</#if>
						<#if product.auditStatus?? && (product.auditStatus=='AUDITTYPE_TO_PM'  ||product.auditStatus=='AUDITTYPE_PASS'  || product.auditStatus=='AUDITTYPE_BACK_QA' || product.auditStatus=='AUDITTYPE_BACK_BUSINESS') && product.hasAuditCategory>
                            <a href="javascript:void(0);" class="editProd" data="${product.productId}" categoryName="<#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if>" data1="<#if product.bizCategory ??>${product.bizCategory.categoryId!''}</#if>">编辑</a>
                        </#if>
                        <#if !product.hasAuditCategory >
                            <a href="javascript:void(0);" class="editProd" data="${product.productId}" categoryName="<#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if>" data1="<#if product.bizCategory ??>${product.bizCategory.categoryId!''}</#if>">编辑</a>
                        </#if>
                        <#if product.auditStatus?? && (product.auditStatus=='AUDITTYPE_TO_QA'||product.auditStatus=='AUDITTYPE_TO_BUSINESS') && product.hasAuditCategory>
                       	 	<a href="javascript:void(0);" class="viewProd" data=${product.productId} categoryName="<#if product.bizCategory ??>${product.bizCategory.categoryName!''}</#if>" data1="<#if product.bizCategory ??>${product.bizCategory.categoryId!''}</#if>" >查看</a>
                        </#if>
                            <a href="javascript:void(0);" class="showProd" data1="${product.urlId}" data=${product.productId} categoryId=${product.bizCategory.categoryId} >预览</a>
                        <@mis.checkPerm permCode="3526" >
                            <a href="javascript:void(0);" class="showNotice" data=${product.productId}>公告</a>
                        </@mis.checkPerm >
                        <@mis.checkPerm permCode="3527" >
                            <a href="javascript:void(0);" class="showRecommend" data=${product.productId}>一句话推荐</a>
                        </@mis.checkPerm >
                        <@mis.checkPerm permCode="3528" >
                            <a href="javascript:void(0);" class="showGift" data=${product.productId}>礼品</a>
                        </@mis.checkPerm >
                            <a href="javascript:void(0);" class="showLogDialog" param="{'parentId':${product.productId},'parentType':'PROD_PRODUCT'}">操作日志</a> 
                        
                        <#if product.auditStatus?? && product.auditStatus=='AUDITTYPE_PASS' && product.hasAuditCategory >
                            <a href="javascript:void(0);" class="cancelProd" data="N" productId=${product.productId}>设为无效</a>
                       	</#if>
                       	
                       	<#if !product.hasAuditCategory >
                       	<@mis.checkPerm permCode="3529" >
                            <#if product.cancelFlag == "Y"> 
                            <a href="javascript:void(0);" class="cancelProd" data="N" productId=${product.productId}>设为无效</a>
                            <#else>
                            <a href="javascript:void(0);" class="cancelProd" data="Y" productId=${product.productId}>设为有效</a>
                             </#if>
                        </@mis.checkPerm >
                       	</#if>
                        <#if product.hasAuditCategory>
                        	<a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${product.productId},'objectType':'PROD_PRODUCT_PRODUCT','logType':'PROD_PRODUCT_ADUIT_STATUS'}" >审核备注</a>
                        </#if>
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
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
    </#if>
    </#if>
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var categorySelectDialog;
$(function(){
	 
//产品规格
	$("a.prodBranch").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data_catId");
		window.location.href="/vst_back/prod/prodbranch/findProductBranchList.do?productId="+productId+"&categoryId="+categoryId;
	});
	
	//提交审核
	$("a.commitAudit").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("categoryId");
		var currentAuditType=$(this).attr("currentAuditType");
		var msg = '确认提交审核?';
		$.ajax({
				url : "/vst_back/prod/product/getSensitiveFlag.do",
				type : "post",
				dataType:"JSON",
				data : {"productId":productId},
				async:false,
				success : function(result) {
					if (result.code == "success") {
						
					}else {
						msg = result.message+'确定提交审核?';
					}
				}
		});
		
		$.confirm(msg,function(){
			$.ajax({
				url : "/vst_back/prod/product/updateAudtiType.do",
				type : "post",
				dataType:"JSON",
				data : {"productId":productId,"currentAuditStatus":currentAuditType,"isPass" : "Y",isSubmit:'Y'},
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message,function(){
						$("#search_button").click();
					});
				}else {
					$.alert(result.message);
				}
				}
			});
		});
	});
	

	
	//撤销审核
	$("a.cancelAudit").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("categoryId");
		var currentAuditType=$(this).attr("currentAuditType");
		
	var htmlArray = [];
	htmlArray.push('<div id="aduitDiv">');
	htmlArray.push('<div style="margin:5px;">确定撤回审核,请选择后退节点</div>');
	htmlArray.push('<div style="margin:5px;"><input type="radio" name="isBackEbk"  id="isBackEbk" value="Y" checked="checked">返回EBK修改 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="isBackEbk"  id="isBackEbk" value="N">返回VST修改</div>');
	htmlArray.push('<div class="operate" style="margin-left:5px;margin-top:20px;"><a class="btn btn_cc1" id="audit_submit" currentAuditType='+currentAuditType+' data='+productId+'>提交</a><a class="btn btn_cc1" id="audit_cancel">取消</a></div>');
	htmlArray.push('</div>');
	
	auditDialog = pandora.dialog({
        width: 500,
        title: "撤销审核",
        mask : true,
        content: htmlArray.join('')
	 });
	});
	
	$("#audit_submit").live("click",function(){
			var data = $(this).attr("data");
			var currentAuditType  = $(this).attr("currentAuditType");
			var isBackEbk = "N";
			if($("#isBackEbk").is(":checked")){
				isBackEbk = "Y";
			}
			$.ajax({
				url : "/vst_back/prod/product/cancelAudtiType.do",
				type : "post",
				dataType:"JSON",
				data : {"productId":data,"isBackEbk":isBackEbk,"currentAuditStatus":currentAuditType},
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message,function(){
						$("#search_button").click();
					});
				}else {
					$.alert(result.message);
				}
				}
			});
	});
	
//商品维护
	$("a.prodGoods").bind("click",function(){
		var productId = $(this).attr("dataProductId");
		var cancelFlag = $(this).attr("dataCancelFlag");
		if(cancelFlag=="Y"){
			window.location.href="/vst_back/goods/goods/showSuppGoodsList.do?productId="+productId;
		}else{
			$.alert("该产品不可用！");
		}
	});

	//查询
	$("#search_button").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#searchForm").submit();
	});
	
	//新建
	$("#new_button").bind("click",function(){
		//打开弹出窗口
		categorySelectDialog = new xDialog("/vst_back/prod/product/showSelectCategory.do",{},{title:"请选择产品的所属品类",width:900,height:600});
		return;
	});
	
	//修改
	$("a.editProd").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data1");
		var categoryName = $(this).attr("categoryName");
		window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
		return false;
	});
	
	
	//查看
	$("a.viewProd").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data1");
		var categoryName = $(this).attr("categoryName");
		window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName+"&isView=Y");
		return false;
	});
	
	
	//预览
	$("a.showProd").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("categoryId");
		var urlId = $(this).attr("data1");
		if(categoryId=="1"){
			window.open("http://hotels.lvmama.com/hotel/"+productId);
		}else if(categoryId=="11" || categoryId=="12"){
			var url = "http://ticket.lvmama.com/scenic-"+urlId;
			window.open(url);
		}else if(categoryId=="13"){
			window.open("http://ticket.lvmama.com/scenic-"+urlId);
		}else if(categoryId=="8"){
			window.open("http://www.lvmama.com/youlun/cruise-"+productId+".html");
		}else {
			$.alert("该产品不能预览");
			return;
		}
	});
	
	$("#audit_cancel").live("click",function(){
		auditDialog.close();
});		
	
	
//设置为有效或无效
	$("a.cancelProd").bind("click",function(){
		var entity = $(this);
		var cancelFlag = entity.attr("data");
		var productId = entity.attr("productId");
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/prod/product/cancelProduct.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"productId":productId},
			success : function(result) {
			if (result.code == "success") {
				$.alert(result.message,function(){
					$("#searchForm").submit();
				});
			}else {
				$.alert(result.message);
			}
			}
		});
		});
	});

});
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	};
	
		//公告
	$("a.showNotice").bind("click",function(){
		var productId = $(this).attr("data");
	new xDialog("/vst_back/prod/productNotice/findProductNoticeList.do?productId="+productId+"&noticeType=PRODUCT_All",{},{title:"公告",width:1000,iframe:true,scrolling:"yes"});
	});
	
			//一句话推荐
	$("a.showRecommend").bind("click",function(){
		var productId = $(this).attr("data");
	new xDialog("/vst_back/prod/productNotice/findProductNoticeList.do?productId="+productId+"&noticeType=PRODUCT_RECOMMEND",{},{title:"一句话推荐",width:1000,iframe:true,scrolling:"yes"});
	});
	
			//礼品
	$("a.showGift").bind("click",function(){
		var productId = $(this).attr("data");
	new xDialog("/vst_back/prod/productNotice/findProductNoticeList.do?productId="+productId+"&noticeType=PRODUCT_GIFT",{},{title:"礼品",width:1000,iframe:true,scrolling:"yes"});
	});
	
	vst_pet_util.superUserSuggest("#productManagerName","#productManagerId");
</script>


