<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/findProductInputType.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${bizCategory.categoryName}</a> &gt;</li>
            <li><a href="#">产品维护</a> &gt;</li>
            <li class="active">添加产品</li>
        </ul>
</div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
<form action="/vst_back/insurance/prod/product/addProduct.do" method="post" id="dataForm">
		<input type="hidden" name="productId" value="${productId!''}">
		<input type="hidden" name="senisitiveFlag" value="N">
		<div class="p_box box_info p_line">
            <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
	                <tr>
	                	<td class="e_label" width="150"><i class="cc1">*</i>所属品类：</td>
	                	<td>
	                		<input type="hidden" id="categoryId" name="bizCategoryId" value="${bizCategory.categoryId}" required>
	                		<input type="hidden" id="categoryName" name="bizCategory.categoryName" value="${bizCategory.categoryName}" >
	                		${bizCategory.categoryName}
	                	</td>
	                </tr>
					<tr>
	                	<td class="e_label"><i class="cc1">*</i>产品名称：</td>
	                    <td><label><input type="text" class="w35" style="width:700px" name="productName" id="productName" maxLength=50 required>&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
	                   <div id="productNameError"></div>
	                    </td>
	                    
	                </tr>
	               	<tr>
						<td class="e_label"><i class="cc1">*</i>状态：</td>
						<td>
							<select name="cancelFlag" required>
								<option value="N">无效</option>
		                    	<option value="Y" selected="selected">有效</option>
		                    </select>
	                   	</td>
	                </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>推荐级别：</td>
						<td>
							<label><select name="recommendLevel" required>
		                    	<option value="5" selected="selected">5</option>
		                    	<option value="4">4</option>
		                    	<option value="3">3</option>
		                    	<option value="2">2</option>
		                    	<option value="1">1</option>
		                    </select>说明：由高到低排列，即数字越高推荐级别越高</label>
	                    </td>
	                </tr>
                	</tbody>
                </table>
            </div>
        </div>

		<div class="p_box box_info">
 			<#assign index=0 />
 			<#assign productId="" />
		    <#list bizCatePropGroupList as bizCatePropGroup>
            <#if bizCatePropGroup.bizCategoryPropList?? && (bizCatePropGroup.bizCategoryPropList?size gt 0)>
            <div class="title">
			    <h2 class="f16">${bizCatePropGroup.groupName!''}：</h2>
		    </div>
            <div class="box_content">
            <table class="e_table form-inline">
                <tbody>
                	<#list bizCatePropGroup.bizCategoryPropList as bizCategoryProp>
	                	<tr>
		                <td width="150" class="e_label td_top"><#if bizCategoryProp.nullFlag == 'Y'><i class="cc1">*</i></#if>${bizCategoryProp.propName!''}：</td>
	                	<td><span class="${bizCategoryProp.inputType!''}" >
	                	
	                		<input type="hidden" name="prodProductPropList[${index}].propId" value="${bizCategoryProp.propId!''}" />
	                		
	                		<!-- 調用通用組件 -->
	                		<@displayHtml productId index bizCategoryProp />
	                		
	                		<div id="errorEle${index}Error" style="display:inline"></div>
	                		<span style="color:grey">${bizCategoryProp.propDesc!''}</span>
	                	</span></td>
		               </tr>
		               <#assign index=index+1 />
                	</#list>
               	</tbody>
                </table>
            </div>
        </div>
        </#if>
		</#list> 
		
		<div class="p_box box_info p_line">
		 	  <div class="title">
			   <h2 class="f16">关联</h2>
			  </div>
			  <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
		                <tr name='no1'>
					   	   <td name="addspan" width="150" class="e_label"><i class="cc1">*</i>目的地：</td>
				           <td>
		                    	<input type="text" class="w35" id="dest_0" name="dest" readonly = "readonly" required>
		                    	<input type="hidden" name="prodDestReList[0].destId" id="destId0" /><a class="btn btn_cc1" id="new_button">添加</a>
		                    	<div id="addDestError"></div>
		                    	</br>
		                    	<div id="destDiv"></div>
		                    </td>
		        	    </tr>
                	</tbody>
                </table>
            </div>
		</div>
         
