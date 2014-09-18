<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div>
        <div class="iframe_content pd0">
            <div style="margin-bottom:0px;" class="p_box">
            	<form id="updateForm" method="post" action="/vst_back/prod/compship/productInformation/updateProductInformation.do">
                    <table class="e_table form-inline mt10">
                        <tbody>
                            <tr>
                                <td class="e_label">
                                	选择适用渠道：
									<input type="hidden" name="productId" value="${productId}"/>
									<input type="hidden" id="distributorName" value="${distributorName}"/>
									<input type="hidden" name="groupDateId" id="groupDateId" value="${groupDateId}"/>                                
                                </td>
								<#list distributors as distributor>
									<td>
										<label class="checkbox mr10">
											<input type="checkbox" name="saveIds" class="${distributor.distributorName}" value="${distributor.distributorId}"/>${distributor.distributorName}
										</label>
									</td>
								</#list>                                
                            </tr>
                            <tr>
                                <td colspan="6" class="e_label">出发日期：
                                   <input type="text" id="upDepartureDate" value="${prodGroupDate.departureDate}" name="departureDate" class="Wdate" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
	</div>	
</body>
</html>

<script>
	$(document).ready(function(){
		var distributorName = $('#distributorName').val();
   	    if(undefined!=distributorName&&distributorName.length>0){
			 var str = new Array();
			 str = distributorName.split(","); 
			 for(var i = 0;i<str.length;i++){
				$("input[name='saveIds']").each(function(){
			     	if($(this).attr('class')==str[i]){
			     		$(this).attr('checked','checked');
			     	}
				});		
			 }						
   	  	}			
	});
</script>
