<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="http://pic.lvmama.com/min/index.php?f=/styles/v5/modules/tip.css,/styles/youlun/youlun_admin.css">
</head>

<body>
  <div class="iframe_form mt10" style="display:block;">
     <div class="box_content">
        <div class="itemBox">
            <label class="item_title"><em>*</em>行程标题：</label>
            <div class="form-inline form-small">
                <input class="textClass" id="tour_title" name="tour_title" type="text"  >
                <input type="hidden" id="routeDetailId" value="">
                <input type="hidden" id="productId" value="${productId!''}">
                <input type="hidden" id="n_day" value="${n_day!''}">
                <input type="hidden" id="days" value="${days!''}">
            </div>
        </div>
        <div class="itemBox">
            <label class="item_title">交通：</label> 
            <div class="form-inline form-small">
            </div>
        </div>
        <div class="itemBox">
            <label class="item_title">用餐：</label> 
            <div class="form-inline form-small">
            </div>
        </div>
		<div class="itemBox teshu"> 
		<label class="item_title"> 
		<em>*</em> 
		住宿： 
		</label> 
		<div class="form-inline form-small"> 
		<#--
		<input id="stayDesc" class="textareaBox" type="textarea" style="margin-left:20px" name="stayDesc">
		--> 
		<textarea  id="stayDesc" name="stayDesc" style="width: 330px; height: 58px;" ></textarea>
		</div> 
		</div>
          
        <div class="itemBox teshu">
            <label class="item_title"><em>*</em>行程描述：</label>
            <div class="nrBox">
            </div>
            <div class="addMoreBtn" onclick="createMoreJsBox()">新增一段行程</div>
   		 </div>  
	</div>
</div>
<div>
<div style="display:block;height:auto;overflow:hidden;margin:0 auto;width:230px;"> 
<div style="float:left;" onclick="submitContent()" class="saveTravelBtn">保存当日行程 </div> 
<a param="{'parentId':${productId},'parentType':'PROD_PRODUCT','logType':'PROD_TRAVEL_DESIGN'}" class="showLogDialog" style="float:left;display:block;width:95px;height:24px;line-height:24px;margin-top:23px;margin-left:10px;" href="javascript:void(0);">[查看操作日志]</a> 
</div>
<script src="http://pic.lvmama.com/js/jquery-1.7.js"></script>
<script src="http://pic.lvmama.com/js/youlun/youlun_admin.js"></script>
<script type="text/javascript" src="/vst_back/js/json2.js"></script>
<script src="/vst_back/js/file/ajaxUpload.js"></script>
<#include "/base/foot.ftl"/>
<script type="text/javascript">
var initLoading = top.pandora.loading("正在努力加载...");
var paramJOSN = [{key:"strokeDesc",value:"行程说明"},{key:"attractions",value:"景点介绍"},{key:"tips",value:"温馨提示"}];// 行程说明
var trafficToolJOSN = [{key:"train",value:"火车"},{key:"aircraft",value:"飞机"},{key:"car",value:"汽车"},{key:"cruise",value:"邮轮"}];//交通工具
var mealsDescJSON = [{key:"breakfast",value:"早餐"},{key:"chinese",value:"中餐"},{key:"dinner",value:"晚餐"}];//用餐方式
var trafficBoxIndex = 0;

// 获取字符数
String.prototype.getBytes = function() { 
　　var cArr = this.match(/[^x00-xff]/ig); 
　　return this.length + (cArr == null ? 0 : cArr.length); 
} 

function createTrafficItems(){
  var trafficContent = $(".box_content .itemBox:eq(1) div");
  for(var i=0;i<trafficToolJOSN.length;i++){
  	 var key = trafficToolJOSN[i].key;
	 var value = trafficToolJOSN[i].value;
     trafficContent.append("<input type=\"checkbox\" id=\"traffic_item_"+i+"\" name=\"traffic_item\" class=\"checkboxClass\" value=\""+key+"\"/>");
	 trafficContent.append("<label class=\"checkbox_title\">"+value+"</label>");
  }
  
  var mealsDesc = $(".box_content .itemBox:eq(2) div");
  for(var i=0;i<mealsDescJSON.length;i++){
  	 var key = mealsDescJSON[i].key;
	 var value = mealsDescJSON[i].value;
     mealsDesc.append("<input type=\"checkbox\" id=\"mealsDesc_"+i+"\" name=\"mealsDesc\" class=\"checkboxClass\" value=\""+key+"\"/>");
	 mealsDesc.append("<label class=\"checkbox_title\">"+value+"</label>");
  }
}