</form>
</div>
<div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var dictSelectDialog;//标准产品中动态加载中Input_type_select的对话框
var busiSelectIndex;//酒店业务字典

var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
//目的地窗口
var destSelectDialog;
var loading;

//JQuery 自定义验证
jQuery.validator.addMethod("isCharCheck", function(value, element) {
    var chars =  /^([\u4e00-\u9fa5]|[a-zA-Z0-9]|[\+-]|[\u0020])+$/;//验证特殊字符  
    return this.optional(element) || (chars.test(value));       
 }, "不可为空或者特殊字符");
 
$(".INPUT_TYPE_NUMBER").append("<label>天</label>");
var insureDayInput = $(".INPUT_TYPE_NUMBER").find("input:eq(1)");
 
$("#save").click(function(){
 
	if(!(insureDayInput.val() > 0 && insureDayInput.val() < 366)){
		alert("被保天数必须为1-365间的正数 " );
		return false;
	}
	
	var plusChars =  /^([1-9]|[0-9])+$/;
    if(!plusChars.test(insureDayInput.val())){
     	alert("被保天数必须是正数");
     	return false;
    }
	
	$("#save").attr("disabled","disabled");
	$("#saveAndNext").attr("disabled","disabled");
	
	$.each( $("input[autoValue='true']"), function(i, n){
		if($(n).val()==""){
			$(n).val($(n).attr('placeholder'));
		}
	}); 
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
	$("textarea").not(".ckeditor").each(function(){
		if($(this).text()==""){
			$(this).text($(this).attr('placeholder'));
		}
	});
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
		$("#saveAndNext").removeAttr("disabled");
		return false;
	}
	
	//刷新AddValue的值		
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
	loading = top.pandora.loading("正在努力保存中...");	
	$.ajax({
		url : "/vst_back/insurance/prod/product/addProduct.do",
		type : "post",
		dataType : 'json',
		data : $("#dataForm").serialize(),
		success : function(result) {
			if(result.code == "success"){
				loading.close();
				//为子窗口设置productId
				$("input[name='productId']").val(result.attributes.productId);
				//为父窗口设置productId
				$("#productId",window.parent.document).val(result.attributes.productId);
				$("#productName",window.parent.document).val(result.attributes.productName);
				$("#categoryName",window.parent.document).val(result.attributes.categoryName);
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",mask:true,ok:function(){
					$("#save").removeAttr("disabled");
					$("#saveAndNext").removeAttr("disabled");
					parent.checkAndJump();
				}});
			}else {
				$.alert(result.message);
				loading.close();
				$("#save").removeAttr("disabled");
				$("#saveAndNext").removeAttr("disabled");
			}
		},
		error : function(){
			loading.close();
			$("#save").removeAttr("disabled");
			$("#saveAndNext").removeAttr("disabled");
		}
	  });
	});
});
 
