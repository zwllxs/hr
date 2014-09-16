<#assign hours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]>
<#assign minutes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<form id="dataForm">
    <table class="p_table form-inline">
        <tbody>
            <tr>
                <td class="p_label"><i class="cc1">*</i>车次号：</td>
                <td><input type="text" id="trainNo" name="trainNo" required="true"></td>
                <td class="p_label"><i class="cc1">*</i>车次类型：</td>
                <td>
                    <select id="trainType" name="trainType">
                        <option value=""></option>
                        <#list trainTypes as type>
	                       <option value="${type.type!''}">${type.cnName!''}</option>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="p_label">始发站：</td>
                <td>
                    <input type="text" class="searchInput" id="startStationString" name="startStationString" errorele="searchValidate">
                    <input type="hidden" id="startStation" name="startStation">
                </td>
                <td class="p_label">到达站：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveStationString" name="arriveStationString" errorele="searchValidate">
                    <input type="hidden" id="arriveStation" name="arriveStation">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>出发城市：</td>
                <td>
                    <input type="text" class="searchInput" id="startDistrictString" name="startDistrictString" errorele="searchValidate" readonly="readonly" required="true">
                    <input type="hidden" id="startDistrict" name="startDistrict">
                </td>
                <td class="p_label"><i class="cc1">*</i>抵达城市：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveDistrictString" name="arriveDistrictString" errorele="searchValidate" readonly="readonly" required="true">
                    <input type="hidden" id="arriveDistrict" name="arriveDistrict">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>始发时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" class="Wdate w110" id="startTime" name="startTime" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true">
                </td>
                <td class="p_label"><i class="cc1">*</i>终到时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" class="Wdate w110" id="arriveTime" name="arriveTime" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true">
                 </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>运行时长：</td>
                <td>
                    <select id="costTimeHour" name="costTimeHour" class="w6">
                        <option value=""></option>
                        <#list hours as hour>
                            <option value="${hour!''}">${hour!''}</option>
                        </#list>
                    </select>
                                                            小时
                    <select id="costTimeMinute" name="costTimeMinute" class="w6">
                        <option value=""></option>
                        <#list minutes as minute>
                            <option value="${minute!''}">${minute!''}</option>
                        </#list>
                    </select>
                                                            分钟
                </td>
                <td class="p_label"><i class="cc1">*</i>运行里程：</td>
                <td>
                    <input type="text" id="mileage" name="mileage"></input>公里
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>经停次数：</td>
                <td>
                    <select id="stopCount" name="stopCount" class="w6">
                        <option value=""></option>
                        <#list 0..30 as stopCount>
                            <option value="${stopCount!''}">${stopCount!''}</option>
                        </#list>
                    </select>
                </td>
                <td class="p_label"><i class="cc1">*</i>列车状态：</td>
                <td>
                    <select id="cancelFlag" name="cancelFlag" class="w7">
                        <option value=""></option>
                        <option value="Y">有效</option>
                        <option value="N">无效</option>
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
            url : "/vst_back/biz/train/addTrain.do",
            type : "post",
            dataType : "json",
            async : false,
            data : $("#dataForm").serialize(),
            success : function(result) {
                if (result.code == "success") {
                    alert(result.message);
                    addDialog.close();
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