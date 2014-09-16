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
            <li class="active">供应商列表</li>
        </ul>
</div>
<div class="iframe_search">
	<form method="post" action='/vst_back/ebooking/userManager/findEbookingSupplierList.do' id="searchForm">
		<table align="left" >
            <tbody>
                <tr align="left" >
                    <td class="s_label" align="left">供应商名称</span>
                  		 <input type="text" class="searchInput" name="supplierName" id="sName" value="${supplier.supplierName!''}">
                    </td>
                    <td class=" operate mt10" width="200px;" align="left">
                    	<a class="btn btn_cc1" id="search_button">查询</a>
                    </td>
                </tr>
            </tbody>
        </table>        
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center" style="margin-top: 40px;">
                <thead>
                    <tr>
                	<th>供应商编号</th>
                    <th>供应商名称</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as supplier> 
					<tr>
					<td>${supplier.supplierId!''} </td>
					<td>${supplier.supplierName!''} </td>
					<td class="oper">
                        <a href="javascript:void(0);" class="addSupp" data=${supplier.supplierId}>新增账号</a>
                        <a href="/vst_back/ebooking/userManager/findEbookingUserList.do?supplierId=${supplier.supplierId}&supplierName=${supplier.supplierName}">账号管理</a>
                    </td>
					</tr>
					</#list>
                </tbody>
            </table>
            <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
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
	vst_pet_util.commListSuggest("#sName", null,'/vst_back/supp/supplier/searchSupplierList.do');
	$(function(){
		//查询
		$("#search_button").click(function(){
			if(!$("#searchForm").validate().form()){
				return;
			}
			$("#searchForm").submit();
		});
		
		//跳转到新增账号页面
		$("a.addSupp").bind("click",function(){
		    var supplierId  = $(this).attr("data");
		    var supplierId  = $(this).attr("data");
			var addUser = new xDialog("/vst_back/ebooking/userManager/toAddEbkUserPage.do",{"supplierId":supplierId}, {title:"新增账号",width:450,ok:function(){
					if(!$("#addBbkUserForm").validate().form()){
						return false;
					}
					$.ajax({
						url : "/vst_back/ebooking/userManager/addEbkUser.do",
						type : "post",
						data : $(".dialog #addBbkUserForm").serialize(),
						success : function(result) {
							if (result == "fail") {
								$.alert('用户名已经存在!');
							}else if(result == "success"){
								$.alert('新增成功!');
								addUser.close();
								$("#searchForm").submit();
							}else{
								$.alert('新增失败!');
							}
						}
					});				
		     	},
	  			okValue:"保存"
		     });	 
		});
		
		
	});
	
</script>
