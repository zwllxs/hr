<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
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
            <li class="active">主题管理</li>
        </ul>
</div>
<div class="iframe_content">
    <div class="p_box box_info">
		<form method="post" action='/vst_back/biz/bizSubject/findBizSubjectList.do' id="searchForm">
	        <table class="s_table">
	            <tbody>
	                <tr>
	                	<td class="s_label">主题类型：</td>
	                    <td class="w18">
	                    	<select name="subjectType">
	                    		<option value="">全部</option>
	                    		<#list subjectTypeList as type>
		                    		<option value="${type.code}" <#if (bizSubject.subjectType == type.code)>selected</#if>>
			                			${type.cnName}
			                		</option>	                    			
	                    		</#list> 	                    		
	                    	</select>
	                    </td>
	                 	<td class="s_label">主题名称：</td>
	                    <td class="w18">
	                       <input maxlength="50" id="subjectName" type="text" name="subjectName" value="<#if bizSubject??>${bizSubject.subjectName}</#if>"/>
	                    </td>
	                    <td class=" operate mt10">
	                    </td>
	                </tr>
	                <tr>
	                	<td class="s_label">是否标红：</td>
	                    <td class="w18">
	                    	<select name="redFlag">
	                    		<option value="">全部</option>
	                    		<option value="Y" <#if bizSubject?? && bizSubject.redFlag=='Y'>selected</#if> >是</option>
	                    		<option value="N" <#if bizSubject?? && bizSubject.redFlag=='N'>selected</#if> >否</option>
	                    	</select>
	                    </td>
	                 	<td class="s_label">是否有效：</td>
	                    <td class="w18">
	                    	<select name="cancelFlag">
	                    		<option value="">全部</option>
	                    		<option value="Y" <#if bizSubject?? && bizSubject.cancelFlag=='Y'>selected</#if> >有效</option>
	                    		<option value="N" <#if bizSubject?? && bizSubject.cancelFlag=='N'>selected</#if> >无效</option>
	                    	</select>	                       
	                    </td>
	                    <td class="operate mt10">
		                   	<a class="btn btn_cc1" id="search_button">查询</a> 
	                    </td>
	                </tr>	                
	            </tbody>
	        </table>	
		</form>
	</div>
	<div align="right">
		<a class="btn btn_cc1" id="showAddBizSubject">新增主题</a>
	</div>
<!-- 主要内容显示区域\\ -->
    <#if pageParam??>
	    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
		    <div class="p_box box_info">
		    	<table class="p_table table_center" style="margin-top: 10px;">
		            <thead>
		                <tr>
		                	<th width="60">主题ID</th>
		                    <th width="200">主题名称</th>
		                    <th width="200">主题拼音</th>
		                    <th width="100">类型</th>
		                    <th width="150">引用(品类产品)</th>
		                    <th width="90">引用次数</th>
		                    <th width="60">标红</th>
		                    <th width="60">状态</th>
		                    <th width="100">创建时间</th>
		                    <th width="100">更新时间</th>
		                    <th width="150">操作</th>
		                </tr>
		            </thead>
		            <tbody>
						<#list pageParam.items as bizSubject> 
						<tr>
							<td>${bizSubject.subjectId!''}</td>
							<td>${bizSubject.subjectName!''}</td>
							<td>${bizSubject.pinyin!''}</td>
							<td>${bizSubject.subjectTypeCn}</td>
							<td class="oper"><a href="javascript:void(0);" class="showProdProduct" data="${bizSubject.subjectId!''}">查看景点</a></td>
							<td>${bizSubject.count}</td>													
							<td>
								<#if bizSubject.redFlag=='Y'>
									是
								<#else>
									否
								</#if>
							</td>													
							<td>
								<#if bizSubject.cancelFlag == "Y"> 
									<span style="color:green" class="cancelProd">有效</span>
								<#else>
									<span style="color:red" class="cancelProd">无效</span>
								</#if>							
							</td>
							<td>
								${bizSubject.createTime?string('yyyy-MM-dd HH:mm:ss')}
							</td>
							<td>
								${bizSubject.updateTime?string('yyyy-MM-dd HH:mm:ss')}
							</td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="editBizSubject" data1="${bizSubject.subjectName!''}" data="${bizSubject.subjectId!''}">修改</a>
		                        <a href="javascript:void(0);" class="deleteBizSubject" data="${bizSubject.subjectId!''}">删除</a>
		                    </td>
						</tr>
						</#list>
		            </tbody>
		        </table>
				<#if pageParam.items?exists> 
					<div class="paging" > 
						${pageParam.getPagination()}
					</div> 
				</#if>
			</div><!-- div p_box -->
		<#else>
			<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关信息，重新输入相关条件查询！</div>
	    </#if>
    </#if>
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	
	var showAddOrUpdate,showProdProduct;
	
	$(function(){
		// 设置菜单
		$('.J_list',window.parent.document).find('li').eq(0).click();
		
		// 查询
		$('#search_button').bind('click',function(){
			$("#searchForm").submit();
		});
		
		// 跳转到新增页面
		$("#showAddBizSubject").bind("click",function(){
			showAddOrUpdate = new xDialog("/vst_back/biz/bizSubject/showSaveOrUpdateBizSubject.do?",{},{title:"新增主题",width:800,height:500});
			return;
		});	
		
		// 跳转到修改页面
		$(".editBizSubject").bind("click",function(){
			var subjectId = $(this).attr('data');
			var subjectName = $(this).attr('data1');
			var title = '修改主题-'+subjectName;
			showAddOrUpdate = new xDialog("/vst_back/biz/bizSubject/showSaveOrUpdateBizSubject.do?subjectId="+subjectId,{},{title:title,width:800,height:500});
			return;
		});
		
		// 删除主题信息
		$(".deleteBizSubject").bind("click",function(){
			var subjectId = $(this).attr('data');
			$.confirm('删除此主题则关联关系会同时删除,确认删除此主题',function(){
				$.ajax({
					url:'/vst_back/biz/bizSubject/deleteBizSubjectByReId.do',
					type:'POST',
					data:{subjectId:subjectId},
					success:function(result){
						if(result.code=='success'){
				 	 	 	 $.alert(result.message,function(){
				 	 	 	 	search();
				 	 	 	 });
				 	 	 }else{
							$.alert(result.message);			 	 	 
				 	 	 }
					}			
				});			
			});
			return;
		});
		
		// 	查看景点
		$(".showProdProduct").bind("click",function(){
			var subjectId = $(this).attr('data');
			showProdProduct = new xDialog("/vst_back/biz/bizSubject/showProdProduct.do?subjectId="+subjectId,{},{title:"主题管理的产品",width:800});
			return;
		});	
	});
	
	// 查询
	function search(){
		$("#searchForm").submit();
	}
	
</script>


