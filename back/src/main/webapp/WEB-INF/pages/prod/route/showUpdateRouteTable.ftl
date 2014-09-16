<#if r?exists>
<#else>
	<#assign r = route />
	<#assign r_index = 0/>
</#if> 
<tr>
	<td > 
		 <table style="margin-top: 5px;" class="e_table form-inline">
		<tr>
        	<td class="e_label"><span class="notnull">*</span>
        		第 <span name="nDay">${r_index+1}</span> 天 ：
        		<input type="hidden" class="nDay" name="prodLineRouteDetailList[${r_index}].nDay" value="${(r.nDay??)?string(r.nDay,r_index+1)}">
        	</td>
            <td>
            	<label><input type="text" class="w35 title" style="width:700px" name="prodLineRouteDetailList[${r_index}].title"  value="${r.title}" required=true maxlength="250">&nbsp;</label>
            </td>
        </tr>
		<tr>
        	<td class="e_label"><span class="notnull">*</span>行   程：</td>
            <td>
            	<label> 
            		<textarea maxlength="1000" class="content"  required=true  name="prodLineRouteDetailList[${r_index}].content" rows="10" style="width:700px" >${r.content}</textarea>
            	</label> 
            	<div id="productNameError"></div>
            </td>
        </tr>
       	<tr>
			<td class="e_label">住   宿：</td>
			<td> 
				<#if r.stayType??>
					<input type="radio" checked="checked" value="yes" class="zhusu" name="zhusu{index}"/>含住宿
					<input type="radio" value="no" class="zhusu" name="zhusu{index}"/>不含住宿				
					<select class="stayType${r_index}" name="prodLineRouteDetailList[${r_index}].stayType">
	                    <#list hotelStarList as hotel>
	                		<option value='${hotel.dictId}' ${(hotel.dictId == r.stayType )?string('selected=\"selected\"','')}>${hotel.dictName}</option>
		                </#list>
	                </select>
	                <input class="stayDesc${r_index}" maxlength="25" name="prodLineRouteDetailList[${r_index}].stayDesc" value="${r.stayDesc}" type="text" > 注，文本框里面可输入具体酒店等内容
				<#else>
					<input type="radio" value="yes" class="zhusu" name="zhusu{index}"/>含住宿
					<input type="radio" checked="checked" class="zhusu" value="no" name="zhusu{index}"/>不含住宿						
					<select class="stayType${r_index}" disabled="disabled"  name="prodLineRouteDetailList[${r_index}].stayType">
	                    <#list hotelStarList as hotel>
	                		<option value='${hotel.dictId}' ${(hotel.dictId == r.stayType )?string('selected=\"selected\"','')}>${hotel.dictName}</option>
		                </#list>
	                </select>
	                <input class="stayDesc${r_index}" disabled="disabled" maxlength="25" name="prodLineRouteDetailList[${r_index}].stayDesc" value="${r.stayDesc}" type="text" > 注，文本框里面可输入具体酒店等内容
				</#if>
			</td>
        </tr>
       	<tr>
			<td class="e_label">用   餐：</td>
			<td>
				 <input type="checkbox" ${(r.breakfastFlag =='Y')?string('checked=\"checked\"','')} class="breakfastFlag" value="Y" name="prodLineRouteDetailList[${r_index}].breakfastFlag"/>
				  早餐<input type="text" <#if r.breakfastFlag!='Y'>disabled="disabled"</#if> class="breakfastDesc"  value="${r.breakfastDesc}" maxlength="25" name="prodLineRouteDetailList[${r_index}].breakfastDesc"> &nbsp;
				  
				  <input type="checkbox" ${(r.lunchFlag =='Y')?string('checked=\"checked\"','')}  class="lunchFlag"  value="Y" name="prodLineRouteDetailList[${r_index}].lunchFlag"/>
				  中餐<input <#if r.lunchFlag!='Y'>disabled="disabled"</#if> type="text"  class="lunchDesc"  value="${r.lunchDesc}" maxlength="25"  name="prodLineRouteDetailList[${r_index}].lunchDesc"> &nbsp;
				  
				  <input type="checkbox" ${(r.dinnerFlag =='Y')?string('checked=\"checked\"','')}  class="dinnerFlag"  value="Y" name="prodLineRouteDetailList[${r_index}].dinnerFlag"/>
				  晚餐<input <#if r.dinnerFlag!='Y'>disabled="disabled"</#if> type="text"  class="dinnerDesc"  value="${r.dinnerDesc}" maxlength="25" name="prodLineRouteDetailList[${r_index}].dinnerDesc"> &nbsp;
           	</td>
        </tr>
       	<tr>
			<td class="e_label">交   通：</td>
			<td>
				<#list trafficList as t>
					 <input class="trafficType" ${(r.trafficType??&&r.trafficType?index_of(t.code)!=-1)?string('checked=\"checked\"','')}  type="checkbox" name="prodLineRouteDetailList[${r_index}].trafficType"  value='${t.code}'/>${t.cnName}&nbsp;
                </#list> 
                <#if r.trafficType=='OTHERS'>
                	<input type="text" maxlength="25" class="trafficOther"  value="${r.trafficOther}"  name="prodLineRouteDetailList[${r_index}].trafficOther"  >	
				<#else>
					<input type="text" disabled="disabled" maxlength="25" class="trafficOther"  value="${r.trafficOther}"  name="prodLineRouteDetailList[${r_index}].trafficOther"  >
                </#if>
           	</td>
        </tr>
       	<tr style="border-bottom: dashed 1px #D9D9D9 ; ">
       		<td class="e_label"> </td>
			<td  style="float:right;">
				 <input type="button" onclick="delTr2($(this))" data1="${r.routeId}" data="${r.detailId}" name='delBtn'  value="删除">
				 <input type="button" onclick="addTr2('editTable', -7)" value="插入一天">
           	</td>
        </tr> 
        </table>
	</td>
</tr>