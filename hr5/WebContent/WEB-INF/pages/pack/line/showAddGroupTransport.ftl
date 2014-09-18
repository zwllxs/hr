<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>插入时间段</div>
       <div class="p_box box_info p_line">
       <form action="/vst_back/productPack/line/addGroup.do" method="post" id="dataForm">
       		<input type="hidden"  name="productId" id="productId"  value="${productId }"/>
       		<input type="hidden"  name="groupType" id="groupType"  value="${groupType }"/>
       		<input type="hidden"  name="selectCategoryId" id="selectCategoryId"  value="${selectCategoryId }"/>
       		
            <div class="box_content">
	            <table class="e_table form-inline" >
					   <tr >
		                	<td class="e_label" style="text-align: left;">产品品类</td>
		                    <td style="text-align: left;">
		                    	<select name="categoryId" id="categoryId"  readonly = "true">
								  	<#list bizCategoryList as list>
								  		<#if selectCategoryId == list.categoryId>
					                    	<option value="${list.categoryId}" selected>${list.categoryName}</option>
					                    </#if>
								  	</#list>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组时间限制</td>
		                    <td style="text-align: left;">
		                    	<select name="dateType" id="dateType" readonly = "true">
		                    			<#if selectCategoryId == '16'>
		                    				<option value="DATERANGESELECT" selected>区间日期，可选</option>
		                    			<#else>
		                    				<option value="NODATESELECT" selected>指定日期，不可选</option>
		                    			</#if>
							  	</select>
		                    </td>
		                </tr>
		                 <tr>
		                	<td class="e_label" style="text-align: left;">组可添加产品数量限制</td>
		                    <td style="text-align: left;">
		                    	<select name="selectType" id="selectType" readonly = "true">
		                    		<#if selectCategoryId == '15' || selectCategoryId == '18'>
		                    			<option value="ONE" selected>只能添加一个产品</option>
		                    		<#else>
		                    			 <option value="NOLIMIT" selected>无限制</option>
		                    		</#if>
							  	</select>
		                    </td>
		                </tr>           	
	            </table>
            </div>
            
            <div class="box_content">
	            	<table class="e_table form-inline">
		             		<tbody>
		             			<tr>
			             			<td colspan="3" class="e_label" style="text-align: left;">交通类型</td>
			             		</tr>
		             			 <tr >
			             			<td  colspan="3" class="e_label" style="text-align: left;"><input type="radio" data="transportType" name="prodPackageGroupTransport.transportType" value="TOBACK" checked="checked" class="c1"/>往返程</td>
			                   </tr>
			                    <tr class="c1">
			             			<td class="e_label" style="text-align: right;">去程：</td>
			             			<td style="" >
			             				出发地 &nbsp;&nbsp;<input type="text" class="" name="n1"  id="toStartPoint" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.toStartPoint" id="toStartPointHidden">
				                    </td>
				                    <td style="" >
			             				第<select style="width:50px;" class="travelDays" name="prodPackageGroupTransport.toStartDays"></select>天出发
				                    </td>
			             		</tr>
			             		<tr class="c1">
			             			<td class="e_label" style="text-align: right;"></td>
			             			<td s	tyle="" >
			             				目的地 &nbsp;&nbsp;<input type="text" class="" name="n2"  id="toDestination" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.toDestination" id="toDestinationHidden">
				                    </td>
				                    <td style="" >
				                    </td>
			             		</tr>
			             		 <tr class="c1">
			             			<td class="e_label" style="text-align: right;">返程：</td>
			             			<td style="" >
			             				出发地 &nbsp;&nbsp;<input type="text" class="" name="n3"  id="backStartPoint" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.backStartPoint" id="backStartPointHidden">
				                    </td>
				                    <td style="" >
			             				第<select style="width:50px;" class="travelDays" name="prodPackageGroupTransport.backStartDays"></select>天出发
				                    </td>
			             		</tr>
			             		<tr class="c1">
			             			<td class="e_label" style="text-align: left;"></td>
			             			<td s	tyle="" >
			             				目的地 &nbsp;&nbsp;<input type="text" class="" name="n4" id="backDestination" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.backDestination" id="backDestinationHidden">
				                    </td>
				                    <td style="" >
				                    </td>
			             		</tr>
		             		  <tr >
			             			<td  colspan="3" class="e_label" style="text-align: left;"><input type="radio" data="transportType" name="prodPackageGroupTransport.transportType" value="TO" class="c2"/>单程</td>
			                   </tr>
			                    <tr class="c2">
			             			<td class="e_label" style="text-align: right;"><input type="radio" name="type" value="to" class="toType" checked=checked/>去程：</td>
			             			<td style="" >
			             				出发地 &nbsp;&nbsp;<input type="text" class="" name="n5" id="toStartPoint1" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.toStartPoint" id="toStartPoint1Hidden">
				                    </td>
				                    <td style="" >
			             				第<select style="width:50px;" class="travelDays"  name="prodPackageGroupTransport.toStartDays"></select>天出发
				                    </td>
			             		</tr>
			             		<tr class="c2">
			             			<td class="e_label" style="text-align: right;"></td>
			             			<td style="" >
			             				目的地 &nbsp;&nbsp;<input type="text" class="" name="n6" id="toDestination1" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.toDestination" id="toDestination1Hidden">
				                    </td>
				                    <td style="" >
				                    </td>
			             		</tr>
			             		<tr class="c2">
			             			<td class="e_label" style="text-align: right;"><input type="radio" name="type" value="back" class="toType"/>返程：</td>
			             			<td style="" >
			             				出发地 &nbsp;&nbsp;<input type="text" class="" name="n7" id="backStartPoint1" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.backStartPoint" id="backStartPoint1Hidden">
				                    </td>
				                    <td style="" >
			             				第<select style="width:50px;" class="travelDays"  name="prodPackageGroupTransport.backStartDays"></select>天出发
				                    </td>
			             		</tr>
			             		<tr class="c2">
			             			<td class="e_label" style="text-align: left;"></td>
			             			<td style="" >
			             				目的地 &nbsp;&nbsp;<input type="text" class="" name="n8" id="backDestination1" required>
			             				<input type="hidden" class="" name="prodPackageGroupTransport.backDestination" id="backDestination1Hidden">
				                    </td>
				                    <td style="" >
				                    </td>
			             		</tr>
		             		</tbody>
		             	</table>
            </div>
            </form>
        </div>
        
        <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">确认并保存</a></div>
        </div>
