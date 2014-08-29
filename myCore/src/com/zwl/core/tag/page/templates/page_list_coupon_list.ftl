  <!--pager  start-->
	<div class="pager">
		<div class="pager_txt">共<font color="#FF0000">${totalPageNum}</font>页</div>
		<ul>
			<#if rewrite>
			 <li><a href='${path}1${endWith}' class="pg_btn" title='跳到首页'>首页</a></li>
			 <li><a href='${path}${currentPageNo-1}${endWith}' class="pg_btn" title='跳到上一页'>上一页</a></li>
		   <#else> 
			 <li><a href='?${url}pageNo=1' title='跳到首页' class="pg_btn">首页</a></li>
		 	 <li><a href='?${url}pageNo=${currentPageNo-1}' title='跳到上一页' class="pg_btn">上一页</a></li> 
		   </#if> 
	   		
	   		<#if 0<totalPageNum&&totalPageNum<=sect >
				 <#list 1..totalPageNum as i>
				 	<#if i == currentPageNo >
				 		<li><a class="on" >${i}</a></li>
				 	<#else>
					 	<#if rewrite>
					   	  <li><a href="${path}${i}${endWith}" class="bd">${i}</a></li>
					    <#else> 
						  <li><a href="?${url}pageNo=${i}" class="bd">${i}</a></li>
					    </#if> 
				 	</#if> 
				 </#list>
			<#else> 
				 <#assign n=(currentPageNo/sect)?int> 
			 	 <#list (n*sect)..((n+1)*sect) as i>
			 		 <#if i <= totalPageNum >
			 		 	<#if i!=0>
							<#if i == currentPageNo>
			                   <li><a class="on" >${i}</a></li>
			                <#else> 
			                    <#if rewrite>
							   	  <li><a href="${path}${i}${endWith}" class="bd">${i}</a></li>
							    <#else> 
								  <li><a href="?${url}pageNo=${i}" class="bd">${i}</a></li>
							    </#if> 
			                </#if> 
		                </#if> 
			 		 <#else>
			 		 	<#break> 
			 		 </#if> 
			 	 </#list>
			</#if> 
			
			
			<#if rewrite>
				 <li><a href='${path}${currentPageNo+1}${endWith}' title='跳到下一页' class="pg_btn">下一页</a></li>
				 <li><a href='${path}${totalPageNum}${endWith}' title='跳到最后一页' class="pg_btn">尾页</a></li>
		    <#else> 
				 <li><a href='?${url}pageNo=${currentPageNo+1}' title='跳到下一页' class="pg_btn">下一页</a></li>
				 <li><a href='?${url}pageNo=${totalPageNum}' title='跳到最后一页' class="pg_btn">尾页</a></li>
		    </#if> 
		    
		</ul>
	</div>
   <!--pager  start-->