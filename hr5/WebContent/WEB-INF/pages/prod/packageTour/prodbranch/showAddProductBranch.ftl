<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_search" style="width:920px;">
	<#include "/prod/packageTour/prodbranch/findProdBranchInputType.ftl"/>
	
	<#if bizBranch.branchName == '可换-酒店'>
		<#assign branchName = '房型'/>
	<#else>
		<#assign branchName = bizBranch.branchName/>
	</#if>

	<form method="post" id="showAddProdBranchDataForm">
		<input name="productId" type="hidden" value ="${productId!''}">
		<input name="branchId" type="hidden" value ="${branchId!''}">
		<input name="mainProdBranchId" type="hidden" value ="${mainProdBranchId!''}">
		<input type="hidden" name="senisitiveFlag" value="N">
		<div class="dialog-content clearfix" data-content="content" style="width:920px;">
	        <div class="p_box box_info p_line" style="width:920px;">
	            <div class="box_content " style="width:920px;">
	                <table class="e_table form-inline " style="width:920px;"> 
	                    <tbody>
	                   		<tr>
	                   			<td width="100" class="e_label td_top">产品规格ID：</td>
			                    <td><input type="hidden" name="productBranchId" id="productBranchId" value="${productBranch.productBranchId!''}" class="w35">
			                    	<#if productBranchId == null>保存后系统自动生成<#else>${productBranchId}</#if>
			                    </td>
			                </tr>
			                <tr>
			                 	<td width="100" class="e_label td_top"><i class="cc1">*</i>${branchName}名称：</td>
			                    <td><label><input type="text" name="branchName" id="branchName" required=true maxLength=50 
			                    	 value="${productBranch.branchName!''}" class="w35"></label>
			                    </td>
			                </tr>
				               <tr>
									<td width="100" class="e_label td_top"><i class="cc1">*</i>是否有效：</td>
									<td>
										<select name="cancelFlag" id="cancelFlag">
							                 <option value="N" <#if productBranch.cancelFlag == 'N'>selected="selected"</#if>>无效 </option>
					                    	 <option value="Y" <#if productBranch.cancelFlag == 'Y'>selected="selected"</#if>>有效 </option>
					                   	</select>				                    	
					                </td>					                   			                
				                </tr>
			                 <tr>
			                    <td width="100" class="e_label td_top"><i class="cc1">*</i>推荐级别：</td>
			                    <td>
			                    <label>
				                    <select name="recommendLevel">
				 						<option value ="5" <#if productBranch.recommendLevel == 5>selected="selected"</#if> >5</option>
				  						<option value ="4" <#if productBranch.recommendLevel == 4>selected="selected"</#if> >4</option>
				  						<option value ="3" <#if productBranch.recommendLevel == 3>selected="selected"</#if> >3</option>
				  						<option value ="2" <#if productBranch.recommendLevel == 2>selected="selected"</#if> >2</option>
				  						<option value ="1" <#if productBranch.recommendLevel == 1>selected="selected"</#if> >1</option>
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
			            <#if productBranch.productBranchId == null>
			            	<#assign productBranchId='' />
			            </#if>
						<#list branchPropList as branchProp>
			                <tr>
				                <td width="100" class="e_label td_top">${branchProp.propName!''}<#if branchProp.nullFlag == 'Y'><i class="cc1">*</i></#if>：</td>
			                	<td>
			                		<#if productBranch.productBranchId == null>
			               				<@displayHtml productBranchId index branchProp ''/>
			               			<#else>
			               				<@displayHtml productBranchId index branchProp productBranch/>
			               			</#if>
			                		<input type="hidden" name="productBranchPropList[${index}].propId" value="${branchProp.propId}">
			                		<input type="hidden" name="productBranchPropList[${index}].propCode" value="${branchProp.propCode}">
			                		<#if productBranch.productBranchId != null>
				                		<input type="hidden" name="productBranchPropList[${index}].productBranchId" value="${productBranch.productBranchId}">
				                		<input type="hidden" name="productBranchPropList[${index}].productBranchPropId" value="${branchProp.prodProductBranchProp.productBranchPropId}">
			                		</#if>
			                		<div id="ele${index}Error" style="display:inline"></div>
			                	</td>
				               </tr>
				               <#assign index=index+1 />
							</#list> 
			            </tbody>
	                </table>
	            </div>
	        </div>
	        
	        <!--只有附加规格显示-->
	        <#if bizBranch.branchCode = 'addition'>
	        <div class="p_box box_info p_line">
	            <div class="box_content ">
	                <table class="e_table form-inline ">
	                    <tbody>
	                    	<tr>
			                	<td  width="100">设置规则-下单限制</td>
			                    <td>&nbsp;</td>
			                </tr>
	                   		<tr>
			                	<td width="100" class="e_label td_top"><i class="cc1">*</i>常规限制：</td>
			                    <td>
				                    <input type="radio"  name="relationType" value="OPTIONAL" required="true" <#if prodBranchRelationType??&&prodBranchRelationType.relationType=='OPTIONAL'>checked=checked</#if> >任选
				                    <input type="radio"  name="relationType" value="OPTION" <#if prodBranchRelationType??&&prodBranchRelationType.relationType=='OPTION'>checked=checked</#if> >可选
				                    <input type="radio"  name="relationType" value="AMOUNT" <#if prodBranchRelationType??&&prodBranchRelationType.reType=='AMOUNT'>checked=checked</#if>>等量
			                    </td>
			                </tr>
	        			</tbody>
	                </table>
	                <div>注，任选[0、1、2、3、…最大购买数]；可选[0、最大购买数]；等量[最大购买数]</div>
	            </div>
	        </div>
	        </#if>
	        
	    </div>
	</form>
	<div class="p_box box_info clearfix mb20">
		<div class="fl operate"><a class="btn btn_cc1" id="save">保存</a></div>
	</div>
