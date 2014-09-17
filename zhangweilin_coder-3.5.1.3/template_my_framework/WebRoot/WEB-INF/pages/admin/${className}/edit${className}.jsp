<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/zwl-tags" prefix="zwl"%> 
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link id="link" href="${'$'+'{basePath }'}/res/css/admin/green.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${'$'+'{basePath }'}/res/js/changSkin.js"></script>

<style>
.key {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	color: red;
	text-decoration: none;
} 
 
</style>
 
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="17" height="29" valign="top" background="${'$'+'{basePath }'}/res/images/mail_leftbg.gif"></td>
    <td width="935" height="29" valign="top" background="${'$'+'{basePath }'}/res/images/content-bg.gif">
	<table width="30%" height="31" border="0" cellpadding="0" cellspacing="0" class="left_topbg" id="table2">
      <tr>
         <td height="31"><div class="titlebt">${"$"+"{beanNameText}"}管理</div></td>
      </tr>
    </table>
	</td>
    <td width="16" valign="top" background="${'$'+'{basePath }'}/res/images/mail_rightbg.gif"></td>
  </tr>
  <tr>
    <td height="71" valign="middle" background="${'$'+'{basePath }'}/res/images/mail_leftbg.gif">&nbsp;</td>
    <td valign="top"  class="tr2"><table width="100%" height="138" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="13" valign="top">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td class="left_txt">当前位置：${"$"+"{beanNameText}"}管理</td>
          </tr>
          <tr>
            <td height="20"><table width="100%" height="1" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
              <tr>
                <td></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" height="55" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="10%" height="55" valign="middle"><img src="${'$'+'{basePath }'}/res/images/frame/title.gif" width="54" height="55"></td>
                <td width="90%" valign="top">
                	<span class="left_txt2">在这里，您可以添加</span><span class="key">${"$"+"{beanNameText}"}</span><span class="left_txt2">！</span><br>
				</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>
            <div class="largeTitle" style="height: 31;" >
            	<div class="left_bt2">&nbsp;&nbsp;&nbsp;&nbsp;${"$"+"{beanNameText}"}表单</div>
            </div>
            </td> 
          </tr>
          <tr>
            <td>
            
            <!-- 表单开始 -->
            <s:form action="add_update_${table.className}">
            <s:if test="${table.className?uncap_first}!=null">
            	<s:hidden name="${table.className?uncap_first}.${table.pkName?uncap_first }"></s:hidden>
            </s:if>
            <s:hidden name="lastRealPath"></s:hidden> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
			  <tr>
                <td width="20%" height="30" align="right"  class="tr1 left_txt2">${"$"+"{beanNameText}"}${c.remarksFirst}：</td>
                <td width="80%" height="30" class="tr1">
                	<s:textfield name="${table.className?uncap_first}.${c.columnName?uncap_first}" ></s:textfield>
                </td>
              </tr>
			</#if>
			        <#assign isFK=false />
			        
			</#list>
              <tr>
                <td height="1" colspan="3" align="center" > 
                	&nbsp;
                </td>
              </tr>
              
              <tr>
                <td colspan="3" align="center" class="tr1 left_txt2"> 
                	<s:submit value="提交" cssStyle="width:100px;" ></s:submit>
                	<s:reset value="重置" cssStyle="width:100px;"></s:reset>
                </td>
              </tr>
              
                </table>
               </s:form>
               <!-- 表单结束 --> 
                </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table> 
    <td background="${'$'+'{basePath }'}/res/images/mail_rightbg.gif">&nbsp;</td>
  <tr>
    <td valign="middle" background="${'$'+'{basePath }'}/res/images/mail_leftbg.gif"></td>
      <td height="17" valign="top" background="${'$'+'{basePath }'}/res/images/buttom_bgs.gif"> </td>
    <td background="${'$'+'{basePath }'}/res/images/mail_rightbg.gif"></td>
  </tr>

</body>
