<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
</div>
<div class="iframe_content">   
<div class="p_box">
<form id="destAdvertisingForm">
	<input type="hidden" name="destId" value="${dest.destId!''}">
	<input type="hidden" name="destName" value="${dest.destName!''}">
	<input type="hidden" name="showTab" value="${showTab!''}">
	
	<div class="p_box box_info p_line">
			  <div class="box_content">
                <table class="e_table form-inline">
                    <tbody>
                    <#if bizProdAdList?? && bizProdAdList?size gt 0>
		                <#list bizProdAdList as bizProdAd>
			                <tr <#if bizProdAd_index=0>name='no1'</#if>>
			                	<#if bizProdAd_index=0>
						   			<td name="addspan" rowspan='${bizProdAdList?size}' class="e_label"><i class="cc1">*</i>关联产品：</td>
						   		</#if>
					            <td>${bizProdAd.seq}.&nbsp;
					            	<input type="text" name="aroundDest" class="w35" id="productId_${bizProdAd_index}" value="${bizProdAd.prodProduct.productName}" data="${bizProdAd.prodProduct.productId}" readonly = "readonly" required >
					            	<input type="hidden" name="bizProdAdList[${bizProdAd_index}].productId" id="productId${bizProdAd_index}" value="${bizProdAd.productId}">  <a class='btn btn_cc1' name='del_button' >删除</a>
					            	<input type="hidden" name="bizProdAdList[${bizProdAd_index}].destId" id="destId" value="${bizProdAd.destId}">
					            	<input type="hidden" name="bizProdAdList[${bizProdAd_index}].seq" value="${bizProdAd.seq}">
					            	<#if bizProdAd_index=0><a class="btn btn_cc1" id="new_button">添加产品</a></#if>
					            </td>
			        	    </tr>
	                	</#list>
                	<#else>
                		<tr name='no1'>
					   	   <td name="addspan" width="150" class="e_label"><i class="cc1">*</i>关联产品：</td>
				           <td>
		                    	<input type="text" class="w35" id="productId_0" name="aroundDest" readonly="readonly" required>
		                    	<a class='btn btn_cc1' name='del_button' >删除</a>
		                    	<input type="hidden" name="bizProdAdList[0].productId" id="productId0" /><a class="btn btn_cc1" id="new_button">添加产品</a>
		                    	<input type="hidden" name="bizProdAdList[0].destId" value="${dest.destId}"> 
		                    	<input type="hidden" name="bizProdAdList[0].seq" value="1">
		                    	<div id="addDestError"></div>
		                    	</br>
		                    	<div id="destDiv"></div>
		                    </td>
		        	    </tr>
                	</#if>
                	</tbody>
                </table>
            </div>
		</div>
		
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="saveButton" name="saveButton">保存</button>

</div>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>

$("#saveButton").click(function(){
 	var hasAroundDest = "false";
 	$('input[name="aroundDest"]').each(function(){  
		if ($(this).val() != ""){
			hasAroundDest = "true";
		}
	});
	if(hasAroundDest == "false"){
		alert("请选择产品");
		return;
	}
	var msg = '确认保存吗 ？';	 
	$.confirm(msg,function(){
		//遮罩层
		$("#saveButton").attr("disabled","disabled");
		$.ajax({
			url : "/vst_back/front/destAdvertising/addDestAdvertising.do",
			type : "post",
			dataType : 'json',
			data : $("#destAdvertisingForm").serialize(),
			success : function(result) {
				if(result.code == "success"){
					pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",mask:true,ok:function(){
						$("#saveButton").removeAttr("disabled");
					}});
				}else {
					$.alert(result.message);
					$("#saveButton").removeAttr("disabled");
				}
			},
			error : function(){
				$("#saveButton").removeAttr("disabled");
			}
		  });
	});
});

var prodSelectDialog;

var prods = ',';//子页面选择项对象数组
var count =0;
var markProd;
var markProdId;

//编辑页加载时先累计已有的产品ID
$("input[name='aroundDest']").each(function(){
	markProdId = $(this).next().attr("id");
 	if($('#'+ markProdId).val()!=""){
 		if(prods == ","){
 			prods = $('#'+ markProdId).val();
 		}else{
 			prods = prods + "," + $('#'+ markProdId).val();
 		}
 	}
});
	
//选择目的地返回方法
function onSelectProd(params){
	if(params!=null){
		var prodId = params.productId;
		prods = "";
		for(var i = 0; i < 20; i++){
			if($("#productId_"+i) != null){
				if($("#productId_"+i).attr("data") != null){
					 prods = prods + ',' + $("#productId_"+i).attr("data");
				}
			}
		}
		if(prods.indexOf(prodId)==0 || prods.indexOf(prodId)> 0 )
		{
		    alert('产品已经存在');
		    return;
		}else{
			prods = prods + ',' + prodId;
		}
		$("#"+markProd).val(params.productName);
		$("#"+markProdId).val(prodId);
	}
	prodSelectDialog.close();
}

//新建产品
$("#new_button").bind("click",function(){
	var rows = $("input[name=aroundDest]").size();
	if(rows > 1){
		alert("目的地最多关联2产品做广告");
		return;
	}
	count = rows;
	$("td[name=addspan]").attr("rowspan",rows+1);
	var $tbody = $(this).parents("tbody");
	$tbody.append("<tr><td><input type='text' class='w35' name='aroundDest' id='productId_"+count+"' readonly = 'readonly' required='true' /><input type='hidden' name='bizProdAdList["+count+"].productId' id='productId"+count+"'/>&nbsp;<a class='btn btn_cc1' name='del_button'>删除</a></td></tr>"); 
});

//删除产品
$("a[name=del_button]").live("click",function(){
	if($(this).parents("tr").attr("name")=="no1"){
		$(this).parents("tr").find("input").val("");
		$(this).parents("tr").find("input").attr("data","");
		$("#aroundDestId0").val("");
	}else{
		$(this).parents("tr").remove();
	}
	var rows = $("input[name='aroundDest']").size();
	$("td[name=addspan]").attr("rowspan",rows);
});

//打开选择产品
$("input[name=aroundDest]").live("click",function(){
	markProd = $(this).attr("id");
	var idValue = markProd.split('_')[1];
	markProdId = 'productId'+idValue;
	var url = "/vst_back/front/destAdvertising/findProductList.do?categoryIds=${categoryIds}";
	prodSelectDialog = new xDialog(url,{},{title:"选择产品",iframe:true,width:800,height:670});
});
 
</script>