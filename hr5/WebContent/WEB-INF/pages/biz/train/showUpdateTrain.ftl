<#assign hours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]>
<#assign minutes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]>
<!DOCTYPE html>
<html>
<head>
   
</head>
<body>
<form id="dataForm">
    <input type="hidden" name="trainId" value="${bizTrain.trainId!''}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
                <td class="p_label"><i class="cc1">*</i>车次号：</td>
                <td><input type="text" id="trainNo" name="trainNo" required="true" value="${bizTrain.trainNo!''}"></td>
                <td class="p_label"><i class="cc1">*</i>车次类型：</td>
                <td>
                    <select id="trainType" name="trainType">
                        <#list trainTypes as type>
                            <#if type.type == bizTrain.trainType>
                                <option value="${type.type!''}" selected="selected">${type.cnName!''}</option>
                            <#else>
                                <option value="${type.type!''}">${type.cnName!''}</option>
                            </#if>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="p_label">始发站：</td>
                <td>
                    <input type="text" class="searchInput" id="startStationString" name="startStationString" errorele="searchValidate" value="${bizTrain.startStationString!''}">
                    <input type="hidden" id="startStation" name="startStation" value="${bizTrain.startStation!''}">
                </td>
                <td class="p_label">到达站：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveStationString" name="arriveStationString" errorele="searchValidate" value="${bizTrain.arriveStationString!''}">
                    <input type="hidden" id="arriveStation" name="arriveStation" value="${bizTrain.arriveStation!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>出发城市：</td>
                <td>
                    <input type="text" class="searchInput" id="startDistrictString" name="startDistrictString" errorele="searchValidate" readonly="readonly" required="true" value="${bizTrain.startDistrictString!''}">
                    <input type="hidden" id="startDistrict" name="startDistrict" value="${bizTrain.startDistrict!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>抵达城市：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveDistrictString" name="arriveDistrictString" errorele="searchValidate" readonly="readonly" required="true" value="${bizTrain.arriveDistrictString!''}">
                    <input type="hidden" id="arriveDistrict" name="arriveDistrict" value="${bizTrain.arriveDistrict!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>始发时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" class="Wdate w110" id="startTime" name="startTime" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true" value="${bizTrain.startTime!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>终到时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" class="Wdate w110" id="arriveTime" name="arriveTime" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true" value="${bizTrain.arriveTime!''}">
                 </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>运行时长：</td>
                <td>
                    <select id="costTimeHour" name="costTimeHour" class="w6">
                        <option value=""></option>
                        <#list hours as hour>
                            <#if hour == bizTrain.costTimeHour>
                                <option value="${hour!''}" selected="selected">${hour!''}</option>
                            <#else>
                                <option value="${hour!''}">${hour!''}</option>
                            </#if>
                        </#list>
                    </select>
                                                            小时
                    <select id="costTimeMinute" name="costTimeMinute" class="w6">
                        <option value=""></option>
                        <#list minutes as minute>
                            <#if minute == bizTrain.costTimeMinute>
                                <option value="${minute!''}" selected="selected">${minute!''}</option>
                            <#else>
                                <option value="${minute!''}">${minute!''}</option>
                            </#if>
                        </#list>
                    </select>
                                                            分钟
                </td>
                <td class="p_label"><i class="cc1">*</i>运行里程：</td>
                <td>
                    <input type="text" id="mileage" name="mileage" value="${bizTrain.mileage!''}"></input>&nbsp;公里
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>经停次数：</td>
                <td>
                    <select id="stopCount" name="stopCount" class="w6">
                        <option value=""></option>
                        <#list 0..30 as stopCount>
                            <#if stopCount == bizTrain.stopCount>
                                <option value="${stopCount!''}" selected="selected">${stopCount!''}</option>
                            <#else>
                                <option value="${stopCount!''}">${stopCount!''}</option>
                            </#if>
                        </#list>
                    </select>
                </td>
                <td class="p_label"><i class="cc1">*</i>列车状态：</td>
                <td>
                    <select id="cancelFlag" name="cancelFlag" class="w7">
                        <#if bizTrain.cancelFlag == "Y">
                            <option value="Y" selected="selected">有效</option>
                        <#else>
                            <option value="Y">有效</option>
                        </#if>
                        <#if bizTrain.cancelFlag == "N">
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
<button class="pbtn pbtn-small btn-ok" style="margin-left:50%; margin-top: 20px;" id="saveButton">保存</button>

<script>
    
    var districtSelectDialog;

    //选择出发城市
    $("#startDistrictString").on('click', function(){
        districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{id:"startDistrict"},{title:"选择出发城市",iframe:true,width:"1000",height:"600"});
    });
    
    //选择抵达城市
    $("#arriveDistrictString").on('click', function(){
        districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{id:"arriveDistrict"},{title:"选择抵达城市",iframe:true,width:"1000",height:"600"});
    });
    
    //选择城市
    function onSelectDistrict(params){
        if(params != null){
            var districtName = params.districtName;
            var districtId = params.districtId;
            if(districtSelectDialog.data.id === "startDistrict"){
                $("#startDistrictString").val(districtName);
                $("#startDistrict").val(districtId);
            } else {
                $("#arriveDistrictString").val(districtName);
                $("#arriveDistrict").val(districtId);
            }
        }
        districtSelectDialog.close();
    }
    
    //自动补全车站信息
    vst_pet_util.commListSuggest($("#startStationString"),$("#startStation"),'/vst_back/prod/traffic/searchTrainStationList.do','');
    vst_pet_util.commListSuggest($("#arriveStationString"),$("#arriveStation"),'/vst_back/prod/traffic/searchTrainStationList.do','');
    
    $("#dataForm").validate({
      rules: {
    	  costTimeHour: "required",
          costTimeMinute: "required",
          stopCount: "required",
          cancelFlag: "required",
          mileage: "required",
          trainType: "required"
      }
    });
    
    //保存
    $("#saveButton").on("click", function() {
        if(!$("#dataForm").validate().form()){
            return false;
        }
        $.ajax({
            url : "/vst_back/biz/train/updateTrain.do",
            type : "post",
            dataType : "json",
            async : false,
            data : $("#dataForm").serialize(),
            success : function(result) {
                if (result.code == "success") {
                    alert(result.message);
                    updateDialog.close();
                    window.location.reload();
                } else {
                    alert(result.message);
                }
            }
        });
    });
    
    
</script>
</body>
</html>