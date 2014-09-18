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
            <li class="active">标签配置</li>
        </ul>
</div>
<div class="iframe_content">
    <div class="p_box box_info">
		<form method="post" action='/vst_back/biz/bizTag/findBizTagList.do' id="searchForm">
	        <table class="s_table">
	            <tbody>
	                <tr>
	                	<td class="s_label">小组名称：</td>
	                    <td class="w18">
	                    	<select name="tagGroup" id="tagGroup">
	                    		<option value="">全部</option>
	                    		<#list tagGroups as tagGroup>
	                    			<option value="${tagGroup.tagGroup}" <#if (bizTag.tagGroup == tagGroup.tagGroup)>selected</#if>>
	                    				${tagGroup.tagGroup}
	                    			</option>
	                    		</#list>
	                    	</select>
	                    </td>
	                 	<td class="s_label">标签名称：</td>
	                    <td class="w18">
	                    	<input type="hidden" id="selectTagName" value="${bizTag.tagName}"/>
	                        <select name="tagName" id="tagName">
	                    		<option value="">全部</option>
				        	</select>
	                    </td>
	                    <td class=" operate mt10">
		                   	<a class="btn btn_cc1" id="search_button">查询</a> 
	                    </td>
	                </tr>
	            </tbody>
	        </table>	
		</form>
	</div>
	<div align="right">
		<a class="btn btn_cc1" id="showAddBizTag">新增标签</a>
	</div>
<!-- 主要内容显示区域\\ -->
    <#if pageParam??>
	    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
		    <div class="p_box box_info">
		    	<table class="p_table table_center" style="margin-top: 10px;">
		            <thead>
		                <tr>
		                	<th width="80px">小组名称</th>
		                    <th>标签名称</th>
		                    <th>SEQ</th>
		                    <th width="350px">操作</th>
		                </tr>
		            </thead>
		            <tbody>
						<#list pageParam.items as bizTag> 
						<tr>
							<td>${bizTag.tagGroup!''}</td>
							<td>${bizTag.tagName!''}</td>
							<td>${bizTag.seq!''}</td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="showBizTag" data="${bizTag.tagId!''}">查看</a>
		                        <a href="javascript:void(0);" class="editBizTag" data="${bizTag.tagId!''}">修改</a>
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
<form id="selectTagNameForm">
</form>	
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	
	var showAddOrUpdate;
	$(function(){
		
		// 设置菜单
		$('.J_list',window.parent.document).find('li').eq(2).click();
		
		// 查询
		$('#search_button').bind('click',function(){
			$("#searchForm").submit();
		});
		
		// 跳转到新增页面
		$("#showAddBizTag").bind("click",function(){
			showAddOrUpdate = new xDialog("/vst_back/biz/bizTag/showSaveOrUpdateBizTag.do?",{},{title:"新增标签",iframe:true,width:800});
			return;
		});	
		
		// 跳转到修改页面
		$(".editBizTag").bind("click",function(){
			var tagId = $(this).attr('data');
			showAddOrUpdate = new xDialog("/vst_back/biz/bizTag/showSaveOrUpdateBizTag.do?tagId="+tagId,{},{title:"修改标签",iframe:true,width:800});
			return;
		});
		
		// 跳转到查看页面
		$(".showBizTag").bind("click",function(){
			var tagId = $(this).attr('data');
			showAddOrUpdate = new xDialog("/vst_back/biz/bizTag/findProdTagByTagId.do?tagId="+tagId+"&objectType=PROD_PRODUCT",{},{title:"标签关联的产品和商品",iframe:true,width:800,height:700});
			return;
		});	
		
		$('#tagGroup').bind('change',function(){
			findTagNameByGroup();
		});		
		
		findTagNameByGroup();		
	});
	
	// 查询
	function search(){
		$("#searchForm").submit();
	}
	
   // 创建表单元素
   function createItem(name,value){
 	   $("#selectTagNameForm").append('<input type=hidden name='+name+' value='+value+'>');
   }	
	
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
	
</script>


