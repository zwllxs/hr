<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<form id="dataForm">
    <input type="hidden" id="stopId" name="stopId" value="${bizTrainStop.stopId!''}">
    <div class="p_box">
        <div>经停车站信息：${trainNo}</div>
    </div>
    <table class="p_table form-inline">
        <tbody>
            <tr>
                <td class="p_label"><i class="cc1">*</i>站次编号：</td>
                <td><input type="text" id="stopStep" name="stopStep" required="true" value="${bizTrainStop.stopStep!''}"></td>
                <td class="p_label"><i class="cc1">*</i>车站名称：</td>
                <td>
                    <input type="text" class="searchInput" errorele="searchValidate" id="stopStationString" name="stopStationString" required="true" value="${bizTrainStop.stopStationString!''}">
                    <input type="hidden" id="stopStation" name="stopStation" value="${bizTrainStop.stopStation!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>到站时间：</td>
                <td>
                    <input type="text" class="Wdate w110" id="arrivalTime" name="arrivalTime" errorEle="searchValidate" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true" value="${bizTrainStop.arrivalTime!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>出站时间：</td>
                <td>
                    <input type="text" class="Wdate w110" id="departureTime" name="departureTime" errorEle="searchValidate" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true" value="${bizTrainStop.departureTime!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>停站时间：</td>
                <td>
                    <input type="text" id="stopTime" name="stopTime" required="true" value="${bizTrainStop.stopTime!''}">分钟
                </td>
                <td class="p_label"><i class="cc1">*</i>状态：</td>
                <td>
                    <select id="cancelFlag" name="cancelFlag" class="w7">
                        <#if bizTrainStop.cancelFlag == "Y">
                            <option value="Y" selected="selected">有效</option>
                        <#else>
                            <option value="Y">有效</option>
                        </#if>
                        <#if bizTrainStop.cancelFlag == "N">
                            <option value="N" selected="selected">无效</option>
                        <#else>
                            <option value="N">无效</option>
                        </#if>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
</form>
<button class="pbtn pbtn-small btn-ok" style="margin-left: 50%; margin-top: 20px;" id="saveButton" stopId="${bizTrainStop.stopId!''}" trainId="${trainId}" trainNo="${trainNo}">确定</button>

<#include "/base/foot.ftl"/>
<script>
    $.noConflict();
    //自动补全车站名称
    vst_pet_util.commListSuggest($("#stopStationString"),$("#stopStation"),'/vst_back/prod/traffic/searchTrainStationList.do','');
    
    function validate(){
    	if($("#stopStep").val()==""){
    		alert("站次编号为必填项");
    		return false;
    	}
    	if($("#stopStationString").val()=="" && $("#stopStation").val()==""){
            alert("车站名称为必填项");
            return false;
        }
    	if($("#arrivalTime").val()==""){
            alert("到站时间为必填项");
            return false;
        }
    	if($("#stopTime").val()==""){
            alert("停站时间为必填项");
            return false;
        }
    	if($("#cancelFlag").val()==""){
            alert("状态为必填项");
            return false;
        }
    }
    
    //保存
    $("#saveButton").on("click", function() {
        if(!validate()){
        	return false;
        }
        var trainId = $(this).attr('trainId');
        var trainNo = $(this).attr('trainNo');
        $.ajax({
            url : "/vst_back/biz/trainStop/updateTrainStop.do",
            type : "post",
            dataType : "json",
            async : false,
            data : $("#dataForm").serialize(),
            success : function(result) {
                if (result.code == "success") {
                    alert(result.message);
                    updateDialog.close();
                    stopInfoDialog.close();
                    stopInfoDialog = new xDialog("/vst_back/biz/trainStop/findTrainStopList.do",{"trainId":trainId,"trainNo":trainNo}, {title:"经停信息",width:800});
                } else {
                    alert(result.message);
                }
            }
        });
    });
    
</script>
</body>
</html>