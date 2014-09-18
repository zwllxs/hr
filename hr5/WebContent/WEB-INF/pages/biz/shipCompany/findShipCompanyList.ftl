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
            <li><a href="#">邮轮公司管理</a> &gt;</li>
            <li class="active">邮轮公司列表</li>
        </ul>
</div>

    <div class="p_box box_info">
	<form method="post" action='/vst_back/ship/shipCompany/findShipCompanyList.do' id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                	<td class="s_label">邮轮公司ID：</td>
                    <td class="w18"><input type="text" name="dictId" value="${bizDict.dictId!''}" number="true" ></td>
				
                    <td class="s_label">邮轮公司名称：</td>
                    <td class="w18"><input type="text" name="dictName" value="${bizDict.dictName!''}"></td>
                    
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10">
                    <a class="btn btn_cc1" id="search_button">查询</a> 
                    <a class="btn btn_cc1" id="new_button">新增</a></td>
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
                    <th>邮轮公司ID</th>
                    <th>邮轮公司名称</th>
                    <th>状态</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as bizDict> 
					<tr>

						<td>${bizDict.dictId!''} </td>
						<td>${bizDict.dictName!''} </td>
						<td>
						<#if bizDict.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProd">有效</span>
						<#else>
						<span style="color:red" class="cancelProd">无效</span>
						</#if>
					</td>
						<td class="oper">
                            <a href="javascript:void(0);" class="editProd" data="${bizDict.dictId}" data2 = "${bizDict.dictName!'' }">编辑</a>
                            <a href="javascript:void(0);" class="showLogDialog" param="{'parentId':${bizDict.dictDefId},'objectId':${bizDict.dictId},'parentType':'DICT_BUSINESS'}">操作日志</a> 
                         
                            <#if bizDict.cancelFlag == "Y"> 
                            <a href="javascript:void(0);" class="cancelProd" data="N" dictId=${bizDict.dictId} dictDefId=${bizDict.dictDefId}>设为无效</a>
                            <#else>
                            <a href="javascript:void(0);" class="cancelProd" data="Y" dictId=${bizDict.dictId} dictDefId=${bizDict.dictDefId}>设为有效</a>
                             </#if>
                            <a href="javascript:void(0);" class="showPhoto" data=${bizDict.dictId}>图片</a>
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
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关数据，重新输入相关条件查询！</div>
    </#if>
    </#if>
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var addShipCompanyDialog,updateShipCompanyDialog,categorySelectDialog;
var  findShipCompanyDialog=window;
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
	
	//新建
	$("#new_button").bind("click",function(){
		//打开弹出窗口
		addShipCompanyDialog = new xDialog("/vst_back/biz/dict/showAddDict.do",{},{title:"新增邮轮公司",width:800,height:700});
		return;
	});
	
	//修改
	$("a.editProd").bind("click",function(){
		var dictId = $(this).attr("data");
	    var url = "/vst_back/biz/dict/showUpdateDict.do";
		var dictName =$(this).attr("data2");
		updateShipCompanyDialog = new xDialog(url,{"dictId":dictId,"requestSource":"shipCompany"}, {title:"修改" + dictName,width:800,height:700});
		return false;
	});
	
	// Comphoto
	$("a.showPhoto").bind("click",function(){
		var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+$(this).attr("data")+"&objectType=DICT_ID";
		new xDialog(url,{},{title:"图片列表",iframe:true,width:800});
	});
	
//产品规格
	$("a.prodBranch").bind("click",function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data_catId");
		window.location.href="/vst_back/prod/prodbranch/findProductBranchList.do?productId="+productId+"&categoryId="+categoryId;
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

	
//设置为有效或无效
	$("a.cancelProd").bind("click",function(){
		var entity = $(this);
		var cancelFlag = entity.attr("data");
		var dictId = entity.attr("dictId");
		var dictDefId = entity.attr("dictDefId");
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/ship/shipCompany/cancelShipCompany.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"dictId":dictId,"dictDefId":dictDefId},
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
	
</script>


