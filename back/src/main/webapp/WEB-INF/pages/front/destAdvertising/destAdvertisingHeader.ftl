<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>

<body>
	<div class="iframe_content mt10">
		<input type="hidden" value="${dest.destId}" id="destId"/>
		<input type="hidden" value="${showTab}" id="showTab"/>
		 <div class="title">
		     <h2 class="f16">当前目的地：${dest.destName!''}</h2>
		 </div>
		<div class="p_box box_info p_line">
			<div id="price_tab" class="price_tab">
				<ul class="J_tab ui_tab">
					<li id="show1" ><a href="javascript:;">门票</a></li>
					<li id="show2" ><a href="javascript:;">全部线路</a></li>
					<li id="show3" ><a href="javascript:;">出发地跟团游</a></li>
					<li id="show4" ><a href="javascript:;">目的地跟团游</a></li>
					<li id="show5" ><a href="javascript:;">自由行</a></li>
					<li id="show6" ><a href="javascript:;">周边跟团游</a></li>
				</ul>
			</div>            
		</div>
		<div class="destAdvertising" id="destAdvertising">
		</div>
	</div>	
	<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	$(function(){
		var showTabValue = $('#showTab').val();
		if(showTabValue != ""){
			var obj = $('#' + showTabValue);
		}else{
			var obj = $('#show1');
		}
		showPage(obj);
	});
	
	$("#price_tab ul li").click(function(e) {
	        showPage($(this));
	    });
	    
	function showPage(obj){
		$("#destAdvertising").html("");
	    var destId = $("#destId").val();

		var url = ''; 
		if(destId.length <= 0){
			obj = $('#show1');
		}
		
		var id = obj.attr('id');
		if(id=='show6'){
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show6';
		}else if(id=='show5'){
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show5';
		}else if(id=='show4'){
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show4';
		}else if(id=='show3'){
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show3';		
		}else if(id=='show2'){
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show2';
		}else{
			url = '/vst_back/front/destAdvertising/showEditDestAdvertising.do?destId='+destId+'&showTab=show1';
		}
		for(var i = 1; i <= 6; i++){
			$('#show'+i).attr('class','');
		}
		obj.attr('class','active');
		var iframe = "<iframe id=\"main\" class=\"iframeID\" src=\""+url+"\" width=\"900\" height=\"450\" frameborder=\"no\" scrolling=\"auto\"/>";
		$(".destAdvertising").append(iframe);
		
		$("#main").load(function(){
			var srollPos = $(window).scrollTop();
			totalheight = parseFloat($(window).height()+parseFloat(srollPos));			
			var mainheight = totalheight;
			totalwidth = parseFloat($(window).width()+parseFloat(srollPos));			
			var mainwidth = totalwidth-50;
			$(this).width(900);
			$(this).height(450);
		});	
	}
	
</script>
