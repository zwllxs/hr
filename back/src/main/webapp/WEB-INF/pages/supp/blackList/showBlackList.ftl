<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_content mt10">
<div class="tiptext tip-warning cc5">
    <p class="pl15">日期限制：该商品在指定游玩日期范围内的每一天，同一个手机号，最多允许订购的笔数。（已取消的订单不参与累加计算）</p>
    <p class="pl15">黑名单：该黑名单列表内，所有日期均不允许下单。</p>      
</div>
		<div class="p_box box_info p_line">
			<div id="price_tab" class="price_tab">
				<input type="hidden" value="${categoryId}" id="hCategoryId"/>
				<ul class="J_tab ui_tab">
					<li id="show1" class="active"><a href="javascript:showPage('show1');">游玩日期范围限制</a></li>
					<li id="show2" ><a href="javascript:showPage('show2');">手机黑名单</a></li>
					<li id="show3" ><a href="javascript:showPage('show3');">身份证黑名单</a></li>
				</ul>
			</div>            
		</div>
		<div class="limit" id="limit">
         <form id="searchForm" action="/supp/blacklist/saveLimit.do"  method="post">
         <input type="hidden" id="limitId" name="limitId" <#if limit??>value="${limit.limitId}"</#if>>
         <input type="hidden" id="goodId" name="goodId" value="${goodId}">
		 <table class="e_table form-inline">
		    <tbody>
				<tr>
					<td width="120" class="e_label td_top"><i class="cc1">*</i>游玩日期范围：</td>
                    <td class="w18" colspan='5'><input type="text" <#if limit??> value="${limit.startTime?string('yyyy-MM-dd')}"</#if> id="startTime" name="startTime" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true})" />
					--<input type="text" <#if limit??> value="${limit.endTime?string('yyyy-MM-dd')}"</#if> id="endTime" name="endTime" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({readOnly:true})" /></td>
                </tr>
                <tr>
                    <td width="120" class="e_label td_top"><i class="cc1">*</i>同游玩日同手机最多订购笔数：</td>
                    <td>
                    <select id="limitNum" name="limitNum">
                    <#list blacklistNumList as blackListNum>
                    <#if limit??>
                    <#if blackListNum == limit.limitNum>
                    <option value="${blackListNum}"  selected="selected">${blackListNum}</option>
                    <#else>
                    <option value="${blackListNum}">${blackListNum}</option>
                    </#if>
                    <#else>
                    <option value="${blackListNum}">${blackListNum}</option>
                    </#if>
                    </#list>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td width="120" class="e_label td_top"></td>
                    <td><div class="fl operate"><a class="btn btn_cc1" id="saveLimit">保存</a></div></td>
                </tr>
           </tbody>
		</table>
	</form>
		</div>
</div>	
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	
	
	function showPage(obj){
		
	    var goodId = $("#goodId").val();
		if(obj=='show2'){
			location.href = '/vst_back/supp/blackList/showPhoneList.do?goodId='+goodId;
		}else if(obj=='show3'){
			location.href = '/vst_back/supp/blackList/showIDCardList.do?goodId='+goodId;
		}
	}
	
	$("#saveLimit").click(function(){
	    var startTime = $("#startTime").val();
	    var endTime = $("#endTime").val();
	    var limitNum = $("#limitNum").val();
	    
	    if(startTime==''){
			$.alert("请选择开始时间");
			return;
		}
		if(endTime==''){
			$.alert("请选择结束时间");
			return;
		}
		
		var d1 = new Date(startTime.replace(/\-/g, "\/"));  
		var d2 = new Date(endTime.replace(/\-/g, "\/"));  
		if(d1 > d2)  
        {  
            $.alert("开始时间不能大于结束时间！");  
            return false;  
        }
		
		if(limitNum==''){
			$.alert("请填写份数");
			return;
		}
		$.ajax({
				url : "/vst_back/supp/blackList/saveLimit.do",
				type : "post",
				dataType : 'json',
				data : $("#searchForm").serialize(),
				success : function(result) {
				        $.alert("保存成功");
				}
			});
	});
	
</script>