
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
    <input type="hidden" name="dictId" id="dictId" value="${dictId}">
    <input type="hidden" name="dictDefId" id="dictDefId" value="${dictDefId}">
    <table class="p_table form-inline">
		<tr>
			<td  class=" operate mt10"><a class="btn btn_cc1" id="newButton">新增</a></td>
		</tr>
	</table>
	<table class="p_table table_center">
        <thead>
            <tr>
        	<th>编号</th>
            <th>属性定义名</th>
            <th>录入方式</th>
            <th>是否必填</th>
            <th>状态</th>
            <th>排序值</th>
            <th>说明文字</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDictProp> 
			<tr>
			<td>${bizDictProp.dictPropDefId!''} </td>
			<td>${bizDictProp.dictPropDefName!''} </td>
			<td>${bizDictProp.inputTypeCnName!''} </td>
			<td>${bizDictProp.nullFlag!''} </td>
			<td>
				<#if bizDictProp.cancelFlag == "Y"> 
				<span style="color:green" class="cancelProp">有效</span>
				<#else>
				<span style="color:red" class="cancelProp">无效</span>
				</#if>
			</td>
			<td>${bizDictProp.seq!''} </td>
			<td>${bizDictProp.propDesc!''} </td>
			<td class="oper">
                <a href="javascript:void(0);" class="editDictPropDef" data=${bizDictProp.dictPropDefId}>编辑属性</a>
                <a href="javascript:void(0);" class="editFlag" data1="${bizDictProp.dictPropDefId!''}" data2="${bizDictProp.cancelFlag}">${(bizDictProp.cancelFlag=='N')?string("设为有效", "设为无效")}</a>
            </td>
			</tr>
			</#list>
        </tbody>
    </table>
			 
	</div><!-- div p_box -->

</div><!-- //主要内容显示区域 -->

<script>
	//字典属性定义添加/修改dialog对象，不要重名
	var addDictPropDefDialog,updateDictPropDefDialog;
	
	$("#newButton").bind("click",function(){
		var dictDefId = $("#dictDefId").val();
		var url = "/vst_back/biz/dictPropDef/showAddDictPropDef.do";
		addDictPropDefDialog = new xDialog(url,{"dictDefId":dictDefId},{title:"添加属性定义",width:800});
	});
	
	$("a.editDictPropDef").bind("click",function(){
		var dictId = $("#dictId").val();
		var dictDefId = $("#dictDefId").val();
		var dictPropDefId = $(this).attr("data");
		var url = "/vst_back/biz/dictPropDef/showUpdateDictPropDef.do";
		updateDictPropDefDialog = new xDialog(url,{"dictDefId":dictDefId,"dictId":dictId,"dictPropDefId":dictPropDefId},{title:"修改属性定义",width:800});
	});
		
	//设置状态
	$("a.editFlag").bind("click",function(){
		 var dictPropDefId=$(this).attr("data1");
		 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
		 var url = "/vst_back/biz/dictPropDef/editDictPropDefFlag.do?dictPropDefId="+dictPropDefId+"&cancelFlag="+cancelFlag;
		 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
		 $.confirm(msg, function () { 
			 $.get(url, function(data){
				dictPropDefListDialog.reload();
		     });
	     });
	});
	
</script>
