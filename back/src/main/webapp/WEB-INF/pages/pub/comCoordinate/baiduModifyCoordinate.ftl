<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>驴妈妈_标地管理后台</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/vst_back/css/backstage_table.css" rel="stylesheet" type="text/css">
<link href="/vst_back/css/map.css" rel="stylesheet" type="text/css" />

<script src="http://pic.lvmama.com/js/jquery-1.7.js"></script>
<script src="http://api.map.baidu.com/api?v=1.4" type="text/javascript"></script>
<script src="http://dev.baidu.com/wiki/static/map/API/examples/script/convertor.js" type="text/javascript"></script>

</head>

<body>

   <table width="98%" border="0"  align="center" cellpadding="0" cellspacing="0">
     <tr>
       <td height="30" width="47"></td>
       <td width="552" colspan="2">
       <font onClick="history.back()"  style="cursor:pointer;font:#FF0000">返回上一页</font>
        </td>
      </tr>          
    </table>

	<table width="100%"  border="10"  cellpadding="4" cellspacing="1" bgcolor="#464646">
	  <tr height="30" bgcolor="#FFFFFF">
	    <td width="22%"  bgcolor="#FFFFFF">名称：</td>
	    <td>${comCoordinate.searchKey!''}
		    <#if signTypeName != null>
		    	&nbsp;&nbsp;&nbsp;&nbsp;类型：${signTypeName!''}&nbsp;
		    </#if>
	    </td>
	   </tr>
	   <tr  height="25"  bgcolor="#FFFFFF">
	    <td>地址：</td>
	    <td>${comCoordinate.address!''}&nbsp;</td>
	  </tr>
	  <tr  height="25" bgcolor="#FFFFFF">
	    <td>经度：</td>
	    <td>${comCoordinate.longitude!''}&nbsp;</td>
	  </tr>
	  <tr  height="25"  bgcolor="#FFFFFF">
	    <td>纬度：</td>
	    <td>${comCoordinate.latitude!''}&nbsp;</td>
	  </tr>
	  <tr  height="25" bgcolor="#FFFFFF">
	    <td>根据名称：</td>
	    <td>
		    <label>
		      <input type="text" style="background-color: #ffeeee" id="searchKey" name="searchKey" value='${searchKey!''}' size="60" />
		      <input type="button" value="搜索坐标" onclick="chosethis(document.getElementById('searchKey').value)"/>
		    </label>
	    </td>
	  </tr>
	  
	  <tr  bgcolor="#FFFFFF">
	  	<!-- 左边查百度得到的百度地名列表 -->
	    <td style="background-color: #FFFF00" valign="top"><div id="results"></div></td>
	    <td valign="top">
	    <table width="100%"  border="1" cellpadding="0" cellspacing="0">
	      <tr>
	        <td width="65%">
	          <!-- 百度地图展示容器 -->
	          <div style="width: 100%; height: 510px; float:center; border: 1px solid black;" id="container"><input type="hidden" value="123456" id="centerId"/></div>
	        </td>
	        <!-- 右边坐标展示 -->
	        <td valign="top" bgcolor="#00FFFF">
	          <table width="100%" border="1" cellpadding="4" cellspacing="1" bgcolor="#464646" style="display:none" id="coordinateInfoTable">
	          	  <input id="coordId" value="${comCoordinate.coordId!''}" type="hidden" readonly="readonly"/>
	          	  <tr  bgcolor="#FFFFFF">
		            <td height="25">填写地址：</td>
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="40">${searchKey!''}</td>       
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="25">经纬度地址：</td>     
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td  height="40"><input id="address" value="${comCoordinate.address!''}" style="width:350px" type="text" readonly="readonly"/></td>    
		          </tr>
		           <tr  bgcolor="#FFFFFF">
		            <td  height="0.5"><input id="address"  type="hidden" value="${comCoordinate.address!''}"   /></td>    
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="25">经度：</td>
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="40"><input id="longitude" value=0.0 type="text" readonly="readonly"/></td>  
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="25">纬度：</td>       
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td height="40"><input id="latitude"  value=0.0 type="text" readonly="readonly"/></td>
		          </tr>
		          <tr  bgcolor="#FFFFFF">
		            <td  height="100%" align="center">
		              <input type="button" id="Submit3" value="更新经纬度坐标" onClick="getLocationAddress()"/>&nbsp;
		            </td>
		         </tr>
	        </table></td>
	      </tr>
	    </table></td>
	  </tr>
	</table>

    <!-- 登录弹出层 -->
	<div class="bgLogin"></div>
	<div class="LoginAndReg">
		<p class="topLogin"><span class="titleLogin">更新坐标</span><a class="btn-close" onclick="hideRapidDiv()"><img src="http://pic.lvmama.com/img/icons/closebtn.gif" alt="关闭" /></a></p>
		<table width="100%" border="1">
		  <tr>
		    <td>经纬度反查地址：</td>
		  </tr>
		  <tr>
		    <td height="40">
		    	<p id="coordinateAddress2"/>
		    </td>
		  </tr>
		  <tr>
		    <td>
		      <div align="center">
		            <input type="button" id="Submit6" value="更新坐标" onClick="updateCoordinate()"/>
		            <input type="button" id="Submit7" value="不更新" onClick="hideRapidDiv()"/>
		      </div>
		    </td>
		  </tr>
		</table>		
	</div>	