</div>

<#include "/base/foot.ftl"/>
</body>
</html>

<script>
$("#cancelFlag").attr("disabled","disabled");

var addChangeHotelDialog,updateChangeHotelDialog;
//JQuery 自定义验证
jQuery.validator.addMethod("isCharCheck", function(value, element) {
    var chars =  /^([\u4e00-\u9fa5]|[a-zA-Z0-9\+])+$/;//验证特殊字符    
    return this.optional(element) || (chars.test(value));       
 }, "不可输入特殊字符");
 
 //填充酒店数据
 function fillHotel(hotelId,hotelName,_flag){
    if(null != hotelId)
    {   if("Y" == _flag)
        {
        	$("#belongs_hotel").children("select").append("<option  value='"+hotelId+"' selected>"+hotelName+"</option>");
        }else{
            $("#belongs_hotel").children("select").find("option:selected").text(hotelName);
        }
    }
 }
 
$(document).ready(function(){
	//为checkbox 设置addValue
	 setCheckBoxAddValue();
	
	//为radio 设置addValue
	setRadioAddValue();
	
	//为select 设置addValue
	setSelectAddValue();
	
	$("#belongs_hotel").append("<a class='btn btn_cc1' id='addHotel'>新增酒店</a>&nbsp;<a class='btn btn_cc1' id='updateHotel'>编辑酒店</a>");
	$("#bed_type").append("<label>说明:案例,180cm*200cm;案例,可以拼床</label>");
	$("#internet").append("<label>说明:案例,早9点到10点8元;案例,10元/小时</label>");
	
	$("#addHotel").click(function(){
	     var productId = '${productId!''}';
	     addChangeHotelDialog = new xDialog("/vst_back/biz/changeHotel/showAddChangeHotel.do",{"productId":productId,"branchId":"${productBranch.branchId!''}"},{title:"新增可换酒店",width:900,height:700});
		 return;
	});
	
	$("#updateHotel").click(function(){
	     var dictId = $("#belongs_hotel").children("select").val();
	     if(null != dictId && ""!=dictId){
	       		updateChangeHotelDialog = new xDialog("/vst_back/biz/changeHotel/showUpdateChangeHotel.do",{"dictId":dictId,"branchId":"${productBranch.branchId!''}"},{title:"编辑可换酒店",width:900,height:700});
		        return;
	     }
	});
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
	if(!$("#showAddProdBranchDataForm").validate({
		rules: {
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
	
	if(typeof($("#stay_max_child").find("input").val()) != "undefined"){
		var stayMaxChild = parseFloat($("#stay_max_child").find("input").val());
		var stayMaxAdult = parseFloat($("#stay_max_adult").find("input").val());
		if(!(stayMaxAdult > 0 || stayMaxAdult == 0)){
			$.alert("最多入住成人数必须大于等于0！");
			return false;
		 }
		if(!(stayMaxChild > 0 || stayMaxChild == 0)){
			$.alert("最多入住儿童数必须大于等于0！");
			return false;
		 }	  
	}	 
	
	//刷新产品规格
	refreshAddValue();
	
	$("#cancelFlag").removeAttr("disabled");
	
	var msg = '确认保存吗 ？';	
	 if(refreshSensitiveWord($("input[type='text'],textarea"))){
	 	 $("input[name=senisitiveFlag]").val("Y");
	 	msg = '内容含有敏感词,是否继续?'
	 }
	
	$.confirm(msg,function(){
		//遮罩层
		var loading = top.pandora.loading("正在努力保存中...");	
		//提交新增
		$.ajax({
			url : "/vst_back/packageTour/prod/prodbranch/saveProductBranch.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#showAddProdBranchDataForm").serialize(),
			success : function(result) {
				 loading.close();
			     if(result.code=="success"){
						var productBranchId = $("#productBranchId").val();
						if(productBranchId == null || productBranchId == ''){
							$("#productBranchId",window.parent.document).val(result.attributes.productBranchId);
						}else{
							$("#productBranchId",window.parent.document).val(productBranchId);
						}
						confirmAndRefresh(result);
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
	
	
	//确定并刷新
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
				$("#save").removeAttr("disabled");
				var obj=$("#show2",window.parent.document); 
				parent.showPage(obj);
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	}					
});

refreshSensitiveWord($("input[type='text'],textarea"));
</script>