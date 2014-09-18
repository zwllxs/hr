<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">大交通</a> &gt;</li>
            <li><a href="#">航班/车次/班次信息</a> &gt;</li>
            <li class="active">信息维护</li>
        </ul>
</div>
<div class="fl operate"><a class="btn btn_cc1" id="new_button">添加航班</a></div>
<div class="iframe_content mt10">
 <!-- 主要内容显示区域\\ -->        
        <div class="p_box box_info">
            <table class="p_table table_center">
                <thead>
                    <tr>
                        <th>航班号</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <#if groupList?? && groupList?size &gt; 0>
                	<#list groupList as group> 
						<tr>
							<td>11111</td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp">编辑</a>
		                            <#if suppGoods.cancelFlag == "Y"> 
		                            <a href="javascript:void(0);" class="cancelProp" data="N">设为无效</a>
		                            <#else>
		                            <a href="javascript:void(0);" class="cancelProp" data="Y">设为有效</a>
		                            </#if>		                            
		                 	</td>
						</tr>
						</#list>
                <#else>
					<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td></tr>
		    	</#if>
		    	</tbody>
            </table>
        </div>
 </div>
<!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>

<script> 

</script>
