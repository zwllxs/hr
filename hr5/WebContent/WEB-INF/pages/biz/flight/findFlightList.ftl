<!DOCTYPE html>
<html>
  <head>
    <#include "/base/head_meta.ftl"/>
  </head>
  <body>
  <div class="iframe_content">   
    <div class="p_box">
        <form method="post" action='/vst_back/biz/flight/findFlightList.do' id="searchForm">
            <table class="s_table">
                <tbody>
                    <tr>
                        <td class="s_label">航班号：</td>
                        <td class="w18"><input type="text" id="flightNo" name="flightNo" value="${bizFlight.flightNo!''}"></td>
                        <td class="s_label">出发城市：</td>
                        <td class="w18">
                            <input type="text" id="startDistrictString" name="startDistrictString" value="${bizFlight.startDistrictString!''}" errorele="searchValidate" class="searchInput" readonly="readonly">
                            <input type="hidden" id="startDistrict" name="startDistrict" value="${startDistrict!''}">
                        </td>
                        <td class="s_label">到达城市：</td>
                        <td class="w18">
                            <input type="text" id="arriveDistrictString" name="arriveDistrictString" value="${bizFlight.arriveDistrictString!''}" errorele="searchValidate" class="searchInput" readonly="readonly">
                            <input type="hidden" id="arriveDistrict" name="arriveDistrict" value="${arriveDistrict!''}">
                        </td>
                        <td class="s_label">航空公司：</td>
                        <td class="w18">
                            <select id="airline" name="airline">
                                <option value=""></option>
                                <#list airlines as al>
                                    <#if al.dictId == airline>
                                        <option value="${al.dictId}" selected="selected">${al.dictName}</option>
                                    <#else>
                                        <option value="${al.dictId}">${al.dictName}</option>
                                    </#if>
                                </#list>
                            </select>
                        </td>
                        <td class="operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                        <td class="operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                        <input type="hidden" name="page" value="${bizFlight.page}">
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
                <th>航班号</th>
                <th>航空公司</th>
                <th>出发城市</th>
                <th>抵达城市</th>
                <th>是否有效</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <#list pager.items as bizFlight> 
            <tr>
                <td>${bizFlight.flightId!''}</td>
                <td>${bizFlight.flightNo!''}</td>
                <td>${bizFlight.airlineString!''}</td>
                <td>${bizFlight.startDistrictString!''}</td>
                <td>${bizFlight.arriveDistrictString!''}</td>
                <td>
                    <#if bizFlight.cancelFlag == "Y"> 
                        <span style="color:green" class="cancelProp">有效</span>
                    <#elseif bizFlight.cancelFlag == "N">
                        <span style="color:red" class="cancelProp">无效</span>
                    <#else>
                        <span style="color:red" class="cancelProp"></span>
                    </#if>
                </td>
                <td class="oper">
                    <a href="javascript:void(0);" class="editProp" data="${bizFlight.flightId}">编辑</a>
                    <#if bizFlight.cancelFlag == "Y"> 
                         <a href="javascript:void(0);" class="cancelProp" data="N" flightId="${bizFlight.flightId}">设为无效</a>
                    <#elseif bizFlight.cancelFlag == "N">
                         <a href="javascript:void(0);" class="cancelProp" data="Y" flightId="${bizFlight.flightId}">设为有效</a>
                    </#if>
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
            var url = "/vst_back/biz/flight/showAddFlight.do";
            addDialog = new xDialog(url, {}, {title:"新增航班信息",width:800});
        });
        
        //修改
        $("a.editProp").on('click',function(){
            var flightId = $(this).attr("data");
            var url = "/vst_back/biz/flight/showUpdateFlight.do";
            updateDialog = new xDialog(url,{"flightId":flightId}, {title:"编辑航班信息",width:800});
        });
        
        //设置有效或无效
        $("a.cancelProp").on("click",function(){
            var entity = $(this);
            var cancelFlag = entity.attr("data");
            var flightId = entity.attr("flightId");
            msg = cancelFlag === "N" ? "确认设为无效？" : "确认设为有效？";
            if(confirm(msg)){    
                $.ajax({
                    url : "/vst_back/biz/flight/setCancelFlag.do",
                    type : "post",
                    data : {"cancelFlag":cancelFlag,"flightId":flightId},
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
