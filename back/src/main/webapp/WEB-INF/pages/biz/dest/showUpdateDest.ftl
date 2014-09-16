<form id="dataForm">
	<input type="hidden" name="destId" value="${dest.destId!''}">
	<input type="hidden" name="destType" value="${dest.destType!''}">
	<input type="hidden" name="cancelFlag" value="${dest.cancelFlag!''}">
	<input type="hidden" name="foreighFlag" id="foreighFlag" value="${dest.foreighFlag!''}">
	
        <table class="p_table form-inline">
            <tbody>
                <tr>
                <td class="p_label" colspan="4" style="text-align:left;"><i class="cc1">*</i>目的地ID：${dest.destId!''}</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>目的地名称：
                	</td>
                    <td><input type="text" id="destName" name="destName" value="${dest.destName!''}" required=true>
                    <div id="destNameError"></div>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>拼音：</td>
                    <td>
                    	<input type="text" id="pinyin" name="pinyin" value="${dest.pinyin!''}" required=true>
                    </td>
				</tr>
				<tr>
                    <td class="p_label"><i class="cc1">*</i>简拼：</td>
                    <td>
                    	<input type="text" id="shortPinyin" name="shortPinyin" value="${dest.shortPinyin!''}" required=true>
                    </td>
                    <td class="p_label">英文名：</td>
                    <td>
                    	<input type="text" name="enName" value="${dest.enName!''}">
                    </td>
                 </tr> 
				 <tr>
                	<td class="p_label"><i class="cc1">*</i>目的地类型：</td>
                    <td>
                    <#list destTypeList as destType>
                    		<#if dest.destType == destType.code>${destType.cnName!''}</#if>
                    </#list>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>所属行政关系：</td>
                    <td>
                   	    <input type="text" id="districtName" value="${dest.districtName!''}" required=true readonly="readonly">
                    	<input type="hidden" name="districtId" value="${dest.districtId!''}" id="districtId">
                    </td>
                 </tr>
                 <tr>
                    <td class="p_label">别名：</td>
                    <td colspan="3" >
                    <textarea rows=2  style="width: 350px" maxlength=200 name="destAlias" >${dest.destAlias!''}</textarea> 多个以逗号分隔
                    </td>
                </tr>
                <tr>
                <td class="p_label">当地语言名：</td>
                    <td colspan="3" >
                    <textarea rows=2 style="width: 350px" maxlength=200 name="localLang" >${dest.localLang!''}</textarea> 多个以逗号分隔
                    </td>
                </tr>
                 <tr>
                    <td class="p_label">父级目的地(主)：</td>
                    <td >
                    	<input type="text" id="parentName" value="<#if dest.parentDest??>${dest.parentDest.destName!''}</#if> " readonly="readonly">
                    	<input type="hidden" name="parentId" value="${dest.parentId!''}" id="parentId">
                    </td>
                    <td class="p_label" name="foreighFlagId_label" id="foreighFlagId_label" >是否境外：</td>
                    <td id="foreighFlagId_td">
                		<#if dest.foreighFlag == 'Y'>是<#else>否</#if>
                    </td>
                </tr>
                 <tr>
                    <td class="p_label">父级目的地(次)：</td>
                    <td colspan="3" >
	                    <div class="parentDestList" style="overflow-x:hide; overflow-y:scroll;height: 80px;" >
	                    <#list dest.parentDestList as parentDest>
	                     <span><input type='hidden' id="otherParentDestIds" name='parentDestList[${parentDest_index}].destId' destName="${parentDest.destName}"  value='${parentDest.destId}'>${parentDest.destName}&nbsp;<a href= "javascript:delOtherParent('${parentDest.destId}');" id='a_${parentDest.destId}' class='delParentDest'>删除</a></span><br>
	                    </#list>
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

function initDests(){
    dests = [];
	//添加选中次父级目的地
    $('input[id="otherParentDestIds"]').each(function(){
		 var dest = {};
         dest.destId = $(this).val();
         dest.destName = $(this).attr("destName");
         dests.push(dest);
	});
}

//选择目的地
function onSelectDest(params){
	if(params!=null){
		$("#parentName").val(params.destName);
		$("#parentId").val(params.destId);
		if(!($("#destType").val() == "CONTINENT" || $("#destType").val() == "SPAN_COUNTRY" || $("#destType").val() == "COUNTRY")){
			$("#foreighFlag").val(params.foreighFlag);
			if(params.foreighFlag == 'Y'){
 				 $('#foreighFlagId_td').html("是");
			}else{
				 $('#foreighFlagId_td').html("否");
			}
		}
	}
	destSelectDialog.close();
}

//打开选择父目的地窗口
$("#parentName").click(function(){
     initDests();
	destSelectDialog = new xDialog("/vst_back/biz/dest/selectDestList.do?type=main&parentDestId="+$("#parentId").val()+"&destId=${dest.destId}",{},{title:"选择目的地",iframe:true,width:"1000",height:"600"});
});

//修改目的地
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.confirm("确认修改吗 ？", function (){
	$.ajax({
	url : "/vst_back/biz/dest/updateDest.do",
	type : "post",
	dataType:"json",
	async: false,
	data : $("#dataForm").serialize(),
	success : function(result) {
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

var shtml;
// 次父级目的地选择后的回调函数
function onSelectOtherDest(params) {

if (params != null) {
        $('.parentDestList').empty();
	    shtml = '';
	    for(var i =0; i<params.length; i++){
	    shtml +="<span><input class='parents' type='hidden' id='otherParentDestIds' name='parentDestList["+i+"].destId' destName='" + params[i].destName + "'  value='"+params[i].destId+"'>"+params[i].destName+"&nbsp;"+"<a href= 'javascript:delOtherParent(\""+params[i].destId+"\");' id='a_"+params[i].destId+"' class='delParentDest'>"+"删除</a></span><br>";
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
   if($.trim($("#parentName").val())==""){
      alert("请选择主父级目的地！");
      return;
    }
    initDests();
	otherDestSelectDialog = new xDialog("/vst_back/biz/dest/selectDestList.do?type=other&parentDestId="+$("#parentId").val()+ "&destId=${dest.destId}",{},{title:"选择(次)父级目的地",iframe:true,width:"1000",height:"600"});
});  
		
function remove(arrPerson,objPropery,objValue) 
{ 
	return $.grep(arrPerson, function(cur,i){ 
		return cur[objPropery]!=objValue; 
	}); 
}
</script>
