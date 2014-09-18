<form id="dataForm">
        <table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label"><i class="cc1">*</i>所属行政区域：</td>
                    <td>
                   	    <input type="text" id="districtName" readonly="readonly" required=true>
                    	<input type="hidden" name="districtId" id="districtId">
                    </td>
                </tr> 
				<tr>
                	<td class="p_label"><i class="cc1">*</i>线路名称：
                	</td>
                    <td><input type="text" id="trafficName" name="trafficName" required=true>
                    
                    </td>
                </tr>
            </tbody>
        </table>
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

var destSelectDialog,otherDestSelectDialog;

//添加线路
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.ajax({
	url : "/vst_back/biz/trafficLine/addTrafficLine.do",
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


		
	
</script>
