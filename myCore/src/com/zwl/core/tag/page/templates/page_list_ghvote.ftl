
	   <#if rewrite>
	   	 <a href='${path}1${endWith}' title='跳到首页'>&laquo;首页</a>   
		 <a href='${path}${currentPageNo-1}${endWith}' title='跳到上一页'>上一页</a>   
	   <#else> 
		 <a href='?${url}pageNo=1' title='跳到首页'>&laquo;首页</a>   
		 <a href='?${url}pageNo=${currentPageNo-1}' title='跳到上一页'>上一页</a>     
	   </#if> 
		
		<#if 0<totalPageNum&&totalPageNum<=sect >
			 <#list 1..totalPageNum as i>
			 	<#if i == currentPageNo >
			 		<a class="selected">${i}</a>
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
		                   <a class="selected">${i}</a>
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
	   	  	 <a href='${path}${currentPageNo+1}${endWith}' title='跳到下一页'>下一页</a>  
			 <a href='${path}${totalPageNum}${endWith}' title='跳到最后一页'>尾页&raquo;</a>  
	    <#else> 
			 <a href='?${url}pageNo=${currentPageNo+1}' title='跳到下一页'>下一页</a>  
			 <a href='?${url}pageNo=${totalPageNum}' title='跳到最后一页'>尾页&raquo;</a>  
	    </#if> 
			
		 到第 
			<input name='pageNo' type='text' size='2' style='ime-mode:disabled'  onblur='gotoPage(this.value)'/>
			<#if rewrite>
		   	  	 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='${path}'+pageNo+'${endWith}';}}</script>
		    <#else> 
				 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='?${url}pageNo='+pageNo;}}</script> 
		    </#if> 
			
		 页
	</span>