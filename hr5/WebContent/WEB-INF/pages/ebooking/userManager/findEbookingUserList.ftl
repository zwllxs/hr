<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
	<form method="post" action='/vst_back/ebooking/userManager/findEbookingUserList.do' id="searchForm">
        <table>
            <tbody>
                <tr>
                    <td class="s_label" style="font-size: 14px; font-style:normal;">供应商：</td>
                    <td class="w18" style="font-size: 12px; font-style:normal;">
                    	${supName}
                    	<input type="hidden" name="supplierId" value="${supplierId}"/>
                    	<input type="hidden" name="supplierName" value="${supName}"/>
                    </td>
                    <td class=" operate mt10">
                    	<a class="btn btn_cc1" href="/vst_back/ebooking/userManager/findEbookingSupplierList.do">返回</a>
                    </td>
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
					    <th>用户名</th>
					    <th>状态</th>
					    <th>打印通关票据</th>
					    <th>是否管理员</th>
					    <th>父级用户</th>
					    <th>驴妈妈联系人</th>
					    <th>姓名</th>
					    <th>手机</th>
					    <th>备注</th>
					    <th>创建时间</th>
					    <th>操作</th>                	
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as ebkUser>
						<tr>
							<td>${ebkUser.userName!''} </td>
							<td>
								<#if ebkUser.cancelFlag == "Y"> 
									<span style="color:green" class="cancelProp">正常</span>
								<#else>
									<span style="color:red" class="cancelProp">锁定</span>
								</#if>								
							</td>
							<td>
								<#if ebkUser.printFlag == "Y"> 
									<span class="cancelProp">打印</span>
								<#else>
									<span class="cancelProp">不打印</span>
								</#if>									
							</td>
							<td>
								<#if ebkUser.adminFlag == "Y"> 
									<span class="cancelProp">是</span>
								<#else>
									<span class="cancelProp">否</span>
								</#if>								
							</td>
							<td>${ebkUser.parentUserName!''} </td>
							<td>${ebkUser.lvmamaContactName!''} </td>
							<td>${ebkUser.name!''} </td>
							<td>${ebkUser.mobile!''} </td>
							<td>${ebkUser.description!''} </td>
							<td>
								${ebkUser.createTime?string("yyyy-MM-dd HH:mm:ss")} 
							</td>
							<td>
		                        <a href="javascript:void(0);" class="updateEbkUser" data=${ebkUser.userId} data1=${supName}>修改</a>
		                        <a href="javascript:void(0);" class="changeUserPwd" data=${ebkUser.userId}>初始化密码</a>
		                        <a href="javascript:void(0);" class="bindingTicket" data=${ebkUser.userId}>绑定门票</a>
		                        <a href="javascript:void(0);" class="unbindingTicket" data=${ebkUser.userId}>修改门票</a>
		                        <a href="javascript:void(0);" class="bindingRoute" data=${ebkUser.userId}>绑定线路</a>
                                <a href="javascript:void(0);" class="unbindingRoute" data=${ebkUser.userId}>修改线路</a>
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
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	$(function(){
		//跳转到修改账号页面
		$("a.updateEbkUser").bind("click",function(){
		    var userId = $(this).attr("data");
		    var supName = $(this).attr("data1");
			var updateUser = new xDialog("/vst_back/ebooking/userManager/toUpdateEbkUserPage.do",{"userId":userId}, {title:"修改账号",width:450,ok:function(){
					$.ajax({
						url : "/vst_back/ebooking/userManager/updateEbkUser.do",
						type : "post",
						data : $(".dialog #updateBbkUserForm").serialize(),
						success : function(result) {
							if (result == "fail") {
								$.alert('用户名已经存在!');
							}else if(result == "success"){
								$.alert('修改成功!');
								updateUser.close();
								$("#searchForm").submit();
							}else{
								$.alert('修改失败!');
							}						
						}
					});
		     	},
	  			okValue:"保存"
		     });	 
		});	
		
		//初始化EBOOKING用户密码
		$("a.changeUserPwd").bind("click",function(){
		    var userId = $(this).attr("data");
			$.confirm("确定初始化密码吗?", function () {
				$.ajax({
					url : "/vst_back/ebooking/userManager/initEbkUserPassword.do",
					type : "post",
					data : {userId:userId}, 
					success : function(result) {
						if(result == "success"){
							$.alert('操作成功!');
						}else{
							$.alert('操作失败!');
						}						
					}
				});
			});			    
		});	
		
		//绑定门票
		$("a.bindingTicket").bind("click",function(){
		    var userId = $(this).attr("data");
		    selectUserBindingTicketDialog = new xDialog("/vst_back/ebooking/userManager/selectBindingTicket.do?toBindingGoods=Y&userId="+userId+"&supplierId=${supplierId}",
		    	{},{title:"绑定门票", iframe:true, width:900});
		});	
		
		//解除绑定门票
		$("a.unbindingTicket").bind("click",function(){
		    var userId = $(this).attr("data");
		    selectUserBindingTicketDialog = new xDialog("/vst_back/ebooking/userManager/selectBindingTicket.do?toBindingGoods=&userId="+userId+"&supplierId=${supplierId}",
		    	{},{title:"修改门票", iframe:true, width:900});
		});
		
		//绑定线路
        $("a.bindingRoute").bind("click",function(){
            var userId = $(this).attr("data");
            selectUserBindingRouteDialog = new xDialog("/vst_back/ebooking/userManager/selectBindingRoute.do?toBindingRoute=Y&userId="+userId+"&supplierId=${supplierId}",
                {},{title:"绑定线路", iframe:true, width:900});
        }); 
        
        //解除绑定线路
        $("a.unbindingRoute").bind("click",function(){
            var userId = $(this).attr("data");
            selectUserBindingRouteDialog = new xDialog("/vst_back/ebooking/userManager/selectBindingRoute.do?toBindingRoute=&userId="+userId+"&supplierId=${supplierId}",
                {},{title:"修改线路", iframe:true, width:900});
        });
		
	});
</script>

