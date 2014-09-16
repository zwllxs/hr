<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="position:relative">
<div class="iframe_header">
        <ul class="iframe_nav">
            <li>线路
            </li>
            <li>产品维护 </li>
            <li class="active">退改规则</li>
        </ul>
    </div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
        <p class="pl15">注：供应商打包的商品，此处设置的是产品对用户端的退改规则。且会将这个值赋值给到该产品的商品。</p>
        <p class="pl15">注：自主打包的产品，此处设置的是产品对用户端的退改规则。被打包的单项产品，其依旧有自己的独立退改规则，用于内部结算使用。</p>
        <p class="pl15">注：关联销售的产品，不参与这里的规则。</p>
    </div>
	<div id="timePriceDiv" class="time_price">
	</div>
 <div class="p_box box_info mt10" >
 	<div class="price_tab">
        <ul class="J_tab ui_tab">
            <li class="active" data="0"><a href="javascript:;">设置退改规则</a></li>
        </ul>
     </div>
     <div class="price_content">
     <div style="margin:-10px 0 0 20px">   
     <form id="timePriceForm">
     <input type="hidden" name="productId" id="productId" value="${productId}">
	 <div class="p_date">
	 	
            <ul class="cal_range">
                <li><i class="cc1">*</i>日期范围:</li>
                <li><input type="text" name="startDate" errorEle="selectDate" class="Wdate" required=true id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" /></li>
                <li>-</li>
                <li><input type="text" name="endDate" errorEle="selectDate" class="Wdate" required=true id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" /></li>
                <li class="cc3">仅可操作两年内的时间</li>
                <div id="selectDateError" style="display:inline"></div>
            </ul>
            <ul class="app_week">
                <li><i class="cc1">*</i>适用日期:</li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDayAll">全部</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="2">一</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="3">二</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="4">三</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="5">四</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="6">五</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="7">六</label></li>
                <li><label class="checkbox"><input type="checkbox" class="checkbox_top" name="weekDay" value="1">日</label></li>
            </ul>
    </div>
        <div class="J_con active" style="position:relative; padding-bottom:80px">
      		  <ul class="cal_range">
                <li><i class="cc1">*</i>  退改类型：:</li>
                <li><select name="cancelStrategy">
                	<option value="MANUALCHANGE">人工退改</option>
                	<option value="UNRETREATANDCHANGE">不退不改</option>
                </select></li>
            </ul>
		</div>
		</form>
 </div>  
 </div>
 </div>
 <div class="p_box box_info clearfix mb20">
            <div class="fl operate"><a class="btn btn_cc1" id="timePriceSaveButton">保存</a><a href="javascript:void(0);" style="margin-left:100px;" class="showLogDialog btn btn_cc1" param="{'objectId':${productId},'objectType':'SUPP_GOODS_GOODS'}">操作日志</a></div>
        </div>
 </div>
 </div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script src="/vst_back/js/pandora-calendar.js"></script>

