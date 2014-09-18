    
<#--
<!--
<#import "/WEB-INF/pages/common/showDynamicHtmlPlugin.ftl" as showDynamicHtmlPlugin>-->
<!-- <@showDynamicHtmlPlugin.show bizDictExtend/> -->
	显示一个动态的html插件
	@param bizDictPropExtend 点评 
-->
<#macro show bizDictPropExtend>

//属性名称
    private String dictPropDefName;
    
    //录入方式
    private String inputType;
    //最大长度
    private Integer maxLength;
    //是否可空
    private String nullFlag;
    //属性描述
    private String propDesc; 
    
    
<#if cmtComment != null && cmtComment.cmtLatitudes != null>

	<input type="text" name="dictPropValue" value="${bizDictPropExtend.dictPropValue!''}">
							
</#if> 
</#macro>
 
