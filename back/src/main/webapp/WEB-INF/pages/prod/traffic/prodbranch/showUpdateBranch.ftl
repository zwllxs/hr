<#include "/base/findProductBranchInputType.ftl"/>
<form method="post" id="dataForm">
<input type ="hidden" name="productId" value ="${productBranch.productId!''}">
<input type="hidden" name="productBranchId" value="${productBranch.productBranchId!''}">
<input type="hidden" name="senisitiveFlag" value="N">
<div class="dialog-content clearfix" data-content="content">
            <div class="p_box box_info p_line">
                <div class="box_content ">
                    <table class="e_table form-inline ">
                        <tbody>
                            <tr>
			                	 <td width="150" class="e_label td_top">规格名：</td>
			                     <td>${productBranch.bizBranch.branchName!''}<input type="hidden" name="brName" value="${productBranch.bizBranch.branchName!''}" class="w35"></td>
			                </tr>
			                <tr>
			                     <td width="150" class="e_label td_top">产品规格ID：</td>
			                     <td>${productBranch.productBranchId!''}<input type="hidden" name="branchId" value="${productBranch.bizBranch.branchId!''}" class="w35"></td>
			                </tr>
			                <tr>
			                    <td width="150" class="e_label td_top"><i class="cc1">*</i>名称：</td>
			                     <td><label><input type="text" name="branchName" id="branchName" value="${productBranch.branchName!''}" required=true class="w35"></label></td>
			                 </tr>
			                 <tr>
				                 <td width="150" class="e_label td_top"><i class="cc1">*</i>是否有效：</td>
				                    <td>
				                    <select name="cancelFlag" id="cancelFlag">
			                   			 <option value='Y' <#if productBranch.cancelFlag == 'Y'>selected</#if> >有效</option>
			                   			 <option value='N' <#if productBranch.cancelFlag == 'N'>selected</#if> >无效</option>
	                   		        </select>
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
						<#list branchPropList as branchProp>						
						
	                		<#assign productBranchId='' />
	                		<#assign productBranchPropId='' />
	                		<#assign propValue='' />
	                		<#if branchProp?? && branchProp.prodProductBranchProp!=null >
	                			<#assign productBranchPropId=branchProp.prodProductBranchProp.productBranchPropId />
		                		<#assign productBranchId=branchProp.prodProductBranchProp.productBranchId />
		                		<#if branchProp.prodProductBranchProp.prodValue !=null >
					     			<#assign propValue=branchProp.prodProductBranchProp.prodValue />
					    		</#if>
	                		</#if>
	                		
				                <td width="150" class="e_label td_top">
					                <#if branchProp.nullFlag == 'Y'><i class="cc1">*</i></#if>${branchProp.propName!''}
					                <#if branchProp.cancelFlag =='N'><span class="valid">[无效]</span></#if>：
				                </td>
			                	<td><span class="">
			                		<input type="hidden" name="productBranchPropList[${index}].productBranchId" value="${productBranchId}" />
			                		<input type="hidden" name="productBranchPropList[${index}].propId" value="${branchProp.propId}" />
			                		<input type="hidden" name="productBranchPropList[${index}].productBranchPropId" value="${productBranchPropId}" />
			                		
			                		<!-- 开始通用组件 -->
			                		<@displayHtml productBranchId index branchProp />
			                		
			                		<#if branchProp.propDesc !=null><span style="color:grey">说明：${branchProp.propDesc!''}</span></#if>
			                		<div id="ele${index}Error" style="display:inline"></div>
			                	</span></td>
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
		setSelectAddValue("Y");
	
	});

  $("#save").bind("click",function(){
		
			$(".ckeditor").each(function(){
				var that = $(this);
				$.each(CKEDITOR.instances, function(i, n){
					if(that.attr('name')==n.name){
						that.text(n.getData());
						if(that.attr("data")=="YY"){
							that.attr("required",true);
							that.show();
						}
		    		}
				});
			});
			
			//验证
			if(!$("#dataForm").validate({
				rules: {
				    maxVisitor: {
				      required: true,
				      number:true,
				      min:0
				    }
				  }
			}).form()){
				return;
			}
			
			 var msg = '确认修改吗 ？';	
			 if(refreshSensitiveWord($("input[type='text'],textarea"))){
			 	 $("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?';
			 }else {
			$("input[name=senisitiveFlag]").val("N");
			}
			
			$.confirm(msg, function () {
			
			//刷新产品规格
			refreshAddValue();
			//遮罩层
    		var loading = top.pandora.loading("正在努力保存中...");	
			
			$.ajax({
			url : "/vst_back/prod/prodbranch/updateProductBranch.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
				loading.close();
			   if(result.code=="success"){
						$.alert(result.message,function(){
				   				updateDialog.close();
				   				window.location.reload();
		   			});
					}else {
						$.alert(result.message);
			   		}
			   }
			});
			});						
		});
		$(function(){
			$("select #cancelFlag").val("${productBranch.cancelFlag!''}");
			$("select #recommendLevel").val("${productBranch.recommendLevel!''}");
		});
		
		
	
$(function(){

      $(".INPUT_TYPE_DDMM").each(function(){

              if($(this).find('.hourMinute').val() != null) {
		        $(this).find("select[name='hour']").val($(this).find('.hourMinute').val().split(':')[0]);
			    $(this).find("select[name='minute']").val($(this).find('.hourMinute').val().split(':')[1]);
		       }
		       
               var obj = $(this);
		 	   $(this).find('.dd').bind("change",function(){
			       obj.find('.hourMinute').val(obj.find("select[name='hour']").val() +":"+obj.find("select[name='minute']").val());
		       }); 
		      
       });
});	

refreshSensitiveWord($("input[type='text'],textarea"));
</script>
