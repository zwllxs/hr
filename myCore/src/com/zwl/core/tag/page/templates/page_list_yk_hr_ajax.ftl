<style>
	.page_fl{padding-left:8px; padding-right:2px;}
	.badoo a{cursor:pointer;}
</style>

<div class="badoo">
	  
	 <#if currentPageNo==1 > 
	 	 <a title='跳到上一页'> < 上一页</a>   
	 <#else>
		 <a onclick="${function}('${action}',${currentPageNo-1})" title='跳到上一页'> < 上一页</a>   
	 </#if> 
	
	
	 <a onclick="${function}('${action}',1);" class="page_fl" title='跳到首页'>首页</a>        
	
	<#if 0<totalPageNum&&totalPageNum<=sect >
		 <#list 1..totalPageNum as i>
		 	<#if i == currentPageNo >
		 		<span class="current">${i}</span>
		 	<#else>
				<a onclick="${function}('${action}',${i})">${i}</a>  
		 	</#if> 
		 </#list>
	<#else> 
		 <#assign n=(currentPageNo/sect)?int> 
	 	 <#list (n*sect)..((n+1)*sect) as i>
	 		 <#if i <= totalPageNum >
	 		 	<#if i!=0>
					<#if i == currentPageNo>
	                   <span class="current">${i}</span>
	                <#else> 
					   <a onclick="${function}('${action}',${i})">${i}</a>  
	                </#if> 
                </#if> 
	 		 <#else>
	 		 	<#break> 
	 		 </#if> 
	 	 </#list>
	</#if> 
	
	 <a onclick="${function}('${action}',${totalPageNum})" title='跳到尾页' class="page_fl" title='跳到最后一页'>尾页</a>  
	 
	 <#if currentPageNo==totalPageNum >
	 	<a title='跳到下一页'>下一页  > </a>  
	 <#else>
	 	<a onclick="${function}('${action}',${currentPageNo+1})" title='跳到下一页'>下一页  > </a>
	 </#if> 
</div>