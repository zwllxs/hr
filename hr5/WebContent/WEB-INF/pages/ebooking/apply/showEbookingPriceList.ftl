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
            <li><a href="/vst_back/ebooking/apply/showEbookingSupplierList.do">审核列表</a> &gt;</li>
            <li class="active">审核修改</li>
        </ul>
</div>
<div class="iframe_search">
		<label>供应商名称：${ebkProdApply.supplierName!''}</label>
		<table class="s_table">
			<tr>
 					<td class="s_label">变更编号：${ebkProdApply.applyId!''}</td>
                    <td class="s_label">变更条目：<#list applyTypeList as list>
					            <#if ebkProdApply.applyType?? && ebkProdApply.applyType==list.code>${list.cnName!''}</#if>
					        </#list>
					</td>
                    <td class="s_label">提交信息：</td>
                    <td>申请单于${ebkProdApply.createTime?string('yyyy-MM-dd HH:mm:ss')} ${ebkProdApply.createUser!''}提交</td>
                    <td class="s_label">审核信息：</td>
                    <td><#if ebkProdApply.auditTime??>申请单于${ebkProdApply.auditTime?string('yyyy-MM-dd HH:mm:ss')} 由 ${ebkProdApply.auditUserName!''}</#if>
                    	<i class="cc1"><#list auditStatusList as list>
					            <#if ebkProdApply.auditStatus?? && ebkProdApply.auditStatus==list.code>${list.cnName!''}</#if>
					        </#list></i>
					</td>
			</tr>
		</table>
</div>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
		    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
			<table class="p_table table_center">
                <thead>
                    <tr>
                        <th>房型名称</th>
                        <th>起始日期</th>
                        <th>截止日期</th>
                        <th>适用星期</th>
                       <#if ebkProdApply.applyType=="PRICE_APPLY"> 
                        <th>早餐</th>
                        <th>结算价</th>
                        <th>销售价</th>
                        <th>提前预订时间</th>
                       <#else>
                       	<th>房态</th>
                        <th>保留房数量</th>
                       </#if>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as price> 
					<tr>
					<td>${price.suppGoodsName!''}</td>
                    <td>${price.startDate?string('yyyy-MM-dd')}</td>
                    <td>${price.endDate?string('yyyy-MM-dd')}</td>
				    <td><#if price.applyWeek??>
				    		<#list price.applyWeek?split(",") as week>
				            	<#if week=1> 日<#elseif week=2>一<#elseif week=3>二<#elseif week=4>三<#elseif week=5>四<#elseif week=6>五<#elseif week=7>六
				            	</#if>
				            </#list>
				    	</#if>
				    </td>
				    <#if ebkProdApply.applyType=="PRICE_APPLY">
                    <td>${price.breakfast!''}</td>
                    <td><#if price.settlementPrice??>
		                    <#if price.settlementPrice%100 == 0>${price.settlementPrice/100}.00
		                    <#else>${price.settlementPrice/100}
		                    </#if>
                    	</#if>
                    </td>
                    <td><#if price.marketPrice??>
                    		<#if price.marketPrice%100 == 0>${price.marketPrice/100}
	                    	<#else>${price.marketPrice/100}
	                    	</#if>
                    	</#if>
                    </td>
                    <td name="aheadBookTime">${price.aheadBookTime!''}</td>
                    <#else>
                    <td><#list stockStatusList as list>
					            <#if price.stockStatus?? && price.stockStatus==list.code>${list.cnName!''}</#if>
					        </#list></td>
                    <td>${price.stock!''}</td>
                    </#if>
					</tr>
					</#list>
                </tbody>
            </table>
            <#else>
				<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关审查对象，重新输入相关条件查询！</div>
		    </#if>
  			<#if pageParam.items?exists> 
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
	$(function(){
	
		$("td[name=aheadBookTime]").each(function(){
 			$(this).text(minutesToDate($(this).text()));
			});
		
	});
	//将分钟数转换为天/时/分
                function minutesToDate(time){
                	var time = parseInt(time);
					var day=0;
					var hour=0;
					var minute=0;
					if(time >  0){
						day = Math.ceil(time/1440);
						hour = parseInt((1440 - time%1440)/60);
						minute = parseInt((1440 - time%1440)%60);
					}else if(time < 0 ){
						time = -time;
						hour = parseInt(time/60);
						minute = parseInt(time%60);
					}
					if(hour<10)
						hour = "0"+hour;
					if(minute<10)
						minute = "0"+minute;
					return day+"天"+hour+"点"+minute+"分";
                }
</script>
