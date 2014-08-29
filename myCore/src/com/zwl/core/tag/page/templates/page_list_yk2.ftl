<Div class="tij_pages">
	
	<#if currentPageNo &gt; 1 >
	   <#if rewrite>
	   	 <a class="tij_pages_k3_3"  style="margin-right:5px;" href='${path}1${endWith}' title='跳到首页'>首页</a>   
		 <a class="tij_pages_k3_2" href='${path}${currentPageNo-1}${endWith}' title='跳到上一页'>上一页</a>  
	   <#else> 
		 <a class="tij_pages_k3_3"  style="margin-right:5px;" href='?${url}pageNo=1' title='跳到首页'>首页</a>   
		 <a class="tij_pages_k3_2" href='?${url}pageNo=${currentPageNo-1}' title='跳到上一页'>上一页</a>  
	   </#if> 
	</#if> 
	
	<#if 0<totalPageNum&&totalPageNum<=sect >
		 <#list 1..totalPageNum as i>
		 	<#if i == currentPageNo >
		 		<a class="tij_pages_k1" style="background-color: #FF0024;color: #FFFFFF;">${i}</a>
		 	<#else>
		 		<#if rewrite>
			   		<a class="tij_pages_k1" href='${path}${i}${endWith}'>${i}</a>  
			    <#else> 
					<a class="tij_pages_k1" href='?${url}pageNo=${i}'>${i}</a>  
			    </#if> 
		 	</#if> 
		 </#list>
	<#else> 
		 <#assign n=(currentPageNo/sect)?int> 
	 	 <#list (n*sect)..((n+1)*sect) as i>
	 		 <#if i <= totalPageNum >
	 		 	<#if i!=0>
					<#if i == currentPageNo>
	                 	<a class="tij_pages_k1" style="background-color: #FF0024;color: #FFFFFF;">${i}</a>
	                <#else> 
	                    <#if rewrite>
					   		 <a class="tij_pages_k1" href='${path}${i}${endWith}'>${i}</a> 
					    <#else> 
							 <a class="tij_pages_k1" href='?${url}pageNo=${i}'>${i}</a> 
					    </#if> 
	                </#if> 
                </#if> 
	 		 <#else>
	 		 	<#break> 
	 		 </#if> 
	 	 </#list>
	</#if> 
	
	<#if currentPageNo<totalPageNum>
		<#if rewrite>
	   		 <a class="tij_pages_k3" href='${path}${currentPageNo+1}${endWith}' title='跳到下一页'>下一页</a>  
			 <a class="tij_pages_k3_3" href='${path}${totalPageNum}${endWith}' title='跳到最后一页'>尾页</a>
	    <#else> 
			 <a class="tij_pages_k3" href='?${url}pageNo=${currentPageNo+1}' title='跳到下一页'>下一页</a>  
			 <a class="tij_pages_k3_3" style="margin-right:5px;"  href='?${url}pageNo=${totalPageNum}' title='跳到最后一页'>尾页</a>
	    </#if> 
	</#if> 
	共${totalPageNum}页	
	
	 到第 
		<input name='pageNo' type='text' size='2'  class="tij_pages_k2" onblur='gotoPage(this.value)'/>
		<#if rewrite>
	   	  	 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='${path}'+pageNo+'${endWith}';}}</script>
	    <#else> 
			 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='?${url}pageNo='+pageNo;}}</script> 
	    </#if> 
	 页
</Div>  