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
<form action="/vst_back/combTicket/prod/product/addProduct.do" method="post" id="dataForm">
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
	                    <td><label><input type="text" class="w35" maxlength="50" style="width:700px" name="productName" id="productName" required>&nbsp;请勿输入下列字符    <> % # * & ^ @ ! ~ / \ '||"</label>
	                   <div id="productNameError"></div>
	                   <span style="color:grey">请输入组合套餐的名称，当自主打包套餐时，请完整输入名称，如上海欢乐谷+东方明珠 情侣票。</span>
	                    </td>
	                    
	                </tr>
	               <#----> 	<tr>
						<td class="e_label"><i class="cc1">*</i>状态：</td>
						<td>
							<select name="cancelFlag" required>
								<option value="N">无效</option>
		                    	<option value="Y">有效</option>
		                    </select>
	                   	</td>
	                </tr></#---->
	                <tr>
						<td class="e_label"><i class="cc1">*</i>推荐级别：</td>
						<td>
							<label><select name="recommendLevel" required>
		                    	<option value="5">5</option>
		                    	<option value="4">4</option>
		                    	<option value="3">3</option>
		                    	<option value="2" selected="selected">2</option>
		                    	<option value="1">1</option>
		                    </select>说明：由高到低排列，即数字越高推荐级别越高</label>
	                    </td>
	                </tr>
					<tr name='no1'>
				   		<td name="addspan" rowspan=1 class="e_label"><i class="cc1">*</i>目的地：</td>
			            <td>
			            	<input type="text" errorEle="descRecode" name="dest" id="dest0" readonly="readonly" required>
			            	<input type="hidden" name="prodDestReList[0].destId" id="destId0"><label id="mainFlag">主目的地</label>
			            	<input type="hidden" name="prodDestReList[0].mainFlag" value="Y">
			            	<a class="btn btn_cc1" id="new_button">添加目的地</a><span style='color:grey'>目的地必须添加，有且只有一个作为主目的地。</span>
			            	<div id="descRecodeError" style="display:inline"></div>
			            </td>
	        	    </tr>
	                <tr>
						<td class="e_label"><i class="cc1">*</i>组合套餐类型：</td>
						<td>
							<label><select name="packageType" id="packageType" required>
                    	 			<option value="">请选择</option>
				    				<#list packageTypeList as list>
				                    	<option value=${list.code!''}>${list.cnName!''}</option>
					                </#list>
			        		</select></label>
	                    </td>
	                </tr>
                	</tbody>
                </table>
		           <table class="e_table form-inline">
	                <tr>
						<td width="1000px;">
							<div id="showDistributorProd" >
								<#include "/prod/combTicket/product/showDistributorProd.ftl"/>
							<div>					
						</td>
						<td>
	                    </td>
	                </tr>	            
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
</form>
</div>
<div class="fl operate" style="margin:20px;"><a class="btn btn_cc1" id="save">保存</a><a class="btn btn_cc1" id="saveAndNext">保存并维护下一步</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

	// 根据组合套餐类型显示或隐藏销售渠道
	showDistributorProd();
	
	jQuery.validator.addMethod("isChar1", function(value, element) {
	   var pattern = new RegExp("[<>/?\"%#\\\\&*@!~'|^]");
	    return this.optional(element) || (!pattern.test(value));       
	 }, "不可输入特殊字符");	

