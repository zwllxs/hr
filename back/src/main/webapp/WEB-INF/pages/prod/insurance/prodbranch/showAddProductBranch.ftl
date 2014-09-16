<#include "/base/findProductBranchInputType.ftl"/>
<form method="post" id="dataForm">
<input name="productId" type="hidden" value ="${productId!''}">
<input type="hidden" name="senisitiveFlag" value="N">
<div class="dialog-content clearfix" data-content="content">
            <div class="p_box box_info p_line">
                <div class="box_content ">
                    <table class="e_table form-inline ">
                        <tbody>
                       		<tr>
			                	<td width="150" class="e_label td_top">规格名：</td>
			                    <td>${bizBranch.branchName!''}<input type="hidden" name="brName" value=${bizBranch.branchName!''} class="w35"></td>
			                </tr>
                       		<tr>
                       			<td width="150" class="e_label td_top">产品规格ID：</td>
			                    <td><input type="hidden" name="bizBranch.branchId" value=${bizBranch.branchId!''} class="w35"></td>
			                </tr>
			                <tr>
			                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>名称：</td>
			                    <td><label><input type="text" name="branchName" id="branchName" required=true maxLength=50 class="w35">"案例，经济型 "</label>
			                    <div id="branchNameError"></div>
			                    </td>
			                </tr>    
			                <tr>
 								<td width="150" class="e_label td_top"><i class="cc1">*</i>是否有效：</td>
 								<td>
									<select name="cancelFlag" required=true>
						                 <option value="N">无效 </option>
				                    	 <option value="Y" selected="selected">有效 </option>
				                   	</select>				                    	
				                </td>					                   			                
			                </tr>
			                <tr>
			                    <td width="150" class="e_label td_top" ><i class="cc1">*</i>推荐级别：</td>
			                    <td>
			                    <label>
				                    <select name="recommendLevel" required=true>
				 						<option value ="5" selected="selected">5</option>
				  						<option value ="4">4</option>
				  						<option value ="3">3</option>
				  						<option value ="2">2</option>
				  						<option value ="1">1</option>
									</select>
									由高到低排列，即数字越高推荐级别越高
									<label>
			                    </td>
			                </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="p_box box_info">
                <div class="box_content ">
                    <table class="e_table form-inline ">
                       <tbody>
			            <#assign index=0 />
			            <#assign productBranchId='' />
						<#list branchPropList as branchProp>
			                <tr>
				                <td width="150" class="e_label td_top">${branchProp.propName!''}<#if branchProp.nullFlag == 'Y'><i class="cc1">*</i></#if>：</td>
			                	<td><span class="">
			                	
                					<@displayHtml productBranchId index branchProp />
			                				               			
			                		<#if branchProp.propDesc !=null><span style="color:grey">说明：${branchProp.propDesc!''}</span></#if>
			                		<input type="hidden" name="productBranchPropList[${index}].propCode" value="${branchProp.propCode}">
			                		<input type="hidden" name="productBranchPropList[${index}].propId" value="${branchProp.propId}">
			                		<div id="ele${index}Error" style="display:inline"></div>
			                		</span>
			                	</td>
				               </tr>
				               <#assign index=index+1 />
							</#list> 
			            </tbody>
                    </table>
                </div>
            </div>
        </div>
</form>

<div class="p_box box_info clearfix mb20">
	<div class="fl operate"><a class="btn btn_cc1" id="save">保存</a></div>
</div>

<script>
$(document).ready(function(){
	//为checkbox 设置addValue
	 setCheckBoxAddValue();
	
	//为radio 设置addValue
	setRadioAddValue();
	
	//为select 设置addValue
	setSelectAddValue();
});

//JQuery 自定义验证
jQuery.validator.addMethod("isCharCheck", function(value, element) {
    var chars =  /^([\u4e00-\u9fa5]|[a-zA-Z0-9\+])+$/;//验证特殊字符  
    return this.optional(element) || (chars.test(value));       
 }, "不可为空或者特殊字符");
 
$("#save").bind("click",function(){
	$("#save").attr("disabled","disabled");
	$(".ckeditor").each(function(){
		var that = $(this);
		$.each(CKEDITOR.instances, function(i, n){
				if(that.attr('name')==n.name){
	    			if(n.getData()==""){
						that.text(that.attr('placeholder'));
					}else{
						that.text(n.getData());
					}
					if(that.attr("data")=="Y"){
						that.attr("required",true);
						that.show();
					}
	    		}
		});
	});

	//验证
	if(!$("#dataForm").validate({
		rules : {
			productName : {
				isCharCheck : true
			}
				},
		messages : {
			productName : '不可为空或者特殊字符'
		}
	}).form()){
		$("#save").removeAttr("disabled");
		return;
	}
	
	//刷新产品规格
	refreshAddValue();
	
	var msg = '确认保存吗 ？';	
	    if(refreshSensitiveWord($("input[type='text'],textarea"))){
	     $("input[name=senisitiveFlag]").val("Y");
	 	 msg = '内容含有敏感词,是否继续?';
	}else {
			$("input[name=senisitiveFlag]").val("N");
	}
	$.confirm(msg,function(){
		//遮罩层
		var loading = top.pandora.loading("正在努力保存中...");	
		$("#save").attr("disabled","disabled");
		$.ajax({
			url : "/vst_back/insurance/prod/prodbranch/addProductBranch.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			     if(result.code=="success"){
			     	loading.close();
			     	$("#save").hide();
			     	pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定", mask:true,ok:function(){
					 	$("#save").show();
					 	$("#save").removeAttr("disabled");
		   				addDialog.close();
		   				window.location.reload();
					}});
				 }else {
					$.alert(result.message);
		   		 }
		   },
			error : function(){
				$("#save").removeAttr("disabled");
			}
		});				
		
	});
			
});
</script>