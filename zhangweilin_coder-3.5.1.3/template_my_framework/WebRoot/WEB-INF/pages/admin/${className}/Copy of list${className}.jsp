<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/zwl-tags" prefix="zwl"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>${"$"+"{beanNameText}"}列表</title>

		<link href="${'$'+'{basePath }'}/res/css/admin/tab.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${'$'+'{basePath }'}/res/js/list.js"></script>
	</head>

	<body>
	 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="30" background="${'$'+'{basePath }'}/res/images/frame/tab_05.gif">
					 <!-- 列表工具栏 -->
					 <jsp:include page="../_include/list_toolbar.jsp">
					 	<jsp:param name="addPath" value="edit_${'$'+'{beanName}'}" />
					 </jsp:include>  
					   
					  <!-- 查询面板开始 -->
					 <jsp:include page="../_include/queryPanel/queryPanel.jsp"></jsp:include>
			          <!-- 查询面板结束 -->
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="8" background="${'$'+'{basePath }'}/res/images/frame/tab_12.gif">
								&nbsp;
							</td>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="1"
									bgcolor="b5d6e6" onmouseover="changeto()"
									onmouseout="changeback()">
									
									<s:form id="del_bat_form" action="del_bat_${table.className}"  onsubmit="return ConfirmDel(this)">	
									<!-- 数据表格标题 开始 -->
									<tr>
										<td width="3%" height="22" background="${'$'+'{basePath }'}/res/images/frame/bg.gif"
											bgcolor="#FFFFFF">
											<div align="center">
												<input  title="点击此处全选" type="checkbox"  onclick=CheckAll(this)  value="checkbox" />
											</div>
										</td>
										
										<!-- 选项列开始 -->
										<td width="3%" height="22" background="${'$'+'{basePath }'}/res/images/frame/bg.gif"
											bgcolor="#FFFFFF">
											<div align="center">
												<span class="STYLE1">序号</span>
											</div>
										</td>
										
										 <#-- 表的普通字段,即po的普通属性 -->
										<#assign isFK=false />
										<#list table.columns as c>
										    <#--得到当前表所有的外键-->
										    <#list table.importedKeys.foreignKeyMap?keys as key>
										        <#--得到当前外键的所有外键字段-->
										        <#list table.importedKeys.foreignKeyMap[key].fkColumnMap?keys as key2>
										            <#--如果外键字段与当前属性名一样，则此属性不输出-->
										            <#if table.importedKeys.foreignKeyMap[key].fkColumnMap[key2]?replace('_', '')?lower_case=c.columnName?lower_case>
										                <#assign isFK=true />
										            </#if>
										        </#list>
										    </#list>
										    <#--属性名为id,则此属性不输出-->
										   <#if c.isPK>
										   		<#assign isFK=true />
										   </#if>
										<#if isFK=false>
										 <td width="12%" height="22" background="${'$'+'{basePath }'}/res/images/frame/bg.gif"
											bgcolor="#FFFFFF">
											<div align="center">
												<span class="STYLE1">${"$"+"{beanNameText}"}${c.remarksFirst}</span>
											</div>
										 </td>
										</#if>
										        <#assign isFK=false />
										        
										</#list>
										 
										<td width="10%" height="22" background="${'$'+'{basePath }'}/res/images/frame/bg.gif"
											bgcolor="#FFFFFF" class="STYLE1">
											<div align="center">
												基本操作
											</div>
										</td>
									</tr>
									<!-- 数据表格标题 结束 -->
								 	
								 	<s:if test="${table.className?uncap_first}List!=null&&${table.className?uncap_first}List.size>0">
									<s:iterator value="${table.className?uncap_first}List" status="index">
									
									<!-- 数据表格数据行 开始 -->
									<tr>
										<td height="20" bgcolor="#FFFFFF">
											<div align="center">
												<input title="点击选定该项" type="checkbox" name="toDelBat" value="${'$'+'{'+table.pkName?uncap_first+'}'}" />
											</div>
										</td>
										<td height="20" bgcolor="#FFFFFF">
											<div align="center" class="STYLE1">
												<div align="left" title="第${'$'+'{index.index+1+(pageInfo.pageNo-1)*pageInfo.perPageSize}'}条">
													${"$"+"{index.index+1+(pageInfo.pageNo-1)*pageInfo.perPageSize}"}
												</div>
											</div>
										</td>
										
										
										 <#-- 表的普通字段,即po的普通属性 -->
										<#assign isFK=false />
										<#list table.columns as c>
										    <#--得到当前表所有的外键-->
										    <#list table.importedKeys.foreignKeyMap?keys as key>
										        <#--得到当前外键的所有外键字段-->
										        <#list table.importedKeys.foreignKeyMap[key].fkColumnMap?keys as key2>
										            <#--如果外键字段与当前属性名一样，则此属性不输出-->
										            <#if table.importedKeys.foreignKeyMap[key].fkColumnMap[key2]?replace('_', '')?lower_case=c.columnName?lower_case>
										                <#assign isFK=true />
										            </#if>
										        </#list>
										    </#list>
										   <#--属性名为id,则此属性不输出-->
										   <#if c.isPK>
										   		<#assign isFK=true />
										   </#if>
										<#if isFK=false>
										 <td height="20" bgcolor="#FFFFFF">
											<div align="left">
												<span class="STYLE1" title="${'$'+'{'+c.columnName?uncap_first+'}' }">
													${'$'+'{'+c.columnName?uncap_first+'}' }
												</span>
											</div>
										</td>
										</#if>
										        <#assign isFK=false />
										        
										</#list>
										<td height="20" bgcolor="#FFFFFF">
											<div align="center">
												<span class="STYLE4"> 
												   <jsp:include page="../_include/operator.jsp">
												   		<jsp:param name="pkName" value="${table.pkName?uncap_first}"/>
												   		<jsp:param name="pkValue" value="${'$'+'{'+table.pkName?uncap_first+'}'}"/>
												   </jsp:include>
												 </span>
											</div>
										</td>
										
									</tr>
									<!-- 数据表格数据行 结束 -->
								 </s:iterator>
								 </s:if>
								 <s:else>
								 	<tr>
								 		<td colspan="${table.columns?size+3 }" height="20" bgcolor="#FFFFFF">
											<div align="center">
												<span style="color:red;font-size: 13px;">
													 目前没有符合条件的记录
												</span>
											</div>
										</td>
								 	</tr>
								 </s:else>
								 </s:form>
								</table>
							 	
							</td>
							<td width="8" background="${'$'+'{basePath }'}/res/images/frame/tab_15.gif">
								&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="35" background="${'$'+'{basePath }'}/res/images/frame/tab_19.gif">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="12" height="35">
								<img src="${'$'+'{basePath }'}/res/images/frame/tab_18.gif" width="12" height="35" />
							</td>
							<td>
								 <zwl:page totalSize="${'$'+'{pageInfo.totalSize}'}" perPageSize="${'$'+'{pageInfo.perPageSize}'}" cssStyle="STYLE1" />
							</td>
							<td width="16">
								<img src="${'$'+'{basePath }'}/res/images/frame/tab_20.gif" width="16" height="35" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	  
	</body>
</html>
