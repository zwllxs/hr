	<span >
		<#if currentPageNo &gt; 1 >
		   <#if rewrite>
		   	 <a href='${path}1${endWith}' title='跳到首页'>首</a>   
			 <a href='${path}${currentPageNo-1}${endWith}' title='跳到上一页'>上</a>   
		   <#else> 
			 <a href='?${url}pageNo=1' title='跳到首页'>首</a>   
			 <a href='?${url}pageNo=${currentPageNo-1}' title='跳到上一页'>上</a>     
		   </#if> 
		</#if> 
		
		<#if 0<totalPageNum&&totalPageNum<=sect >
			 <#list 1..totalPageNum as i>
			 	<#if i == currentPageNo >
			 		<a style="background-color: #02c1de; color: #FFFFFF;" href="#">${i}</a>
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
		                   <a style="background-color: #02c1de; color: #FFFFFF;" href="#">${i}</a>
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
		
		<#if currentPageNo<totalPageNum>
			<#if rewrite>
		   	  	 <a href='${path}${currentPageNo+1}${endWith}' title='跳到下一页'>下</a>  
				 <a href='${path}${totalPageNum}${endWith}' title='跳到最后一页'>尾</a>  
		    <#else> 
				 <a href='?${url}pageNo=${currentPageNo+1}' title='跳到下一页'>下</a>  
				 <a href='?${url}pageNo=${totalPageNum}' title='跳到最后一页'>尾</a>  
		    </#if> 
		</#if> 
			
		 到第 
			<input name='pageNo' type='text' size='2' style='ime-mode:disabled'  class="tijian1_k3_right_k2_1"  onblur='gotoPage(this.value)'/>
			<#if rewrite>
		   	  	 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='${path}'+pageNo+'${endWith}';}}</script>
		    <#else> 
				 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='?${url}pageNo='+pageNo;}}</script> 
		    </#if> 
			
		 页
	</span>