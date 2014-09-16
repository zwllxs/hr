<form action="" method="post" id="dataForm" class="dataForm">
		<input type="hidden" name="productId" value="${traffic.productId}">
		<input type="hidden" name="busId" value="${bus.busId}">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="">类型：</td>
                	<td><select name="tripType">
                	<option value="TO">去程</option>
                	<option value="BACK"  <#if traffic.toType==null || traffic.backType==null>disabled=disabled</#if> >返程</option>
                	</select></td>
                </tr>
                <tr>
                	<td class=""><#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if>地点：</td>
                	<td><input type="text" name="adress"  id="adress"  value="${bus.adress}"></td>
                </tr>
                <tr>
                	<td class=""><#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if>时间：</td>
                	<td><input type="hidden" name="startTime" id="startTime">
                	  <select class="w10 mr10" id="hour">
		                      <#list 0..23 as i>
		                      <option value="${i}"  <#if i==hour>selected=selected</#if>  >${i}</option>
		                      </#list>
		                </select>:
		                <select class="w10 mr10" id="minute">
		                      <#list 0..59 as i>
		                      <option value="${i}"<#if i==minute>selected=selected</#if> >${i}</option>
		                      </#list>
		                </select>分
                	</td>
                </tr>
            </tbody>
        </table>
</form>	
<div class="p_box box_info clearfix mb20">
     <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<script> 
	$("#save").click(function(){
				if($("#adress").val()==""){
						$.alert("请输入<#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if>地点");
						return;
				}
				$("#startTime").val($("#hour").val()+":"+$("#minute").val());
				
			var msg = '确认修改吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?';
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
				$.confirm(msg,function(){
						$.ajax({
						url : "/vst_back/prod/traffic/updateTrafficBusDetail.do",
						type : "post",
						data : $("#dataForm").serialize(),
						success : function(result) {
								if(result.code=='success'){
									$.alert("保存成功",function(){
											$("#traffic",parent.document).parent("li").trigger("click");
									});
								}else {
									$.alert("保存失败");
								}
						}
					});
				});
				
	});
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>
