
<style>
	.notnull {color:red;}
</style>
<form  id="dataForm">
				<tbody>
                    <tr>
                    	<input name="noticeId" type="hidden" value ="${productNotice.noticeId!''}">
                    	<input id="productId" type="hidden" value ="${productNotice.productId!''}">
                    	
                    </tr>
                 </tbody>
        <table class="p_table form-inline">
            <tbody>
              <#if noticeType != 'PRODUCT_GIFT' && noticeType != 'PRODUCT_RECOMMEND'>
                <tr>
                	<td class="s_label">类型<span class="notnull">*</span>：</td>
                       <td>
                       	<input type="hidden" name = "noticeType" value = "${productNotice.noticeType}"/>
                       	${productNotice.noticeTypeCN!''}
                    </td>
                 </tr>
              <#else>
                  <input type="hidden" name="noticeType" value="${noticeType}">      
              </#if>  
                 <tr>
                	<td class="p_label">内容<span class="notnull">*</span>：</td>
                    <td><textarea class="w35 textWidth" name="content" required maxlength=100 value="${productNotice.content!''}">${productNotice.content!''}</textarea></td>  
				 </tr>  
			 <#if noticeType == 'PRODUCT_GIFT'>	 
				 <tr>   
                	<td class="p_label">提供方<span class="notnull">*</span>：</td>
                    <td>
                        ${supplierName!''}
                    </td>  
				 </tr>   
			 </#if>               	    
                 <tr>
                    <td class="s_label">开始时间:</td>
                       <td>
                    	<input type="text" name="startTime" value="${productNotice.startTime?string("yyyy-MM-dd")}" id="d4321" onfocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" class="w35 Wdate" /> <span style="color:red">（不填,则默认当前日期）</span> 	         			  
                    </td>
                 </tr>
                 <tr>   
                    <td class="s_label">结束时间<span class="notnull">*</span>：</td>
                       <td>
                    	<input class="w35 Wdate" type="text" name="endTime" id="d4322" required value="${productNotice.endTime?string("yyyy-MM-dd")}"   class="Wdate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})"/>               			  
                    </td>
                </tr>
             <#if noticeType == 'PRODUCT_GIFT'>	 
				 <tr>   
                	<td class="p_label">关联商品<span class="notnull">*</span>：</td>
                    <td>
                        <div id="noticeGoods"  style="overflow:scroll;height: 280px;">
                            <#list contactlist as contact> 
                              <span><input type='checkbox' name='gids'  value='"+d.goodsId+"'>"+"&nbsp;["+d.supplierName+"]&nbsp;"+"["+d.pbranchName+"]&nbsp;"+"["+d.branchName+"]&nbsp;"+"["+d.goodsName+"]<br>";</span><br>
                            </#list>
                        </div>
                    </td>  
				 </tr>   
			 </#if> 
            </tbody>
        </table>
</form>
<br/>
<div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<script>
var supplierId = '${supplierId}';
var strs = '${gids}';
var type = '${noticeType}';
var productId = $("#productId").val();


function checkGoods(){
var arr = strs.split(',');
$('input[name="gids"]').each(function(){
     if($.inArray($(this).val(),arr)>-1)
     {
         $(this).attr("checked",true);
     } 
});

}

function checkSuppGoods()
{
     var checkNum = 0;
     $('input[name="gids"]').each(function(){
			if($(this).attr("checked")=="checked")
			{
			   checkNum++;
			}
	 });
     if(checkNum==0)
     {
        alert('请选择一个商品！');
        return false;
     }
     else
     {
       return true;
     }
}



function fillData(data){

if(strs!=null && strs!='')
{
	       $('#noticeGoods').empty();
	       var shtml='';
	       $.each(data,function(i,d){
	          shtml += "<span style='white-space:nowrap;'><input type='checkbox' name='gids'  value='"+d.goodsId+"' >"+"&nbsp;["+d.supplierName+"]&nbsp;"+"["+d.pbranchName+"]&nbsp;"+"["+(d.branchFlag=="Y"?"有效":"无效")+"]&nbsp;"+"["+d.branchName+"]&nbsp;"+"["+(d.goodsFlag=="Y"?"有效":"无效")+"]&nbsp;"+"["+d.goodsName+"]</span><br>";
	       });
	       $('#noticeGoods').html(shtml);
	       checkGoods();
	       }
}	
	   
if(type =='PRODUCT_GIFT' && supplierId !='')
{   	
	         $.ajax({
					url : "/vst_back/goods/goods/findSuppGoodsJson.do",
					type : "post",
					async: false,
					data : {"supplierId":supplierId,"productId":productId},
					dataType:'JSON',
					success : fillData
			});	   
}




		$("#save").bind("click",function(){
			//验证
			if(!$("#dataForm").validate({
		}).form()){
				return;
			}
			
			if(type =='PRODUCT_GIFT' && !checkSuppGoods()){
			   return;
			}
			
			$.ajax({
			url : "/vst_back/prod/productNotice/updateProductNotice.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			   if(result.code=="success"){
						$.alert(result.message,function(){
				   				updateDialog.close();
				   				location.reload();
		   			});
					}else {
						$.alert(result.message);
			   		}
			   }
			});						
		});
		
		$(".textWidth").keyup(function() {
				var wordsLenth = $(this).attr("maxlength") - $(this).val().length;
				$(this).siblings("#textWidthTip").remove();
				$(this).after("<span id = 'textWidthTip'>还能输入" + wordsLenth + "字</span>");
			});
		
</script>