<form action="/vst_back/prod/traffic/showAddTrafficFlightDetail.do" method="post" id="dataForm" class="dataForm">
		<input type="hidden" name="productId" value="${traffic.productId}">
		<input type="hidden" name="groupId" value="${group.groupId}">
        <table class="p_table form-inline">
            <tbody>
        	<#assign index=0 />
        	<#if traffic.toType!=null&&traffic.backType!=null>
                <tr>
                	<td class="">往返-去程</td>
                </tr>
                <tr>
                	<td class="">直飞/中转:<select id="transfer"><option value="1">直飞</option><option value="2"  <#if flightListTo?size==2>selected=selected</#if> >1程中转</option></select></td>
                </tr>
                <#list flightListTo as prodTrafficFlight>
					<tr <#if index%2==1>class="moreFlight"</#if> >
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[${index}].flightNo" class="toType" value='${prodTrafficFlight.flightNo}' >
                	<input type="hidden" name="prodTrafficFlightList[${index}].tripType" value="TO">
                	<input type="hidden" class="flightId" name="prodTrafficFlightList[${index}].flightId" value="${prodTrafficFlight.flightId}">
                	</td>
                </tr>
                <#if flightListTo?size ==1>
                 <tr class="moreFlight" style="display:none">
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[3].flightNo" class="toType"></td>
                	<input type="hidden" name="prodTrafficFlightList[3].tripType" value="TO">
                </tr>
                </#if>
                <#assign index=index+1 />
				</#list>
                <tr>
                	<td class="">往返-返程</td>
                </tr>
                <#list flightListBack as prodTrafficFlight>
					<tr <#if index%2==1>class="moreFlight"</#if> >
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[${index}].flightNo" class="backType" value='${prodTrafficFlight.flightNo}' >
                	<input type="hidden" name="prodTrafficFlightList[${index}].tripType" value="BACK">
                	<input type="hidden"  class="flightId" name="prodTrafficFlightList[${index}].flightId" value="${prodTrafficFlight.flightId}">
                	</td>
                </tr>
                <#if flightListBack?size ==1>
                 <tr class="moreFlight" style="display:none">
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[4].flightNo" class="backType"></td>
                	<input type="hidden" name="prodTrafficFlightList[4].tripType" value="BACK">
                </tr>
                </#if>
                <#assign index=index+1 />
				</#list>
                <#else>
                <tr>
                	<td class="">单程</td>
                </tr>
                <tr>
                	<td class="">直飞/中转:<select id="transfer"><option value="1">直飞</option><option value="2"   <#if flightListTo?size==2>selected=selected</#if>  >1程中转</option></select></td>
                </tr>
               <#list flightListTo as prodTrafficFlight>
					<tr  <#if index%2==1>class="moreFlight"</#if> >
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[${index}].flightNo" class="toType" value='${prodTrafficFlight.flightNo}' >
                	<input type="hidden" name="prodTrafficFlightList[${index}].tripType" value="TO">
                	<input type="hidden" class="flightId" name="prodTrafficFlightList[${index}].flightId" value="${prodTrafficFlight.flightId}">
                	</td>
                </tr>
                <#assign index=index+1 />
				</#list>
				<#if flightListTo?size ==1>
                 <tr class="moreFlight" style="display:none">
                	<td class="">航班号：<input type="text" name="prodTrafficFlightList[1].flightNo" class="toType"></td>
                	<input type="hidden" name="prodTrafficFlightList[1].tripType" value="TO">
                </tr>
                </#if>
                </#if>
            </tbody>
        </table>
</form>
<div class="p_box box_info clearfix mb20">
     <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<script> 
	$(".toType,.backType").each(function(){
			vst_pet_util.commListSuggest($(this),$("form"),'/vst_back/prod/traffic/searchFlightNoList.do','');
	});
	
	$("#save").click(function(){
				try{
					$(".toType,.backType").each(function(){
						if(!$(this).is(":hidden")){
							if($(this).val()==""){
								throw "请输入航班信息";
							}
						}
					});
				}catch(e){
					$.alert(e);
					return;
				}
				//首先删掉其它航班
				$(".flightId").each(function(){
						var flightId = $(this).val();
						if($(this).attr("disabled")=="disabled"){
								$.ajax({
									url : "/vst_back/prod/traffic/deleteTrafficFlightDetail.do",
									type : "post",
									data : {"flightId":flightId},
									success : function(result) {
											
									}
								});
						}
				});
				$.ajax({
					url : "/vst_back/prod/traffic/updateTrafficFlightDetail.do",
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
	
	$("#transfer").change(function(){
		var value = $(this).val();
		if(value=="2"){
			$(".moreFlight").show();
			$(".moreFlight").find("input").removeAttr("disabled");
		}else {
			$(".moreFlight").hide();
			$(".moreFlight").find("input").attr("disabled","disabled");
		}
	});
</script>
