<form action="/vst_back/prod/traffic/showAddTrafficTrainDetail.do" method="post" id="dataForm" class="dataForm">
		<input type="hidden" name="productId" value="${traffic.productId}">
		<input type="hidden" name="trainId" value="${train.trainId}">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="">类型：</td>
                	<td><select name="tripType">
                	<option value="TO" <#if train.tripType=='TO'>selected=selected</#if> >去程</option>
                	<option value="BACK" <#if train.tripType=='BACK'>selected=selected</#if>  <#if traffic.toType==null || traffic.backType==null>disabled=disabled</#if> >返程</option>
                	</select></td>
                </tr>
                <tr>
                	<td class="">车次号：</td>
                	<td><input type="text" name="trainNo" id="toType" value="${train.trainNo}"></td>
                </tr>
            </tbody>
        </table>
</form>	
<div class="p_box box_info clearfix mb20">
     <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<script> 
	vst_pet_util.commListSuggest($("#toType"),$("form"),'/vst_back/prod/traffic/searchTrainNoList.do','');
	
	$("#save").click(function(){
				if($("#toType").val()==""){
						$.alert("请输入车次信息");
						return;
				}
				$.ajax({
					url : "/vst_back/prod/traffic/updateTrafficTrainDetail.do",
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
</script>
