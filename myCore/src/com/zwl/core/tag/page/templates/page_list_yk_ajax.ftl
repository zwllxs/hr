	<span >
		<#if currentPageNo &gt; 1 >
			 <a href="#" onclick="${function}('${action}',1);" title='跳到首页'>首</a>   
			 <a href="#" onclick="${function}('${action}',${currentPageNo-1})" title='跳到上一页'>上</a>     
		</#if> 
		
		<#if 0<totalPageNum&&totalPageNum<=sect >
			 <#list 1..totalPageNum as i>
			 	<#if i == currentPageNo >
			 		<a href="#" style="background-color: #02c1de; color: #FFFFFF;" href="#">${i}</a>
			 	<#else>
			 		<a href="#" onclick="${function}('${action}',${i})">${i}</a>  
			 	</#if> 
			 </#list>
		<#else> 
			 <#assign n=(currentPageNo/sect)?int> 
		 	 <#list (n*sect)..((n+1)*sect) as i>
		 		 <#if i <= totalPageNum >
		 		 	<#if i!=0>
						<#if i == currentPageNo>
		                   <a href="#" style="background-color: #02c1de; color: #FFFFFF;" href="#">${i}</a>
		                <#else> 
		                   <a href="#" onclick="${function}('${action}',${i})">${i}</a>  
		                </#if> 
	                </#if> 
		 		 <#else>
		 		 	<#break> 
		 		 </#if> 
		 	 </#list>
		</#if> 
		
		<#if currentPageNo<totalPageNum>
			<a href="#" onclick="${function}('${action}',${currentPageNo+1})" title='跳到下一页'>下</a>  
			<a href="#" onclick="${function}('${action}',${totalPageNum})" title='跳到最后一页'>尾</a>  
		</#if> 
			
		 到第 
			<input name='pageNo' type='text' size='2' style='ime-mode:disabled'  class="tijian1_k3_right_k2_1"  onblur='gotoPage(this.value)'/>
			<script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){${function}('${action}',pageNo);}}</script>
		 页
	</span>