$("#saveAndNext").click(function(){
	if(!(insureDayInput.val() > 0 && insureDayInput.val() < 366)){
		alert("被保天数必须为1-365间的正数 " );
		return false;
	}
	
	$("#save").attr("disabled","disabled");
	$("#saveAndNext").attr("disabled","disabled");
					
	$.each( $("input[autoValue='true']"), function(i, n){
		if($(n).val()==""){
			$(n).val($(n).attr('placeholder'));
		}
	}); 
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
	$("textarea").not(".ckeditor").each(function(){
		if($(this).text()==""){
			$(this).text($(this).attr('placeholder'));
		}
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
		$("#saveAndNext").removeAttr("disabled");
		return;
	}
	
	//刷新AddValue的值		
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
	loading = top.pandora.loading("正在努力保存中...");	
	$.ajax({
			url : "/vst_back/insurance/prod/product/addProduct.do",
			type : "post",
			dataType : 'json',
			data : $("#dataForm").serialize(),
			success : function(result) {
				loading.close();
				if(result.code == "success"){
					//为子窗口设置productId
					$("input[name='productId']").val(result.attributes.productId);
					//为父窗口设置productId
					$("#productId",window.parent.document).val(result.attributes.productId);
					$("#productName",window.parent.document).val(result.attributes.productName);
					$("#categoryName",window.parent.document).val(result.attributes.categoryName);		
					pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
						$("#save").removeAttr("disabled");
						$("#saveAndNext").removeAttr("disabled");
						var categoryId = $("#categoryId").val();
						var productId = result.attributes.productId;
						window.location = "/vst_back/prod/prodbranch/findProductBranchList.do?productId="+productId+"&categoryId="+categoryId;
					}});
					$(".pg_title", parent.document).html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("input[name='productName']").val()+"   "+"品类:"+$("input[name='categoryName']").val()+"   "+"产品ID："+$("input[name='productId']").val());
				}else {
					loading.close();
					$.alert(result.message);
					$("#save").removeAttr("disabled");
					$("#saveAndNext").removeAttr("disabled");
				}
			},
			error : function(){
				loading.close();
				$("#save").removeAttr("disabled");
				$("#saveAndNext").removeAttr("disabled");
			}
		});
	
	});
});
	
function showAddFlagSelect(params,index){
	if($(params).find("option:selected").attr('addFlag') == 'Y'){
		var StrName = document.getElementsByName("prodProductPropList["+index+"].addValue")
		if($(StrName).size()==0){
			$(params).after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
		}
	}else{
		$(params).next().remove();
	}
}

var dests = '';//子页面选择项对象数组
var count =0;
var markDest;
var markDestId;

//选择目的地
function onSelectDest(params){
	if(params!=null){
		var destId = params.destId;
		dests = "";
		for(var i = 0; i < 20; i++){
			if($("#destId"+i) != null){
				if($("#destId"+i).val() != null){
					 dests = dests + ',' + $("#destId"+i).val();
				}
			}
		}
		if(dests.indexOf(destId)==0 || dests.indexOf(destId)> 0 )
		{
		    alert('目的地已经存在');
		    return;
		}else{
			dests = dests + ',' + destId;
		}
		$("#"+markDest).val(params.destName);
		$("#"+markDestId).val(destId);
	}
	destSelectDialog.close();
}

//新建目的地
$("#new_button").live("click",function(){
	count++;
	var rows = $("input[name=dest]").size();
	$("td[name=addspan]").attr("rowspan",rows+1);
	var $tbody = $(this).parents("tbody");
	$tbody.append("<tr><td><input type='text' class='w35' name='dest' id='dest_"+count+"' readonly = 'readonly' required='true'/><input type='hidden' name='prodDestReList["+count+"].destId' id='destId"+count+"'/>&nbsp;<a class='btn btn_cc1' name='del_button'>删除</a></td></tr>"); 
});

//删除目的地
$("a[name=del_button]").live("click",function(){
	if($(this).parents("tr").attr("name")=="no1"){
		var $td = $(this).parents("tr").children("td:first");
		$(this).parents("tr").next().prepend($td);
		$(this).parents("tr").next().attr("name","no1");
		$(this).parents("tr").next().children("td:last").append("<a class='btn btn_cc1' id='new_button'>添加目的地</a>")
	}
	$(this).parents("tr").remove();
	var rows = $("input[name=dest]").size();
	$("td[name=addspan]").attr("rowspan",rows);
});

//打开选择行政区窗口
$("input[name=dest]").live("click",function(){
	markDest = $(this).attr("id");
	var idValue=markDest.split('_')[1];
	markDestId = 'destId'+idValue;
	//markDestId = $(this).next().attr("id");
	var url = "/vst_back/biz/dest/selectDestList.do?type=main";
	destSelectDialog = new xDialog(url,{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
});	

</script>