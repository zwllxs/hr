 <div style="overflow-x:hide; overflow-y:scroll;height: 900px;" >
		<div class="iframe_header">
		        <ul class="iframe_nav">
		            <li>签证&gt;</li>
		            <li class="active">签证材料维护 &gt;</li>
		            <li class="active">签证材料明细</li>
		        </ul>
		</div>
		
		<div class="iframe_search" >
			<div class="title">
				<h2 class="f14">编辑签证材料明细</h2>
			</div>
			<div class="p_box box_info clearfix  mt10">
				<table class="p_table form-inline">
		            <tbody>
		                <tr>
		                	<td class="p_label" style="width:120px;">签证国家：</td>
		                	<td >
		                		 <span id="country">${bizVisaDoc.country}</span>
		                	</td>
		                	<td class="p_label" style="width:120px;">签证类型：</td>
		                	<td >
		                		 <span id="visaType">
			                		<#list vistTypeList as bizDict>
		                    			<#if bizVisaDoc.visaType==bizDict.dictId>${bizDict.dictName}</#if>
					  				</#list>
			                	</span>
		                	</td>
		                </tr>
		                <tr>
		                	<td class="p_label" style="width:120px;">送签城市：</td>
		                	<td >
		                		 <span id="city">
			                		<#list vistCityList as bizDict>
		                    			<#if bizVisaDoc.city==bizDict.dictId>${bizDict.dictName}</#if>
					  				</#list>
					  			</span>
		                	</td>
		                	<td class="p_label" style="width:120px;">所属人群：</td>
		                	<td >
		                		<#list occupTypeList as occupType>
				                	<#if occupType.code==bizVisaDocOccup.occupType>${occupType.cnName}</#if>
				                </#list>
		                	</td>
		                </tr>
		            </tbody>
		        </table>
			</div>
			<div class="p_box box_info clearfix  mt10">
				<table class="p_table table_center">
		            <thead>
	                    <tr>
	                	<#--<th>编号</th>-->
	                	<th width="100">材料名称</th>
	                	<th>材料要求</th>
	                    <th>关联材料</th>
	                    <th style="width:100px;">排序</th>
	                    <th style="width:200px;">操作</th>
	                    </tr>
	                </thead>
		            <tbody id="mark">
		            <#list bizVisaDocDetailList as item> 
		                <tr>
		                	<td>${item.title}</td>
		                	<td>${item.content}</td>
		                	<td>
		                		<#list item.bizVisaDetailTemplateList as templateItem>
		                			<a href="javascript:void(0);" onclick="delBizVisaDetailTemplate(this,${templateItem.templateId})" >${templateItem.templateName}<i class="e_icon icon-error"></i></a>
		                		</#list>
		                	</td>
		                	<td>${item.seq}</td>
		                	<td>
		                		<a href="javascript:void(0);" onclick="editBizVisaDocDetail(this,${item.detailId});" class="ml20">修改</a>
		                		<a href="javascript:void(0);" onclick="delBizVisaDocDetail(${item.detailId})" class="ml20">删除</a>
		                		<a href="javascript:void(0);" onclick="showUploadTemplate(${item.detailId})" class="ml20">上传文件</a>
		                	</td>
		                </tr>
		                </#list>
		            </tbody>
		        </table>
			</div>
			<form action="/visa/prodVisaDocument/saveVisaDocumentDetail.do" method="post" id="documentDetailForm">
				<input type="hidden" name="docId" value="${bizVisaDocOccup.docId}">
				<input type="hidden" name="occupId" value="${bizVisaDocOccup.occupId}">
				<input type="hidden" name="detailId" value="">
		            <table class="p_table form-inline">
			            <tbody>
			                <tr>
			                	<td class="p_label" style="width:120px;">材料名称<i class="cc1">（*）</i>：</td>
			                	<td >
			                		<input type="text" class="textWidth" name="title" maxlength="100" value="">
			                	</td>
			                </tr>
							<tr>
			                	<td class="p_label" style="width:120px;" >材料要求<i class="cc1">（*）</i>：</td>
			                    <td >
			                    	<textarea name="content" class="textWidth" maxlength="1000" style="width: 410px; height: 75px;" ></textarea>
			                    </td>
			                </tr>
			                <tr>
			                	<td class="p_label" style="width:120px;" >排序<i class="cc1">（*）</i>：</td>
			                    <td >
			                    	<input type="text" name="seq" maxlength="2" value="">
			                    	&nbsp;&nbsp;&nbsp;<span style="color:blue">签证材料的排序，用于网站前台展示的签证材料明细的排序</span>
			                    </td>
			                </tr>
			            </tbody>
			        </table>
			        <br/>
			        <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
			            <div class="fl operate"><a class="btn btn_cc1" id="save_visa_document_Detail">保存</a></div>
			        </div>
			</form>
		</div>
