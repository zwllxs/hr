
<style>
	.notnull {color:red;}
</style>
<form  id="dataForm">
				<tbody>
                    <tr>
                    	<input name="productId" type="hidden" value ="${productId!''}">
                    </tr>
                 </tbody>
        <table class="p_table form-inline">
            <tbody>
           <#if noticeType != 'PRODUCT_GIFT' && noticeType != 'PRODUCT_RECOMMEND'>
                <tr>
                	<td class="s_label">类型<span class="notnull">*</span>：</td>
                       <td>
                    	<input type="radio" name="noticeType" value="PRODUCT_INTERNAL" required=true errorEle="noticeType"/>对内
                		<input type="radio" name="noticeType" value="PRODUCT_ALL" required=true errorEle="noticeType"/>全部
                		<div id="noticeTypeError"></div>
                    </td>
                 </tr>
           <#else>
                  <input type="hidden" name="noticeType" value="${noticeType}">      
           </#if>   
                 <tr>   
                	<td class="p_label">内容<span class="notnull">*</span>：</td>
                    <td><textarea class="w35 textWidth" name="content" maxlength=100 required></textarea></td>  
				 </tr>     
			<#if noticeType == 'PRODUCT_GIFT'>	 
				 <tr>   
                	<td class="p_label">提供方<span class="notnull">*</span>：</td>
                    <td>
                        <select name="suppSupplier" id="suppSupplier">
                           <#list suppSupplierList as suppSupplier> 
                              <option value="${suppSupplier.supplierId}">${suppSupplier.supplierName}</option> 
                           </#list>
                        </select>
                    </td>  
				 </tr>   
			</#if>          	    
                 <tr>
                    <td class="s_label">开始时间<span class="notnull">*</span>：</td>
                       <td>
                    	<input type="text" name="startTime" required id="d4321" onfocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" class="w35 Wdate"/>      			  
                    </td>
                 </tr>
                 <tr>   
                    <td class="s_label">结束时间<span class="notnull">*</span>：</td>
                       <td>
                    	<input class="w35 Wdate" type="text" name="endTime" id="d4322" class="Wdate" required onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})"/>               			  
                    </td>
                </tr>
                
             <#if noticeType == 'PRODUCT_GIFT'>	 
				 <tr>   
                	<td class="p_label">关联商品<span class="notnull">*</span>：</td>
                    <td>
                        <div id="noticeGoods" style="overflow:scroll;height: 280px;">
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
var type = '${noticeType}';
var productId = '${productId}';
if(type =='PRODUCT_GIFT')
{
              $.ajax({
					url : "/vst_back/goods/goods/findSuppGoodsJson.do",
					type : "post",
					async: false,
					data : {"supplierId":$("#suppSupplier").val(),"productId":productId},
					dataType:'JSON',
					success : fillData
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
        $.alert('请选择一个商品！');
        return false;
     }
     else
     {
       return true;
     }
}


var disflag = false;

		$("#save").bind("click",function(){
		      
		    if(disflag)
		    {
		       return;
		    }
			//验证
			if(!$("#dataForm").validate({
		          }).form()){
				return;
			}
			
			if(type =='PRODUCT_GIFT' && !checkSuppGoods()){
			   return;
			}
	
			$.ajax({
			url : "/vst_back/prod/productNotice/addProductNotice.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			   if(result.code=="success"){
			            disflag = true;
						$.alert(result.message,function(){
				   				addDialog.close();
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
			
	   function fillData(data){
	       $('#noticeGoods').empty();
	       var shtml='<input type="checkbox" id="ckAll" >&nbsp;全选<br>';
	       $.each(data,function(i,d){
	           shtml += "<span style='white-space:nowrap;'><input type='checkbox' name='gids'  value='"+d.goodsId+"' >"+"&nbsp;["+d.supplierName+"]&nbsp;"+"["+d.pbranchName+"]&nbsp;"+"["+(d.branchFlag =="Y"?"有效":"无效")+"]&nbsp;"+"["+d.branchName+"]&nbsp;"+"["+(d.goodsFlag =="Y"?"有效":"无效")+"]&nbsp;"+"["+d.goodsName+"]</span><br>";
	       });
	       $('#noticeGoods').html(shtml);
	       
	       $("#ckAll").bind("click",function(){
				  if($(this).attr("checked")=="checked")
				  {
				
					  $('input[name="gids"]').each(function(){
					         $(this).attr("checked",true);
					  });
				  }
				  else
				  {
				
				      $('input[name="gids"]').each(function(){
					         $(this).attr("checked",false);
					  });
				  }

            });
	   }		
	
	   $("#suppSupplier").change(function(){
	         $.ajax({
					url : "/vst_back/goods/goods/findSuppGoodsJson.do",
					type : "post",
					async: false,
					data : {"supplierId":$(this).val(),"productId":productId},
					dataType:'JSON',
					success : fillData
			});	   
	   });
</script>