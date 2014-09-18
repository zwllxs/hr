<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">保险管理</a> &gt;</li>
        <li class="active">保险配置列表</li>
    </ul>
</div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content mt20">   
    <div class="p_box">
    <table class="p_table table_center">
        <thead>
            <tr>
            	<td> <div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="new_button">新增</a></div></td>
             </tr>
        </thead>
    </table>
	<table class="p_table table_center">
        <thead>
            <tr>
            	<th>品类</th>
                <th>适用品类</th>
            	<th>考虑元素</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list bizInsurCatRuleList as bizInsurCatRule> 
				<tr>
					<td>${bizInsurCatRule.bizCategory.categoryName!''} </td>
					<td>
						<#list bizInsurCatRule.bizDictList as bizInsurCatRuleBizDict> 
							${bizInsurCatRuleBizDict.dictName!''} 
						</#list>
					</td>
					<td><#if bizInsurCatRule.destFlag =="Y">目的地</#if>&nbsp;
					<#if bizInsurCatRule.daysFlag =="Y">被保天数</#if></td>
					<td class="oper">
						<a class="editBizInsurCatRule" href="javascript:;" data="${bizInsurCatRule.ruleId!''}">编辑</a>
                    </td>
				</tr>
			</#list>
        </tbody>
    </table>
    
</div><!-- div p_box -->
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
//属性列表弹出框对象，不要有重名的
var saveDialog;

$(function(){
 
	//修改
	$("a.editBizInsurCatRule, #new_button").bind("click",function(){
	    var ruleId=$(this).attr("data");
	    var url = "/vst_back/insurance/InsurCatRule/showAddUpdateInsurCatRule.do";
	    saveDialog = new xDialog(url,{"ruleId":ruleId}, {title:"配置保险调取规则",width:800,height:450});
	});
	
	//设置状态
	$("a.editFlag").bind("click",function(){
		 var dictId=$(this).attr("data1");
		 var dictCancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
		 var url = "/vst_back/biz/dict/editDictFlag.do?dictId="+dictId+"&cancelFlag="+dictCancelFlag+"&newDate="+new Date();
		 msg = dictCancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 	 $.confirm(msg, function () {
			 $.get(url, function(data){
			    alert("设置成功");
				$("#searchForm").submit();
		     });
	     });
	});
	 
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}
	} 
});

</script>

