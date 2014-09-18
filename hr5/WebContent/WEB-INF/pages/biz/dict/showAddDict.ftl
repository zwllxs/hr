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
            	<td class="p_label"><span class="notnull">*</span>字典定义名词：</td><td>${ dictDef.dictDefName !''}</td>
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
                <td><textarea  id="dictName" name="dictName" required=true style="width: 330px; height: 58px;"></textarea></td>
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
			url : "/vst_back/biz/dict/addDict.do",
			type : "post",
			dataType : 'json',
			data : $("#dataForm").serialize(),
			success : function(result) {
				$("#addButton").removeAttr("disabled");
				loading.close();
				if (result.code == "success") {
					$.alert(result.message);
					addShipCompanyDialog.close();
					window.location = "/vst_back/ship/shipCompany/findShipCompanyList.do";
				} else {
					$.alert(result.message);
				}
			},
			error : function() {
				$("#addButton").removeAttr("disabled");
				loading.close();
				addShipCompanyDialog.close();
			}
		});

	});
</script>
