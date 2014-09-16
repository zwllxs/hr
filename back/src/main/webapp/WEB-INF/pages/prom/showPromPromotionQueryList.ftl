<#--页眉-->
<#import "/base/spring.ftl" as s/>
<#import "/base/pagination.ftl" as pagination>
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<#--页面导航-->
<div class="iframe_header">
        <i class="icon-home ihome"></i>
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">促销管理</a> &gt;</li>
            <li class="active">查询列表</li>
        </ul>
    </div>

<#--表单区域-->
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/prom/promotion/queryPromPromotionQueryList.do" method="post" onsubmit="return false">
		<table class="s_table  form-inline">
            <tbody>
               
                <tr>
                    <td class="w6 s_label">促销名称：</td>
                    <td class="w8"><input type="text" class="w10" name="title" value=${promPromotion.title}></td>
                    <td class="w6 s_label">促销ID：</td>
                    <td class="w8"><input type="text" class="w10" name="promPromotionId" value=${promPromotion.promPromotionId}></td>
                    <td class="w10 s_label">促销是否开启：</td>
                    <td class="w8">
                        <select class="w8" name="valid">
                        	<option value="" <#if promPromotion.valid==''>selected</#if> >不限</option>
                            <option value="Y" <#if promPromotion.valid=='Y'>selected</#if> >是</option>
                            <option value="N" <#if promPromotion.valid=='N'>selected</#if> >否</option>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="operate mt20" style="text-align:center"><a class="btn btn_cc1" id="search_button">查询</a>&nbsp;&nbsp;<a class="btn btn_cc1" target="_blank" href="/vst_back/prom/promotion/showPromotionMaintain.do">新增</a></div>
        <div id="errorMessage" class="no_data mt20" style="display:none;"><i class="icon-warn32"></i>请至少输入一个查询条件！</div>
	</form>
</div>
<div id="result" class="iframe_content mt20"></div>
	
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
 
$(function(){
	//查询
	$("#search_button").bind("click",function(){
		 
		//加载促销
		loadPromotionList();
	});
	 
});
//加载促销
function loadPromotionList(){
		if(!$("#searchForm").validate().form()){
				return false;
		 }
		$("#result").empty();
		$("#result").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'>正在努力的加载数据中......</div>");
		 //ajax加载结果
		var $form=$("#searchForm");
		 $("#result").load($form.attr("action"),$form.serialize(),function(){
			 
		});
}
function closeProm(promId,valid){
	var str="";
	if('N'==valid){
		str="关闭";
	}else{
		str="开启";
	}
	if(confirm('确定要'+str+'该促销吗?'))
	$.ajax({
			url : "/vst_back/prom/promotion/openClosePromotionInfo.do",
			type : "get",
			dataType : 'json',
			data : {"promPromotionId":promId,"valid":valid},
			success : function(result) {
				if(result.success){
					//加载促销
					loadPromotionList();
				 }else{
				 	$.alert(result.message);
				 }
			}
		});
}
</script>