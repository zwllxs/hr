<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_content">
    <div class="p_box box_info">
    	<form id="dataForm">
	        <table class="s_table" style="margin-top: 10px;">
	            <tbody>
	                <tr>
	                	<td class="s_label"  style="width:80px;">主题名称：</td>
	                    <td class="w18" style="width:200px;">
	                    	<input type="text" id="subjectName" name="subjectName" errorEle="code">
	                    	<input type="hidden" id="subjectId" name="subjectId">
	                    </td>
	                    <td class=" operate mt10" style="width:300px;">
		                   	<a class="btn btn_cc1" id="addProdSubject" name="addProdSubject" >新增主题</a>
		                   	<div id="codeError" style="display:inline"></div>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	     <form>
	</div>
<!-- 主要内容显示区域\\ -->
    <div class="p_box box_info">
    	<table class="p_table table_center" style="margin-top: 10px;">
            <thead>
                <tr>
                	<th width="40px">关联ID</th>
                    <th width="150px">主题名称</th>
                    <th width="30px">SEQ</th>
                    <th width="100px">操作</th>
                </tr>
            </thead>
            <#if prodSubjects?? && prodSubjects?size &gt; 0>
	            <tbody>
	            	<#assign i=0 />
					<#list prodSubjects as prodSubject> 
						<tr id="${prodSubject.reId}">
							<td>${prodSubject.reId!''}</td>
							<td>
								<#if prodSubject.bizSubject??>
									${prodSubject.bizSubject.subjectName!''}
								</#if>
							</td>
							<td>${prodSubject.seq!''}</td>							
							<td class="oper">
								<a class="btn btn_cc1 delete" data="${prodSubject.reId}">删除</a>
								<#if i &gt; 0>
									<a class="btn btn_cc1 setFirst" data="${prodSubject.reId}">设为第一主题</a>
								</#if>
		                    </td>
						</tr>
						<#assign i=i+1 />
					</#list>
	            </tbody>
            </#if>
        </table>
	</div><!-- div p_box -->
	<form id="searchForm" method="post" action="/vst_back/biz/prodSubject/findProdSubjectList.do">
		<input type="hidden" id="productId" name="productId" value="${prodSubject.productId}">
	</form>    
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	var categoryId = $('#categoryId',window.parent.document).val();
	vst_pet_util.searchBizSubject("#subjectName", "input[name=subjectId]", categoryId);
	
	$(function(){
		
		// 设置菜单
		
		
		// 新增主题
		$('#addProdSubject').bind('click',function(){
			var productId = $('#productId').val();
			var subjectId = $('#subjectId').val();

			//验证
			if(!$("#dataForm").validate({
				rules : {
					subjectName:{
						required : true
					}
				}
			}).form()){
				return false;
			}

			$.ajax({
				url:'/vst_back/biz/prodSubject/saveProdSubject.do',
				type:'post',
				data:{productId:productId,subjectId:subjectId},
				success:function(result){
					if(result.code=='success'){
			 	 	 	 $.alert(result.message,function(){
			 	 	 	 	 window.location.reload();
			 	 	 	 });
			 	 	 }else{
						$.alert(result.message);			 	 	 
			 	 	 }					
				}
			});			
					
		});
		
		
		// 设为第一主题
		$('.setFirst ').bind('click',function(){
			
			var oldTrObj = $('.table_center').find('tr').eq(1);
			var oldTrId = oldTrObj.attr('id'); // 原有第一主题ID
			
			var newTrObj = $(this);
			var newTrId = newTrObj.attr('data');// 新设第一主题ID
			
			$.ajax({
				url:'/vst_back/biz/prodSubject/updateProdSubjectSeq.do',
				type:'post',
				data:{firstReId:newTrId,oldReId:oldTrId},
				success:function(result){
					if(result.code=='success'){
			 	 	 	 $.alert(result.message,function(){
							 window.location.reload();			 	 	 	 	  
			 	 	 	 });
			 	 	 }else{
						$.alert(result.message);			 	 	 
			 	 	 }					
				}
			});				
		});
		
		// 删除
		$('.delete ').bind('click',function(){
			 var reId = $(this).attr('data');
			 $.confirm('删除确认',function(){
				$.ajax({
					url:'/vst_back/biz/prodSubject/deleteProdSubjectByReId.do',
					type:'post',
					data:{reId:reId},
					success:function(result){
						if(result.code=='success'){
				 	 	 	 $.alert(result.message,function(){
				 	 	 	 	$('#'+reId).remove();
				 	 	 	 });
				 	 	 }else{
							$.alert(result.message);			 	 	 
				 	 	 }					
					}
				});													 
			 });
		});	
		
		if($("#isView",parent.top.document).val()=='Y'){
			$("#addProdSubject,.setFirst,.delete").remove();
		}
	});
	
</script>