</body>
</html>

<script type="text/javascript">
var localLongitude="${comCoordinate.longitude!''}";
var localLatitude="${comCoordinate.longitude!''}";
var coordId="${comCoordinate.coordId!''}";
var searchKey="${comCoordinate.searchKey!''}";
var address="${comCoordinate.address!''}";
var objectId="${comCoordinate.objectId!''}";
var coordType="${comCoordinate.coordType!''}";
var objectType="${comCoordinate.objectType!''}";
var isHaveLatitude = "true";

//初始化百度地图
initBaiduMap(localLongitude,localLatitude,searchKey,address,coordId);

function initBaiduMap(localLongitude,localLatitude,searchKey,address,coordId){
	if(localLongitude==""){
	   localLongitude=116.404844;
	   isHaveLatitude = "false";
    }
	if(localLatitude==""){
	   localLatitude=39.923125;
	   isHaveLatitude = "false";
    }
	var map = new BMap.Map("container");
	var point = new BMap.Point(localLongitude,localLatitude);
	map.centerAndZoom(point, 15);
	map.enableScrollWheelZoom();                  // 启用滚轮放大缩小。
    map.enableKeyboard();                         // 启用键盘操作。
    map.addControl(new BMap.OverviewMapControl());//添加缩略地图控件
	map.addControl(new BMap.NavigationControl()); //添加导航控件
	map.addOverlay(markerInfoWindow(searchKey,address,point,coordId));//弹出默认的标签

	 /**
      * 根据景区名称查询坐标
      */ 
    chosethis = function (searchWord){
			if (searchWord=="") {
				alert("请输入搜索的景区名称");
			}
			window.openInfoWinFuns = null;
			var options = {
			  onSearchComplete: function(results){
			    // 判断状态是否正确
			    if (local.getStatus() == BMAP_STATUS_SUCCESS){
			    	document.getElementById("results").innerHTML="";
			        var s = [];
			        s.push('<div style="font-family: arial,sans-serif; border: 1px solid rgb(153, 153, 153); font-size: 12px;">');
			        s.push('<div style="background: none repeat scroll 0% 0% rgb(255, 255, 255);">');
			        s.push('<ol style="list-style: none outside none; padding: 0pt; margin: 0pt;">');
			        openInfoWinFuns = [];
			        //遍历查询结果
			        for (var i = 0; i < results.getCurrentNumPois(); i ++){
			        
			            var marker = addMarker(results.getPoi(i).point,i);
			            var openInfoWinFun = addInfoWindow(marker,results.getPoi(i),results.getPoi(i).point,i);
			            openInfoWinFuns.push(openInfoWinFun);
			            
			            // 默认打开第一标注的信息窗口
			            var selected = "";
			            if(i == 0){
			                selected = "background-color:#f0f0f0;";
			                openInfoWinFun();
			            }
			            s.push('<li id="list' + i + '" style="margin: 2px 0pt; padding: 0pt 5px 0pt 3px; cursor: pointer; overflow: hidden; line-height: 17px;' + selected + '" onclick="openInfoWinFuns[' + i + ']()">');
			            s.push('<span style="width:1px;background:url(http://api.map.baidu.com/bmap/red_labels.gif) 0 ' + ( 2 - i*20 ) + 'px no-repeat;padding-left:10px;margin-right:3px"> </span>');
			            s.push('<span style="color:#00c;text-decoration:underline">' + results.getPoi(i).title.replace(new RegExp(results.keyword,"g"),'<b>' + results.keyword + '</b>') + '</span>');
			            s.push('<span style="color:#666;"> - ' + results.getPoi(i).address + '</span>');
			            s.push('</li>');
			            s.push('');
			        }
			        s.push('</ol></div></div>');
			        document.getElementById("results").innerHTML = s.join("");
			    }else{
			    	$("#coordinateInfoTable").css({"display":"none"});
			    	document.getElementById("results").innerHTML="";
			    	alert("没有找到相关信息,请重新选择关键词！");
			    }
			  }
			};

			// 添加标注
			function addMarker(point, index){
			  var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {
			    offset: new BMap.Size(10, 25),
			    imageOffset: new BMap.Size(0, 0 - index * 25)
			  });
			  var marker = new BMap.Marker(point, {icon: myIcon});
			  map.addOverlay(marker);
			  return marker;
			}
			
			//添加信息窗口
			function addInfoWindow(marker,poi,point,index){
			    var maxLen = 20;
			    // infowindow的标题
			    var infoWindowTitle = '<div style="font-weight:bold;color:#CE5521;font-size:14px">'+poi.title+'</div>';
			    // infowindow的显示信息
			    var infoWindowHtml = [];
			    infoWindowHtml.push('<table cellspacing="0" style="table-layout:fixed;width:100%;font:12px arial,simsun,sans-serif"><tbody>');
			    infoWindowHtml.push('<tr>');
			    infoWindowHtml.push('<td style="vertical-align:top;line-height:16px">' + poi.address + ' </td>');
			    infoWindowHtml.push('</tr>');
			    infoWindowHtml.push('</tbody></table>');
			    var infoWindow = new BMap.InfoWindow(infoWindowHtml.join(""),{title:infoWindowTitle,width:200}); 
			   
			    var openInfoWinFun = function(){
			        marker.openInfoWindow(infoWindow);
			        for(var cnt = 0; cnt < maxLen; cnt++){
			            if(!document.getElementById("list" + cnt)){continue;}
			            if(cnt == index){
			                document.getElementById("list" + cnt).style.backgroundColor = "#f0f0f0";
			            }else{
			                document.getElementById("list" + cnt).style.backgroundColor = "#fff";
			            }
			            $("#coordinateInfoTable").css({"display":""});
						$("#address").val(poi.address);
						$("#longitude").val(point.lng);
						$("#latitude").val(point.lat);
			        }
			    }
			    
				var gc = new BMap.Geocoder();
			    marker.addEventListener("click", function(e){
			    	var pt = e.point;
				    gc.getLocation(pt, function(rs){
			        var addComp = rs.addressComponents;
			    	$("#coordinateInfoTable").css({"display":""});
					$("#address").val(poi.address);
					$("#longitude").val(e.point.lng);
					$("#latitude").val(e.point.lat);
					});
					//打开信息窗口
				    openInfoWinFun();
			    });
			    return openInfoWinFun;
			}
			
			var local = new BMap.LocalSearch("全国", options);
			local.search(searchWord);
		}
		if(isHaveLatitude == "false"){
			chosethis(searchKey);
		}
}

