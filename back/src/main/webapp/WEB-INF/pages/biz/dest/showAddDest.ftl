<form id="dataForm">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>目的地名称：
                	</td>
                    <td><input type="text" id="destName" name="destName" required=true>
                    <div id="destNameError"></div>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>拼音：</td>
                    <td>
                    	<input type="text" id="pinyin" name="pinyin" required=true>
                    </td>
					
                </tr> 
                <tr>
                    <td class="p_label"><i class="cc1">*</i>简拼：</td>
                    <td>
                    	<input type="text" id="shortPinyin" name="shortPinyin" required=true>
                    </td>
                    <td class="p_label">英文名：</td>
                    <td>
                    	<input type="text" name="enName" >
                    </td>
                </tr>
                 <tr>
                    <td class="p_label">别名：</td>
                    <td colspan="3" >
                    	<textarea rows=2  style="width: 350px" maxlength=200 name="destAlias" ></textarea> 多个以逗号分隔
                    </td>
                </tr>
                <tr>
                    <td class="p_label">当地语言名：</td>
                    <td colspan="3" >
                    	<textarea rows=2 style="width: 350px" maxlength=200 name="localLang" ></textarea> 多个以逗号分隔
                    </td>
                </tr>
				<tr>
				   <td class="p_label"><i class="cc1">*</i>目的地类型：</td>
                    <td>
                    	<select name="destType" id="destType" required=true>
                    	<option value="">请选择</option>
                    	<#list destTypeList as destType>
                    		<option value="${destType.code!''}">${destType.cnName!''}</option>
                    	</#list>		
                    	</select>
                    </td>
				    <td class="p_label"><i class="cc1">*</i>所属行政关系：</td>
                    <td>
                   	    <input type="text" id="districtName" readonly="readonly" required=true>
                    	<input type="hidden" name="districtId" id="districtId">
                    </td>
                </tr>
                 <tr>
                    <td class="p_label" >父级目的地(主)：</td>
                    <td >
                    	<input type="text" id="parentName" readonly="readonly">
                    	<input type="hidden" name="parentId" id="parentId">
                    </td>
                    <td class="p_label" name="foreighFlagId_label" id="foreighFlagId_label" >是否境外：</td>
                    <td name="foreighFlagId" id="foreighFlagId" >
                		<input type="radio" name="foreighFlag" id="foreighFlag_Y" value="Y" >是&nbsp;&nbsp;
                		<input type="radio" name="foreighFlag" id="foreighFlag_N" value="N" >否
                    </td>
                </tr>
                 <tr>
                    <td class="p_label">父级目的地(次)：</td>
                    <td colspan="3" >
	                    <div class="parentDestList" style="overflow-x:hide; overflow-y:scroll;height: 80px;">
	                    </div>
	                    <a href="javascript:void(0);" class="otherParentDests" >+增加次父级目的地</a>
                    </td>
                </tr>
            </tbody>
        </table>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>

<script>
vst_pet_util.destListSuggest("#destName",null,false);
var dests = [];//子页面选择项对象数组

$("#destType").change(function(){
   var destType = $(this).val();
   if($(this).val() == "CONTINENT" || $(this).val() == "SPAN_COUNTRY" || $(this).val() == "COUNTRY"){
   		$("#foreighFlagId").show();
 		$("#foreighFlagId_label").show();
 		$("#foreighFlag_Y").prop("checked",true);
 		$("#foreighFlag_N").prop("checked",false);
 		
   }else{
 		$("#foreighFlagId").hide();
 		$("#foreighFlagId_label").hide();
 		$("#foreighFlag_Y").prop("checked",false);
 		$("#foreighFlag_N").prop("checked",true);
   }
});

//根据输入的中文名称自动补全拼音
$("#destName").change(function(){
   if($.trim($(this).val()) != ""){
		$("#pinyin").val(vst_pet_util.convert2pinyin($(this).val()));
		$("#shortPinyin").val(vst_pet_util.convert2shortpinyin($(this).val()));
   }
});

var districtSelectDialog;
//选择行政区
function onSelectDistrict(params){
	if(params!=null){
		$("#districtName").val(params.districtName);
		$("#districtId").val(params.districtId);
	}
	districtSelectDialog.close();
}

//打开选择行政区窗口
$("#districtName").click(function(){
	districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do?type=main",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});

var destSelectDialog,otherDestSelectDialog;
//选择父目的地返回的窗口
function onSelectDest(params){
	if(params!=null){
		$("#parentName").val(params.destName);
		$("#parentId").val(params.destId);
	    if(!($("#destType").val() == "CONTINENT" || $("#destType").val() == "SPAN_COUNTRY" || $("#destType").val() == "COUNTRY")){
			if(params.foreighFlag == 'Y'){
				$("#foreighFlag_Y").prop("checked",true);
 				$("#foreighFlag_N").prop("checked",false);
			}else{
				$("#foreighFlag_Y").prop("checked",false);
 				$("#foreighFlag_N").prop("checked",true);
			}
		}
	}
	destSelectDialog.close();
}

//打开选择父目的地窗口
$("#parentName").click(function(){
	destSelectDialog = new xDialog("/vst_back/biz/dest/selectDestList.do?type=main&parentDestId="+$("#parentId").val(),{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
});

//添加目的地
$("#editButton").bind("click",function(){

	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.ajax({
	url : "/vst_back/biz/dest/addDest.do",
	type : "post",
	dataType:"json",
	async: false,
	data : $("#dataForm").serialize(),
	success : function(result) {
	   if(result.code=="success"){
			$.alert(result.message,function(){
   				addDialog.close();
   				window.location.reload();
   			});
		}else {
			$.alert(result.message);
   		}
	   }
	});						
});

var shtml;
// 次父级目的地选择后的回调函数
function onSelectOtherDest(params) {

if (params != null) {
        $('.parentDestList').empty();
	    shtml = '';
	    for(var i =0; i<params.length; i++){
	    shtml +="<span><input class='parents' type='hidden' name='parentDestList["+i+"].destId' value='"+params[i].destId+"'>"+params[i].destName+"&nbsp;"+"<a href= 'javascript:delOtherParent(\""+params[i].destId+"\");' id='a_"+params[i].destId+"' class='delParentDest'>"+"删除</a></span><br>";
        }
        $('.parentDestList').html(shtml);
}
	// 关闭目的地列表
	otherDestSelectDialog.close();
}

function delOtherParent(destId)
{  
       var obj = $('#a_'+destId).parent("span");
       obj.remove();     
	   dests = remove(dests,"destId", destId);
}
 
$("a.otherParentDests").click(function() {
   if($("#parentName").val()==""){
      alert("请选择主父级目的地！");
      return;
    }
    //var pdest = $("#dataForm").serialize(); 
	otherDestSelectDialog = new xDialog("/vst_back/biz/dest/selectDestList.do?type=other&parentDestId="+$("#parentId").val(),{},{title:"选择(次)父级目的地",iframe:true,width:"1000",height:"700"});
});  
		
function remove(arrPerson,objPropery,objValue) 
{ 
	return $.grep(arrPerson, function(cur,i){ 
		return cur[objPropery]!=objValue; 
	}); 
}
</script>