<script>

	var good = {};
	var globalIndex = 0;
	var specDate;
	$("#backToLastPageButton").click(function(){
		window.history.go(-1);
	});
	
	
	$("#timePriceSaveButton").click(function(){
	
	  //验证日期
	  if(!$("#timePriceForm").validate().form()){
		  return;
	   }
		var loading = top.pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/prod/refund/editProductReFund.do",
			data :　$("#timePriceForm").serialize(),
			dataType:'JSON',
			success : function(result){
				$.alert(result.message,function(){
					refresh();
				});
				loading.close();
			},
			error : function(){
				$.alert('服务器错误');
				loading.close();
			}
		})
	});
	
	
	    //设置week选择,全选
		$("input[type=checkbox][name=weekDayAll]").click(function(){
			if($(this).attr("checked")=="checked"){
				$("input[type=checkbox][name=weekDay]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=weekDay]").removeAttr("checked");
			}
		})
		
		
		 //设置week选择,单个元素选择
		$("input[type=checkbox][name=weekDay]").click(function(){
			if($("input[type=checkbox][name=weekDay]").size()==$("input[type=checkbox][name=weekDay]:checked").size()){
				$("input[type=checkbox][name=weekDayAll]").attr("checked","checked");
			}else {
				$("input[type=checkbox][name=weekDayAll]").removeAttr("checked");
			}
		});
         
         	var template = {
                warp: '<div class="ui-calendar"></div>',
                calControl: '<span class="month-prev" {{stylePrev}} title="上一月">‹</span><span class="month-next" {{styleNext}} title="下一月">›</span>',
                calWarp: '<div class="calwarp clearfix">{{content}}</div>',
                calMonth: '<div class="calmonth">{{content}}</div>',
                calTitle: '<div class="caltitle"><span class="mtitle">{{month}}</span></div>',
                calBody: '<div class="calbox">' +
                            '<i class="monthbg">{{month}}</i>' +
                            '<table cellspacing="0" cellpadding="0" border="0" class="caltable">' +
                                '<thead>' +
                                    '<tr>' +
                                        '<th class="sun">日</th>' +
                                        '<th class="mon">一</th>' +
                                        '<th class="tue">二</th>' +
                                        '<th class="wed">三</th>' +
                                        '<th class="thu">四</th>' +
                                        '<th class="fri">五</th>' +
                                        '<th class="sat">六</th>' +
                                    '</tr>' +
                                '</thead>' +
                                '<tbody>' +
                                    '{{date}}' +
                                '</tbody>' +
                            '</table>' +
                        '</div>',
                weekWarp: '<tr>{{week}}</tr>',
                day: '<td {{week}} {{dateMap}} >' +
                        '<div {{className}}>' +
                            '<span class="calday">{{day}}</span>' +
                            '<span class="calinfo"></span>' +
                            '<div class="fill_data"></div>' +
                        '</div>' +
                     '</td>'
            };
         
           	// 填充日历数据
            function fillData() {
                var that = this,
                    url = "/vst_back/prod/refund/findProductReFund.do";
				
				
                var month = that.options.date.getMonth();
                var year = that.options.date.getFullYear();
                var day = that.options.date.getDate();
                
                specDate = year+"-"+(month+1)+"-"+day;
                
                function setData(data) {
                
                    if (data === undefined) {
                        return;
                    }
                    console.debug(data);
                    data.forEach(function (arr) {
                        var $td = that.warp.find("td[date-map=" + arr.specDateStr + "]");
                        var liArray = [];
                        var cancelStrategy = "";
                        if(arr.cancelStrategy=='MANUALCHANGE'){
                        	cancelStrategy = '人工退改';
                        }else if(arr.cancelStrategy=='UNRETREATANDCHANGE'){
                        	cancelStrategy = '不退不改';
                        }
                        liArray.push('<li>'+cancelStrategy+'</li>');
                        $td.find("div.fill_data").append("<ul>"+liArray.join('')+"</ul>");
                    });

                }
                
                //将分钟数转换为天/时/分
                function minutesToDate(time){
                	var time = parseInt(time);
					var day=0;
					var hour=0;
					var minute=0;
					if(time >  0){
						day = Math.ceil(time/1440);
						if(time%1440==0){
							hour = 0;
							minute = 0;
						}else {
							hour = parseInt((1440 - time%1440)/60);
							minute = parseInt((1440 - time%1440)%60);
						}
						
					}else if(time < 0 ){
						time = -time;
						hour = parseInt(time/60);
						minute = parseInt(time%60);
					}
					if(hour<10)
						hour = "0"+hour;
					if(minute<10)
						minute = "0"+minute;
					return day+"天"+hour+"点"+minute+"分";
                }           
                
                $.ajax({
                    url: url,
                    type: "POST",
                    dataType: "JSON",
                    data : {"productId" : $("#productId").val(),"specDate" : specDate},
                    success: function (json) {
                       setData(json);
                    },
                    error: function () { }
                });

            }
         
         function refresh(){
         	
                pandora.calendar({
                    sourceFn: fillData,
                    autoRender: true,
                    frequent: true,
                    showNext: true,
                    mos :0,
                    template: template,
                    target: $("#timePriceDiv")
                });
         }
         
         refresh()
</script>
