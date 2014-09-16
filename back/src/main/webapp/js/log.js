/******************
 * 日志页面.
 * 
 */
$(function(){
   
	$("a.showLogDialog").live("click",function(){
		var param=$(this).attr("param");
	    new xDialog("/vst_back/pub/comLog/findComLogList.do?param="+param,{},{title:"日志详情页",iframe:true,width:1000,hight:500,scrolling:"yes"});
	});


});