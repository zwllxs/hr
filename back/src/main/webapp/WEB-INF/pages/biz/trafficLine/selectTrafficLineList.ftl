

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box" style="overflow:scroll;height: 300px;">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th>选择</th>
        	<th>线路编号</th>
            <th>线路名称</th>
            </tr>
        </thead>
        <tbody>
            <#if pageParam.items?size gt 0>
               <input type="hidden" id="linesize" value="${pageParam.items?size}"/>
            </#if>
			<#list pageParam.items as trafficLine> 
			<tr>
			<td>
				<input type="checkbox"  name="trafficId" value="${trafficLine.trafficId}">
			    <input type="hidden" name="trafficNameHide" value="${trafficLine.trafficName!''}">
			</td>
			<td>${trafficLine.trafficId!''} </td>
			<td>${trafficLine.trafficName!''} </td>
			</tr>
			</#list>
        </tbody>
    </table>
	</div><!--p_box-->
	
</div><!-- //主要内容显示区域 -->
<div class="operate"><a class="btn btn_cc1"  id="selectButton">确定</a></div>
<script>
var linesSize = $("#linesize").val();
if(linesSize == null || linesSize == 0)
{
  $(".p_box").css("overflow","hidden");
}
var strs = '${trafficIds}';
var arr = strs.split(',');
$('input[name="trafficId"]').each(function(){
     if($.inArray($(this).val(),arr)>-1)
     {
         $(this).attr("checked",true);
     } 
});

$("#selectButton").bind("click",function(){
     
     var lines = $('input[name="trafficId"]');
     var checkedlines = $('input[name="trafficId"]:checked');
     if(lines.size()==0){
        alert('请新增地铁线路！');
        return;
     }
     if(checkedlines.size()==0){
        alert('请选择地铁线路！');
        return;
     }
     var trafficIds = [];
     
     $('input[name="trafficId"]:checked').each(function(){  
             var obj = $(this).parent("td");
             var trafficLine = {};
             trafficLine.trafficId = $(this).val();
             trafficLine.trafficName = obj.find("input[name='trafficNameHide']").val();
             trafficIds.push(trafficLine);
     });
	 onSelectTrafficLine(trafficIds);

});
</script>