</div>
<script>
$(function(){
	var selectCategoryId = $("#selectCategoryId").val();
	//当地游
	if(selectCategoryId == '16'){
		//入住晚数
		$("#stayDays").append("<option value='0>0</option>");
	}
	
	var routeNum = "${routeNum}";
	if(routeNum != null && routeNum != ''){
		for(var index = 0 ; index < parseInt(routeNum); index ++){
			//添加行程天数
			$(".travelDays").append("<option value='" + (index + 1) + "'>" + (index + 1) + "</option>");
		}
	}

});

var districtSelectDialog;
//打开选择行政区窗口
$("#toStartPoint,#toDestination,#backStartPoint,#backDestination,#toStartPoint1,#toDestination1,#backStartPoint1,#backDestination1").click(function(){
   //用于显示文字的元素ID
	var nameId = $(this).attr("id");
	//用于显示ID的元素ID
	var elementId = nameId+"Hidden";
	districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do?elementId="+elementId+"&nameId="+nameId,{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});

//选择行政区
function onSelectDistrict(params){
	if(params!=null){
		$("#"+params.nameId).val(params.districtName);
		$("#"+params.elementId).val(params.districtId);
	}
	districtSelectDialog.close();
	$("#districtError").hide();
}

//设置disabled
$("input[data=transportType]").each(function(){
	var that = $(this);
	var cl = that.attr("class");
	//如果没被选中，则找到后面紧跟的div然后设置为disabled
	if(!that.is(":checked")){
		that.closest("tr").nextAll("."+cl).find("input,select").attr("disabled","disabled");
	}
});
//点击事件
$("input[data=transportType]").bind("click",function(){
	var that = $(this);
	var cl = that.attr("class");
	//全部设置为无效
	$(".c1,.c2").find("input,select").attr("disabled","disabled");
	//如果没被选中，则找到后面紧跟的div然后设置为disabled
	if(that.is(":checked")){
		if(cl=='c1'){
			that.closest("tr").nextAll(".c1").find("input,select").removeAttr("disabled");
		}else if(cl=='c2'){
			//把选中框设置为可用
			$(".toType").removeAttr("disabled");
			//把已选中的设置为非disabled
			$(".c2").find("input[type=radio]:checked").closest("tr").find("input,select").removeAttr("disabled");
			$(".c2").find("input[type=radio]:checked").closest("tr").next("tr").find("input,select").removeAttr("disabled");
		}
	}
});

//去程返程点击事件
$("input[value=back]").bind("click",function(){
	var that = $(this);
	if(that.is(":checked")){
		 //把去程设置为不可点击
		  $("input[value=to]").closest("tr").find("input[type=text],select").attr("disabled","disabled");
		   $("input[value=to]").closest("tr").next("tr").find("input[type=text],select").attr("disabled","disabled");
	}
	that.closest("tr").find("input,select").removeAttr("disabled");
	that.closest("tr").next("tr").find("input,select").removeAttr("disabled");
});
//去程返程点击事件
$("input[value=to]").bind("click",function(){
	var that = $(this);
	if(that.is(":checked")){
		 //把去程设置为不可点击
		  $("input[value=back]").closest("tr").find("input[type=text],select").attr("disabled","disabled");
		   $("input[value=back]").closest("tr").next("tr").find("input[type=text],select").attr("disabled","disabled");
	}
	that.closest("tr").find("input,select").removeAttr("disabled");
	that.closest("tr").next("tr").find("input,select").removeAttr("disabled");
});

$("#save").bind("click",function(){
	
	 //验证
	if(!$("#dataForm").validate({
		rules : {},
		messages : {}
	}).form()){
		return;
	}
	//判断是不是往返类型
	if($("input[data=transportType]:checked").val()=="TOBACK"){
			//检查去程和返程时间是否满足要求
			if($("select[name=toStartDays][disabled!=disabled]").val() > $("select[name=backStartDays][disabled!=disabled]").val()){
					$.alert("去程出发时间不能大于返程出发时间");
					return;
			}
	}
	$.ajax({
		url : "/vst_back/productPack/line/addGroup.do",
		type : "post",
		dataType : 'json',
		async: false,
		data : $("#dataForm").serialize(),
		success : function(result) {
			if(result.code == "success"){
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
					$("#traffic",parent.document).parent("li").trigger("click");
				}});
			}else if(result.code == "error"){
				$.alert(result.message);
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown,exc) {
		}
	})
	
});
</script>