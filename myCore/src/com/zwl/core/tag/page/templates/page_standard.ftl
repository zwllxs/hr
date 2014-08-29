
<table class='${cssStyle}' width='100%' cellspacing='0' border='0' cellpadding='0'>
	<tr>
		<td align='center' height='25' width='40%'>
			共有
			<b>${totalSize}</b>条&nbsp; 每页显示
			<b>${perPageSize}</b> 条&nbsp; 修改为每页显示
			<select name='per_pageSize' onChange='javascript:location=this.options[this.selectedIndex].value;'>
			    <#list start..end as i>
					<option value='?${url}perPageSize=${i}&pageNo=1'${(perPageSize==i)?string(' selected','')}>
						${i}
					</option>
				</#list>
			</select>
			&nbsp; 条&nbsp;
		</td>
		<td width='60%' align='right'>
		  <#if totalPageNum<=1 > 
		  	   首页 上一页 下一页 末页	
		  <#elseif currentPageNo==1>
		  	   <#assign next=currentPageNo+1> 
		  	   首页 上一页 <a href='?${url}perPageSize=${perPageSize}&pageNo=${next}'>下一页</a> <a href='?${url}perPageSize=${perPageSize}&pageNo=${totalPageNum}'>末页</a>
		  <#elseif currentPageNo==totalPageNum>
		  	   <#assign pre=currentPageNo-1> 
		  		<a href='?${url}perPageSize=${perPageSize}&pageNo=1'>首页</a> 
		  		<a href='?${url}perPageSize=${perPageSize}&pageNo=${pre}'>上一页</a> 
		  		下一页 末页
		  <#else>
		  	  <#assign next=currentPageNo+1> 
		  	  <#assign pre=currentPageNo-1> 
		  	  <a href='?${url}perPageSize=${perPageSize}&pageNo=1'>首页</a> 
		  	  <a href='?${url}perPageSize=${perPageSize}&pageNo=${pre}'>上一页</a> 
		  	  <a href='?${url}perPageSize=${perPageSize}&pageNo=${next}'>下一页</a> 
		  	  <a href='?${url}perPageSize=${perPageSize}&pageNo=${totalPageNum}'>末页</a>
		  </#if> 
		       跳至 <select name='sel_page' onChange='javascript:location=this.options[this.selectedIndex].value;'>
	       
          <#list 1..totalPageNum as i>
			   <#if i==currentPageNo>
			        <option value='?${url}perPageSize=${perPageSize}&pageNo=${i}' selected>${i}</option>
			   <#else>
			        <option value='?${url}perPageSize=${perPageSize}&pageNo=${i}'>${i}</option>
			   </#if>
		  </#list> 
		  
		  </select>&nbsp;/<b>${totalPageNum}</b>页     
</td></tr></table>		 

