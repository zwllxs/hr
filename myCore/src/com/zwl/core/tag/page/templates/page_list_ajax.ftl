<table class='${cssStyle}' width='100%' cellspacing='0' border='0' cellpadding='0'>
	<tr>
		<td align='center' height='25' width='40%'>
			${currentPageNo} /
			<b>${totalPageNum}</b> 页
			
			<#if currentPageNo &gt; 1 >
				 <a href="#" onclick="${function}('${action}',1);" title='首页'>|<<</a>   
				 <a href="#" onclick="${function}('${action}',${currentPageNo-1})" title='上一页'><<</a>    
			</#if> 
			
			<#if 0<totalPageNum&&totalPageNum<=sect >
				 <#list 1..totalPageNum as i>
				 	<#if i == currentPageNo >
				 		${i}  
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
			                   ${i}  
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
				<a href="#" onclick="${function}('${action}',${currentPageNo+1})" title='下一页'>>></a>  
				<a href="#" onclick="${function}('${action}',${totalPageNum})" title='末页'>>>|</a>  
			</#if> 
			
			 跳至 <input name='pageNo' type='text' size='2' style='ime-mode:disabled' onblur='gotoPage(this.value)'/>
				 <script>function gotoPage(pageNo){if(pageNo!=''&& !isNaN(pageNo)){${function}('${action}',pageNo);}}</script>
	</td>
  </tr>
 </table>
			  