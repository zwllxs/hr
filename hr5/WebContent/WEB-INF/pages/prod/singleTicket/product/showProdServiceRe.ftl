<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">商品维护</a> &gt;</li>
            <li class="active">设置服务保障</li>
        </ul>
	</div>
	<div class="p_box box_info">
		 <div class="box_content">
		 	<form id="saveOrUpdateForm">
			    <table>
			        <tbody>
			            <tr>
			            	<td class="e_label" width="130px;">设置服务保障：</td>
			            	<td>
			            		<input type="hidden" name="productId" value="${productId}"/>
			            		<#list serviceTypes as serviceType>
			            			<#assign sType=0 />
			            			<#if prodServiceRes?? && prodServiceRes?size &gt; 0>
			            				<#list prodServiceRes as prodServiceRe>
			            					<#if serviceType.code==prodServiceRe.serviceType>
			            						<#if serviceType.code=='ENSURING_THE_GARDEN'>
			            							<input type="checkbox" errorEle="code" checked="checked" name="serviceTypes" value="${serviceType.code!''}" disabled/>
			            						<#else>
			            							<input type="checkbox" errorEle="code" checked="checked" name="serviceTypes" value="${serviceType.code!''}"  />
			            						</#if>
			            						${serviceType.cnName!''}
			            						<#assign sType=serviceType.code />
			            					</#if>
			            				</#list>
			            			</#if>
			            			<#if sType!=serviceType.code>
			            				<#if serviceType.code=='ENSURING_THE_GARDEN'>
			            					<input type="hidden" name="serviceTypes" value="ENSURING_THE_GARDEN"/>
			            					<input type="checkbox" errorEle="code" checked="checked" name="serviceTypes" value="${serviceType.code!''}" disabled />
			            				<#else>
			            					<input type="checkbox" errorEle="code" name="serviceTypes" value="${serviceType.code!''}"  />
			            				</#if>
			    						${serviceType.cnName!''}				
			            			</#if>
				                </#list>
			            	</td>
			            </tr>
			            <tr>
			            	<td>&nbsp;</td>
			           		<td>
			           			<div class="fl operate" style="margin:20px;margin-left:210px;">
			           				<a class="btn btn_cc1" id="saveOrUpdate">保存</a>
			           			</div>	
			           		</td>
			            </tr>
			   		</tbody>
			   	</table>
			</form>
		</div>
    </div>
</body>
<#include "/base/foot.ftl"/>
<script>
	$(function(){
		// 保存于修改
		$('#saveOrUpdate').bind('click',function(){
			$.ajax({
				url: '/vst_back/singleTicket/prod/prodServiceRe/saveOrUpdateProdServiceRe.do',
			    type:'POST',
			    dataType:'json',
			    data:$("#saveOrUpdateForm").serialize(),
			    success:function(result){
					if(result.code=='success'){
						$.alert(result.message);
					}else{
						$.alert(result.message);
					}								    
			    }
			});
		});
	});
		if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>
</html>