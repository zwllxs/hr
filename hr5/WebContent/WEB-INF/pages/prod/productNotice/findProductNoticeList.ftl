 <!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px;">  
<div class="iframe-content">
<div id="tip" class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
        <p class="pl15">1.对内，仅客服可见该内容；全部，用户及客服都可见该内容。</p>
</div>
<div class="fl operate"><a class="btn btn_cc1" id="new" data=${productId} data1=${noticeType}>新增</a></div></br></br>
<#if pageParam.items?? &&  pageParam.items?size &gt; 0>  
  
    <div >
	<table class="p_table table_center">
                <thead>
                    <tr>
                	<th>类型</th>
                	<th>内容</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as productNotice > 
					<tr>
					<td>${productNotice.noticeTypeCN!''} </td>
					<td>${productNotice.content!''} </td>
					<td>${productNotice.startTime?string("yyyy-MM-dd")} </td>
					<td>${productNotice.endTime?string("yyyy-MM-dd")}</td>
					<td class="oper">
                            <a href="javascript:void(0);" class="editProductNotice" data=${productNotice.noticeId!''} data1=${productNotice.noticeType!''}>编辑</a>
                            <a href="javascript:void(0);" class="cancelProductNotice" data=${productNotice.noticeId!''}>删除</a>        
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
		<div class="no_data mt20"><i class="icon-warn32"></i>
		<#if noticeType == "PRODUCT_GIFT">
		暂无礼品信息  ！
		<#elseif noticeType == "PRODUCT_RECOMMEND">
		暂无推荐信息  ！
		<#else>
		暂无相关公告  ！
		</#if>
		</div>
    </#if>
	
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var tt = '${noticeType}';
if(tt == 'PRODUCT_RECOMMEND' || tt == 'PRODUCT_GIFT')
{
   $("#tip").css("display","none");
}
var addDialog,updateDialog;

	//新建

	$("#new").bind("click",function(){
		 var productId = $(this).attr("data"); 
		 var noticeType = $(this).attr("data1"); 
		 var strTitle = "新增公告";
    	if(noticeType=='PRODUCT_RECOMMEND')
    	{
    	   strTitle = "新增推荐";
    	}
    	if(noticeType=='PRODUCT_GIFT')
    	{
    	   strTitle = "新增礼品";
    	}
		 
		 
		addDialog = new xDialog("/vst_back/prod/productNotice/showAddProductNotice.do",{"productId":productId,"noticeType":noticeType}, {title:strTitle,width:900,hight:600,scrolling:"yes"})
		});

	//修改
	$("a.editProductNotice").bind("click",function(){
		var noticeId = $(this).attr("data");
		var noticeType = $(this).attr("data1"); 
		
		var strTitle = "修改公告";
    	if(noticeType=='PRODUCT_RECOMMEND')
    	{
    	   strTitle = "修改推荐";
    	}
    	if(noticeType=='PRODUCT_GIFT')
    	{
    	   strTitle = "修改礼品";
    	}
    	
		updateDialog = new xDialog("/vst_back/prod/productNotice/showUpdateProductNotice.do",{"noticeId":noticeId,"noticeType":noticeType}, {title:strTitle,width:900});
});

	//删除
	$("a.cancelProductNotice").bind("click",function(){
	 var noticeId=$(this).attr("data");
	 msg = " 确认删除 ？";
	 $.confirm(msg, function () {
	  $.get("/vst_back/prod/productNotice/editFlag.do?noticeId="+noticeId, function(result){
       confirmAndRefresh(result);
       });
       });
});
	
	
	//确定并刷新
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				location.reload();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	}

</script>
