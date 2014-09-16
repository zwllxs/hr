<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="http://pic.lvmama.com/min/index.php?f=/styles/v5/modules/tip.css,/styles/youlun/youlun_admin.css">
</head>

<body>
<div class="main_all">
	<div class="divClass">
		<table class="s_table">
<tbody><tr> 
<td class="qudao_t"> 

<label style="width:auto;margin:0 5px;" class="item_title"><em>*</em>行程天数</label> 
<input type="text" class="textClass" id="searchText" name="searchText" value="${days!0}"> 
</td> 
<td class="qudao_t"> 
<input type="button" onclick="onSearch();" value="确认行程天数" style="width:120px;height:26px;border:none;background:#4D90FE;color:#fff;"> 
</td> 
</tr> 
</tbody>	
		</table>
		<input type="hidden" id="productId" value="${productId!''}">
		<input type="hidden" id="routeId" value="${routeId!''}">
	</div>
	<div class="iframe_header" style="padding:0 17px;">
		<div class="iframe_content" style="padding:0;">
			<div class="hd">
				<div class="switch">
					<div class="mainHd">
						<ul class="hdList">
							<!--不需要默认，直接加载数据库中数据
							<li class="nav_Li">1</li>
							<li>2</li>
							<li>3</li>
							-->
						</ul>
					</div>
				</div>  	
			</div>
			<div class="left">
				<span><em></em></span>
			</div>
			<div class="right">
				<span><em></em></span>
			</div>
		</div> 
	</div>
</div>
</html>
<script src="http://pic.lvmama.com/js/jquery-1.7.js"></script>
<script src="http://pic.lvmama.com/js/youlun/youlun_admin.js"></script>
<script type="text/javascript">

var _numindex = 0;

function onSearch(){
   var searchText = $("#searchText").val();
   if(searchText.length>0){
   	   searchText = $.trim(searchText);
   }else{
   		alert('行程天数不能为空!!');
		return;  
   }
   
   if(!window.parent.isNumeric(searchText)){
   		$('#searchText').focus();
		alert('行程天数只能为正整数!!');
		return;   	
   }
   
   var routeId = $("#routeId").val();;
   if('undefined'==routeId || routeId.length<=0){
   		updateRouteDesc();
   }else{
	   if(confirm("是否确认修改?")){
	   		updateRouteDesc();
	   }
   }
}

function updateRouteDesc(){
    var searchText = $("#searchText").val();
    var oData = {};
    oData.productId = $("#productId").val();
    oData.routeId = $("#routeId").val();
    oData.days = $("#searchText").val();
	var loading = top.pandora.loading("正在努力保存中...");
    $.ajax({
	   url:'/vst_back/prod/compship/routedesign/updateRouteDays.do',
	   async:false,
	   type:'post',
	   data: oData,
	   success:function(data){
	   	   loading.close();
		   if (data.code == "success") {
 			   $.alert(data.message,function(){
 			   	   $("#productId").val(data.attributes.productId);
			   	   $("#routeId").val(data.attributes.routeId);
			   	   var liCnt = parseInt($(".hdList li").length);
				   var showCnt = searchText - 1;
				   var addCnt = searchText - liCnt;
				   if(liCnt < searchText){
					  for(var i=liCnt+1;i<=searchText;i++){
					   	 $("<li>"+i+"</li>").appendTo(".hdList");
					  }
				   }
				   $(".hdList li").show();
				   $(".hdList li:gt("+showCnt+")").remove();
				   $(".hdList li:eq(0)").addClass('nav_Li').siblings().removeClass('nav_Li');
				   initSearchContent();
 			   }); 
		   }else{
		   	  $.alert(data.message); 
		   	  var liCnt = parseInt($(".hdList li").length);
		   	  $("#searchText").val(liCnt);
		   }
	   }
	});
}

