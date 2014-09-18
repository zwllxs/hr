<form id="dataForm">
<input type="hidden" name="trafficId" value="${trafficLine.trafficId}">
<input type="hidden" name="cancelFlag" value="${trafficLine.cancelFlag}">
        <table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label"><i class="cc1">*</i>所属行政区域：</td>
                    <td>
                   	    <input type="text" id="districtName" value="${trafficLine.districtName}" readonly="readonly" required=true>
                    	<input type="hidden" name="districtId" value="${trafficLine.districtId}" id="districtId">
                    </td>
                </tr> 
				<tr>
                	<td class="p_label"><i class="cc1">*</i>线路名称：
                	</td>
                    <td><input type="text" id="trafficName" value="${trafficLine.trafficName}" name="trafficName" required=true>
                    </td>
                </tr>
            </tbody>
        </table>
        

    <div id="stations_div" class="p_box" style="overflow:scroll;height: 380px;">
            包含站点：
	<table class="p_table table_center">
        <thead>
            <tr>
            <th>选择</th>
        	<th>站点编号</th>
            <th>站点名称</th>
            </tr>
        </thead>
        <tbody>
			<#list trafficLine.stations as station> 
			<tr>
			<td>
				<input type="checkbox" checked="checked"  name="stations[${station_index}].signId" value="${station.signId}">
			    <input type="hidden" name="signNameHide" value="${station.signName!''}">
			</td>
			<td>${station.signId!''} </td>
			<td>${station.signName!''} </td>
			</tr>
			</#list>
        </tbody>
    </table>
	</div>
	</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>

<script>
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


//编辑线路
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.confirm("确认修改吗 ？", function (){
	$.ajax({
	url : "/vst_back/biz/trafficLine/updateTrafficLine.do",
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


		
	
</script>