function createLable(text,class_text,isRequired){
   var $labelObj = $("<label class=\""+class_text+"\"></label>");
   if(isRequired){
		$labelObj.append("<em>*</em>");
   }
   $labelObj.append(text);
   return $labelObj;
}

function createBoxItem(item_title,item_content,item_css){
	var boxItemObj = $("<div class=\""+item_css+"\"></div>");
	boxItemObj.append(item_title);

	var boxItemContent = $("<div class=\"form-inline form-small\"></div>");
	boxItemContent.append(item_content);
    
	boxItemObj.append(boxItemContent);
	return boxItemObj;
}

function createMoreJsBox(title,titleOptions,content,routeDescId){
  if(!routeDescId) {
  	routeDescId = "";
  }
  var boxObj = $("<div class=\"addMoreJsBox\">");
  var route_desc_id = $("<input type=\"hidden\" name='routeDescId' id=\""+(trafficBoxIndex+1)+"\" value=\""+routeDescId+"\"/>");
  var seq = $("<input type=\"hidden\" name=\"seq\" value=\""+(trafficBoxIndex+1)+"\"/>");
  boxObj.append(route_desc_id);
  boxObj.append(seq);
  var boxTitleObj = $("<h3>第"+(trafficBoxIndex+1)+"段</h3>");
 
  if(trafficBoxIndex != 0){
     boxTitleObj.append("<span class=\"delMoreBtn\" onclick=\"removeMoreJsBox("+trafficBoxIndex+")\">删除</span>");
  }
  
  boxTitleObj.append("<span class=\"delMoreBtn\" onclick=\"selectImgBtn("+routeDescId+")\">查看图片</span>");

  boxObj.attr("id","addMoreJsBox_"+trafficBoxIndex);
  boxObj.append(boxTitleObj);

  //创建行程标题的Html
  var tourTitleLable = createLable('标题：','item_title',false);
  var tourTitleContent = null;
  if(title){
    tourTitleContent = $("<input class=\"textClass\" name=\"itemBox_title\" type=\"text\" value=\""+title+"\">");
  }else{
    tourTitleContent = $("<input class=\"textClass\" name=\"itemBox_title\" type=\"text\" >");
  }
  
  boxObj.append(createBoxItem(tourTitleLable,tourTitleContent,"itemBox_sec"));

   var tourTitleSelect = $('<select name=\"titleOptions\" class=\"selectClass\"></select>');
  
  //行程说明
  for(var i=0;i<paramJOSN.length;i++){
	var key = paramJOSN[i].key;
	var value = paramJOSN[i].value;
	  if(titleOptions){
	  	 if(key==titleOptions){
	  	 	tourTitleSelect.append('<option value=\"'+key+'\" selected=\"selected\">'+value+'</option>'); 
	  	 }else{
	  	 	tourTitleSelect.append('<option value=\"'+key+'\" >'+value+'</option>');
	  	 }
	  }else{
	  	tourTitleSelect.append('<option value=\"'+key+'\" >'+value+'</option>');
	  }
	
  }
  
  tourTitleSelect.insertAfter(tourTitleContent);
  
  var tourCxtLable = createLable('内容：','item_title',true);
  var tourCxtContent = '';
  // 线路内容
  if(content){
  	tourCxtContent = $("<textarea name=\"content\"  class=\"textareaBox traveDes\">"+content+"</textarea>");
  }else{
    tourCxtContent = $("<textarea name=\"content\" class=\"textareaBox traveDes\"></textarea>");
  }
  //创建行程内容的Html
  boxObj.append(createBoxItem(tourCxtLable,tourCxtContent,"itemBox_sec teshu"));


  trafficBoxIndex ++ ;
 
  $(".nrBox").append(boxObj);
  
setHeight(window); 
 refreshSensitiveWord($("input[type='text'],textarea"));
}

