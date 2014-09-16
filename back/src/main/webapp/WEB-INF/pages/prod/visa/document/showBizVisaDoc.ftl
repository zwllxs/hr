<form action="/vst_back/visa/visaDoc/showBizVisaDoc.do" method="post" id="dataForm">
		<input type="hidden" name="docId" <#if bizVisaDoc?? && bizVisaDoc.docId??>value="${bizVisaDoc.docId}"</#if>> 
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>签证材料名称：</td>
                	<td colspan=2>
                		<input type="text" name="docName" <#if bizVisaDoc?? && bizVisaDoc.docName??>value="${bizVisaDoc.docName}"</#if> required> 
                	</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>签证国家/地区：</td>
                	<td colspan=2>
                		<input type="text" id="country1" name="country" <#if bizVisaDoc?? && bizVisaDoc.country??>value="${bizVisaDoc.country}"</#if> required <#if bizVisaDoc?? && bizVisaDoc.docId??>readOnly</#if>> 
                	</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>签证类型：</td>
                	<td colspan=2>
                		<select class="w15" name="visaType" onchange="checkRequired();" required <#if bizVisaDoc?? && bizVisaDoc.docId??>disabled</#if>>
                    	<option value="" selected="">全部</option>
						 <#list vistTypeList as bizDict>
		                    <option value="${bizDict.dictId}" <#if bizVisaDoc!=null && bizVisaDoc.visaType==bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
					  	</#list>
                    	</select>
                	</td>
                </tr>
                <tr>
                	<td class="p_label" name="city*"><i class="cc1">*</i>送签城市：</td>
                	<td colspan=2>
                		<select class="w15" name="city" required <#if bizVisaDoc?? && bizVisaDoc.docId??>disabled</#if>>
                    	<option value="" selected="">全部</option>
						<#list vistCityList as bizDict>
		                    <option value=${bizDict.dictId} <#if bizVisaDoc!=null && bizVisaDoc.city==bizDict.dictId>selected</#if>>${bizDict.dictName}</option>
					  	</#list>
                    </select>
                	</td>
                </tr>
            </tbody>
        </table>
        <i class="cc1">*</i>免签、落地签、自备签、对应的送签城市非必填；
</form>
<div class="p_box box_info clearfix mb20">
	<div class="fl operate"><a class="btn btn_cc1" id="saveVisaDoc">保存</a></div>
</div>
<script>
vst_pet_util.visaCountrySuggest("#country1","#country1");
 
		function checkRequired(){
			$(".e_error").remove();
			if($("select[name=visaType]").val()=='708' || $("select[name=visaType]").val()=='709' || $("select[name=visaType]").val()=='710'){
				$("select[name=city]").removeAttr("required");
				$("td[name='city*']>i").text("");
			}else{
				$("select[name=city]").attr("required",true);
				$("td[name='city*']>i").text("*");
			}
		}
		
		$("#saveVisaDoc").bind('click',function(){
		
			if(!$("#dataForm").validate().form()){
						return false;
			 }
		 	
		 	var msg = '确认保存吗 ？';	
		    if(refreshSensitiveWord($("input[type='text'],textarea"))){
			     $("input[name=senisitiveFlag]").val("Y");
			 	 msg = '内容含有敏感词,是否继续?';
			}else {
			$("input[name=senisitiveFlag]").val("N");
			}
		 	$.confirm(msg,function(){
		 		$.ajax({
				url : "/vst_back/visa/visaDoc/updateBizVisaDoc.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					if(result.code == "success"){
						$.alert(result.message,function(){
							$("#searchForm").submit();
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