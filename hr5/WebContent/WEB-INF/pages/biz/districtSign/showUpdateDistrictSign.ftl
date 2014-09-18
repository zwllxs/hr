
<style>
	.notnull {color:red;}
</style>

<form  id="dataForm">
	<input type="hidden" name="signId" value="${districtSign.signId!''}">
	
    <table id="distTb" class="p_table form-inline">
    <tbody>
        <tr>
        	<td class="p_label">名称<span class="notnull">*</span>：</td>
            <td><input type="text" name="signName" value="${districtSign.signName!''}" required=true></td>
        </tr>
        <tr>
             <td class="p_label">行政区域<span class="notnull">*</span>：</td>
             <input type="hidden" name="districtId"  id="districtId" value="${districtSign.districtId!''}">
             <td><input type="text" name="districtName"  required=true id="districtName" value="${district.districtName!''}" readOnly="true"></td>
        </tr>
        <tr>
       		<td class="p_label">类型<span class="notnull">*</span>：</td>
            <td>
            	<select id="signType" name="signType" value="${districtSign.signType!''}" required=true>
                	 <#list bizDictList as bizDict>
                		<#if districtSign.signType == bizDict.dictId>
                			<option value="${bizDict.dictId!''}" selected="selected">${bizDict.dictName!''}</option>
                		<#else>
                			<option value="${bizDict.dictId!''}">${bizDict.dictName!''}</option>
                		</#if>
                	</#list>
            	</select>
            </td>
        </tr>
         <tr>
            <td class="p_label">英文名：</td>
            <td>
            	<input type="text" name="enName"  value="${districtSign.enName!''}">
            </td>
         </tr>
         <tr>
            <td class="p_label">别名：</td>
            <td>
            <textarea rows=2  style="width: 200px" maxlength=200 name="signAlias" >${districtSign.signAlias!''}</textarea>&nbsp;多个以“，”分隔
            </td>
         </tr>
         <tr>
            <td class="p_label">当地语言名：</td>
            <td>
            <textarea rows=2  style="width: 200px" maxlength=200 name="localLang" >${districtSign.localLang!''}</textarea>&nbsp;多个以“，”分隔
            </td>
         </tr>
          <tr>
                 <td class="p_label">拼音：</td>
                <td>
                	<input type="text" name="pinyin"  value="${districtSign.pinyin!''}">
                </td> 
            </tr>
            <tr>
                 <td class="p_label">简拼：</td>
                <td>
                	<input type="text" name="shortPinyin" value="${districtSign.shortPinyin!''}">
                </td> 
         </tr>
         <tr>
     		 <td class="p_label">描述：</td>
             <td><textarea name="signDesc">${districtSign.signDesc!''}</textarea></td> 
         </tr>
         <#if districtSign.signType == 2006>
              <tr id='lineTr'><td class='p_label'>所属线路<span class='notnull'>*</span>：</td><td><input type='text' value='${lineNames}' id='lines' name='lines' readOnly='true' required=true></td></tr>
         </#if>
    </tbody>
    </table>
    <div class='trafficLines'>
         <#list districtSign.trafficLines as trafficLine> 
           <span><input type='hidden' class='trafficLines_input' name='trafficLines[${trafficLine_index}].trafficId' value='${trafficLine.trafficId}'></span><br>
         </#list>
    </div>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>

<script>
var districtSelectDialog,linesDialog;

$("#lines").bind("click",function(){
    if($("#districtName").val() == "")
      {
         alert("请选择行政区域！");
         return;
      }
    var trafficIds = $("*[class='trafficLines_input']").map(function(){return $(this).val()}).get().join(",");
	var url = "/vst_back/biz/trafficLine/selectTrafficLineList.do";
	linesDialog = new xDialog(url,{"districtId":$("#districtId").val(),"trafficIds":trafficIds},{title:"选择地铁线路",width:"500"});
});

//选择行政区

function onSelectDistrict(params){
	if(params!=null){
		var oldvalue = $("#districtId").val();
	    if(oldvalue != params.districtId){
	         $('.trafficLines').empty();
        	 $("#lines").val('');
	    }
		$("#districtId").val(params.districtId);
		$("#districtName").val(params.districtName);
	}
	districtSelectDialog.close();
}

$("#districtName").bind("click",function(){
	var url = "/vst_back/biz/district/selectDistrictList.do";
	districtSelectDialog = new xDialog(url,{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});
	
//修改地理位置
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.confirm("确认修改吗 ？", function (){
		$.ajax({
		url : "/vst_back/biz/districtSign/updateDistrictSign.do",
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
// 地铁线路选择后的回调函数
function onSelectTrafficLine(params) {

if (params != null) {
        $('.trafficLines').empty();
	    shtml = '';
	    linesStr = '';
	    for(var i =0; i<params.length; i++){
	    shtml +="<span><input type='hidden' class='trafficLines_input' name='trafficLines["+i+"].trafficId' value='"+params[i].trafficId+"'></span><br>";
        linesStr += params[i].trafficName+",";
        }
        $('.trafficLines').html(shtml);
        $("#lines").val(linesStr);
}
	// 关闭地铁线路列表窗口
	linesDialog.close();
}



$("#signType").change(function(){
   var text = $(this).find("option:selected").text();
   if(text == "地铁"){
      var trHTML = "<tr id='lineTr'><td class='p_label'>所属线路<span class='notnull'>*</span>：</td><td><input type='text' id='lines' name='lines' readOnly='true' required=true></td></tr>";
      $("#distTb").append(trHTML);
      $("#lines").bind("click",function(){
      if($("#districtName").val() == "")
      {
         alert("请选择行政区域！");
         return;
      }
      var trafficIds = $("*[name='trafficLines_input']").map(function(){return $(this).val()}).get().join(",");
	  var url = "/vst_back/biz/trafficLine/selectTrafficLineList.do";
	  linesDialog = new xDialog(url,{"districtId":$("#districtId").val(),"trafficIds":trafficIds},{title:"选择地铁线路",width:"500"});
      });
   }else{
      $("#lineTr").remove();
      $(".trafficLines").empty();
   }
 });
</script>