function removeMoreJsBox(curIndex){
     var id = curIndex+1;
     var index = $('#'+id).val();
	 if(confirm("是否确认删除?")){
	      if('undefined'==index || index.length<=0){
	      		$("#addMoreJsBox_"+curIndex).remove();
	      }else{
	      	  var productId = $('#productId').val();
	      	  var routeId = $('#routeId',parent.document).val();
	      	  var n_day = $('#n_day').val();
		      $.ajax({
				  type:"POST",
				  url:"/vst_back/prod/compship/travelDesign/delRouteDesc.do",
				  data:{routeDescId:index,productId:productId,routeId:routeId,n_day:n_day},
				  datatype:"text",
				  success:function(data){
					if (data.code == "success") {
				   	   $.alert(data.message,function(){
				   	   		$("#addMoreJsBox_"+curIndex).remove();
					   });				   
				    }else{
				   	  $.alert(data.message);
				    }				   	  
				  }         
			   });
	      }
	 }
}

function isNumeric(p) { 
 if (/^[1-9]\d*$/.test(p))
     return   true ;
 else
     return   false ;
} 	

function paramCheck(value,len){ 
　　if(value.getBytes()>len){ 
	　　return true; 
　　} 
　　return false; 
} 

// 保存当日行程
function submitContent(){
   var productId = $('#productId').val();
   var n_day = $('#n_day').val();
   
   var days = $('#searchText',parent.document).val();
   if(days.length>0){
   	   days = days.trim();
   }else{
   		alert('行程天数不能为空!!');
		return;  
   }
   if(!isNumeric(days)){
   		$('#searchText',parent.document).focus();
		alert('行程天数只能为正整数!!');
		return;   	
   }   

   var routeId = $('#routeId',parent.document).val();
   var objs = $(".nrBox .addMoreJsBox");
   var dataJosns = new Array();
   for(var i=0;i<objs.length;i++){
     var obj = objs[i];
     var dataJOSN = {};
     var seq = $("[name='seq']",obj).val();// 线路顺序
	 var itemBoxTitle =  $("[name='itemBox_title']",obj).val();// 线路描述标题
     var routeDescId = $('input[name=routeDescId]',obj).val();
	 
	 if(paramCheck(itemBoxTitle,20)){
	 	alert('第'+seq+'段的标题字符数超过规定字符数!!');
   		return;
	 }
	 var itemBox_option =  $("[name='titleOptions']>option:selected",obj).val();// 线路描述行程说明
	 var content =  $("[name='content']",obj).val();// 线路描述内容
	 if(content.length<=0){
	 	alert('第'+seq+'段的内容不能为空!!');
	 	return;
	 }else{
		if(content.trim().length<=0){
			alert('第'+seq+'段的内容不能为空!!');
		 	return;
		}
     }
	 if(paramCheck(content,2000)){
	 	alert('第'+seq+'段的内容字符数超过规定个数!!');
   		return;
	 }     
	 dataJOSN['routeDescId'] = routeDescId;
	 dataJOSN['title'] = itemBoxTitle;
	 dataJOSN['titleType'] = itemBox_option;
	 dataJOSN['content'] = content;
	 dataJOSN['seq'] = seq;
	 dataJosns.push(dataJOSN);
   }
   var routeDetailId = $('#routeDetailId').val();//行程ID
   var tour_title = $('#tour_title').val();//行程标题
   if(tour_title.length<=0){
		alert('行程标题不能为空!!');
	 	return;
   }else{
		if(tour_title.trim().length<=0){
			alert('行程标题不能为空!!');
		 	return;
		}
   }
   // 校验字符个数是否大于行程标题数据库定义字符长度
   if(paramCheck(tour_title,20)){
   		alert("行程标题字符数超过规定个数!!"); 
   		return;
   }
   	   
   var stayDesc = $('#stayDesc').val();// 住宿
   if(stayDesc.length<=0){
		alert('住宿不能为空!!');
	 	return;
   }else{
		if(stayDesc.trim().length<=0){
			alert('住宿不能为空!!');
		 	return;
		}
		
		   if(stayDesc=="" || stayDesc.length>100){
   	          alert("住宿不能为空，且不能超过100个字符");
   	          return;
     		}
   }
   
   var trafficTool = '';// 交通
   $('input[name="traffic_item"]:checked').each(function(){
      trafficTool+=$(this).val()+',';
   });
	   
   var mealsDesc = '';// 用餐
   $('input[name="mealsDesc"]:checked').each(function(){
      mealsDesc+=$(this).val()+',';
   });
   
   var dd = JSON.stringify(dataJosns);
   
   var msg = '确认保存吗 ？';	
   if(refreshSensitiveWord($("input[type='text'],textarea"))){
   	 $("input[name=senisitiveFlag]").val("Y");
 	 msg = '内容含有敏感词,是否继续?';
   }else {
			$("input[name=senisitiveFlag]").val("N");
	}
   $.confirm(msg,function(){
   	//显示正在保存
   	var loading = top.pandora.loading("正在努力保存中...");
   		$.ajax({
		  type:"POST",
		  url:"/vst_back/prod/compship/travelDesign/addTravelDesign.do",
		  data:{routeDetailId:routeDetailId,routeDetail:dd,trafficTool:trafficTool,tr_title:tour_title,pid:productId,n_day:n_day,days:days,routeId:routeId,stayDesc:stayDesc,mealsDesc:mealsDesc},
		  datatype:"text",
		  success:function(data){
		  	 loading.close();
		   if (data.message>=0) {
				var routeId = $('#routeId',parent.document).val();
			    if(routeId.length<=0){
			    	$('#routeId',parent.document).val(data.message);
			    }		   
		   	  alert('保存成功!!');
		   	  window.location.reload();
		   }else{
		   	  alert(data.message);
		   }	  
		  },
		  error:function(){
		  	loading.close();
			alert("error!!");
	      }         
  	 });
   });
  
}


