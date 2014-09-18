<#import "/base/pagination.ftl" as pagination>
<#--页面导航-->
<div id="logResultList" class="divClass">
 <table class="p_table table_center" >

  
    <thead>
        <tr>
              <TR>
				<th style="width:5%;" nowrap="nowrap">操作员</th>
				<th style="width:10%;" nowrap="nowrap">操作日期</th>
				<th style="width:20%;" nowrap="nowrap">状态变化</th>
				<th  style="width:30%;word-break: break-all;" nowrap="nowrap">备注</th>
				<th style="width:30%;" nowrap="nowrap">系统说明</th>
				
			</TR>
        </tr>
    </thead>
    <tbody>
     
    	<#list pageParam.items  as log>
		    <TR>
			<TD>${log.operatorName!''}</TD>
			<TD>${log.createTime?string('yyyy-MM-dd HH:mm:ss')} </TD>
			<TD>${log.logName!''}</TD>
			<TD style="text-align:left;">${log.memo!''}</TD>
			<TD style="text-align:left;">${log.content!''}</TD>
			
			
			</TR>
	   </#list>
   
                
              </tbody>
   <TR>
  <TD COLSPAN ="6">
   <@pagination.paging pageParam true "#logResultList"/>
  <#--分页标签
  <@pagination.paging pageParam>
 </@pagination.paging>
   
  -->

  </TD>
  </TR>
  <TR>
  <TD style="border-left:0;border-right:0;border-bottom:0;" COLSPAN ="6">
  	 <a class="btn btn_cc1" id="closeLog" >关闭</a>
  	
  </TD>
  </TR>
</table>
</div>
<script type="text/javascript">

         $("#closeLog").bind("click",function(){
         
         	showLogDialog.close();
         	/**
         	$("#logResult").css("display","none");
         	
         	$('html, body, .content').animate({scrollTop: 0}, 300);
         	*/ 
         });
 </script>
