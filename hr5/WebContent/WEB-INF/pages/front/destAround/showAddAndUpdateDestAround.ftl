
<div class="iframe_content">
<div class="p_box">

<form id="destAdvertisingForm">
	  <input type="hidden" name="destId" value="${dest.destId!''}">
	  <input type="hidden" name="destName" value="${dest.destName!''}">
	  
	  <div class="box_content">
        <table class="e_table form-inline">
            <tbody>
            <#if destAroundList?? && destAroundList?size gt 0>
                <#list destAroundList as bizDestAround>
	                <tr <#if bizDestAround_index=0>name='no1'</#if>>
	                	<#if bizDestAround_index=0>
				   			<td name="addspan" rowspan='${destAroundList?size}' class="e_label"><i class="cc1">*</i>第2目的地：</td>
				   		</#if>
			            <td>${bizDestAround.seq}.&nbsp;
			            	<input type="text" name="aroundDest" class="w35" id="dest_${bizDestAround_index}" value="${bizDestAround.aroundDistrict.districtName}" data="${bizDestAround.aroundDistrict.districtId}" readonly = "readonly" required >
			            	<input type="hidden" name="bizDestAroundList[${bizDestAround_index}].aroundDestId" id="aroundDestId${bizDestAround_index}" value="${bizDestAround.aroundDestId}">
			            	<input type="hidden" name="bizDestAroundList[${bizDestAround_index}].destId" id="destId${bizDestAround_index}" value="${bizDestAround.destId}"> <a class='btn btn_cc1' name='del_button'>删除</a>
			            	<input type="hidden" name="bizDestAroundList[${bizDestAround_index}].seq" value="${bizDestAround.seq}">
			            	<#if bizDestAround_index=0><a class="btn btn_cc1" id="new_button">添加目的地</a></#if>
			            </td>
	        	    </tr>
            	</#list>
        	<#else>
        		<tr name='no1'>
			   	   <td name="addspan" width="150" class="e_label"><i class="cc1">*</i>第2目的地：</td>
		           <td>
                    	<input type="text" class="w35" id="dest_0" name="aroundDest" readonly="readonly" required>
                    	<input type="hidden" name="bizDestAroundList[0].aroundDestId" id="aroundDestId0" />
                    	<a class='btn btn_cc1' name='del_button' >删除</a><a class="btn btn_cc1" id="new_button">添加</a>
                    	<input type="hidden" name="bizDestAroundList[0].destId" value="${dest.destId}" id="destId0"> 
                    	<input type="hidden" name="bizDestAroundList[0].seq" value="1">
                    	<div id="addDestError"></div>
                    	</br>
                    	<div id="destDiv"></div>
                    </td>
        	    </tr>
        	</#if>
        	</tbody>
        </table>
    </div>
		
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="saveButton" name="saveButton">保存</button>

</div>
</div><!-- //主要内容显示区域 -->

<script>
var destSelectDialog;
var districts = ',';//子页面选择项对象数组
var count =0;
var markDistrict;
var markDistrictId;

//编辑页加载时先累计已有的行政区ID
$("input[name='aroundDest']").each(function(){
	markDistrictId = $(this).next().attr("id");
 	if($('#'+ markDistrictId).attr("data")!=""){
 		if(districts == ","){
 			districts = $('#'+ markDistrictId).attr("data");
 		}else{
 			districts = districts + "," + $('#'+ markDistrictId).attr("data");
 		}
 	}
});

var districtSelectDialog;
//选择行政区返回方法
function onSelectDistrict(params){
	if(params!=null){
		var districtId = params.districtId;
		districts = "";
		for(var i = 0; i < 20; i++){
			if($("#aroundDestId"+i) != null){
				if(typeof($("#aroundDestId"+i).val()) != "undefined"){
					 districts = districts + ',' + $("#aroundDestId"+i).val();
				}
			}
		}
		if(districts.indexOf(districtId)==0 || districts.indexOf(districtId)> 0 )
		{
		    alert('行政区已经存在');
		    return;
		}else{
			districts = districts + ',' + districtId;
		}
		$("input[name=aroundDest]").removeAttr("disabled");
		$("#"+markDistrict).val(params.districtName);
		$("#"+markDistrictId).val(districtId);
	}
	districtSelectDialog.close();
}

//新建行政区
$("#new_button").bind("click",function(){
	var rows = $("input[name=aroundDest]").size();
	count = rows;
	$("td[name=addspan]").attr("rowspan",rows+1);
	var $tbody = $(this).parents("tbody");
	$tbody.append("<tr><td><input type='text' class='w35' name='aroundDest' id='dest_"+count+"' readonly = 'readonly' required='true' /><input type='hidden' name='bizDestAroundList["+count+"].aroundDestId' id='aroundDestId"+count+"'/>&nbsp;<a class='btn btn_cc1' name='del_button'>删除</a></td></tr>"); 
});

//删除行政区
$("a[name=del_button]").bind("click",function(){
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

//打开选择行政区
$("input[name=aroundDest]").live("click",function(){
	markDistrict = $(this).attr("id");
	var idNum = markDistrict.split('_')[1];
	markDistrictId = 'aroundDestId'+idNum;
	var url = "/vst_back/front/destAround/selectDistrictList.do?";
	districtSelectDialog = new xDialog(url,{},{title:"选择行政区",iframe:true,width:"900",height:"550"});
	$("input[name=aroundDest]").attr("disabled","disabled");
});


$("#saveButton").click(function(){
  
	var msg = '确认保存吗 ？';
	$.confirm(msg,function(){
		//遮罩层
		$("#saveButton").attr("disabled","disabled");
		$.ajax({
			url : "/vst_back/front/destAround/addDestAround.do",
			type : "post",
			dataType : 'json',
			data : $("#destAdvertisingForm").serialize(),
			success : function(result) {
				if(result.code == "success"){
					pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",mask:true,ok:function(){
						$("#saveButton").removeAttr("disabled");
						addAndUpdateDialog.close();
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

</script>