</div>
<script> 
	var visaDocumentDialog;
	var uploadTemplateDialog;
	$(document).ready(function(){
		$(".textWidth").each(function(){
			$(this).keyup(function() {
					vst_util.countLenth($(this));
			});
		});
		$("#save_visa_document_Detail").click(function(){
			
			if(!$("#documentDetailForm").validate({
				rules : {
					title: {
						required : true
					},
					content: {
						required : true
					},
					seq :{
						required : true,
						isInteger: true
					}
				}
			}).form()){
				return false;
			} 
			
		  var msg = '确认保存吗 ？';	
		  if(refreshSensitiveWord($("input[type='text'],textarea"))){
		 	 msg = '内容含有敏感词,是否继续?';
		  }
			$.confirm(msg,function(){
				loading = pandora.loading("正在努力保存中...");
				$.ajax({
					url : "/vst_back/visa/visaDoc/saveBizVisaDocDetail.do",
					type : "post",
					dataType : 'json',
					data : $("#documentDetailForm").serialize(),
					success : function(result) {
						loading.close();
						if(result.code=='success'){
					 		$.alert(result.message,function(){
					 			$("input[type=hidden][name=detailId]").val("");
								$("input[type=text][name=title]").val("");
								$("input[type=text][name=title]").next().remove();
								$("textarea[name=content]").val("");
								$("textarea[name=content]").next().remove();
								$("input[type=text][name=seq]").val("");
								$("#mark").empty();
								$(result.attributes.bizVisaDocDetailList).each(function(i){
								    $that =$(this);
								    var temp = "<tr><td>"+$that.attr('title')+"</td><td>"+$that.attr('content')+"</td><td>";
									$($that.attr('bizVisaDetailTemplateList')).each(function(i){
										temp = temp +"<a href='javascript:void(0);' onclick='delBizVisaDetailTemplate(this,"+$(this).attr('templateId')+")' >"+$(this).attr('templateName')+"<i class='e_icon icon-error'></i></a>";
									}); 
									temp = temp + "</td><td>"+$that.attr('seq')+"</td><td><a href='javascript:void(0);' onclick='editBizVisaDocDetail(this,"+$that.attr('detailId')+");' class='ml20'>修改</a><a href='javascript:void(0);' onclick='delBizVisaDocDetail("+$that.attr('detailId')+")' class='ml20'>删除</a><a href='javascript:void(0);' onclick='showUploadTemplate("+$that.attr('detailId')+")' class='ml20'>上传文件</a></td></tr>";
							 		$("#mark").append(temp);
							 	}); 
		   					});
					 	}else{
						 	$.alert(result.message);
					 	}
						
					}
				});
			
			});
			
		});
		
	});
	
	function showUploadTemplate(detailId){
		uploadTemplateDialog = 
		new xDialog("/vst_back/visa/visaDoc/showUploadTemplate.do",
		{"detailId":detailId},
		{title:"添加签证材料明细模板",width:400,height:200});
	}
	
	function editBizVisaDocDetail(obj,detailId){
		$("input[type=hidden][name=detailId]").val(detailId);
		$("input[type=text][name=title]").val($(obj).parents("tr").children("td:nth-child(1)").text());
		$("textarea[name=content]").val($(obj).parents("tr").children("td:nth-child(2)").text());
		$("input[type=text][name=seq]").val($(obj).parents("tr").children("td:nth-child(4)").text());
		refreshSensitiveWord($("input[type='text'],textarea"));
	}
	
	function delBizVisaDocDetail(detailId){
		 if(confirm('确定要删除此材料明细吗(删除此材料明细将会级联删除相应关联材料)'))
		 	$.ajax({
					url : "/vst_back/visa/visaDoc/delBizVisaDocDetail.do",
					type : "post",
					dataType : 'json',
					data : "detailId="+detailId,
					success : function(result) {
						if(result.code=='success'){
					 		$.alert(result.message,function(){
								$("#mark").empty();
								$(result.attributes.bizVisaDocDetailList).each(function(i){
								    $that =$(this);
								    var temp = "<tr><td>"+$that.attr('title')+"</td><td>"+$that.attr('content')+"</td><td>";
									$($that.attr('bizVisaDetailTemplateList')).each(function(i){
										temp = temp +"<a href='javascript:void(0);' onclick='delBizVisaDetailTemplate(this,"+$(this).attr('templateId')+")' >"+$(this).attr('templateName')+"<i class='e_icon icon-error'></i></a>";
									}); 
									temp = temp + "</td><td>"+$that.attr('seq')+"</td><td><a href='javascript:void(0);' onclick='editBizVisaDocDetail(this,"+$that.attr('detailId')+");' class='ml20'>修改</a><a href='javascript:void(0);' onclick='delBizVisaDocDetail("+$that.attr('detailId')+")' class='ml20'>删除</a><a href='javascript:void(0);' onclick='showUploadTemplate("+$that.attr('detailId')+")' class='ml20'>上传文件</a></td></tr>";
							 		$("#mark").append(temp);
							 	}); 
		   					});
					 	}else{
					 		$.alert(result.message);
					 	}
						
					}
				});
	}
	
	function delBizVisaDetailTemplate(obj,templateId){
		if(confirm('确定要删除此模板附件吗?'))
		 	$.ajax({
					url : "/vst_back/visa/visaDoc/delBizVisaDetailTemplate.do",
					type : "post",
					dataType : 'json',
					data : "templateId="+templateId,
					success : function(result) {
						if(result.code=='success'){
					 		$.alert(result.message,function(){
					 		  $(obj).remove();
					 		}); 
					 	}else{
					 		$.alert(result.message);
					 	}
						
					}
				});
	}
	refreshSensitiveWord($("input[type='text'],textarea"));
</script>
