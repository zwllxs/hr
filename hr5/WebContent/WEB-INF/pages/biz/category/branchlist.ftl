<table class="p_table form-inline">
	<tr>
		<td  class=" operate mt10"><a class="btn btn_cc1" data="" id="addBranchButton">添加新规格</a></td>
	</tr>
</table>
<input type="hidden" name="categoryId" value="${categoryId}">
<table class="p_table table_center">
    <thead>
        <tr>
    	<th>编号</th>
        <th>规格名称</th>
		<th>规格类型</th>
		<th>规格代码</th>
		<th>状态</th>
        <th>操作</th>
       </tr>
    </thead>
    <tbody>
		<#list bizBranchs as bizBranch> 
		<tr>
		<td>${bizBranch.branchId!''} </td>
		<td>${bizBranch.branchName!''}</td>
		<td>${(bizBranch.attachFlag=='Y')?string("主规格", "次规格")}</td>
		<td>${bizBranch.branchCode!''}</td>
		<td>
			<#if bizBranch.cancelFlag == 'Y'>
				<span style="color:green" class="cancelProp">有效</span>
			<#else>
				<span style="color:red" class="cancelProp">无效</span>
			</#if> 
		</td>		
		<td class="oper">
            <a class="editSingleBranch" href="javascript:void(0);" data="${bizBranch.branchId!''}">编辑</a>
			<a class="editBranchProp" href="javascript:void(0);" data="${bizBranch.branchId!''}" data2="${bizBranch.branchName!''}">编辑属性</a>
            <a class="editBranchFlag" href="javascript:void(0);" data="${bizBranch.branchId!''}" data2="${bizBranch.cancelFlag}">${(bizBranch.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
        </td>					
		</tr>
		</#list>
    </tbody>
</table>
<script>

$().ready(function() {
	
$("#addBranchButton").bind("click",function(){
	var categoryId= $("input[name='categoryId']").val();
	var url = "/vst_back/biz/branch/showAddBranch.do?categoryId="+categoryId;
	dialog(url, "添加新规格", 600, "auto",function(){
	   if(!$("#dataForm").validate().form()){
				return false;
		}
        var resultCode;
		$.ajax({
			url : "/vst_back/biz/branch/addBranch.do",
			type : "post",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			dataType:'JSON',
			success : function(result) {
			    resultCode=result.code;
				confirmAndRefresh(result);
			}
		});
		if(resultCode !=='success') return false;
	},"保存");
});
	
//编辑
var dd;
$("a.editSingleBranch").bind("click",function(){
  var branchId=$(this).attr("data");
  var categoryId= $("input[name='categoryId']").val(); 
  var url = "/vst_back/biz/branch/showAddBranch.do?branchId="+branchId+"&categoryId=" +categoryId;
  
  dd = new xDialog(url,{},{title:"修改规格",width:"600",height:"auto",ok:function(){
  		if(!$("#dataForm").validate().form()){
			return false;
		}
		var resultCode; 
		$.confirm("确认修改吗 ？", function () {
			$.ajax({
				url : "/vst_back/biz/branch/updateBranch.do",
				type : "post",
				async: false,
				data : $("#dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
	   				 if(result.code=="success"){
						$.alert(result.message,function(){
							dd.close();
							branchListDialog.reload();
		   				});
					}else {
						$.alert(result.message);
			   		}
				}
			});
		});
		if(resultCode !=='success') return false;
  	},
  	okValue:"保存"
  }); 
});

//有效性修改
$("a.editBranchFlag").bind("click",function(){
	 var branchId=$(this).attr("data");
	 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	 var url = "/vst_back/biz/branch/editFlag.do?branchId="+branchId+"&cancelFlag="+cancelFlag+"&newDate"+new Date();
	 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		 $.get(url, function(result){
	          confirmAndRefresh(result);
	     });
     });
	 return false;
});

//编辑属性
$("a.editBranchProp").bind("click",function(){
    var categoryId=$("input[name='categoryId']").val();
    var branchId=$(this).attr("data");
	var branchName=$(this).attr("data2");
	var url = "/vst_back/biz/branchProp/findBranchPropsList.do?categoryId="+categoryId+"&branchId=" +branchId;
 	new xDialog(url,{},{title:"编辑规格属性:"+branchName,iframe:true,width:1200,height:700});	
	
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			branchListDialog.reload();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			//$.alert(result.message);
		}});
	}
};
  
});

</script>
