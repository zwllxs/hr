<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<#include "/base/taglibs.ftl"/>

<style type="text/css">
     ul, li, div, span, img, p{margin: 0; padding: 0;}
     #mydiv{width: 670px; background-color: #fff; border: 1px solid #aaa; position: absolute; left: 0px; height: 825px; overflow-y:scroll;}
     #mydiv ul{position: relative; overflow: hidden; list-style: none; margin: 20px 0 15px 10px;}
     #mydiv li{float: left; background-color: #f6f6f6; width: 190px; height: 192px; position: relative; border: 1px solid #ddd; margin-left: 10px; margin-bottom: 10px; cursor: default;}
     #mydiv li.delActive{background-color: #f0f8fd; border: 1px solid #cae8f9;}
     .img-head{padding: 0 5px; overflow: hidden; height: 20px; line-height: 24px; font-family: arail;}
     .img-head span{float: left; font-weight: bold; font-size: 18px;}
     .img-head i{float: right; font-style: normal; font-size: 18px; font-weight: bold; color: #6e6f6f; display: none; cursor: pointer;}
     .img-head i:hover{color: red;}
     .drag-ele img, .moveEle img{width: 180px; height: 120px; padding: 5px;}
     .moveEle{position: absolute; z-index: 2; background-color: #f0f8fd; border: 1px solid #cae8f9; width: 190px; height: 192px; left: 0; right: 0; text-align: center;}
     #mydiv li.emptyEle{border: 1px dashed #dedede; line-height: 190px; text-align: center; color: #ccc; font-size: 16; font-weight: bold;}
     #mydiv li.addImg{line-height: 150px; text-align: center; background: url("${requestURL}${contextPath?trim }/img/addImg.png") no-repeat center center; text-indent: -9999px; background-color: #fff; cursor: pointer;}
     .img-info{padding: 0 5px; font-size: 12px; line-height: 16px; text-align: left;}
 </style>

</head>
<body style="overflow:hidden">
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">图片维护</a> &gt;</li>
        </ul>
</div>
<div class="tiptext tip-warning">
	<ul class="iframe_nav">
	    <li>说明：<br></li>
	    <li>1.拖动图片位置可以设置图片显示顺序，保存后生效；<br></li>
	    <li>2.第一张图为主图，拖动图片到第一张图即可设置主图，保存后生效<br></li>
	    <#if minNum?? && maxNum == null>
	    	<li>3.最少上传<span style="color:#F00;font-weight:bold">&nbsp;${minNum }&nbsp;</span>张图片<br></li>
	    <#elseif maxNum?? && minNum == null>
	    	<li>3.最多上传<span style="color:#F00;font-weight:bold">&nbsp;${maxNum }&nbsp;</span>张图片 <br></li>
	    <#elseif minNum?? && maxNum??>
	    	<#if minNum == maxNum && minNum &gt; 0>
	    		<li>3.有且仅能上传<span style="color:#F00;font-weight:bold">&nbsp;${minNum }&nbsp;</span>张图片 <br></li>
	    	<#else>
	    		<li>3.可上传<span style="color:#F00;font-weight:bold">&nbsp;${minNum}-${maxNum}&nbsp;</span>张图<br></li>
	    	</#if>
	    </#if>
	</ul>
</div>
<div class="operate" style="margin-bottom:10px;">
	<a class="btn btn_cc1" id="udpate_button" href="javascript:void(0);">保存</a>
	<span style="color:#F00;font-weight:bold">设置图片顺序后请点击“保存”按钮！</span>
</div>
<div>
	<!-- 照片限制 -->
	<input type="hidden" id="minNum" name="minNum" value="${minNum }"/>
	<input type="hidden" id="maxNum" name="maxNum" value="${maxNum }"/>
	<form action="#" method="post" id="dataForm">
		<input type="hidden" value="${objectType!''}" name="objectType"  id="objectType"/>
		<input type="hidden" value="${objectId!''}" name="objectId"  id="objectId"/>
		<input type="hidden" value="${parentId!''}" name="parentId"  id="parentId"/>
		<input type="hidden" value="${logType!''}" name="logType"  id="logType"/>
		
		<div id="mydiv" style="width:645px;height:800px;text-align: center;">	
		    <ul>
		    	<#assign r_index = 0/>
		    	<#list list as item> 
			        <li class="drag-ele">
			            <p class="img-head">
				            <span class="photoList">
				            		${item.photoId!'' }
				            </span><i title="删除">×</i></p>
			            <img src="http://pic.lvmama.com${item.photoUrl}" width="180" height="120" title="图片" />
			            <p class="img-info">${item.photoContent!'' }</p>
			            <input type='hidden' class="delPhotoId" name='photoList[${r_index}].photoId' jsonName="photoId${r_index}" value='${item.photoId }'/>
		    			<input type="hidden" name='photoList[${r_index}].photoSeq' jsonName="photoSeq${r_index}" value="${item.photoSeq!''}"/>	
			        </li>
			        <#assign r_index = r_index + 1/>
			    </#list>
		        <li class="addImg">
		            	添加图片
		        </li>
		    </ul>
		</div>
	</form>
</div>
<div id="photoTypeDiv" style="display:none;">
<table class="p_table form-inline">
            <tr>
            	<td class="p_label" style="width:15%;">选择图片的类型：</td>
                <td>
					<select id="photoType" name="photoType">
						<option value=""></option>
						<#list typeList as type>
							<option value="${type.type!''}">${type.cnName!''}</option>
						</#list>
					</select>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
</table>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script type="text/javascript">
 function strToObj(str){    
        str = str.replace(/&/g,"','");    
        str = str.replace(/=/g,"':'");    
        str = "({'"+str +"'})";    
        obj = eval(str);     
        return obj;    
 }
 function photoExtHtmlCallback() {
 	return $("#photoTypeDiv").html();
 }
 function photoCallback(photoJson, extJson){
	if(photoJson != null && photoJson !=''){
		var objectId = "${objectId!''}";
		var objectType = "${objectType!''}";
		var parentId = "${parentId!''}";
		var logType = "${logType!''}";
		
		var photo = new Object();
		photo.fileId = photoJson.photo.photoId;
		photo.photoContent = photoJson.photo.photoName;
		photo.photoUrl = photoJson.photo.photoOriginUrl;
		if(extJson){
			extJson = strToObj(extJson);
			photo.photoType = extJson.photoType;
		}		
		var json = JSON.stringify(photo)
		
		var jsonData = "photoJson=" + json	+ "&objectId=" + objectId + "&objectType=" + objectType+ "&parentId=" + parentId + "&logType=" + logType;
		$.ajax({
			url : "/vst_back/pub/comphoto/addBatchComPhoto.do",
			type : "post",
			dataType:"json",
			async: false,
			data : jsonData,
			success : function(result) {
			   if(result.code=="success"){
					alert(result.message);
	   				window.location.reload();
				}else {
					alert(result.message);
		   		}
			}
		});
	}else{
		alert("保存图片失败");
	}
}

$(function () {
	var photoListSize = $("span[class=photoList]").size();
	if(photoListSize != null && photoListSize > 0){
		var imgHeadHtml = $('.drag-ele').eq(0).find('.img-head span').html();
        $('.drag-ele').eq(0).find('.img-head span').html(imgHeadHtml + '<lable class="mainFlag" style="color:#F00;font-weight:bold">(主)</lable>');
        
        var minNum = $("#minNum").val();
	    var maxNum = $("#maxNum").val();
		if(minNum != null && minNum.length > 0 && maxNum != null && maxNum.length > 0){
			if(maxNum == minNum || photoListSize >= parseInt(maxNum)){
				$(".addImg").hide();
			}
		}else if(maxNum != null && maxNum.length > 0){
			if(photoListSize >= parseInt(maxNum)){
				$(".addImg").hide();
			}
		}
	}
	
    //回调函数
    function dragCallBack(){
    }

    //图片说明30个字，超出则截断；
    var len = $('.img-info').length;
    for(var i=0; i<len; i++){
        var txt = $('.img-info').eq(i).text();
        if(txt.length>30){
            var newTxt = txt.substr(0,28) + '…';
            $('.img-info').eq(i).text(newTxt);
        }
    }

     //禁止文本选中，处理chrome的bug
     document.body.onselectstart=function(){
        return false;
     };

    /*hover效果和删除*/
    $('.drag-ele').hover(function(){
        $(this).addClass('delActive');
        $(this).find('i').show();
        $(this).find('i').on('click', function(){
        	var delPhotoId = $($(this).parents('li').find("input[name^='photoList']")[0]).val();
        	delPhoto(delPhotoId);
        	
            $(this).parents('li').remove();
            sortNum();
            return false;
        })
    },function(){
        $(this).removeClass('delActive');
        $(this).find('i').hide();
    });

    /*编号重排*/
    function sortNum(){
        var eleLen = $('.drag-ele').length;
        for(var i=0; i<eleLen; i++){
            var index = i+1;
            var imgHead = $('.drag-ele').eq(i).find('.img-head span');
            $(imgHead).find(".mainFlag").empty();
			if(i == 0){
				 $('.drag-ele').eq(i).find('.img-head span').html(imgHead.html() + '<lable class="mainFlag" style="color:#F00;font-weight:bold">(主)</lable>');
			}else{
				$('.drag-ele').eq(i).find('.img-head span').html(imgHead.html());
			}
        }
        
        var photoListSize = $("span[class=photoList]").size();
        if(photoListSize == 0 && parseInt($("#minNum").val()) > 0){
        	$(".addImg").show();
        }
    }

    //元素移动
    var _bool = false, //鼠标是否按下
            cloneEle,
            moveEle,
            evtX,
            evtY;
    $('.drag-ele').on('mousedown', function (e) {
        _bool = true;
        if(e.target.tagName.toUpperCase() == 'I'){
            return false;
        }
        if(e.which !== 1){
            return false;
        }
        if(!cloneEle) cloneEle = $(this).clone(true);
        moveEle = "<div class='moveEle'>"+cloneEle.html()+"</div>"; //移动的新元素
        $('body').append(moveEle);  //在页面增加移动元素；
        $(this).html("拖动到这里").addClass('emptyEle').css('background-color','#f6f6f6');  //把目标元素变成空白内容

        evtX = e.pageX+10;
        evtY = e.pageY+20;
        $('.moveEle').css('left', evtX + 'px');
        $('.moveEle').css('top', evtY + 'px');
    });
    
    $('#mydiv').delegate('.drag-ele','mousemove', function (e) {
        if (!_bool) {
            return false
        }
        $(this).removeClass('delActive');

        evtX = e.pageX+10;
        evtY = e.pageY+20;
        $('.moveEle').css('left', evtX + 'px');
        $('.moveEle').css('top', evtY + 'px');
        if($(e.currentTarget).hasClass('emptyEle')){
            return false;
        }else{
            var curIndex = $('.drag-ele').index($(e.currentTarget));
            var empIndex = $('.drag-ele').index($('.emptyEle'));
            if(curIndex<empIndex){
                $(e.currentTarget).before($('.emptyEle'));
            }else{
                $(e.currentTarget).after($('.emptyEle'));
            }
        }
    });
    
    $(document).bind('mouseup', function () {
        if (_bool) {
        	if(cloneEle)
            	cloneEle.css({'left':'auto', 'top':'auto'});
            $('.emptyEle').replaceWith(cloneEle);
            $('.moveEle').remove();
            cloneEle = "";
            sortNum();
            //调用回调函数
            dragCallBack();
        }
        $('.drag-ele').removeClass('delActive');
        _bool = false;
    })
    
    $(".addImg").bind("click",function(){
    	if($("#objectType").val() != "" && $("#objectId").val() != "") {
    		var url = "/pet_back/photo/photo/imgPlugIn.do";
    		url += "?relationId=${objectId!''}&relationType=1";
    		
    		comPhotoAddDialog = new xDialog(url,{},{title:"上传图片",iframe:true,width:840,height:800});
		}	
    });
    
    function delPhoto(photoId){
		if(photoId != null && photoId != ''){
			var jsonData = "id=" + photoId + "&parentId=" + $("#parentId").val();
			$.ajax({
	    		url : "/vst_back/pub/comphoto/deleteComPhoto.do",
	    		type : "post",
	    		dataType:"json",
	    		async: false,
	    		data : jsonData,
	    		success : function(result) {
	    		   if(result.code=="success"){
	    				alert(result.message);
	       				window.location.reload();
	    			}else {
	    				alert(result.message);
	    	   		}
	    		}
	    	});
		}else{
			return;
		}
	}
    
    $("#udpate_button").bind("click",function(){
    	var photoListSize = $("span[class=photoList]").size();
    	if(photoListSize < 1){
    		alert("无图片不能保存");
        	return false;
    	}
    	
    	if(photoListSize > 2){
    		
    		alert("最多可上传2张图片");
    		return false;
    	
    	}
    	
    	//图片限制
    	var minNum = $("#minNum").val();
    	var maxNum = $("#maxNum").val();
    	if(minNum != null && minNum.length > 0 && maxNum != null && maxNum.length > 0){
			if(maxNum == minNum && (photoListSize > minNum || photoListSize < minNum)){
				alert("有且仅能上传 " + minNum + " 张照片");
        		return false;
			}
		}
    	
    	if(minNum != null && minNum.length >0 ){
    		if(photoListSize < parseInt(minNum)){
    			alert("至少上传 " + minNum + " 张照片");
        		return false;
    		}
    	}
    	
    	if(maxNum != null  && maxNum.length >0){
    		if(photoListSize > parseInt(maxNum)){
    			alert("最多上传 " + maxNum + " 张照片");
        		return false;
    		}
    	}
    	
    	//封装json数据
    	var photoArr = new Array();
    	var eleLen = 0;
    	if($('.drag-ele') != null && $('.drag-ele').length > 0){
    		eleLen = $('.drag-ele').length;
    	}
    	
        for(var i=0; i<eleLen; i++){
        	var photo = new Object();
            var inputObj = $('.drag-ele').eq(i).find('input');
            photo.photoId = $(inputObj.eq(0)).val();
            photoArr.push(photo);
        }
    	
    	var photoJson = "";
    	if(photoArr != null && photoArr.length > 0){
    		photoJson = JSON.stringify(photoArr)
    	}
    	
    	var jsonData = "photoJson=" + photoJson 
    		+ "&objectId=" + $("#objectId").val()
    		+"&objectType=" + $("#objectType").val()
    		+"&parentId=" + $("#parentId").val()
    		+"&logType=" + $("#logType").val();
    		
    	$.ajax({
    		url : "/vst_back/pub/comphoto/updateComPhoto.do",
    		type : "post",
    		dataType:"json",
    		async: false,
    		data : jsonData,
    		success : function(result) {
    		   if(result.code=="success"){
    				alert(result.message);
       				window.location.reload();
    			}else {
    				alert(result.message);
    	   		}
    		}
    	});
    });
    
});
</script>