function initSearchContent(){
	initFrameContent();
	$(".hdList li").click(function(){
		_numindex = $(this).index();
  		$(this).addClass('nav_Li').siblings().removeClass('nav_Li');
		$(this).parents('.main_all').find('.iframe_form').eq(_numindex).show().siblings('.iframe_form').hide();
		initFrameContent();
	});

	$('.hdList').each(function(){ 
		var _list_num = $(this).find('li:visible').length;
		if(_list_num>10){
			$(this).parents('.iframe_content').find('.right').addClass('right2').removeClass('right');
			$(this).parents('.iframe_content').find('.right2').show();
		}else{
			$(this).parents('.iframe_content').find('.right2').addClass('right').removeClass('right2');
			$(this).parents('.iframe_content').find('.right').hide();
		}
	});
	  $('.hdList').css({left:0});
	  $('.right2').live('click',function(){
			var small_box = $(this).parents('.iframe_content').find('.hdList');
			var _left = small_box.position().left;	
			var _geshu= small_box.find('li').length;
			var _width=-(_geshu-10)*76+10;
			small_box.animate({'left':_left-76},300,function(){
				if(small_box.stop(true).position().left<_width)
				{
					$(this).parents('.iframe_content').find('.right2').addClass('right').removeClass('right2');
				}										 
			});
			$(this).parents('.iframe_content').find('.left').addClass('left2').removeClass('left');
	  });
				
				
	 $('.left2').live('click',function(){
		 var small_box = $(this).parents('.iframe_content').find('.hdList');
		 var _left = small_box.position().left;		
		 small_box.animate({'left':_left+76},300,function(){
				if(small_box.stop(true).position().left>-1){
					$(this).parents('.iframe_content').find('.left2').addClass('left').removeClass('left2');
				}											
		 });
		 $(this).parents('.iframe_content').find('.right').addClass('right2').removeClass('right')
	 });
}

function initFrameContent(){
	
	//$('.iframe_form:eq(0)').show().siblings('.iframe_form').hide();
	$(".main_all .iframe_form").hide();
	
	var frameCnt = parseInt($(".main_all .iframe_form").length);
	var liCnt = $('.hdList li:visible').length;
    var productId = $('#productId').val();
    var days = $('#searchText').val();
    var n_day = _numindex+1;
    var routeId = $("#routeId").val();
	var $frameContentObj = $("<div class=\"iframe_form mt10\"></div>");
	$frameContentObj.attr("id","frame_");
    var url = '/vst_back/prod/compship/travelDesign/showAddTravelDesignContent.do?productId='+productId+'&n_day='+n_day+"&days="+days+"&routeId="+routeId;
	$frameContentObj.append("<iframe class=\"iframeID\" src = \""+url+"\" frameborder = \"no\" marginheight = \"0\" marginwidth = \"0\" scorlling = \"auto\" width=\"100%\" height = \"599px\"/>");
	$(".main_all").append($frameContentObj);
	$frameContentObj.show();
}


function createLable(text,class_text,isRequired){
   var $labelObj = $("<label class=\""+class_text+"\"></label>");
   if(isRequired){
		$labelObj.append("<em>*</em>");
   }
   $labelObj.append(text);
   return $labelObj;
}

$(function(){ 
	var searchText = $("#searchText").val();
	if(!window.parent.isNumeric(searchText)){
		return;
	}
	
	var liCnt = parseInt($(".hdList li").length);
   	var showCnt = searchText - 1;
   	var addCnt = searchText - liCnt;
   	if(liCnt < searchText){
	  	for(var i=liCnt+1;i<=searchText;i++){
	   	 	$("<li>"+i+"</li>").appendTo(".hdList");
	  	}
   	}
   	$(".hdList li").show();
   	$(".hdList li:gt("+showCnt+")").remove();
   	$(".hdList li:eq(0)").addClass('nav_Li').siblings().removeClass('nav_Li');
	//initSearchContent();
	var productId = $('#productId').val();
	// 查询行程天数
	$.ajax({
		url : "/vst_back/prod/compship/travelDesign/findTravelDesignById.do",
		type : "post",
		dataType : 'json',
		data : {productId:productId},
		success : function(data) {
			var str = data.array;
			if(str!='entry'){
			    var searchText = data.array[0].days;
				$('#searchText').val(searchText);
			}
			//onSearch();
			initSearchContent();
		}
	});		
});

</script>
<#include "/base/foot.ftl"/>
</body>
</html>
