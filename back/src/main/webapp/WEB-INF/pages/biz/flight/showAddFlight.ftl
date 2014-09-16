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
                <td class="p_label"><i class="cc1">*</i>航班号：</td>
                <td><input type="text" id="flightNo" name="flightNo" required="true">&nbsp;&nbsp;<button class="pbtn pbtn-small btn-ok" id="syncButton">同步</button></td>
                <td class="p_label"><i class="cc1">*</i>航空公司：</td>
                <td>
                    <select id="airline" name="airline">
                        <option value=""></option>
                        <#list airlines as airline>
                            <option value="${airline.dictId}">${airline.dictName}</option>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="p_label">始发机场：</td>
                <td>
                    <input type="text" class="searchInput" id="startAirportString" name="startAirportString" errorele="searchValidate">
                    <input type="hidden" id="startAirport" name="startAirport" value="${startAirport!''}">
                </td>
                <td class="p_label">到达机场：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveAirportString" name="arriveAirportString" errorele="searchValidate">
                    <input type="hidden" id="arriveAirport" name="arriveAirport" value="${arriveAirport!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>出发城市：</td>
                <td>
                    <input type="text" class="searchInput" id="startDistrictString" name="startDistrictString" errorele="searchValidate" required="true" readonly="readonly">
                    <input type="hidden" id="startDistrict" name="startDistrict" value="${startDistrict!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>抵达城市：</td>
                <td>
                    <input type="text" class="searchInput" id="arriveDistrictString" name="arriveDistrictString" errorele="searchValidate" required="true" readonly="readonly">
                    <input type="hidden" id="arriveDistrict" name="arriveDistrict" value="${arriveDistrict!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>起飞时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" name="startTime" class="Wdate w110" id="d4321" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true">
                </td>
                <td class="p_label"><i class="cc1">*</i>降落时间：</td>
                <td>
                    <input errorEle="searchValidate" type="text" name="arriveTime" class="Wdate w110" id="d4322" onFocus="WdatePicker({readOnly:'true',dateFmt:'H:mm'})" required="true">
                 </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>经停次数：</td>
                <td>
                    <select id="stopCount" name="stopCount">
                        <option value=""></option>
                        <#list 0..3 as time>
                            <option value="${time}">${time}</option>
                        </#list>
                    </select>
                </td>
                <td class="p_label"><i class="cc1">*</i>机型：</td>
                <td>
                    <select id="airplane" name="airplane">
                        <option value=""></option>
                        <#list airplanes as airplane>
                            <option value="${airplane.dictId}">${airplane.dictName}</option>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>飞行时长：</td>
                <td>
                    <select id="flightTimeHour" name="flightTimeHour" class="w6">
                        <option value=""></option>
                        <#list hours as hour>
                            <option value="${hour}">${hour}</option>
                        </#list>
                    </select>
                                                            小时
                    <select id="flightTimeMinute" name="flightTimeMinute" class="w6">
                        <option value=""></option>
                        <#list minutes as minute>
                            <option value="${minute}">${minute}</option>
                        </#list>
                    </select>
                                                            分钟
                </td>                
            </tr>
        </tbody>
    </table>
    <input type="hidden" id="cancelFlag" name="cancelFlag" value="N">
</form>
<button class="pbtn pbtn-small btn-ok" style="float: right; margin-top: 20px;" id="saveButton">保存</button>

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
    
    //自动补全机场信息
    vst_pet_util.commListSuggest($("#startAirportString"),$("#startAirport"),'/vst_back/prod/traffic/searchAirportList.do','');
    vst_pet_util.commListSuggest($("#arriveAirportString"),$("#arriveAirport"),'/vst_back/prod/traffic/searchAirportList.do','');
    
    $("#dataForm").validate({
      rules: {
        airline: "required",
        stopCount: "required",
        airplane: "required",
        flightTimeHour: "required",
        flightTimeMinute: "required"
      }
    });
    
    //保存
    $("#saveButton").on("click", function() {
        if(!$("#dataForm").validate().form()){
            return false;
        }
        $.ajax({
            url : "/vst_back/biz/flight/addFlight.do",
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