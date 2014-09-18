<!DOCTYPE html>
<html>
  <head>
    <#include "/base/head_meta.ftl"/>
  </head>
  <body>
  <div class="iframe_content">   
    <div class="p_box">
            <div>经停详细信息：${trainNo}</div>
            <div><button class="pbtn pbtn-small btn-ok" style="float: center; margin-top: 20px;" id="add_button" trainId="${trainId}" trainNo="${trainNo}">添加</button></div>
    </div>
    
    <!-- 主要内容显示区域\\ -->
    <div class="p_box">
      <table class="p_table table_center">
        <thead>
            <tr>
                <th>站次编号</th>
                <th>车站名称</th>
                <th>到站时间</th>
                <th>出战时间</th>
                <th>停站时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <#list bizTrainStops as stop> 
            <tr>
                <td>${stop.stopStep!''}</td>
                <td>${stop.stopStationString!''}</td>
                <td>${stop.arrivalTime!''}</td>
                <td>${stop.departureTime!''}</td>
                <td>${stop.stopTime!''}</td>
                <td>
                    <#if stop.cancelFlag == "Y"> 
                        <span style="color:green" class="cancelProp">有效</span>
                    <#elseif stop.cancelFlag == "N">
                        <span style="color:red" class="cancelProp">无效</span>
                    <#else>
                        <span style="color:red" class="cancelProp"></span>
                    </#if>
                </td>
                <td class="oper">
                    <a href="javascript:void(0);" class="editProp" stopId="${stop.stopId!''}" trainId="${trainId}" trainNo="${trainNo}">编辑</a>
                    <#if stop.cancelFlag == "Y"> 
                         <a href="javascript:void(0);" class="cancelProp" data="N" stopId="${stop.stopId!''}">设为无效</a>
                    <#elseif stop.cancelFlag == "N">
                         <a href="javascript:void(0);" class="cancelProp" data="Y" stopId="${stop.stopId!''}">设为有效</a>
                    </#if>
                  </td>
                </tr>
            </#list>
        </tbody>
      </table>
    <button class="pbtn pbtn-small btn-ok" style="margin-left: 50%; margin-top: 20px;" id="close_button">关闭</button>
    </div><!-- div p_box -->
  </div><!-- //主要内容显示区域 -->

    <#include "/base/foot.ftl"/>
    <script>
	    $("#close_button").on('click',function(){
	        stopInfoDialog.close();
	    });
	    
        //添加
        $("#add_button").on('click',function(){
            var url = "/vst_back/biz/trainStop/showAddTrainStop.do";
            addDialog = new xDialog(url, {"trainId":$(this).attr("trainId"), "trainNo":$(this).attr("trainNo")}, {title:"添加经停车站",width:800});
        });
        
        //修改
        $("a.editProp").on('click',function(){
            var url = "/vst_back/biz/trainStop/showUpdateTrainStop.do";
            updateDialog = new xDialog(url,{"stopId":$(this).attr("stopId"),"trainId":$(this).attr("trainId"), "trainNo":$(this).attr("trainNo")}, {title:"编辑经停车站",width:800});
        });
        
        //设置有效或无效
        $("a.cancelProp").on("click",function(){
            var entity = $(this);
            var cancelFlag = entity.attr("data");
            var stopId = entity.attr("stopId");
            msg = cancelFlag === "N" ? "确认设为无效？" : "确认设为有效？";
            if(confirm(msg)){    
                $.ajax({
                    url : "/vst_back/biz/trainStop/setCancelFlag.do",
                    type : "post",
                    data : {"cancelFlag":cancelFlag,"stopId":stopId},
                    success : function(result) {
                        if (result.code == "success") {
                            pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
                                if(cancelFlag == 'N'){
                                    entity.attr("data","Y");
                                    entity.text("设为有效");
                                    $("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
                                }else if(cancelFlag == 'Y'){
                                    entity.attr("data","N");
                                    entity.text("设为无效");
                                    $("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
                                }
                            }});
                        }else {
                            pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
                            }});
                        }       
                    }
                });
            }
        });
    </script>
  </body>
</html>