$(document).ready(function(){
	createTrafficItems();  //交通方式

	searchLineRoute();
	var obj=$("#js_0");
	$("textareaBox",obj).val();　
	
	
setHeight(window);  
}); 


function setHeight(w) { 
var parentFrame = $(w.parent.document).find(".iframeID"); 
var documentHeight=0; 
$.each(parentFrame,function(index,items){ 
var parentFrameBox = $(items).parent(); 
var boxCss = parentFrameBox.css("display"); 
if (boxCss != "none") { 
documentHeight = w.document.body.scrollHeight; 
parentFrame.height(documentHeight + 50); 
return false; 
} 
}); 

if (w == w.parent) 
{ 
return; 
} 
setHeight(w.parent); 
} 

// 查询行程信息
function searchLineRoute(){
	trafficBoxIndex = 0;
	$(".nrBox").html("");
	var n_day = $('#n_day').val();// 取选择的天数
	var productId = $('#productId').val();// 产品ID
	$.ajax({
		url : "/vst_back/prod/compship/travelDesign/findTravelDesignContent.do",
		type : "post",
		dataType : 'json',
		data : {n_day:n_day,productId:productId},
		success : function(data) {
			var routeId = $('#routeId',parent.document).val();
		    if(routeId.length<=0){
		    	$('#routeId',parent.document).val(data.routeId);
		    }
			if(data.result=='entry'){
				createMoreJsBox();
			}else{
				$('#routeDetailId').val(data.routeDetailId);// 行程ID
				$('#tour_title').val(data.dTitle);// 行程标题
				var trafficTool = data.trafficTool;// 交通工具
				var strs= new Array();
				if(trafficTool!=undefined){
					strs=trafficTool.split(",");
					for(var i=0;i<strs.length ;i++ )   
				    {   
				       $("input[name='traffic_item']").each(function(){
						    if($(this).attr('value')==strs[i]){
						    	$(this).attr('checked','checked');
					    	}		
				       });	
				    } 
			    }
			    var mealsDesc = data.mealsDesc;// 用餐类型
			    strs= new Array();
				if(mealsDesc!=undefined){
					strs=mealsDesc.split(",");
					for(var i=0;i<strs.length ;i++ )   
				    {   
				       $("input[name='mealsDesc']").each(function(){
						    if($(this).attr('value')==strs[i]){
						    	$(this).attr('checked','checked');
					    	}		
				       });	
				    } 
			    }
			    $('#stayDesc').val(data.stayDesc);
			    $('#searchText').val(data.days);
				$(data.array).each(function(index) { 
	                var val = data.array[index]; 
	                createMoreJsBox(val.rTitle,val.titleType,val.content,val.routeDescId);
                });	    
			}
			initLoading.close();
		}
	});	
}

// 查看与添加图片
function selectImgBtn(id){
	if(id) {
		var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+id+"&parentId=${productId}&objectType=CRUISE_COMBINATION_PRODUCTS&logType=PROD_TRAVEL_DESIGN";
		new xDialog(url,{},{title:"图片列表",iframe:true,width:800});
	}else{
		alert('请先保存当日行程信息!!');
		return;
	}
}

</script>
</body>
</html>
