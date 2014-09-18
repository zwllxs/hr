<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">签证产品维护</a> &gt;</li>
            <li class="active">添加受理领区</li>
        </ul>
</div>
<div class="iframe_content mt10">
    
 <!-- 主要内容显示区域\\ -->      
        
        <div class="p_box box_info">
        	<input type="hidden" id="productId" name="productId" value="${productId!''}">
        	<input type="hidden" id="categoryId" name="categoryId" value="${bizCategory.categoryId}">
       	 	<table class="s_table">
            <tbody>
                <tr>
				 	<td class=" operate mt10">
                    	<a class="btn btn_cc1" id="new_button">新增</a>
                    </td>
                </tr>
            </tbody>
        	</table>	
            <table class="p_table table_center">
                <thead>
                    <tr>
                        <th>受理领区</th>
                        <th>受理范围</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <#if prodVisaRangeList?? && prodVisaRangeList?size &gt; 0>
                	<#list prodVisaRangeList as prodVisaRange> 
						<tr>
							<td><#list dictExtendList as list>
		    						<#if prodVisaRange!=null && prodVisaRange.rangeCity==list.dictId>${list.dictName!''}</#if>
			                	</#list></td>
							<td width="1000">${prodVisaRange.area!''} </td>
							<td><#if prodVisaRange.cancelFlag == "Y"> 
								<span style="color:green" class="cancelProd">有效</span>
								<#else>
								<span style="color:red" class="cancelProd">无效</span>
								</#if>
							</td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="editProp" data=${prodVisaRange.rangeId}>编辑</a>
		                       <#if prodVisaRange.cancelFlag == "Y"> 
	                            <a href="javascript:void(0);" class="cancelProp" data="N" rangeId=${prodVisaRange.rangeId}>设为无效</a>
	                            <#else>
	                            <a href="javascript:void(0);" class="cancelProp" data="Y" rangeId=${prodVisaRange.rangeId}>设为有效</a>
	                             </#if>
		                 	</td>
						</tr>
						</#list>
				<#else>
					<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关受理领区，重新输入相关条件查询！</div></td></tr>
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
		//新建
		$("#new_button").bind("click",function(){
		if($("#productId").val()!=null && $("#productId").val()!=""){	
			new xDialog("/vst_back/visa/range/showProdVisaRange.do",{productId:$("input[name='productId']").val()},{title:"新增受理领区",width:1000});
		}else{
			$.alert("请先维护产品！");
		}	
		});
		
		//修改
		$("a.editProp").bind("click",function(){
		var rangeId = $(this).attr("data");
		new xDialog("/vst_back/visa/range/showProdVisaRange.do",{productId:$("input[name='productId']").val(),rangeId:rangeId},{title:"编辑受理领区",width:1000});
		});
		
		
		
		//删除
		$("a.cancelProp").bind("click",function(){
			var entity = $(this);
			var cancelFlag = entity.attr("data");
			var rangeId = entity.attr("rangeId");
			 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
		 	$.confirm(msg, function () {
				$.ajax({
					url : "/vst_back/visa/range/cancelProdVisaRange.do",
					type : "post",
					data : {rangeId:rangeId, cancelFlag:cancelFlag},
					success : function(result) {
						if(result.code=='success'){
							$.alert(result.message,function(){
								if(cancelFlag == 'N'){
									entity.attr("data","Y");
									entity.text("设为有效");
									$("span.cancelProd",entity.parents("tr")).css("color","red").text("无效");
								}else if(cancelFlag == 'Y'){
									entity.attr("data","N");
									entity.text("设为无效");
									$("span.cancelProd",entity.parents("tr")).css("color","green").text("有效");
								}
							});
						}else{
							$.alert(result.message);
						}
					}
				});
			});
		});
</script>