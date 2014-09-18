<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_search">
		<form action="/vst_back/prod/compship/productInformation/addProductInformation.do" method="post" id="saveForm">
			<table class="s_table">
				<tr>
					<td class="qudao_t">
						适用渠道：
						<input type="hidden" name="productId" value="${productId}"/>
					</td>
					<#list distributors as distributor>
						<td>
							<div class="qudao_list h22">
								<label class="checkbox mr10">
									<input type="checkbox" name="saveIds" value="${distributor.distributorId}"/>${distributor.distributorName}
								</label>
							</div>
						</td>
					</#list>
				</tr>
				<tr>
					<td class="qudao_t">
						出发日期：
						<input type="hidden" name="productId" value="${productId}"/>
					</td>
 					<td class="w18"><input type="text" name="departureDate" id="departureDate" class="Wdate" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></td>							
					<td class="s_label">
						<button onclick="saveProdGroupdate();" class="btn btn-mini s_btn" type="button">确认新增</button>
					</td>
				</tr>			
			</table>
		</form>
	</div>
	<div class="iframe_content mt20">	
		<div class="p_box">
			<table class="s1_table form-inline" align="center">
				<thead>
					<tr>
						<th>出发日期</th>
						<th>适用渠道</th>
						<th>操作</th>
					</tr>
				</thead>
				<#list prodGroupDates as prodGroupDate>
					<tr>
						<td>${prodGroupDate.departureDate}</td>
						<td>${prodGroupDate.distributorName}</td>
						<td>
							<a href="javascript:;" onclick="showUpdate('${prodGroupDate.groupDateId}');">修改</a>
							<a href="javascript:;" onclick="deleteProdGroupDate('${prodGroupDate.groupDateId}');">删除</a>
						</td>	
					</tr>
				</#list>
			</table>
		</div>
	</div>
	<form id="searchForm" method="post" action="/vst_back/prod/compship/productInformation/showAddOrUpdateProductInformation.do">
		<input type="hidden" name="productId" id="productId" value="${productId}"/>
		<input type="hidden" name="categoryId" value="${categoryId}"/>
	</form>
	<#include "/base/foot.ftl"/>
</body>
</html>
	<script>
		function showUpdate(groupDateId){
		   var productId = $('#productId').val();
		   if(productId.length<=0){
		   	    alert('空!!');
		   	    return;
		   }
		   
		   new xDialog("/vst_back/prod/compship/productInformation/finProductInformationById.do",{"productId":productId,"groupDateId":groupDateId}, {title:"填写商品信息",width:800,cancel: true,ok:function(){
				
				var upDepartureDate = $("#updateForm :input[id='upDepartureDate']").val();
            	if(upDepartureDate.length<=0){
            		$.alert('请选择出发日期!!');
            		return false;
            	}
				
				var ids = '0';
				$("#updateForm :checkbox[name='saveIds']").each(function(){
					 if($(this).attr('checked')=='checked'){
					 	  ids = $(this).val();
					 }
				});
				if(ids=='0'){
					alert('请选择适用渠道!!');
					return false;
				}
				
				$.ajax({
					url : "/vst_back/prod/compship/productInformation/isProductGroupDateByDistId.do",
					type : "post",
					dataType:'JSON',
					data : $('#updateForm').serialize(),
					success : function(data) {
						if(data.code=="success"){
					   	  $.alert(data.message,function(){
							 searchProdGroupdate();
						  });						
						}else{
							$.alert(data.message,function(){
							   searchProdGroupdate();
						    });
				   		}	
					}
				});						
	     	},
			okValue:"确认"
	       });			
			
		}
		
		// 保存商品信息
		function saveProdGroupdate(){
			var departureDate = $('#departureDate').val();
        	if(departureDate.length<=0){
        		$.alert('请选择出发日期!!');
        		return;
        	}
        	
            var ids = '0';
	        $("input[name='saveIds']").each(function(){
			    if($(this).attr('checked')=='checked'){
			    	ids=$(this).val();
		    	}		
	        });
	        if(ids=='0'){
	            $.alert('请选择适用渠道!!');
	       		return false;
	        }	
		
			$.ajax({
				url : "/vst_back/prod/compship/productInformation/isProductGroupDateByDistId.do",
				type : "post",
				dataType:'JSON',
				async: false,
				data : $('#saveForm').serialize(),
				success : function(data) {
					if(data.code=="success"){
				   	  $.alert(data.message,function(){
						 searchProdGroupdate();
					  });						
					}else{
						$.alert(data.message,function(){
						   searchProdGroupdate();
					    });
			   		}				
				}
			});							
		}
		
		// 查询商品信息
		function searchProdGroupdate(){
			var productId = $('#productId').val();
			if(productId.length<=0){
				return;
			}
	   	    $('#hproductId',parent.document).val(productId);
	   	    var obj = $('#show7',parent.document); 
	   	    parent.showPage(obj);
		}
		
		function deleteProdGroupDate(groupDateId){
			var productId = $('#productId').val();
			if(productId.length<=0){
				return;
			}
			if(confirm("确认删除?")){
				$.ajax({
				url : "/vst_back/prod/compship/productInformation/deleteProductInformation.do",
				type : "post",
				dataType:'JSON',
				async: false,
				data : {groupDateId:groupDateId,productId:productId},
				success : function(data) {
					if(data.code=="success"){
				   	  $.alert(data.message,function(){
						 searchProdGroupdate();
					  });						
					}else{
					   $.alert(data.message);
			   		}
				}
			});	
		    }
		}
		
	</script>
