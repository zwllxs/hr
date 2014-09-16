<form id="dataForm">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>区域名称：
                	</td>
                    <td><input type="text" name="districtName" required=true>
                    <div id="districtNameError"></div>
                    </td>
					<td class="p_label">上级区域：</td>
                    <td>
                   	    <input type="text" id="parentName" readonly="raedonly">
                    	<input type="hidden" name="parentId" id="parentId">
                    </td>
                </tr> 
				<tr>
                	<td class="p_label"><i class="cc1">*</i>区域级别：</td>
                    <td>
                    	<select name="districtType" required=true>
                    	<#list districtTypeList as districtType>
                    		<option value="${districtType.code!''}">${districtType.cnName!''}</option>
                    	</#list>		
                    	</select>
                    </td>
					<td class="p_label">英文名：</td>
                    <td>
                    	<input type="text" name="enName" >
                    </td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>拼音：</td>
                    <td>
                    	<input type="text" name="pinyin" required=true>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>简拼：</td>
                    <td colspan="3">
                    	<input type="text" name="shortPinyin" required=true>
                    </td>
                </tr>
                 <tr>
                    <td class="p_label">当地语言名：</td>
                    <td colspan="3" >
                    	<textarea rows=2 style="width: 350px" maxlength=200 name="localLang" ></textarea> 多个以逗号分隔
                    </td>
                </tr>
                <tr>
		            <td class="p_label">别名：</td>
		            <td colspan="3">
		            	<textarea name="districtAlias" rows="3"  maxlength="200" style="width:500px"></textarea>
		            	多个以“，”分开
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
		$("#parentName").val(params.districtName);
		$("#parentId").val(params.districtId);
	}
	districtSelectDialog.close();
}

//打开选择行政区窗口
$("#parentName").click(function(){
	districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});

//添加行政区
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.ajax({
	url : "/vst_back/biz/district/addDistrict.do",
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
