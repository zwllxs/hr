<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="position:relative">	
<div class="iframe_content mt10">
	<div class="clearfix title">
		<h2 class="f16">预订限制<i class="cc1">(<#if comOrderRequired??>更新<#else>新增</#if>)</i></h2>
	 </div>
	<#include "/common/reservationLimit.ftl"/>
	<div class="p_box box_info clearfix mb20">
   		<div class="fl operate"><a class="btn btn_cc1" id="reservationLimitButton">保存</a>
   		<a class="btn" id="backToLastPageButton">返回上一步</a></div>
 	</div>
 </div>

 <#include "/base/foot.ftl"/>
</body>
</html>
<script>
		showRequire($("input[name='categoryId']").val(),"","");


	$("#reservationLimitButton").click(function(){
		if(!$("#reservationLimitForm").validate().form()){
			return false;
		}
		var url =  <#if comOrderRequired??>"/vst_back/ticket/goods/reservationLimit/updateReservationLimit.do"<#else>"/vst_back/ticket/goods/reservationLimit/addReservationLimit.do"</#if>;
		$.ajax({
			url : url,
			data :$("#reservationLimitForm").serialize(),
			dataType:'JSON',
			success : function(result){
				$.alert(result.message,function(){
					window.history.go(-1);
				});
			},
			error : function(){
				$.alert(result.message);
			}
		})
	});
	
	$("#backToLastPageButton").click(function(){
		window.history.go(-1);
	});
</script>
