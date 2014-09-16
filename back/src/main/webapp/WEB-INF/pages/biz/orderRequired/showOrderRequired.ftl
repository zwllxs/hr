<#assign mis=JspTaglibs["/WEB-INF/pages/tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">后台</a> &gt;</li>
        <li><a href="#">下单必填项配置</a></li>
    </ul>
</div>
<div class="iframe_content">
<div class="tiptext tip-warning cc5">
    <p class="pl15">注：被使用定义品类的字段，需要关闭其在产品管理里面该字段创建后可修改额权限</p>
    <p class="pl15">注：删除产品上的属性时，需要看下是否被该处使用</p>      
    </div>
	<form method="post" action='/vst_back/biz/orderRequired/showOrderRequired.do' id="reuqiredForm">
	<div class="p_box box_info">
		<input type="hidden" name="reqId" value="${bizOrderRequired.reqId!''}">
		    <table class="s_table">
		    <tbody>
		    <tr>
	       		<td class="s_label">品类：</td>
	            <td class="w18">
	            	<select id="groupCode" name="groupCode" required=true>
	                	 <#list orderRequiredFieldMap?keys as key>
	                		<#if key == bizOrderRequired.groupCode>
	                			<option value="${key!''}" selected="selected">${orderRequiredFieldMap[key]!''}</option>
	                		<#else>
	                			<option value="${key!''}">${orderRequiredFieldMap[key]!''}</option>
	                		</#if>
	                	</#list>
	            	</select>
	            </td>
	            <td class=" operate mt10">
		            <a class="btn btn_cc1" id="btnSearch">查询</a>
		        </td>
	        </tr>
		    </tbody>
		    </table>	
	</div>
