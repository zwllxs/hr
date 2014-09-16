<!DOCTYPE html>
<html>
  <head>
    <#include "/base/head_meta.ftl"/>
  </head>
  <body>
  <div class="iframe_content">   
    <div class="p_box">
        <form method="post" action='/vst_back/biz/train/findTrainList.do' id="searchForm">
            <table class="s_table">
                <tbody>
                    <tr>
                        <td class="s_label">车次号：</td>
                        <td class="w18"><input type="text" id="trainNo" name="trainNo" value="${bizTrain.trainNo!''}"></td>
                        <td class="s_label">始发城市：</td>
                        <td class="w18">
                            <input type="text" id="startDistrictString" name="startDistrictString" value="${bizTrain.startDistrictString!''}" errorele="searchValidate" class="searchInput" readonly="readonly">
                            <input type="hidden" id="startDistrict" name="startDistrict" value="${startDistrict!''}">
                        </td>
                        <td class="s_label">到达城市：</td>
                        <td class="w18">
                            <input type="text" id="arriveDistrictString" name="arriveDistrictString" value="${bizTrain.arriveDistrictString!''}" errorele="searchValidate" class="searchInput" readonly="readonly">
                            <input type="hidden" id="arriveDistrict" name="arriveDistrict" value="${arriveDistrict!''}">
                        </td>
                        <td class="s_label">车次类型：</td>
                        <td class="w18">
                            <select id="trainType" name="trainType">
                                <option value=""></option>
                                <#list trainTypes as type>
                                    <#if type.type == bizTrain.trainType>
                                        <option value="${type.type!''}" selected="selected">${type.cnName!''}</option>
                                    <#else>
                                        <option value="${type.type!''}">${type.cnName!''}</option>
                                    </#if>
                                </#list>
                            </select>
                        </td>
                        <td class="operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                        <td class="operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                        <input type="hidden" name="page" value="${page!''}">
                    </tr>
                </tbody>
            </table>    
        </form>
    </div>
    
    <!-- 主要内容显示区域\\ -->
    <div class="p_box">
      <table class="p_table table_center">
        <thead>
            <tr>
                <th>ID</th>
                <th>车次号</th>
                <th>车次类型</th>
                <th>出发城市</th>
                <th>抵达城市</th>
                <th>是否有效</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <#list pager.items as bizTrain> 
            <tr>
                <td>${bizTrain.trainId!''}</td>
                <td>${bizTrain.trainNo!''}</td>
                <td>${bizTrain.trainTypeString!''}</td>
                <td>${bizTrain.startDistrictString!''}</td>
                <td>${bizTrain.arriveDistrictString!''}</td>
                <td>
                    <#if bizTrain.cancelFlag == "Y"> 
                        <span style="color:green" class="cancelProp">有效</span>
                    <#elseif bizTrain.cancelFlag == "N">
                        <span style="color:red" class="cancelProp">无效</span>
                    <#else>
                        <span style="color:red" class="cancelProp"></span>
                    </#if>
                </td>
                <td class="oper">
                    <a href="javascript:void(0);" class="editProp" data="${bizTrain.trainId}">编辑</a>
                    <#if bizTrain.cancelFlag == "Y"> 
                         <a href="javascript:void(0);" class="cancelProp" data="N" trainId="${bizTrain.trainId}">设为无效</a>
                    <#elseif bizTrain.cancelFlag == "N">
                         <a href="javascript:void(0);" class="cancelProp" data="Y" trainId="${bizTrain.trainId}">设为有效</a>
                    </#if>
                    <a href="javascript:void(0);" class="stopInfo" trainId="${bizTrain.trainId}" trainNo="${bizTrain.trainNo}">经停信息</a>
                  </td>
                </tr>
            </#list>
        </tbody>
    </table>
    <#if pager.items?exists> 
        <div class="paging"> 
            ${pager.getPagination()}
        </div> 
    </#if>

    </div><!-- div p_box -->
    </div><!-- //主要内容显示区域 -->
    <#include "/base/foot.ftl"/>
    
    <script>
        //选择出发城市
        $("#startDistrictString").on('click', function(){
            districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{id:"startDistrict"},{title:"选择出发城市",iframe:true,width:"1000",height:"600"});
        });
        
        //选择抵达城市
        $("#arriveDistrictString").on('click', function(){
            districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{id:"arriveDistrict"},{title:"选择抵达城市",iframe:true,width:"1000",height:"600"});
        });
        
        //选择城市
        function onSelectDistrict(params){
            if(params != null){
                var districtName = params.districtName;
                var districtId = params.districtId;
                if(districtSelectDialog.data.id === "startDistrict"){
                    $("#startDistrictString").val(districtName);
                    $("#startDistrict").val(districtId);
                } else {
                    $("#arriveDistrictString").val(districtName);
                    $("#arriveDistrict").val(districtId);
                }
            }
            districtSelectDialog.close();
        }
        
        //查询
        $("#search_button").on('click',function(){
            $("#searchForm").submit();
        });
        
        //新增
        $("#new_button").on('click',function(){
            var url = "/vst_back/biz/train/showAddTrain.do";
            addDialog = new xDialog(url, {}, {title:"新增车次信息",width:800});
        });
        
        //修改
        $("a.editProp").on('click',function(){
            var trainId = $(this).attr("data");
            var url = "/vst_back/biz/train/showUpdateTrain.do";
            updateDialog = new xDialog(url,{"trainId":trainId}, {title:"编辑车次信息",width:800});
        });
        
        //经停信息
        $("a.stopInfo").on('click',function(){
            var trainId = $(this).attr("trainId");
            var trainNo = $(this).attr("trainNo");
            var url = "/vst_back/biz/trainStop/findTrainStopList.do";
            stopInfoDialog = new xDialog(url,{"trainId":trainId,"trainNo":trainNo}, {title:"经停信息",width:800});
        });
        
        //设置有效或无效
        $("a.cancelProp").on("click",function(){
            var entity = $(this);
            var cancelFlag = entity.attr("data");
            var trainId = entity.attr("trainId");
            msg = cancelFlag === "N" ? "确认设为无效？" : "确认设为有效？";
            if(confirm(msg)){    
                $.ajax({
                    url : "/vst_back/biz/train/setTrainCancelFlag.do",
                    type : "post",
                    data : {"cancelFlag":cancelFlag,"trainId":trainId},
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
