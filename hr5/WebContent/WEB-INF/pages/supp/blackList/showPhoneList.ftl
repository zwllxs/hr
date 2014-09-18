<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_content mt10">
<div class="tiptext tip-warning cc5">
    <p class="pl15">日期限制：该商品在指定游玩日期范围内的每一天，同一个手机号，最多允许订购的笔数。（已取消的订单不参与累加计算）</p>
    <p class="pl15">黑名单：该黑名单列表内，所有日期均不允许下单。</p>      
</div>
        <div class="p_box box_info p_line">
			<div id="price_tab" class="price_tab">
				<input type="hidden" value="${categoryId}" id="hCategoryId"/>
				<ul class="J_tab ui_tab">
					<li id="show1" ><a href="javascript:showPage('show1');">游玩日期范围限制</a></li>
					<li id="show2" class="active"><a href="javascript:showPage('show2');">手机黑名单</a></li>
					<li id="show3" ><a href="javascript:showPage('show3');">身份证黑名单</a></li>
				</ul>
			</div>            
		</div>
		<input type="hidden" id="goodId" name="goodId" value="${goodId}">
		<div class="fl operate"><a class="btn btn_cc1" id="addIDCARD">添加</a></div><br><br>
	<#if list?? && list?size &gt; 0>
    <table class="p_table table_center" style="width:500px">
    <thead>
        <tr>
            <th class="w18">手机号</th>
            <th class="w18">操作</th>
        </tr>
    </thead>
    <tbody>
        <#list list as SuppGoodsBlackList>
           <tr>
            <td>${SuppGoodsBlackList.blacklistNum!''} </td>
            <td>
                <input type="hidden" name="blacklistId" value="${SuppGoodsBlackList.blacklistId}">
				<a href="javascript:void(0);" onclick='removeTr(this,${SuppGoodsBlackList.blacklistId});' style="color:red;">删除</a></td>
            </td>
           </tr>
        </#list>
    </tbody>
    </table>
    </#if>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

    function showPage(obj){
		
	    var goodId = $("#goodId").val();
		if(obj=='show1'){
			location.href = '/vst_back/supp/blackList/showBlackList.do?goodId='+goodId;
		}else if(obj=='show3'){
			location.href = '/vst_back/supp/blackList/showIDCardList.do?goodId='+goodId;
		}
	}
    
	function removeTr(obj,id){
		if(confirm('确定要删除当前记录吗')){
		$(obj).parent().parent().remove();
		$.ajax({
				url : "/vst_back/supp/blackList/deleteBlackList.do?blackId="+id,
				type : "post",
				dataType : 'json',
				data : $("#searchForm").serialize(),
				success : function(result) {
				   location.reload();
				}
			});
		}
	}
	
	$("#addIDCARD").click(function(){
	var goodId=$("#goodId").val();
	var blacklistType = 'PHONE';
	addDialog = new xDialog("/vst_back/supp/blackList/addBlackList.do",{"goodId":goodId,"blacklistType":blacklistType}, {title:"添加手机号",width:500,hight:400,scrolling:"yes"})
    });
</script>