<!-- 主要内容显示区域\\ -->
    <div class="p_box box_info">
	<table class="p_table table_center">
        <tbody>
	        <tr>
	        	<td colspan="2" style="font-size: 16px;"><b>游玩人/取票人/入住人</b></td>
	        </tr>
			<tr>
            <td class="e_label" width="250" width="250" width="250"><i class="cc1">*</i>是否需要游玩人信息：</td>
            <td style="text-align:left;">
            	<input type="radio" name="needTravFlag" <#if bizOrderRequired.needTravFlag=='Y'>checked</#if> value="Y">&nbsp;是
            	<input type="radio" name="needTravFlag" <#if bizOrderRequired.needTravFlag=='N'>checked</#if> value="N">&nbsp;否
            </td>
        </tr>
        <tr>
            <td class="e_label" width="250"><i class="cc1">*</i>填写数量：1笔订单需要游玩人信息</td>
            <td style="text-align:left;">
            	<#list orderRequiredTravNumMap?keys as key>
            		<#if key!='TRAV_NUM_NO'>
            			<input type="radio" name="travNumType" <#if key==bizOrderRequired.travNumType>checked</#if> value="${key!''}">&nbsp;${orderRequiredTravNumMap[key]!''}
            			<#if key == 'TRAV_NUM_CONF'>注，代表该品类无法规则化，需要业务基于不同商品做设置</#if><#if key == 'TRAV_NUM_ALL'>注，代表该品类基于“数量关联”有几个游玩人就需要填写几个</#if><#if key == 'TRAV_NUM_ONE'>注，代表该品类只需要一个游玩人即可</#if>
            		    <br/>
            		</#if>
            	</#list>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: 16px;"><i class="cc1">*</i><b>游玩人信息明细：</b></td>
        </tr>
        <tr>
            <td class="e_label" width="250">姓名：</td>
            <td style="text-align:left;">需要&nbsp;&nbsp;注，数量根据“填写数量调取”</td>
        </tr>
        <tr>
            <td class="e_label" width="250">英文姓名：</td>
            <td style="text-align:left;">
            	<select id="ennameType" name="ennameType" value="${bizOrderRequired.ennameType!''}" required=true>
            		<#list orderRequiredTravNumMap?keys as key>
	                	<#if key == bizOrderRequired.ennameType>
	                		<option value="${key!''}" selected="selected">${orderRequiredTravNumMap[key]!''}</option>
	               		<#else>
	               			<option value="${key!''}">${orderRequiredTravNumMap[key]!''}</option>
	               		</#if>
	               	</#list>
            	</select>
            </td>
        </tr>
        <tr>
        	<td class="e_label" width="250">手机号：</td>
            <td style="text-align:left;">
            	<select id="phoneNumType" name="phoneNumType" value="${bizOrderRequired.phoneNumType!''}" required=true>
            		<#list orderRequiredTravNumMap?keys as key>
	                	<#if key == bizOrderRequired.phoneNumType>
	                		<option value="${key!''}" selected="selected">${orderRequiredTravNumMap[key]!''}</option>
	               		<#else>
	               			<option value="${key!''}">${orderRequiredTravNumMap[key]!''}</option>
	               		</#if>
	               	</#list>
            	</select>
            </td>
        </tr>
        <tr>
            <td class="e_label" width="250">email：</td>
            <td style="text-align:left;">
            	<select id="emailType" name="emailType" value="${bizOrderRequired.emailType!''}" required=true>
            		<#list orderRequiredTravNumMap?keys as key>
	                	<#if key == bizOrderRequired.emailType>
	                		<option value="${key!''}" selected="selected">${orderRequiredTravNumMap[key]!''}</option>
	               		<#else>
	               			<option value="${key!''}">${orderRequiredTravNumMap[key]!''}</option>
	               		</#if>
	               	</#list>
            	</select>
            </td>
        </tr>
        <tr>
            <td class="e_label" width="250">人群：</td>
            <td style="text-align:left;">
            	<select id="occupType" name="occupType" value="${bizOrderRequired.occupType!''}" required=true>
            		<#list orderRequiredTravNumMap?keys as key>
	                	<#if key == bizOrderRequired.occupType>
	                		<option value="${key!''}" selected="selected">${orderRequiredTravNumMap[key]!''}</option>
	               		<#else>
	               			<option value="${key!''}">${orderRequiredTravNumMap[key]!''}</option>
	               		</#if>
	               	</#list>
            	</select>
            </td>
        </tr>
        <tr>
        	<td class="e_label" width="250">证件：</td>
            <td style="text-align:left;">
            	<select id="idNumType" name="idNumType" value="${bizOrderRequired.idNumType!''}" required=true>
                	 <#list orderRequiredTravNumMap?keys as key>
	                	<#if key == bizOrderRequired.idNumType>
	                		<option value="${key!''}" selected="selected">${orderRequiredTravNumMap[key]!''}</option>
	               		<#else>
	               			<option value="${key!''}">${orderRequiredTravNumMap[key]!''}</option>
	               		</#if>
	               	</#list>
            	</select>
            	<br>
            	<div id="idNumTypeShow">
            	身份证：
            	<input type="radio" name="idFlag" <#if bizOrderRequired.idFlag=='Y'>checked</#if> value="Y" >&nbsp;是
            	<input type="radio" name="idFlag" <#if bizOrderRequired.idFlag=='N'>checked</#if> value="N" >&nbsp;否
            	<br>
            	护&nbsp;&nbsp;&nbsp;照：
            	<input type="radio" name="passprotFlag" <#if bizOrderRequired.passprotFlag=='Y'>checked</#if> value="Y" >&nbsp;是
            	<input type="radio" name="passprotFlag" <#if bizOrderRequired.passprotFlag=='N'>checked</#if> value="N" >&nbsp;否
            	<br>
            	是否港澳通行证：
            	<input type="radio" name="passFlag" <#if bizOrderRequired.passFlag=='Y'>checked</#if> value="Y" >&nbsp;是
            	<input type="radio" name="passFlag" <#if bizOrderRequired.passFlag=='N'>checked</#if> value="N" >&nbsp;否
            	<br>
            	是否台湾通行证:
            	<input type="radio" name="twPassFlag" <#if bizOrderRequired.twPassFlag=='Y'>checked</#if> value="Y" >&nbsp;是
            	<input type="radio" name="twPassFlag" <#if bizOrderRequired.twPassFlag=='N'>checked</#if> value="N" >&nbsp;否
            	</div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: 16px;">紧急联系人：<i class="cc1"><b>注，紧急联系人，若需要，则仅会出现一个让用户输入</b></i></td>
        </tr>
        <tr>
        	<td class="e_label" width="250"><i class="cc1">*</i>是否需要紧急联系人：</td>
        	<td style="text-align:left;">
	        	<input type="radio" name="ecFlag" <#if bizOrderRequired.ecFlag=='Y'>checked</#if> value="Y">&nbsp;是
	            <input type="radio" name="ecFlag" <#if bizOrderRequired.ecFlag=='N'>checked</#if> value="N">&nbsp;否
        	</td>
        </tr>
        <tr>
        	<td class="operate mt10" colspan="2" style="font-size: 16px;">
		        <a class="btn btn_cc1" id="btnSave">保存</a>
		    </td>
        </tr>
        </tbody>
    </table>
	</div><!-- div p_box -->
</form>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
$(function(){
	if($("select[name=idNumType] option:selected").val()=='TRAV_NUM_NO' || $("select[name=idNumType] option:selected").val()=='TRAV_NUM_CONF'){
		$("#idNumTypeShow").hide();
	}else{
		$("#idNumTypeShow").show();
	}
});

	$("select[name=idNumType]").change(function(){
		if($("select[name=idNumType] option:selected").val()=='TRAV_NUM_NO' || $("select[name=idNumType] option:selected").val()=='TRAV_NUM_CONF'){
			$("#idNumTypeShow").hide();
		}else{
			$("#idNumTypeShow").show();
		}
	});

$("#reuqiredForm").validate({
	rules: {
		 'ecFlag':{ required:true },
		 'needTravFlag':{ required:true },
		 'travNumType':{ required:function(){return $("input[name='needTravFlag']:checked").val() === 'Y';} }
	}
});

//修改合同
$("#btnSave").click(function(){
	if(!$("#reuqiredForm").validate().form()){
        return false;
    }
	var resultCode;
	$.ajax({
		url : "/vst_back//biz/orderRequired/addOrModifyOrderRequired.do",
		type : "post",
		data : $("#reuqiredForm").serialize(),
		dataType:'JSON',
		success : function(result) {
			resultCode=result.code;
			confirmAndRefresh(result);
		}
	});
});

$("#btnSearch").click(function(){
	$("#reuqiredForm").submit();
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
  			$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
}
</script>