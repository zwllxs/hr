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
                       			<td>保存后系统自动生成</td>
			                    <input type="hidden" name="bizBranch.branchId" value=${bizBranch.branchId!''} class="w35">
			                </tr>
			                <tr>
			                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>签证规格名称：</td>
			                    <td><label><input type="text" name="branchName" id="branchName" required=true class="w35">"案例，大床房 "</label></td>
			                </tr>    
			                <tr>
 								<td width="150" class="e_label td_top"><i class="cc1">*</i>状态：</td>
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
			                <tr>
			                 	<td width="150" class="e_label td_top"><i class="cc1">*</i>关联材料：</td>
			                    <td><input type="hidden" id="docId" name="docId" class="w35">
			                    	<a class="btn btn_cc1" id="choice_material">选择（修改）材料</a>
			                    	</br>已选材料：
			                    	<table width="70%" border="1" cellpadding="1" cellspacing="0">
				                        <thead>
								        	<tr>
								            	<th>签证材料ID</th>
								                <th>签证材料名称</th>
								            	<th>签证国家/地区</th>
								                <th>签证类型</th>	                    
								                <th>送签城市</th>
								            </tr>
								        </thead>
								         <tbody id="visaDoc"> 
				                        </tbody>
				            		</table>
				                    
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

	$("#save").bind("click",function(){
			if($("#docId").val()==""){
				$.alert("请选择关联材料！");
				return;
			}
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
				    maxVisitor: {
				      required: true,
				      number:true,
				      min:0
				    }
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
				$.ajax({
				url : "/vst_back/visa/prodbranch/addProductBranch.do",
				type : "post",
				dataType:"json",
				async: false,
				data : $("#dataForm").serialize(),
				success : function(result) {
					 loading.close();
				     if(result.code=="success"){
							$.alert(result.message,function(){
									$("#save").removeAttr("disabled");
					   				addDialog.close();
					   				window.location.reload();
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
		
	//选择目的地
function onSelectDoc(params){
	if(params!=null){
		$("#docId").val(params.docId);
		$("select[visa_type='visa_type']").find("option[value="+params.docVisaType+"]").attr("selected",true);
		$("#visaDoc").html("");
		$("#visaDoc").html("<tr><td>"+params.docId+"</td><td>"+params.docName+"</td><td>"+params.docCountry+"</td><td>"+params.docVisaTypeName+"</td><td>"+params.docCity+"</td></tr>");
	}
	docSelectDialog.close();
}

//打开选择行政区窗口
$("#choice_material").click(function(){
	var url = "/vst_back/visa/visaDoc/selectBizVisaDocList.do";
	docSelectDialog = new xDialog(url,{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
});
	
</script>