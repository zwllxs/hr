<#import "/base/pagination.ftl" as pagination>

<#--结果显示-->
<#if resultPage?? && resultPage.items?? &&  resultPage.items?size &gt; 0>
		 <div class="p_box">
   			 	<table class="p_table table_center">
               		<thead>
                		<tr>
                            <th>促销ID</th>
                            <th>规则名称</th>
                            <th>供应商CODE</th>
                            <th>时间类型</th>
                            <th>是否开启</th>
                            <th>是否排他</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th class="w15">操作</th>
                        </tr>
                     </thead>
   					 <tbody>
                        <#list resultPage.items as prom> 
                        	<tr>
                                <td>${prom.promPromotionId!''}</td>
                                <td>${prom.title!''}</td>
                                <td>${prom.code!''}</td>
                                <td><#if prom.timeType=='TIME_VISIT_DATE'>入住日期<#else>在店日期</#if></td>
                                <td><#if prom.valid=='Y'>是<#else>否</#if></td>
                                <td><#if prom.exclusive=='Y'>是<#else>否</#if></td>
                                <td>${prom.beginTime?string('yyyy-MM-dd')}</td>
                                <td>${prom.endTime?string('yyyy-MM-dd')}</td>
                                <td><a target="_blank" href="/vst_back/prom/promotion/showPromotionMaintain.do?promPromotionId=${prom.promPromotionId!''}" >编辑</a>&nbsp;&nbsp;<#if prom.valid=='Y'><a href="javascript:void(0);" onclick="closeProm(${prom.promPromotionId!''},'N');">关闭</a><#else><a href="javascript:void(0);" onclick="closeProm(${prom.promPromotionId!''},'Y');">开启</a></#if></td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                    <@pagination.paging resultPage true "#promotionListDiv"/>
		</div>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关促销，重新输入相关条件查询！</div>
    </#if>