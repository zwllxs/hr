<#include "/base/findDictInputType.ftl"/>
<form  id="dataForm">
    <input id="dictId" type="hidden" name="dictId" value="${bizDict.dictId!''}">
    <input id="dictDefId" type="hidden" name="dictDefId" value="${bizDict.dictDefId!''}">
    <input id="requestSource" type="hidden" name="requestSource" value="${requestSource!''}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
            	<td class="p_label">字典定义ID：</td>
                <td>${bizDict.dictDefId!''}</td>
            </tr>
            <tr>
            	<td class="p_label">字典定义：</td><td>${dictDef.dictDefName!''}</td>
            </tr>
             <tr>
				<td class="p_label">字典状态：</td>
                <td>
                	<select name="cancelFlag">
	                    <option value="Y" <#if bizDict.cancelFlag == 'Y'>selected</#if> >有效</option>
	                    <option value="N" <#if bizDict.cancelFlag == 'N'>selected</#if> >无效</option>
                	</select>
                </td>
            </tr>
            <tr>
            	<td class="p_label"><span class="notnull">*</span>字典名称：</td>
                <td><input type="text" name="dictName" id="dictName" required=true value="${bizDict.dictName!''}"></td>
            </tr>
             <tr>
            	 <td class="p_label">是否可补充：</td>
                <td> 
                	<select name="addFlag">
	                    <option value="Y" <#if bizDict.addFlag == 'Y'>selected</#if> >是</option>
	                    <option value="N" <#if bizDict.addFlag == 'N'>selected</#if> >否</option>
                	</select>
                 </td>
            </tr>
        	<!-- 字典属性list -->
        	<#assign index=0 />
            <#list dictPropDefList as dictPropDef>
            <tr>
                <td class="p_label"><#if dictPropDef.nullFlag == 'Y' && dictPropDef.cancelFlag=='Y'><span class="notnull">*</span></#if>${dictPropDef.dictPropDefName!''}：</td>
            	<td>
           			<!-- 开始通用组件 -->
		            <@displayHtml index dictPropDef />
                	 <!-- 字典定义属性Id -->
                	<input id="dictPropDefId" type="hidden" name="dictPropList[${index}].dictPropDefId" value="${dictPropDef.dictPropDefId!''}">
                	<!--  字典定义Id -->
                	<input id="dictDefId" type="hidden" name="dictPropList[${index}].dictDefId" value="${dictPropDef.dictDefId!''}">
                	<!-- 字典Id -->
        			<input id="dictId" type="hidden" name="dictPropList[${index}].dictId" value="${dictPropDef.bizDictProp.dictId!''}">
                	<!-- 字典属性Id -->
                	<input id="dictPropId" type="hidden" name="dictPropList[${index}].dictPropId" value="${dictPropDef.bizDictProp.dictPropId!''}"/>
            	</td>
              
               </tr>
               <#assign index = index+1 />
			</#list> 
        </tbody>
    </table>
</form>

<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>

<script>
$("#editButton").bind("click",function(){
	//验证
	if (!$("#dataForm").validate({
			rules : {
				dictName : {
					isChar : true
				}
			},
			messages : {
				dictName : '不可输入特殊字符'

			}
		}).form()) {
			$(this).removeAttr("disabled");
			return false;
		}
	
	$.confirm("确认修改吗 ？", function () {
		//验证
		$(this).attr("disabled","disabled");
		//遮罩层
		var loading = pandora.loading("正在努力保存中...");
		var requestSource = $("#requestSource").val();
		
		$.ajax({
			url : "/vst_back/biz/dict/updateDict.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			   if(result.code=="success"){
				   loading.close();
					$.alert(result.message,function(){
					if(requestSource == 'dict'){
						updateDialog.close();
						window.location = "/vst_back/biz/dict/findDictList.do";
					}else if(requestSource == 'shipCompany'){
						updateShipCompanyDialog.close();
						window.location = "/vst_back/ship/shipCompany/findShipCompanyList.do";
					}
	   			});
				}else {
					loading.close();
					$.alert(result.message);
		   		}
			   },
			   error : function() {
				   loading.close();
					$("#editButton").removeAttr("disabled");
					if(requestSource == 'dict'){
						updateDialog.close();
					}else if(requestSource == 'shipCompany'){
						updateShipCompanyDialog.close();
					}
				}
		});
	});
	
});
</script>
