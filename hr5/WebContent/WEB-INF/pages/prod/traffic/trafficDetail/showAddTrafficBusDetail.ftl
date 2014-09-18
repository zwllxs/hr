<form action="/vst_back/prod/traffic/showAddTrafficTrainDetail.do" method="post" id="dataForm" class="dataForm">
		<input type="hidden" name="productId" value="${traffic.productId}">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="">类型：</td>
                	<td><select name="prodTrafficBusList[0].tripType">
                	<option value="TO">去程</option>
                	<option value="BACK"  <#if traffic.toType==null || traffic.backType==null>disabled=disabled</#if> >返程</option>
                	</select></td>
                </tr>
                <tr>
                	<td class=""><#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if>地点：</td>
                	<td><input type="text" name="prodTrafficBusList[0].adress"  id="adress"></td>
                </tr>
                <tr>
                	<td class=""><#if type=='category_traffic_bus_other'>上车点<#else>上船点</#if>时间：</td>
                	<td><input type="hidden" name="prodTrafficBusList[0].startTime" id="startTime">
                	  <select class="w10 mr10" id="hour">
		                      <#list 0..23 as i>
		                      <option value="${i}">${i}</option>
		                      </#list>
		                </select>:
		                <select class="w10 mr10" id="minute">
		                      <#list 0..59 as i>
		                      <option value="${i}">${i}</option>
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
				
				 var msg = '确认保存吗 ？';	
				 if(refreshSensitiveWord($("input[type='text'],textarea"))){
				 	 $("input[name=senisitiveFlag]").val("Y");
				 	msg = '内容含有敏感词,是否继续?'
				 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
				
				$.confirm(msg,function(){
					$.ajax({
						url : "/vst_back/prod/traffic/addTrafficBusDetail.do",
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
</script>