var dictSelectDialog;//标准产品中动态加载中Input_type_select的对话框
var busiSelectIndex;//酒店业务字典

	var districtSelectDialog,contactAddDialog,coordinateSelectDialog;
	 
	$("#save").click(function(){
		$(this).attr("disabled","disabled");
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
					isChar1:true
				},
				distributorIds:{
					required:true
				}
			},
			messages : {
			}
		}).form()){
			$(this).removeAttr("disabled");
			return false;
		}
		
		//刷新AddValue的值		
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
				url : "/vst_back/combTicket/prod/product/addProduct.do",
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
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",mask:true,ok:function(){
							var packageType = $('#packageType').val();// 组合套餐类型
							parent.setCombTicketMenu(packageType);						
							parent.checkAndJump();
						}});
						
					}else {
						$.alert(result.message);
					}
					$("#save").removeAttr("disabled");
				},
				error : function(){
					$("#save").removeAttr("disabled");
					loading.close();
				}
			});
		});
		
	});
	 
	$("#saveAndNext").click(function(){
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
					isChar1 : true
				},
				distributorIds:{
					required:true
				}
			},
			messages : {
			}
		}).form()){
				return false;
			}
		
		
		//刷新AddValue的值		
		refreshAddValue();
		
		 var msg = '确认保存吗 ？';	
		 if(refreshSensitiveWord($("input[type='text'],textarea"))){
		 	 $("input[name=senisitiveFlag]").val("Y");
		 	msg = '内容含有敏感词,是否继续?'
		 }
		
		$.confirm(msg,function(){
			var loading = top.pandora.loading("正在努力保存中...");
		
    	//遮罩层
		$.ajax({
				url : "/vst_back/combTicket/prod/product/addProduct.do",
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
						pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",mask:true,ok:function(){
							var categoryId = $("#categoryId").val();
							var productId = result.attributes.productId;
							var packageType = $('#packageType').val();// 组合套餐类型
							parent.setCombTicketMenu(packageType);	
							// 驴妈妈
							if('LVMAMA'==packageType){
								$(".J_list",window.parent.document).find("li").eq(2).click();
							}else{
								// 供应商
								$(".J_list",window.parent.document).find("li").eq(1).click();
							}	
						}});
						$(".pg_title", parent.document).html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("input[name='productName']").val()+"   "+"品类:"+$("#categoryName").val()+"   "+"产品ID："+$("input[name='productId']").val());
					}else {
						$.alert(result.message);
					}
				},
				error : function(){
					loading.close();
				}
			});
		
		});
		
			
	});
		
	$('#packageType').bind('click',function(){
		showDistributorProd();
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
					
	var dests = [];//子页面选择项对象数组
	var count =0;
	var markDest;
	var markDestId;
	
	//设主目的地
	$("a[name=main_button]").live("click",function(){
		if($(this).parents("td").find("input:first").val()==""){
			$.alert("请先选择目的地");
		}else{
			$("#mainFlag~input").val('N');
			$("#mainFlag").replaceWith("<a class='btn btn_cc1' name='main_button'>设主目的地</a><a class='btn btn_cc1' name='del_button'>删除</a>");
			$(this).next().next().val('Y');
			$(this).next().remove();
			$(this).replaceWith("<label id='mainFlag'>主目的地</label>");
		}
	})
	
	//删除目的地
	$("a[name=del_button]").live("click",function(){
		if($(this).parents("tr").attr("name")=="no1"){
			var $td = $(this).parents("tr").children("td:first");
			$(this).parents("tr").next().prepend($td);
			$(this).parents("tr").next().attr("name","no1");
			$(this).parents("tr").next().children("td:last").append("<a class='btn btn_cc1' id='new_button'>添加目的地</a><span style='color:grey'>有且只能选择一个目的地，目的地不允许重复。</span>")
		}
		
		$(this).parents("tr").remove();
		var rows = $("input[name=dest]").size();
		$("td[name=addspan]").attr("rowspan",rows);
	});
	
	//新建目的地
	$("#new_button").live("click",function(){
		count++;
		var rows = $("input[name=dest]").size();
		$("td[name=addspan]").attr("rowspan",rows+1);
		var $tbody = $(this).parents("tbody");
		$tbody.children("tr:last").before("<tr><td><input type='text' name='dest' id='dest"+count+"' readonly = 'readonly' required><input type='hidden' name='prodDestReList["+count+"].destId' id='destId"+count+"'/>&nbsp;<a class='btn btn_cc1' name='main_button'>设主目的地</a><a class='btn btn_cc1' name='del_button'>删除</a><input type='hidden' name='prodDestReList["+count+"].mainFlag' value='N'></td></tr>"); 
	});

	//选择目的地
	function onSelectDest(params){
   		var flag = true;
		if(params!=null){
			$("input[name=dest]").each(function(){
				if($(this).next().val() == params.destId){
				 	flag = false;
				}
			}); 
			
			if(flag){
				$("#"+markDest).val(params.destName);
				$("#"+markDestId).val(params.destId);
			}else{
				$.alert("同一产品下目的地不能重复！");
			}
		}
		destSelectDialog.close();
	}
	
	//打开选择行政区窗口
	$("input[name=dest]").live("click",function(){
		$(this).parents("td").find("div").remove();
		markDest = $(this).attr("id");
		markDestId = $(this).next().attr("id");
		var url = "/vst_back/biz/dest/selectDestList.do?type=main";
		destSelectDialog = new xDialog(url,{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
	});
	
	function showDistributorProd(){
		var packageType = $('#packageType').val();// 组合套餐类型
		if(packageType=='LVMAMA'){
			$('#showDistributorProd').attr('style','display:inline');
		}else{
			$('#showDistributorProd').attr('style','display:none');
		}
	}
</script>