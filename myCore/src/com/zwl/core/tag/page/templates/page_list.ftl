<table class='${cssStyle}' width='100%' cellspacing='0' border='0' cellpadding='0'>
	<tr>
		<td align='center' height='25' width='40%'>
			${currentPageNo} /
			<b>${totalPageNum}</b> 页
			
			<#if currentPageNo &gt; 1 >
				<#if rewrite>
			   		 <a href='${path}1${endWith}' title='首页'>|<<</a>   
					 <a href='${path}${currentPageNo-1}${endWith}' title='上一页'><<</a>  
			    <#else> 
					 <a href='?${url}pageNo=1' title='首页'>|<<</a>   
					 <a href='?${url}pageNo=${currentPageNo-1}' title='上一页'><<</a>    
			    </#if>
			</#if> 
			
			<#if 0<totalPageNum&&totalPageNum<=sect >
				 <#list 1..totalPageNum as i>
				 	<#if i == currentPageNo >
				 		${i}  
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
			                   ${i}  
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
			   		<a href='${path}${currentPageNo+1}${endWith}' title='下一页'>>></a>  
					<a href='${path}${totalPageNum}${endWith}' title='末页'>>>|</a>  
			    <#else> 
					<a href='?${url}pageNo=${currentPageNo+1}' title='下一页'>>></a>  
					<a href='?${url}pageNo=${totalPageNum}' title='末页'>>>|</a>  
			    </#if>
			</#if> 
			
			 跳至 <input name='pageNo' type='text' size='2' style='ime-mode:disabled' onblur='gotoPage(this.value)'/>
			<#if rewrite>
		   	  	 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='${path}'+pageNo+'${endWith}';}}</script>
		    <#else> 
				 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){window.location='?${url}pageNo='+pageNo;}}</script> 
		    </#if> 
</td></tr></table>
			  