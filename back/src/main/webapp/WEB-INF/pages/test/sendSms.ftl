<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">字典管理</a> &gt;</li>
        <li class="active">字典列表</li>
    </ul>
</div>
<div class="iframe_search">

<form  id="dataForm">
    <table class="p_table form-inline">
        <tbody>
            <tr>
            	<td class="p_label">短信内容：</td>
                <td><input id="content" type="text" name="content"></td>
            </tr>
            <tr>
            	<td class="p_label">手机号：</td>
            	<td>
            		<input id="mobile" type="text" name="mobile">
            	</td>
            </tr>
            <tr>
            	<td class="p_label"> <a id="sendSms" href="javascript:void(0);" >发送</a></td>
            	<td class="p_label"></td>
            </tr>
             <tr>
            	<td class="p_label"> <a id="userUserProxyTest" href="javascript:void(0);" >用户测试</a></td>
            	<td class="p_label"></td>
            </tr>
        </tbody>
    </table>
</form>

</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	//用户测试
	$("#userUserProxyTest").bind("click",function(){
		 $.ajax({
			url : "/vst_back/pet/smsSend/userUserProxyTest.do",
			type : "post",
			data : {},
			dataType:'JSON',
			success : function(result) {
				if (result.flag=='Y') {
		     		alert("发送成功！");
		     	} else {
		     		alert("发送失败！");
		     	}
			}
		});
	});
	
	//新增字典
	$("#sendSms").bind("click",function(){
		var mobile = $("#mobile").val();
		var content = $("#content").val();
			
		 $.ajax({
			url : "/vst_back/pet/smsSend/sendSms.do",
			type : "post",
			data : {content:content,mobile:mobile},
			dataType:'JSON',
			success : function(result) {
				if (result.flag=='Y') {
		     		alert("发送成功！");
		     	} else {
		     		alert("发送失败！");
		     	}
			}
		});
	});
</script>