<#include "/base/findDictInputType.ftl"/>
<form  id="dataForm">
    <table class="p_table form-inline">
        <tbody>
     		<tr> 
    			<input id="dictDefId" type="hidden" name="dictDefId" value="${dictDef.dictDefId!''}">
     		</tr>
            <tr>
            	<td class="p_label">字典定义ID：</td>
                <td>${dictDef.dictDefId!''}</td>
            </tr>
            <tr>
            	<td class="p_label"><span class="notnull">*</span>酒店名称：</td>
                <td><textarea  id="dictName" name="dictName" required=true style="width: 330px; height: 58px;" disabled></textarea></td>
            </tr>
            <!-- 字典属性list -->
        	<#assign index=0 />
            <#list dictPropDefList as dictPropDef>
            <tr>
                <td class="p_label"><#if dictPropDef.nullFlag == 'Y' && dictPropDef.cancelFlag=='Y'><span class="notnull">*</span></#if>${dictPropDef.dictPropDefName!''}：</td>
            	<td>
            	<input id="${dictPropDef.dictPropDefId}" type="hidden"/>
           			<!-- 开始通用组件 -->
		            <@displayHtml index dictPropDef />
		            <!-- 字典定义属性Id -->
                	<input id="dictPropDefId" type="hidden" name="dictPropList[${index}].dictPropDefId" value="${dictPropDef.dictPropDefId!''}">
                	<!--  字典定义Id -->
                	<input id="dictDefId" type="hidden" name="dictPropList[${index}].dictDefId" value="${dictDef.dictDefId!''}">
            	</td>
              
               </tr>
               <#assign index = index+1 />
			</#list> 
        </tbody>
    </table>
</form>

<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="addButton">保存</button>
<script>

//自动补全酒店字典回调函数
function fillHotelData(_id){
    if(null != _id){
       $.ajax({
			url : "/vst_back/biz/changeHotel/searchChangeHotelPropList.do",
			type : "post",
			dataType : 'json',
			data : {'dictId':_id},
			success : function(result) {
				$.each(result,function(k,data){  
				     if(50 != data.dictPropDefId)   
				     {
				         if(55 == data.dictPropDefId)
				         {
				            $("#"+data.dictPropDefId).next("textarea").text(data.dictPropValue);
				         }else if(54 == data.dictPropDefId){
				            $("#"+data.dictPropDefId).next("select").val(data.dictPropValue);
				         }else{
				         	$("#"+data.dictPropDefId).next("input").val(data.dictPropValue);
				         }
				     }
                  });     
			},
			error : function() {
				$("#addButton").removeAttr("disabled");
				loading.close();
				addChangeHotelDialog.close();
			}
		});
    }
}

//给产品ID赋值并设置为不可编辑
$("#50").next("input").val("${productId}");
$("#50").next("input").attr("readonly","readonly");

//给产品ID赋值并设置为不可编辑
var districtSelectDialog;
//选择行政区
$("#51").next("input").attr("readonly","readonly");
function onSelectDistrict(params){
	if(params!=null){
		$("#51").next("input").val(params.districtName);
		$("#districtId").val(params.districtId);
		$("#dictName").removeAttr("disabled");
		vst_pet_util.changeHotelListSuggest("#dictName",encodeURI(encodeURI(params.districtName)));
	}
	districtSelectDialog.close();
}

//打开选择行政区窗口
$("#51").next("input").click(function(){
	districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do?type=main",{},{title:"选择行政区",iframe:true,width:"850",height:"600"});
});


$("#addButton").bind("click",function(){
	$(this).attr("disabled","disabled");
	
	//验证
	if (!$("#dataForm").validate({
			rules : {
				dictDefName : {
					isChar : true
				},
				dictName : {
					isChar : true
				}
			},
			messages : {
				dictDefName : '不可输入特殊字符',
				dictName : '不可输入特殊字符'

			}
		}).form()) {
			$(this).removeAttr("disabled");
			return false;
		}

		//遮罩层
		var loading = pandora.loading("正在努力保存中...");

		$.ajax({
			url : "/vst_back/biz/changeHotel/addChangeHotel.do?branchId=${branchId}",
			type : "post",
			dataType : 'json',
			data : $("#dataForm").serialize(),
			success : function(result) {
			    loading.close();
				$("#addButton").removeAttr("disabled");
				if (result.code == "success") {
					$.alert(result.message);
					fillHotel(result.hotelId,result.hotelName,'Y');
					addChangeHotelDialog.close();
				} else {
					$.alert(result.message);
				}
			},
			error : function() {
				$("#addButton").removeAttr("disabled");
				loading.close();
				addChangeHotelDialog.close();
			}
		});

	});
</script>