//创建标记(设置位置和弹出信息窗)
function markerInfoWindow(title,address,point,coordId){
	var opts = {
	  width : 250,     // 信息窗口宽度
	  height: 100,     // 信息窗口高度
	  title : title  // 信息窗口标题
	}
	var infoWindow = new BMap.InfoWindow(address, opts);  // 创建信息窗口对象
	var marker = new BMap.Marker(point);
	marker.enableDragging(true); // 设置标注可拖拽
	marker.addEventListener("dragging", function(e){
		$("#coordinateInfoTable").css({"display":""});
		$("#address").val(address);
		$("#longitude").val(e.point.lng);
		$("#latitude").val(e.point.lat);
		$("#coordId").val(coordId);
	});          
	marker.addEventListener("click", function(e){          
       this.openInfoWindow(infoWindow); 
        $("#coordinateInfoTable").css({"display":""});
		$("#address").val(address);
		$("#longitude").val(e.point.lng);
		$("#latitude").val(e.point.lat);
		$("#coordId").val(coordId);
	});
	return marker;
}	

/**
 * 根据坐标查询地区详细地址
 */
function getLocationAddress(){
	var longitude = $("#longitude").val();
	var latitude = $("#latitude").val();
	if ($.trim(longitude)=="" || $.trim(latitude)=="") {
		alert("经纬度不能为空");
		return;
	}
	$("#coordinateAddress2").html($("#address").val());
	showRadidLoginDiv();
}
	
/**
 * 更新坐标
 */
function updateCoordinate(isValid) {
	$("#submit6").attr("disabled", true);
	var coordId = $("#coordId").val();			
	var longitude = $("#longitude").val();
	var latitude = $("#latitude").val();	
	var address=$("#address").val();;

	$.ajax({type:"POST",
		url:"/vst_back/pub/comCoordinate/updateCoordinat.do",
		type : "post",
		async: false,
		data: {coordId:coordId,latitude:latitude,longitude:longitude,objectId:objectId,objectType:objectType,coordType:coordType,searchKey:searchKey,address:address},
		dataType:"json",
		success:function(json){
	     	if (json.flag=='Y') {
	     		alert("保存成功！");
	     	} else {
	     		alert(json.msg);
	     	}
	     	hideRapidDiv();
	 		location.reload();
		}
	});
}

function showRadidLoginDiv() {
	$(".bgLogin").show();		
	$(".LoginAndReg").show();						
	var topN = $(window).scrollTop()/2 + 150;
	var leftN = $(window).width()/2 - $(".LoginAndReg").width()/2;
	$(".LoginAndReg").fadeIn(200).css({"top":topN,"left":leftN,"position":"absolute"}); 
}

function hideRapidDiv() {		
	$(".bgLogin").hide();		
	$(".LoginAndReg").hide();	
}
</script>