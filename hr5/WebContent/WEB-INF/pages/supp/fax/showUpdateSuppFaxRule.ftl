
<form id="dataForm">

    <tbody>
                <tr>
                      <td> <input type="hidden" name="supplierId" value="${suppFaxRule.supplierId!''}" > </td>
                      <td> <input type="hidden" name="faxRuleId" value="${suppFaxRule.faxRuleId!''}" > </td>
                </tr>
    </tbody>

    <table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label"><span class="notnull">*</span>品类：</td>
                    <td>     
                    <#if suppFaxRule.categoryId != null>
                   <input type="hidden" name="categoryId" value=${suppFaxRule.categoryId!''} readonly= "readonly">
                   ${suppFaxRule.categoryName!''}
                    </#if>
                    <#if suppFaxRule.categoryId == null>
                    <select name="categoryId" id="categoryId" required>
                    		<option value=""></option>
	                		<#list bizCategories as bizCategory>
                    		<option value="${bizCategory.categoryId!''}" code="${bizCategory.categoryCode!''}">${bizCategory.categoryName!''}</option>
                    		</#list>
                    </select>
                    </#if>
                    </td>
                    <td class="p_label"><span class="notnull">*</span>名称：</td>
                    <td>
                    	<input type="text" name="faxRuleName" id="faxRuleName" value=${suppFaxRule.faxRuleName!''} required>
                    </td>
                </tr> 
				<tr>
					<td class="p_label"><span class="notnull">*</span>传真号码：</td>
                    <td>
                    	<input type="text" name="fax" id="fax" value=${suppFaxRule.fax!''}>
                    </td>
                    <td class="p_label"><span class="notnull">*</span>发送时间：</td>
                    <td>
                    	<select name="sendTime" id="sendTime" required>
	                		<#list sendTimeList as sendTime>
	                    		<option <#if sendTime.code==suppFaxRule.sendTime>selected=selected </#if>value="${sendTime.code!''}" >${sendTime.cnName!''}</option>
	                        </#list>
                    	</select>
                    </td>
                </tr>
               
                <tr>
                    <td class="p_label"><span class="notnull">*</span>是否体现结算价：</td>
                    <td>
                    	<input type="radio" name="showSettleFlag" value="Y" <#if suppFaxRule.showSettleFlag =="Y"> checked="checked"</#if>
                    	>是&nbsp;&nbsp;&nbsp;
                    	<input type="radio" name="showSettleFlag" value="N"<#if suppFaxRule.showSettleFlag =="N"> checked="checked"</#if>>否
                    </td>
                    <td class="p_label">备注：</td>
                    <td>
                    	<textarea name="faxDesc" value=${suppFaxRule.faxDesc!''}>${suppFaxRule.faxDesc!''}</textarea>
                    </td>
                </tr>
                
                <tr>
                    <td class="p_label"><span class="notnull">*</span>传真联系人：</td>
                    <td colspan="3">
                     <div class="suppliersContacList">
                     <#list contactlist as contact> 
                        <span><input type='hidden' name='pids' value='${contact.personId}'>姓名：${contact.name} &nbsp;性别：<#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if>&nbsp;电话：${contact.tel}&nbsp;<a href= 'javascript:delContact("${contact.personId}");' id='a_${contact.personId}' class='delContact'>删除</a></span><br>
                     </#list>
                     </div>
              		 <a href="javascript:void(0);" class="suppliersContac" data=${suppFaxRule.supplierId}>添加传真联系人</a>             
                   </td>
                </tr>
                
            </tbody>
        </table>
</form>

<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>
<script>
var selectContactDialog;
var shtml;
// 传真联系人选择后的回调函数
function onSelectContact(params) {

if (params != null) {
        $('.suppliersContacList').empty();
	    shtml = '';
	    for(var i =0; i<params.length; i++){
	    shtml +="<span><input type='hidden' name='pids' value='"+params[i].personId+"'>姓名："+params[i].pname+"&nbsp;性别："+params[i].sex+"&nbsp;电话："+params[i].tel+"&nbsp;"+"<a href= 'javascript:delContact(\""+params[i].personId+"\");' id='a_"+params[i].personId+"' class='delContact'>"+"删除</a></span><br>";
        }
        $('.suppliersContacList').html(shtml);
}
	// 关闭财务联系人列表
	selectContactDialog.close();
}

var categoryChange = function(){
	if($("#dataForm #categoryId").find("option:selected").attr("code")=='category_hotel') {
		$("#dataForm #sendTime").attr("readonly","readonly");
		$("#dataForm #sendTime").val("IMMEDIATELY");
	} else {
		$("#dataForm #sendTime").removeAttr("readonly");
	}
}
$(function(){
	categoryChange();
	$("#dataForm #categoryId,#sendTime").bind("change",categoryChange);
});

function delContact(v)
{  
       var obj = $('#a_'+v).parent("span");
       obj.remove();     

 } 
 
$("a.suppliersContac").click(function() {
   var supplierId  = $(this).attr("data");
   var pids = $("*[name='pids']").map(function(){return $(this).val()}).get().join(",");
	selectContactDialog = new xDialog("/vst_back/supp/contact/suppliersContac.do", {"supplierId":supplierId,"pids":pids}, {
		title : "选择传真联系人",
		//iframe : true,
		scrolling:"yes",
		width : "1000"
	});
});  

		$("#editButton").bind("click",function(){
			//验证
			if(!$("#dataForm").validate({
			rules: {
				fax:{
					required : true,
					isFax : true
				}
			},
			messages: {
				fax:{
					required:'请输入传真号',
					isFax:'传真号不正确'
				}
			}
		}).form()){
				return;
			}
			$.ajax({
			url : "/vst_back/supp/fax/updateSuppFaxRule.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
				if(result.code=="success"){
			   			$.alert(result.message,function(){
				   				updateDialog.close();
				   				faxListDialog.reload();	
		   			});
			   		}else {
			   		  	$.alert(result.message);
			   		}
			   }
			});						
		});
		
</script>

