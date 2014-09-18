<form action="/vst_back/ticket/goods/goods/addSuppGoods.do" method="post" id="dataForm">
		<input type="hidden" name="productId" value="${productId}"> 
		<input type="hidden" name="rangeId" <#if prodVisaRange?? && prodVisaRange.rangeId??>value="${prodVisaRange.rangeId}"</#if>> 
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>所属领区：</td>
                	<td colspan=2>
                		<select name="rangeCity" id="rangeCity" required>
                    	 			<option value="">请选择</option>
		    						<#list dictExtendList as list>
		    							<option value=${list.dictId!''} <#if prodVisaRange!=null && prodVisaRange.rangeCity==list.dictId>selected</#if>>${list.dictName!''}</option>
			                </#list>
			        	</select>
                	</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>受理范围：</td>
                	<td colspan=2>
                		<textarea class="w35 textWidth" required style="width:700px; height:80px" maxlength=2000 id="area" name="area"><#if prodVisaRange?? && prodVisaRange.area??>${prodVisaRange.area!''}</#if></textarea>
                	</td>
                </tr>
            </tbody>
        </table>
</form>
<div class="p_box box_info clearfix mb20">
	<div class="fl operate" style="margin-top:10px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<script>
$(function(){
	$(".textWidth[maxlength]").each(function(){
		var	maxlen = $(this).attr("maxlength");
		if(maxlen != null && maxlen != ''){
			var l = maxlen*12;
			if(l >= 700) {
				l = 700;
			} else if (l <= 200){
				l = 200;
			} else {
				l = 400;
			}
			$(this).width(l);
		}
		$(this).keyup(function() {
				vst_util.countLenth($(this));
		});
	});
});
$("#save").bind('click',function(){
	//验证
			if(!$("#dataForm").validate({
			}).form()){
				return false;
			}
		  var msg = '是否保存?';	
		  if(refreshSensitiveWord($("input[type='text'],textarea"))){
		 	 msg = '内容含有敏感词,是否继续?';
		  }
			$.confirm(msg,function(){
				$.ajax({
				url : "/vst_back/visa/range/updateProdVisaRange.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					if(result.code=='success'){
						$.alert(result.message,function(){
							location.href="/vst_back/visa/range/findProdVisaRangeList.do?productId="+$("#productId").val()+"&categoryId="+$("#categoryId").val();
			   			});
					}else{
						$.alert(result.message);
					}
				}
				});
			});

});
refreshSensitiveWord($("input[type='text'],textarea"));
</script>