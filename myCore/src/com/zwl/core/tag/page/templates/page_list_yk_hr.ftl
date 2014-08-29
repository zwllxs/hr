<style>
	.page_fl{padding-left:8px; padding-right:2px;}
</style>
 
<div class="badoo">
	  
   <#if rewrite>
	 <a href='${path}${currentPageNo-1}${endWith}' title='跳到上一页'> < 上一页</a>   
	 <a href='${path}1${endWith}' class="page_fl" title='跳到首页'>首页</a>   
   <#else> 
	 <a href='?${url}pageNo=${currentPageNo-1}'  title='跳到上一页'> < 上一页</a>   
	 <a href='?${url}pageNo=1' class="page_fl" title='跳到首页'>首页</a>     
   </#if> 
	
	<#if 0<totalPageNum&&totalPageNum<=sect >
		 <#list 1..totalPageNum as i>
		 	<#if i == currentPageNo >
		 		<span class="current">${i}</span>
		 	<#else>
			 	<#if rewrite>
			   	  <a href='${path}${i}${endWith}'>${i}</a>  
			    <#else> 
				  <a href='?${url}pageNo=${i}'>${i}</a>  
			    </#if> 
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
	                    <#if rewrite>
					   	  <a href='${path}${i}${endWith}'>${i}</a>  
					    <#else> 
						  <a href='?${url}pageNo=${i}'>${i}</a>  
					    </#if> 
	                </#if> 
                </#if> 
	 		 <#else>
	 		 	<#break> 
	 		 </#if> 
	 	 </#list>
	</#if> 
	
	<#if rewrite>
		 <a href="${path}${totalPageNum}${endWith}" title='跳到尾页' class="page_fl">尾页</a>
   	  	 <a href='${path}${currentPageNo+1}${endWith}' title='跳到下一页'>下一页  > </a>  
    <#else> 
    	 <a href='?${url}pageNo=${totalPageNum}' title='跳到尾页' class="page_fl" title='跳到最后一页'>尾页</a>  
		 <a href='?${url}pageNo=${currentPageNo+1}' title='跳到下一页'>下一页  > </a>  
    </#if> 
</div>