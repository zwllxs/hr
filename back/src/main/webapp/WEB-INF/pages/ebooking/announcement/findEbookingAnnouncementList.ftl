<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">EBOOKING</a> &gt;</li>
            <li class="active">公告信息</li>
        </ul>
</div>
<div class="iframe_search">
	<form id="searchForm" action="/vst_back/ebooking/announcement/findEbookingAnnouncementList.do"  method="post">
		<table border="0" cellpadding="0" style="width:380px;">
			<tr>
				<td>
					<label>发布状态： 
						<select name="releaseResult" class="u3" id="releaseResult">
								<option value="">全部</option>
								<option value="RELEASED">已发布</option>
								<option value="UNRELEASED">未发布</option>
						</select>
					</label>
					<input type="hidden" id="selectReleaseResult" value="${releaseResult}">
				</td>
				<td>
					<input type="submit" class="u10 btn btn-small" value="查询">
					<input type="button" id="addA" class="u10 btn btn-small" value="新增"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
	                	<th>序列号</th>
	                    <th>标题</th>
	                	<th>发布人</th>
	                    <th>发布时间</th>	                    
	                    <th>创建时间</th>	                    
	                    <th>发布状态</th>	                    
	                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as announcement> 
						<tr>
							<td>${announcement.announcementId!''} </td>
							<td>${announcement.title!''} </td>
							<td>${announcement.operator!''} </td>
							<td>${announcement.beginDate?string("yyyy-MM-dd HH:mm:ss")} </td>
							<td>
			                	<#if announcement.createTime??>
			                		${announcement.createTime?string('yyyy-MM-dd HH:mm:ss')}
			                	</#if>								
							</td>
							<td>${announcement.releaseStatus!''} </td>
							<td>
								<a href="javascript:void(0);" class="update" data=${announcement.announcementId}>修改</a>
							</td>
						</tr>						
					</#list>
                </tbody>
            </table>
            <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
				<div class="paging" > 
					${pageParam.getPagination()}
				</div> 
			</#if>
	</div><!-- div p_box -->
</div>
<!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
<script type="text/javascript" src="/vst_back/js/ckeditor/ckeditor.js"></script>
</body>
</html>

<script>
	$(function(){
		var releaseResultVal = $("#selectReleaseResult").val();
		$("#releaseResult>option[value='"+releaseResultVal+"']").attr("selected","selected");
		
		//查询
		$("#search_button").click(function(){
			if(!$("#searchForm").validate().form()){
				return;
			}
			$("#searchForm").submit();
		});
		
		//跳转到新增公告信息页面
		$("#addA").bind("click",function(){
			var addAnn = new xDialog("/vst_back/ebooking/announcement/toAddEbkAnnouncementPage.do",{}, {title:"新增公告",width:800,ok:function(){
		       		if(!$("#addAnnouncement").validate().form()){
						return false;
					}
					$('#content').val(CKEDITOR.instances["contentA"].getData());
					$.ajax({
						url : "/vst_back/ebooking/announcement/addEbkAnnouncement.do",
						type : "post",
						data : $(".dialog #addAnnouncement").serialize(),
						success : function(result) {
							addAnn.close();
							$("#searchForm").submit();
						}
					});				
		     	},
	  			okValue:"保存"
		     });	 
		});	
		
		//跳转到修改公告信息页面
		$("a.update").bind("click",function(){
		     var announcementId = $(this).attr("data");
			 var updateUser = new xDialog("/vst_back/ebooking/announcement/toUpdateEbkAnnouncementPage.do",{announcementId:announcementId}, {title:"修改公告",width:800,ok:function(){
		       		if(!$("#updateAnnouncement").validate().form()){
						return false;
					}
					$('#content').val(CKEDITOR.instances["contentA"].getData());
					$.ajax({
						url : "/vst_back/ebooking/announcement/updateEbkAnnouncement.do",
						type : "post",
						data : $(".dialog #updateAnnouncement").serialize(),
						success : function(result) {
							if(result == "success"){
								$.alert('修改成功!');
								updateUser.close();
								$("#searchForm").submit();
							}else{
								$.alert('修改失败!');
							}		
						}
					});	
		     	},
	  			okValue:"保存"
		     });	 
		});			
	});
	
</script>
