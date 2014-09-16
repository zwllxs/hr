<#--页眉-->
<#import "/base/spring.ftl" as spring/>
<#include "/base/head_meta.ftl"/>
<#import "/base/pagination.ftl" as pagination>
<!DOCTYPE html>
<html>
<head>
<title>订单管理-查看日志</title>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<style>
	td{
		word-break:keep-all;
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	td.container {
    	overflow : hidden;
	}
	td.container div {
	    height : 50px;
	    text-align : left;
	} 
</style> 
<#--页面导航-->
<div id="logResultList" class="divClass">
 <table class="p_table table_center" >
    <thead>
        <tr>
              <TR>
				<th style="width:10%;" nowrap="nowrap">创建时间</th>
				<th style="width:20%;" nowrap="nowrap">操作员</th>
				<th   nowrap="nowrap">操作内容</th>
				
			</TR>
        </tr>
    </thead>
    <tbody>
     
    	<#list logList  as log>
		    <TR>
		    <TD>${log.createTime?string('yyyy-MM-dd HH:mm:ss')} </TD>
			<TD>${log.operatorName!''}</TD>
			
			<TD class="container">
					<div class="container_info">
						${log.content!''}
					</div>
			
			</TD>
			</TR>
	   </#list>
   
                
              </tbody>
   <TR>
  <TD COLSPAN ="6">
	<#if pageParam.items?? &&  pageParam.items?size &gt; 0> 
	 	<@pagination.paging pageParam true "#logResultList"/>
	</#if>
  </TD>
  </TR>
</table>
</div>
<#--页脚-->
<#include "/base/foot.ftl"/>
</body>
</html>
<script type="text/javascript">

$(function (){
    var container = $(".container");
    container.bind("mouseenter mouseleave", function (e){
        var current = $(e.currentTarget);
        var overflow = current.css("overflow") === "visible" ? "hidden" : "visible";
        var height = current.find(".container_info").css("height") === "50px" ? "auto" : "50px";
        current.css("overflow", overflow);
        current.find(".container_info").css("height", height);
    });
});

         $("#closeLog").bind("click",function(){
         
         	showLogDialog.close();
         	/**
         	$("#logResult").css("display","none");
         	
         	$('html, body, .content').animate({scrollTop: 0}, 300);
         	*/ 
         });
 </script>
