<form id="dataForm" action="/saveBlackList.do" method="post">
<input type="hidden" id="blacklistType" name="blacklistType" value="${blacklistType}">
<input type="hidden" id="goodId" name="goodId" value="${goodId}">
    <table class="p_table form-inline" style="width:400px" >
        <tbody>
            <tr>
                <td><#if blacklistType=="PHONE">手机</#if><#if blacklistType=="IDCARD">身份证</#if>号</td>
                <td><input type="text" id="blacklistNum" name="blacklistNum" value=""></td>
            </tr>
        </tbody>
    </table>
    <div class="p_box box_info clearfix mb20" style="padding-left:130px;padding-top:20px;">
        <div class="fl operate"><a class="btn btn_cc1" id="save">添加</a></div>
    </div>
</form>
<script> 
     $("#save").click(function(){
        var blacklistNum = $("#blacklistNum").val();
		if(blacklistNum==""){
			$.alert("请输入号码");
			return false;
		}
        var blacklistType = $("#blacklistType").val();
        var blacklistNum = $("#blacklistNum").val();
        if(blacklistType == 'PHONE'){
		   if(isNaN(blacklistNum)){
			  $.alert("请输入数字");
			  return false;
		   }
            var myreg = /^\d+$/;
            if(!myreg.test(blacklistNum)){
        	  $.alert("请输入正确的手机号码！");
              return false;
            }
            if(blacklistNum.length != 11){
               $.alert("手机号长度应该为11位");
			    return false;
            }
            if(blacklistNum < 0){
               $.alert("手机号不能为负数");
			    return false;
            }
            if(blacklistNum.indexOf(' ') >=0){
                $.alert("手机号包含空格");
			    return false;
            }
        }else{
            blacklistNum = blacklistNum.toUpperCase(); 
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X)$)/;
            if(reg.test(blacklistNum) === false)
            {
               $.alert("身份证号格式错误");
               return false;
            }
        }
		$.ajax({
				url : "/vst_back/supp/blackList/saveBlackList.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
				    if(result.message=="error"){
				        $.alert('该号码已存在');
				    }else{
				        $.alert('保存成功');
					    parent.location.reload();
				    }
				}
			});
	});
</script>