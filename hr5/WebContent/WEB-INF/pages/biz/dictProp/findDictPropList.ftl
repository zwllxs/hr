
<!-- 主要内容显示区域\\ -->
<div class="iframe-content  mt20">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            	<th>属性编号</th>
            	<th>业务字典ID</th>
            	<th>业务字典属性定义ID</th>
            	<th>业务字典定义ID</th>
            	<th>业务字典属性内容</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDictPropExtend>
				<tr>
					<td>${bizDictPropExtend.dictPropId!''} </td>
					<td>${bizDictPropExtend.dictId!''} </td>
					<td>${bizDictPropExtend.dictPropDefId!''} </td>
					<td>${bizDictPropExtend.dictDefId!''} </td>
					<td>${bizDictPropExtend.dictPropValue!''} </td>
				</tr>
			</#list>
        </tbody>
    </table>

	</div><!-- div p_box -->
	
	<div class="fl operate">
		<#if listCount == 0>
			<a class="btn btn_cc1" id="newDictProp" href="javascript:;" data="${dictId!''}" >新增</a>
		</#if>
		<a class="btn btn_cc1" id="editDictProp" href="javascript:;" data="${dictId!''}" >编辑</a>
	</div>
                    
</div>
<script>
$(function(){

//修改属性内容
$("#editDictProp").bind("click",function(){
    var dictId=$(this).attr("data");
	var url="/vst_back/biz/dictProp/showAddDictProp.do?dictId="+dictId+"&operFlag=UPDATE";
	new xDialog(url, {},{title:"修改属性内容",width:800, ok: function(){
		 //验证
		if(!$("#showAddDictPropForm").validate().form()){
			return false;
		}
		$.ajax({
			url : "/vst_back/biz/dictProp/updateDictProp.do",
			type : "post",
			data : $(".dialog #showAddDictPropForm").serialize(),
			dataType:'JSON',
			success : function(result) {
				confirmAndRefresh(result);
			}
		});
    }, okValue: "保存"});
});

//新增属性内容
$("#newDictProp").bind("click",function(){
	var dictId=$(this).attr("data");
    var url="/vst_back/biz/dictProp/showAddDictProp.do?dictId="+dictId+"&operFlag=ADD";
    
    new xDialog(url, {},{title:"新增属性内容",width:800, ok: function(){
	    //验证
		if(!$("#showAddDictPropForm").validate().form()){
			return false;
		}
		$.ajax({
			url : "/vst_back/biz/dictProp/addDictProp.do",
			type : "post",
			data : $(".dialog #showAddDictPropForm").serialize(),
			dataType:'JSON',
			success : function(result) {
			  dictPropListDialog.reload();
			}
		});
	}, okValue: "保存"});
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			$("#searchForm").submit();
		}});
	}
}
});

</script>

