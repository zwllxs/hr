
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="tiptext tip-warning">
        <ul class="iframe_nav">
            <li>注：<br></li>
            <li>1，景区中举办的活动；最多允许添加5个活动；<br></li>
            <li>2，当活动状态有效，活动时间未开始时，仍会在前台显示。</li>
        </ul>
	</div>
	<div class="iframe_content">
	    <div class="p_box box_info">
			<form method="post" action='/vst_back/singleTicket/prod/prodActivity/findProdActivityList.do' id="searchForm">
		        <table class="s_table">
		            <tbody>
		                <tr>
		                    <td class=" operate mt10">
		                    	<a class="btn btn_cc1" data="${prodActivity.productId}" data1="${prodActivity.actId}" id="new_button">添加活动</a>
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
		                <th>ID</th>
		                <th>活动主题</th>
		                <th>开始时间</th>
		                <th>结束时间</th>
		                <th>状态</th>
		                <th width="350px">操作</th>
		            </tr>
		        </thead>
	            <tbody>
					<#list prodActivitys as prodActivity> 
						<tr>
							<td>${prodActivity.actId!''} </td>
							<td>${prodActivity.actTheme!''} </td>
							<td><#if prodActivity.startTime??>${prodActivity.startTime?string('yyyy-MM-dd')}</#if></td>
							<td><#if prodActivity.endTime??>${prodActivity.endTime?string('yyyy-MM-dd')}</#if></td>
							<td>
								<#if prodActivity.cancelFlag=='Y'>
									<span style="color:green" class="cancelProd">有效</span>
								<#else>
									<span style="color:red" class="cancelProd">无效</span>
								</#if>
							</td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="edit" data="${prodActivity.productId}" data1="${prodActivity.actId}">编辑</a>
		                        <a href="javascript:void(0);" class="enabled" data="${prodActivity.actId}" <#if prodActivity.cancelFlag='N'> style="display:none"</#if>>设为无效</a>
		                        <a href="javascript:void(0);" class="disable" data="${prodActivity.actId}" <#if prodActivity.cancelFlag='Y'> style="display:none"</#if>>设为有效</a>
		                        <a href="javascript:void(0);" class="showPhoto" data="${prodActivity.actId!''}" parentId="${prodActivity.actId!''}" logType="PROD_TICKET_ACTIVITY">图片</a>
		                    </td>
						</tr>
					</#list>
	            </tbody>
	        </table>
		</div>
	<!-- //主要内容显示区域 -->
	</div>
<#include "/base/foot.ftl"/>
</body>

<script>
	$(function(){ 
		var categorySelectDialog;
		//新建
		$("#new_button").bind("click",function(){
			var productId = $(this).attr("data");
			var actId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodActivity/showProdActivityInfo.do?productId="+productId+"&actId="+actId,{},{title:"景区活动",width:1100});
			return;
		});
		
		//修改
		$("a.edit").bind("click",function(){
			var productId = $(this).attr("data");
			var actId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodActivity/showProdActivityInfo.do?productId="+productId+"&actId="+actId,{},{title:"景区活动",width:1100});
			return false;
		});
		
		//启用
		$("a.disable").bind("click",function(){
			var actId = $(this).attr("data");
			$.ajax({
				url:'/vst_back/singleTicket/prod/prodActivity/updateProdActivityCancelFlag.do',
				type:"get",
				data:{"actId":actId,"cancelFlag":'Y'},
				success:function(result){
					if (result.code == "success") {
						$.alert(result.message,function(){
							window.location.reload();
						});
					}else {
						$.alert(result.message);
					}	
				}
			});
		});
		
		//禁用
		$("a.enabled").bind("click",function(){
			var actId = $(this).attr("data");
			$.ajax({
				url:'/vst_back/singleTicket/prod/prodActivity/updateProdActivityCancelFlag.do',
				type:"get",
				data:{"actId":actId,"cancelFlag":'N'},
				success:function(result){
					if (result.code == "success") {
						$.alert(result.message,function(){
							window.location.reload();
						});
					}else {
						$.alert(result.message);
					}	
				}
			});			
		});
		
		// Comphoto
		$("a.showPhoto").bind("click",function(){
			var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+$(this).attr("data")+"&parentId="+$(this).attr("parentId")
							+"&objectType=TICKET_ACTIVITY&logType="+$(this).attr("logType") + "&minNum=1&maxNum=1";
			new xDialog(url,{},{title:"图片列表",iframe:true,width:"885px",height:"1000px"});
		});
		
	});
	
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>

</html>
