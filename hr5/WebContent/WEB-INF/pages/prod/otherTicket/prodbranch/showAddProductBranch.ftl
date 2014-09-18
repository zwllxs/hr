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
			                    <td><input type="hidden" name="bizBranch.branchId" value=${bizBranch.branchId!''} class="w35">保存后系统自动生成</td>
			                </tr>
			                <tr>
			                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>产品规格名称：</td>
			                    <td><label><input type="text" name="branchName" id="branchName" required=true maxlength="50" class="w35"></label><span style="color:grey">填写项目的名称。</span></td>
			                </tr>    
			               <tr>
 								<td width="150" class="e_label td_top"><i class="cc1">*</i>是否有效：</td>
 								<td>
									<select name="cancelFlag">
						                 <option value="N">无效 </option>
				                    	 <option value="Y">有效 </option>
				                   	</select>				                    	
				                </td>					                   			                
			                </tr>
			                 <tr>
			                    <td width="150" class="e_label td_top"><i class="cc1">*</i>推荐级别：</td>
			                    <td>
			                    <label>
				                    <select name="recommendLevel">
				 						<option value ="5">5</option>
				  						<option value ="4">4</option>
				  						<option value ="3">3</option>
				  						<option value ="2" selected="selected">2</option>
				  						<option value ="1">1</option>
									</select>
									由高到低排列，即数字越高推荐级别越高
									<label>
			                    </td>
			                </tr>
			              <#--  <tr>
			                    <td width="150" class="e_label td_top"><i class="cc1">*</i>最大入住人数：</td>
			                    <td>
			                    	<select name="maxVisitor" id="maxVisitor">
			                    		<#list 1..100 as i>
		                     				 <option value="${i}">${i}</option>
                       					 </#list>
			                    	</select>
			                    </td>
			                </tr>-->
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
//JQuery 自定义验证
jQuery.validator.addMethod("isChar", function(value, element) {
    var chars =  /^[^\\\*\&\#\$\%\@\\^\!\~\+>\<\|\'\"\/]+$/;//验证特殊字符  
    return this.optional(element) || (chars.test(value));       
 }, "不可输入特殊字符");
 
	$(document).ready(function(){
		//检查窗户，阳台，景观的关联
		$("input[type=radio][value=640],input[type=radio][value=641],input[type=radio][value=642],input[type=radio][value=650],input[type=radio][value=651]").bind("click",function(){
			changeLandscape();
		});
		
		function changeLandscape(){
			if($("input[type=radio][value=642]:checked").size()>0||$("input[type=radio][value=651]:checked").size()>0){
				$("input[type=radio][value=655],input[type=radio][value=656],input[type=radio][value=657]").removeAttr("checked").attr("disabled","disabled");
			}else {
				$("input[type=radio][value=655],input[type=radio][value=656],input[type=radio][value=657]").removeAttr("disabled");
			}
		}
	
		//为checkbox 设置addValue
		 setCheckBoxAddValue();
		
		//为radio 设置addValue
		setRadioAddValue();
		
		//为select 设置addValue
		setSelectAddValue();
	
	});

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
				rules: {
					productName : {
						isChar : true
					}
						},
					messages : {
						productName : '不可输入特殊字符'
						
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
		 	msg = '内容含有敏感词,是否继续?'
		 }else {
			$("input[name=senisitiveFlag]").val("N");
	}
		  $.confirm(msg,function(){
		  	//遮罩层
    		var loading = top.pandora.loading("正在努力保存中...");	
			$.ajax({
			url : "/vst_back/otherTicket/prod/prodbranch/addProductBranch.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
				 loading.close();
			     if(result.code=="success"){
						$.alert(result.message,function(){
								$("#save").removeAttr("disabled");
								location.href="/vst_back/otherTicket/prod/prodbranch/findProductBranchList.do?productId=${productId!''}&categoryId=${categoryId!''}";
				   				addDialog.close();
		   				});
				 }else {
					$.alert(result.message);
		   		 }
		   },
			error : function(){
				$("#save").removeAttr("disabled");
			}
			}
			);			
		  	
		  });
						
		});
	
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>