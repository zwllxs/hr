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
        <li><a href="#">供应商管理</a> &gt;</li>
        <li class="active">供应商列表</li>
    </ul>
</div>

<div class="iframe_content">   
	<div class="p_box box_info">
		<form method="post" action='/vst_back/supp/supplier/findSupplierList.do' id="searchForm">
		    <table class="s_table">
		        <tbody>
		            <tr>
		                <td class="s_label">供应商名称：</td>
		                <td class="w18">
		                <!--<input type="text" name="supplierName" value="${supplier.supplierName!''}">-->
		                <input type="text" class="searchInput" name="supplierName" id="supplierName" value="${supplier.supplierName!''}">
		                </td>
		                <td class="s_label">供应商地区：</td>
		                <td class="w18"><input type="text" name="bizDistrict.districtName" value="<#if supplier.bizDistrict??>${supplier.bizDistrict.districtName!''}</#if>"></td>
		                <td class="s_label">供应商ID：</td>
		                <td class="w18"><input type="text" name="supplierId" value="${supplier.supplierId!''}" number=true></td>
		                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button" >查询</a></td>
		                <td class=" operate mt10">
		                <@mis.checkPerm permCode="3531" >
		                <a class="btn btn_cc1" id="new_button">新增</a>
		                </@mis.checkPerm >
		                </td>
		                
		            </tr>
		        </tbody>
		    </table>	
		</form>
	</div>

<!-- 主要内容显示区域\\ -->
    <div class="p_box box_info">
	<table class="p_table table_center">
        <thead>
            <tr>
        	<th>编号</th>
            <th>供应商名称</th>
            <th>上级供应商</th>
            <th>供应商地区</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as supplier> 
			<tr>
			<td>${supplier.supplierId!''} </td>
			<td>${supplier.supplierName!''} </td>
			<td><#if supplier.fatherSupplier??>${supplier.fatherSupplier!''}</#if></td>
			<td><#if supplier.supplierDistrict??>${supplier.supplierDistrict!''}</#if></td>
			<td class="oper">
				<@mis.checkPerm permCode="3532" >
                <a href="javascript:void(0);" class="editSupp" data=${supplier.supplierId}>编辑基本信息</a>
                </@mis.checkPerm >
                <@mis.checkPerm permCode="3533" >
                <a href="javascript:void(0);" class="contactList" data=${supplier.supplierId}>编辑联系人信息</a>
                </@mis.checkPerm >
                <@mis.checkPerm permCode="3534" >
                <a href="javascript:void(0);" class="faxList" data=${supplier.supplierId}>传真设置</a>
                </@mis.checkPerm >  
                <@mis.checkPerm permCode="3535" >               
                 <a href="javascript:void(0);" class="prewarning" data=${supplier.supplierId}>预警</a>
                </@mis.checkPerm >
                 <@mis.checkPerm permCode="3536" > 
                <a href="javascript:void(0);" class="suppApp" data=${supplier.supplierId}>资质审核</a>
                </@mis.checkPerm >
                <@mis.checkPerm permCode="3537" > 
                <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${supplier.supplierId},'objectType':'SUPP_SUPPLIER_SUPPLIER'}">操作日志</a> 
            	</@mis.checkPerm >
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
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
//供应商添加/修改dialog对象，不要重名
var addSupplierDialog,updateSupplierDialog,contactListDialog;
var prewarningAddDialog,qualAddDialog;
vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');
//查询
$("#search_button").click(function(){
	if(!$("#searchForm").validate().form()){
		return;
	}
	$("#searchForm").submit();
});

//新建供应商
$("#new_button").bind("click",function(){
	addSupplierDialog = new xDialog("/vst_back/supp/supplier/showAddSupplier.do",{},{title:"添加供应商",width:900});
});

//编辑联系人
$("a.contactList").bind("click",function(){
	var supplierId  = $(this).attr("data");
	contactListDialog = new xDialog("/vst_back/supp/contact/findContactList.do",{"supplierId":supplierId},{title:"联系人列表",width:900});
});

//传真设置
$("a.faxList").bind("click",function(){
	var supplierId  = $(this).attr("data");
	var param = "?supplierId="+supplierId;
	faxListDialog = new xDialog("/vst_back/supp/fax/findSuppFaxRuleList.do"+param,{},{title:"传真设置",width:900});
});

//预警 提示
$("a.prewarning").bind("click",function(){
	 var supplierId  = $(this).attr("data");		
	prewarningAddDialog =new xDialog("/vst_back/supp/supplier/showSupplierPrewarning.do",{"supplierId":supplierId},{title:"预警提示",width:600});
});

//资质审核
$("a.suppApp").bind("click",function(){
	var supplierId  = $(this).attr("data");
	var param = "?supplierId="+supplierId;
	qualAddDialog =new xDialog("/vst_back/supp/suppQual/findSuppQualList.do"+param,{},{title:"资质审核",width:700});
	return false;
    //qualAddDialog =new xDialog("/vst_back/supp/supplier/showUpdateSupplierQual.do"+param,{},{title:"资质审核",width:700});
});

//修改供应商
$("a.editSupp").bind("click",function(){
    var supplierId  = $(this).attr("data");
	updateSupplierDialog = new xDialog("/vst_back/supp/supplier/showUpdateSupplier.do",{"supplierId":supplierId},{title:"修改供应商",width:800});
});

//设置为有效或无效
$("a.cancelProp").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var supplierId = entity.attr("supplierId");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
 $.confirm(msg, function () {
	$.ajax({
		url : "/vst_back/supp/supplier/cancelSupplier.do",
		type : "post",
		dataType:"JSON",
		data : {"cancelFlag":cancelFlag,"supplierId":supplierId},
		success : function(result) {
		if(result.code == "success"){
		   $.alert(result.message,function(){
			if(cancelFlag == 'N'){
					entity.attr("data","Y");
					entity.text("设为有效");
					$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
				}else if(cancelFlag == 'Y'){
					entity.attr("data","N");
					entity.text("设为无效");
					$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
				}
			});
		}else {
			$.alert(result.message);
		}
	   }
	});
	});
});	
</script>
