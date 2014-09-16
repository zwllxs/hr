<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">标签与主题</a> &gt;</li>
            <li class="active">标签管理</li>
        </ul>
	</div>
 	<div class="price_tab">
        <ul class="J_tab ui_tab">   
            <li <#if prodTagVO.objectType=="PROD_PRODUCT" >class="active"</#if>>
            	<a href="javascript:;" name="tabChange" data=0>产品标签</a>
            </li>
            <li <#if prodTagVO.objectType=="SUPP_GOODS" >class="active"</#if>>
            	<a href="javascript:;" name="tabChange" data=1>商品标签</a>
            </li>
        </ul>
     </div>
	<div class="iframe_search">
		<#if prodTagVO.obejctType=="PROD_PRODUCT" >
			<span style="color:grey">提示：产品编号中可输入多个产品ID，ID间用“，”分隔，可同时查询多个产品</span>
		<#else>
			<span style="color:grey">提示：商品编号中可输入多个商品ID，ID间用“，”分隔，可同时查询多个商品</span>
		</#if>
		<form method="post" action='/vst_back/biz/prodTag/findProdTagList.do' id="searchForm">
			<input type="hidden" name="objectType" value="${prodTagVO.objectType}"/>
	        <table class="s_table">
	            <tbody>
					<tr>
	                	<td class="s_label">小组名称：</td>
	                    <td class="w18">
	                    	<select name="tagGroup" id="tagGroup">
	                    		<option value="">全部</option>
	                    		<#list tagGroups as tagGroup>
	                    			<option value="${tagGroup.tagGroup}" <#if (prodTagVO.tagGroup == tagGroup.tagGroup)>selected</#if>>
	                    				${tagGroup.tagGroup}
	                    			</option>
	                    		</#list>
	                    	</select>
	                    </td>
	                 	<td class="s_label">标签名称：</td>
	                    <td class="w18">
	                    	<input type="hidden" id="selectTagName" value="${prodTagVO.tagName}"/>
	                        <select name="tagName" id="tagName" >
	                    		<option value="">全部</option>
				        	</select>
	                    </td>
	                    <td class=" operate mt10">
	                    </td>
	                </tr>   
	                <#if prodTagVO.objectType=="PROD_PRODUCT" >        
						<tr>
		                	<td class="s_label">产品编号：</td>
		                    <td class="w18" colspan="4">
		                    	<textarea id="productIds" maxlength="500" class="textWidth" name="productIds" style="height:40px;width:500px;" required>${prodTagVO.productIds}</textarea>
		                    </td>
		                </tr>			
						<tr>
		                	<td class="s_label">品类：</td>
		                    <td class="w18">
		                    	<select name="categoryName" id="categoryName">
		                    		<option value="">全部</option>
		                    		<#list bizCategorys as bizCategory>
		                    			<#if bizCategory.categoryId=='6'>
			                    			<option value="${bizCategory.categoryId}" <#if (prodTagVO.categoryName == bizCategory.categoryId)>selected</#if>>
				                				邮轮组合产品
				                			</option>		                    			
		                    			<#else>
			                    			<option value="${bizCategory.categoryId}" <#if (prodTagVO.categoryName == bizCategory.categoryId)>selected</#if>>
				                				${bizCategory.categoryName}
				                			</option>		                    			
		                    			</#if>
		                    		</#list> 
		                    	</select>
		                    </td>
		                 	<td class="s_label">产品名称：</td>
		                    <td class="w18">
		                       	<input style="width:260px;" maxlength="100" id="productName" type="text" name="productName" value="${prodTagVO.productName}"/>
		                    </td>
		                    <td class="operate mt10">
			                   	&nbsp;<a class="btn btn_cc1" id="search_button">查询</a> 
		                    </td>
		                </tr>
		            <#else>
						<tr>
		                	<td class="s_label">商品编号：</td>
		                    <td class="w18" colspan="4">
		                    	<textarea id="suppGoodsIds" maxlength="500" class="textWidth" name="suppGoodsIds" style="height:40px;width:500px;" required>${prodTagVO.suppGoodsIds}</textarea>
		                    </td>
		                </tr>			
						<tr>
		                	<td class="s_label">品类：</td>
		                    <td class="w18" style="width:50px;">
		                    	<input type="radio" id="categoryName" name="categoryName" checked="checked" value="5"/><span>门票<span>
		                    </td>
		                 	<td class="s_label">商品名称：</td>
		                    <td class="w18">
		                       	<input style="width:260px; maxlength="20" id="goodsName" type="text" name="goodsName" value="${prodTagVO.goodsName}"/>
		                    </td>
		                    <td class="operate mt10">
			                   	&nbsp;<a class="btn btn_cc1" id="search_button">查询</a> 
		                    </td>
		                </tr>		            
	                </#if>               
	            </tbody>
	        </table>	
		</form>
		<#if pageParam??>
	    	<#if pageParam.items?? &&  pageParam.items?size &gt; 0>
				<div style="margin-top: 10px;" class="delProdTag">
					<a class="btn btn_cc1" href="javascript:void(0);" id="addProdTag">批量添加标签</a>
					<a class="btn btn_cc1" href="javascript:void(0);" id="delProdTag">批量删除标签</a>
				</div>         	  
				<!-- 主要内容显示区域\\ -->
				<div class="iframe-content">   
				    <div class="p_box">
					    <table class="p_table table_center" style="margin-top: 10px;">
		                    <tr>
								<#if prodTagVO.objectType=="PROD_PRODUCT" > 
									<th width="60">&nbsp;<input type="checkbox" class="selectAll"/></th>
									<th width="60">产品ID</th>
				                    <th width="300">产品名称</th>
				                    <th width="60">标签操作</th>
								<#else>
				                	<th width="60">
				                		<input type="checkbox" class="selectAll"/>
				                	</th>
									<th width="60">商品ID</th>
				                    <th width="300">商品名称</th>
				                    <th width="60">标签操作</th>
								</#if>
		                    </tr>
							<#list pageParam.items as item> 
								<tr>
									<#if prodTagVO.objectType=="PROD_PRODUCT" > 
										<td><input type="checkbox" value="${item.productId}" name="objectIds"/></td>
										<td>${item.productId}</td>
										<td>${item.productName}</td>
										<td>
											<a href="javascript:void(0);" class="add" data="${item.productId}" data1="${item.productName}">新增</a>										
											<a href="javascript:void(0);" data="${item.productId}" data1="${item.productName}" class="update">修改</a>										
										</td>
									<#else>
										<td><input type="checkbox" value="${item.suppGoodsId}" name="objectIds"/></td>
										<td>${item.suppGoodsId}</td>
										<td>
											<#if item.productName??>
												【${item.productName}】&nbsp;【${item.goodsName}】
											<#else>
												${item.goodsName}
											</#if>
										</td>
										<td>
											<a href="javascript:void(0);" class="add" data="${item.suppGoodsId}" data1="${item.goodsName}">新增</a>										
											<a href="javascript:void(0);" data="${item.suppGoodsId}" data1="${item.goodsName}" class="update">修改</a>												
										</td>								
									</#if>
								</tr>
							</#list>
       				 	</table>
				    </div><!-- div p_box -->
				</div>
				<!-- //主要内容显示区域 -->
				<#if pageParam.items?exists> 
					<div class="paging" > 
						${pageParam.getPagination()}
					</div> 
				</#if>
			<#else>
				<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
			</#if>
		</#if>		
    </div>
         
	<form id="showTag" method="post" action='/vst_back/biz/prodTag/showProdTagList.do'>
		<input type="hidden" name="objectType" id="objectType" value="${prodTagVO.objectType}"/>
	</form>
	
	<form id="selectTagNameForm">
	</form>	
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

	   // 创建表单元素
   function createItem(name,value){
 	   $("#selectTagNameForm").append('<input type=hidden name='+name+' value='+value+'>');
   }

	var updateDialog,addDialog,delDialog;
	
	$(function(){
	
		$(".textWidth[maxlength]").each(function(){
			var	maxlen = $(this).attr("maxlength");
			if(maxlen != null && maxlen != ''){
				var l = maxlen*12;
				if(l >= 700) {
					l = 500;
				} else if (l <= 200){
					l = 200;
				} else {
					l = 200;
				}
				$(this).width(l);
			}
			$(this).keyup(function() {
				vst_util.countLenth($(this));
			});
		});		
	
				// 设置菜单
		$('.J_list',window.parent.document).find('li').eq(1).click();
		
		// 查询
		$('#search_button').bind('click',function(){
			search();
		});
		
		//tab切换
		$("a[name=tabChange]").click(function(){
			if($(this).attr("data")==0){
				$(this).parent().next().removeClass();
				$(this).parent().addClass('active');
				$('#objectType').val('PROD_PRODUCT');
			}else {
				$(this).parent().prev().removeClass();
				$(this).parent().addClass('active');
				$('#objectType').val('SUPP_GOODS');
			}
			$('#showTag').submit();
		})
		
		// 批量添加标签
		$('#addProdTag').bind('click',function(){
			var size = $("input[type=checkbox][name=objectIds]:checked").size();
			if(size<=0){
				if($('#obejctType').val()=='SUPP_GOODS'){
					$.alert('请选择添加标签的商品');
				}else{
					$.alert('请选择添加标签的产品');
				}
				return false;
			}else{
				var objectType= $('#objectType').val();
				var title = '批量添加标签';			
				addDialog = new xDialog("/vst_back/biz/prodTag/showAddProdTag.do?objectType="+objectType,{},{title:title,width:800,heigh:700});
				return false;
			}				
		});
		
		// 批量删除标签
		$('#delProdTag').bind('click',function(){
			var size = $("input[type=checkbox][name=objectIds]:checked").size();
			if(size<=0){
				if($('#obejctType').val()=='SUPP_GOODS'){
					$.alert('请选择删除标签的商品');
				}else{
					$.alert('请选择删除标签的产品');
				}
				return false;
			}else{
				var title = '批量删除标签';
				var objectType= $('#objectType').val();
				delDialog = new xDialog("/vst_back/biz/prodTag/showDelProdTag.do?objectType="+objectType,{},{title:title,width:800,heigh:700});
				return false;
			}			
		});	
		
		// 新增
		$('.add').bind('click',function(){
			var objectId = $(this).attr('data');
			var objectName = $(this).attr('data1');
			var objectType= $('#objectType').val();
			var title = '为'+objectName+'新增标签';			
			addDialog = new xDialog("/vst_back/biz/prodTag/showAddProdTag.do?objectId="+objectId+"&objectType="+objectType,{},{title:title,width:800,heigh:700});
			return false;
		});			
		
		
		// 修改	
		$('.update').bind('click',function(){
			var objectType= $('#objectType').val();
			var objectId = $(this).attr('data');
			var objectName = $(this).attr('data1');
			var title = '为'+objectName+'修改标签';
			updateDialog = new xDialog("/vst_back/biz/prodTag/showUpdateProdTag.do?objectType="+objectType+"&objectId="+objectId,{},{title:title,width:800,heigh:700});
			return false;			
		});			
		
		
		// 全选与取消
		$('.selectAll').bind('click',function(){
			 if($(this).attr('checked')=='checked'){
				 $("input[type=checkbox][name=objectIds]").attr('checked',true);			 	
			 }else{
			 	 $("input[type=checkbox][name=objectIds]").attr('checked',false);
			 }
		});
		
		// 
		$('#tagGroup').bind('change',function(){
			findTagNameByGroup();
		});
		
		findTagNameByGroup();
	});
	
	// 根据小组名称查询标签
	function findTagNameByGroup(){
		var tagGroup = $('#tagGroup').val();
		var selectTagName = $('#selectTagName').val();
		$('#selectTagNameForm').empty();
		createItem('tagGroup',tagGroup);
		$.ajax({
			url : "/vst_back/biz/bizTag/findTagNameByGroup.do",
			type : "post",
			async: false,
			data : $("#selectTagNameForm").serialize(),
			success : function(result) {
				$('#tagName').empty();
				$('#tagName').append("<option value=\'\'>全部</option>");
				$.each(result,function(index,data){
					if(selectTagName==data.tagName){
						$('#tagName').append("<option selected value=\'"+data.tagName+"\'>"+data.tagName+"</option>");
					}else{
						$('#tagName').append("<option value=\'"+data.tagName+"\'>"+data.tagName+"</option>");
					}
				});
			},
			error : function(result) {
				$.alert(result.message);
			}
		});		
	}
	
	// 验证商品查询条件是否为空 
	function validateSuppGoods(){
		var flag = false;
		var tagGroup = $('#tagGroup').val();
		var tagName = $('#tagName').val();
		var suppGoodsIds = $('#suppGoodsIds').val();
		var goodsName = $('#goodsName').val();
		if($.trim(tagGroup).length>0){
			flag = true;
		}else if($.trim(tagName).length>0){
			flag = true;
		}else if($.trim(suppGoodsIds).length>0){
			flag = true;
		}else if($.trim(goodsName).length>0){
			flag = true;
		}else if($('#categoryName').attr('checked')=='checked'){
			flag = true;
		}
		return flag;
	}
	
	function search(){
		var objectType= $('#objectType').val();
		var obj = $('#searchForm');
		if(objectType=='PROD_PRODUCT'){
			obj.attr('action','/vst_back/biz/prodTag/findProdTagList.do');
		}else{
			// 验证商品查询条件是否为空
			var flag = validateSuppGoods();
			if(!flag){
				$.alert('查询条件不能为空');		
				return;
			}
			obj.attr('action','/vst_back/biz/prodTag/findSuppTagList.do');
		}
		obj.submit();	
	}
	
</script>


