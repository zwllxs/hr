<style>
	.notnull {color:red;}
</style>

<div>
 房型推荐级别<br/>
 操作
</div>
<form  id="dataForm">
				<tbody>
                    <tr>
                    	<input name="productId" type="hidden" value ="${productId!''}">
                    </tr>
                 </tbody>
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="s_label">修改房型推荐级别<span class="notnull">*</span>：</td>
                    <td>
                    	<select name="recommendLevel" required="">
	                    	<option value="5" selected="">5</option>
	                    	<option value="4">4</option>
	                    	<option value="3">3</option>
	                    	<option value="2">2</option>
	                    	<option value="1">1</option>
                       </select>
                    </td>
                    <td class="s_label">设置房型为无效<span class="notnull">*</span>：</td>
                    <td>
                    	<select name="cancelFlag" required="">
			                    <option value="N" >是</option>
			                    <option value="Y" selected="true">否</option>
                        </select>
                    </td>
                 </tr>
                 <!--
                 <tr>
                   <td><div><hr></div></td>
                 </tr>
                 -->
                 <tr>
                	<td  colspan="4">选择酒店房型<span class="notnull">*</span>
                	</td>
                 </tr>              	    
                 <tr>
                   <td colspan="4">
                   <div class="add_pf">
                	<#list ProdProductBranchs as branch>
                		<span class="INPUT_TYPE_CHECKBOX">     		
	            			<input type="checkbox" name="ids"
	            			 errorele="ids" value="${branch.productBranchId}"
	            			 required=""><span>${branch.branchName}</span>
	                	<!--<span style="color:grey"></span>-->
                        </span>
	                </#list>
	                <div id="idsError" style="display:inline"></div>
                   </div>
                   </td>
                 </tr>
            </tbody>
        </table>
</form>
<br/>
<div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="save">确认保存</a></div>
</div>

<script>

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
	
			$.ajax({
			url : "/vst_back/goods/house/updateHouseType.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			   if(result.code=="success"){
			            disflag = true;
						$.alert(result.message,function(){
				   				houseTypeDialog.close();
				   				//location.reload();
		   			});
					}else {
						$.alert(result.message);
			   		}
			   }
			});						
		});
				
</script>