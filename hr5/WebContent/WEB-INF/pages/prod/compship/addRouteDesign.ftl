<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>

<body>
	<form action="/vst_back/prod/routedesign/addRouteDesign.do" method="post" id="saveForm">
		<div class="iframe_search">
			<input type="hidden" id="productId" name="productId" value="${productId!''}">
			<input type="hidden" id="categoryId" name="categoryId" value="${categoryId}"/>
			<input type="hidden" id="lineRoutedays" value="${days}"/>
			<input type="hidden" id="oldLog" name="oldLog" value="${oldLog}"/>
			
			<table class="s_table">
				<tr>
					<td class="qudao_t">
						航行天数<i class="cc1">(*)</i>
						<input type="text" id="days" name="days" value="${count}"/> &nbsp;天
					</td>
					<td class="s_label">
						&nbsp;录入规则：仅填写数字 &nbsp;
						<button id="comfirmDays" class="btn btn-mini s_btn" type="button">确认航行天数</button>
					</td>							
				</tr>
			</table>
		</div>
		<div class="iframe_content mt20">
			<div class="p_box">
			<label style="width:80px;margin:0 5px;color: #333333;display: inline-block; float: left;font-size: 12px;height: 26px;line-height: 26px;text-align: right;">
				航线介绍
				<i class="cc1">(*)</i>
			</label>						
				<table class="s1_table form-inline" style="float:left;width:90%;">
					<thead>
						<tr align="center">
							<th>行程天数</th>			
							<th>停靠港口</th>			
							<th>抵达时间</th>			
							<th>离港时间</th>		
						</tr>				
					</thead>
					 <#assign i=1> 
					<#list pageParam.items as product> 
						<tr>
							<td >
								<select name="n_day">
									<#list 1..days as day>
										<#if product.nDay==day>
											<option value="${day!''}" selected="selected">${day}</option>
									    <#else>
									    	<option value="${day}" <#if i==day>selected="selected"</#if> >${day}</option>
										</#if>
									</#list>
								</select>
							</td>			
							<td>
								<input type="hidden" id="shipDetailId${product_index+1}" value="${product.shipDetailId}"/>
								
								<#if product.destination!=null>
								<input errorEle="searchValidate" class="w110" name="destination" id="${product_index+1}" type="text" 
								readonly=readonly value="${product.destination}">
								<#else>
								<input errorEle="searchValidate" class="w110" name="destination" id="${product_index+1}" type="text" 
									readonly=readonly value="海上巡游">
								</#if>
								
								<input type="hidden" class="w110" id="districtId${product_index+1}" name="districtId" value="${product.districtId}">
							</td>			
							<td>
								<#if product_index==0>
									——
									<input type="hidden" id="arriveTime${product_index+1}" name="arriveTime"/>
								<#else>
									<input type="text" id="arriveTime${product_index+1}" value="${product.arriveTime}" name="arriveTime" class="Wdate" onFocus="WdatePicker({readOnly:true,dateFmt:'HH:mm:ss'})" />
								</#if>
							</td>			
							<td>
								<#if pageParam.items?size==1>
									<input type="text" id="leaveTime${product_index+1}" value="${product.leaveTime}" name="leaveTime" class="Wdate" onFocus="WdatePicker({readOnly:true,dateFmt:'HH:mm:ss'})" />
								<#elseif pageParam.items?size-1==product_index>
									——
									<input type="hidden" id="leaveTime${product_index+1}" name="leaveTime"/>
								<#else>
									<input type="text" id="leaveTime${product_index+1}"  value="${product.leaveTime}" name="leaveTime" class="Wdate" onFocus="WdatePicker({readOnly:true,dateFmt:'HH:mm:ss'})" />
								</#if>											
							</td>				
						</tr>
						<#assign i=i+1> 										
					</#list>
				</table>
			</div>
		
            <div class="fl operate" >
                	<a class="btn btn_cc1" href="javascript:;" onclick="saveRouteDesign();" style="margin:10px 0 0 500px;float:left;">保存</a>
                	 <a href="javascript:void(0);"  id="searchLog" style="margin:10px 0 0 30px;float:left;" param="{'parentId':${productId},'parentType':'PROD_PRODUCT','logType':'ROUTE_DESIGN'}" >[查看操作日志]</a>
            </div>			
		</div>
	</form>
		<form id="updateRouteDesign" method="post">
			<input type="hidden" id="districtId" name="districtId"/>
			<input type="hidden" id="arriveTime" name="startArriveTime"/>
			<input type="hidden" id="leaveTime" name="endLeaveTime"/>
			<input type="hidden" id="shipDetailId" name="shipDetailId"/>
			<input type="hidden" id="uproductId" name="productId"/>
		</form>
	</div>
	<#include "/base/foot.ftl"/>
</body>
	<script>
		
		var districtSelectDialog,selectSupplierDialog;
		var id ;
		//行政区选择回调函数
		function onSelectDistrict(params){
			if(params!=null){
				$("#districtId"+id).val(params.districtId);
				$("#"+id).val(params.districtName);
			}
			districtSelectDialog.close();
		}
		
		//清除行政区域
		function onClearDistrict(params) {
			$("#districtId"+id).val(null);
			$("#"+id).val("海上巡游");
			
			districtSelectDialog.close();
		}
		
		$(function(){
			$("#comfirmDays").click(function(){
				searchRouteDesign();
			});
			
			 var showLogDialog;
	         $("#searchLog").bind("click",function(){
	         	var productId = $('#productId').val();
				var data= 'productId='+productId+'&page=1';
				showLogDialog = new xDialog("/vst_back/prod/compship/baseinfo/logList.do",data,{title:"查看日志",width:800});
	         });
	         
			$("input[name=destination]").each(function(){
				//打开选择行政区窗口
				$(this).click(function(){
				    id = $(this).attr('id');
					districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1100",height:'600'});
				});	 				
			});	  
		});
		
		// 查询航线信息
		function searchRouteDesign(){
			var productId = $('#productId').val();
			var categoryId = $('#categoryId').val();
			if(categoryId.length<=0){
				$.alert('品类不能为空!!');
				return;
			}
			var days = $('#days').val();
		    if(!window.parent.isNumeric(days)){
		    	$('#days').focus();
				alert('航行天数只能为正整数!!');
				return;   	
		    } 			
			var lineRoutedays = $('#lineRoutedays').val();// 行程天数
			if(lineRoutedays>0){
				if(days-lineRoutedays>0){
					alert("航行天数不能大于行程天数!!");
					return;
				}
			}else{
				alert("请先维护行程设计!!");
				return;
			}
			var url = "/vst_back/prod/compship/routedesign/showAddRouteDesignList.do?op=searchRouteDesign&oldLog="+$('#oldLog').val()+"&count="+days+"&productId="+productId+"&categoryId="+categoryId;
			window.location = url;
		}
		
		// 修改航线设计
		function updateRouteDesign(index){
			var districtId = $('#districtId'+index).val();
			var leaveTime = $('#leaveTime'+index).val();
			var arriveTime = $('#arriveTime'+index).val();
			var shipDetailId = $('#shipDetailId'+index).val();
			var productId = $('#productId').val();
			$('#leaveTime').val(leaveTime);
			$('#districtId').val(districtId);
			$('#arriveTime').val(arriveTime);
			$('#shipDetailId').val(shipDetailId);
			$('#uproductId').val(productId);
		    $.ajax({
			   url:'/vst_back/prod/compship/routedesign/updateRouteDesign.do',
			   type:'post',
			   data: $("#updateRouteDesign").serialize(),
			   success:function(data){
				   if (data.code == "success") {
				   	  $.alert(data.message,function(){
							//searchRouteDesign();
					  });				   
				   }else{
				   	  $.alert(data.message);
				   }
			   }
			});
		}
		
		// 保存航线信息
		function saveRouteDesign(){
			var productId = $('#productId').val();
			if(productId<=0){
				$.alert('请先添加基础信息!!');
			}else{
				var days = $('#days').val();
				var lineRoutedays = $('#lineRoutedays').val();// 行程天数
				if(lineRoutedays>0){
					if(days-lineRoutedays>0){
						alert("航行天数不能大于行程天数");
						return;
					}
				}else{
					alert("请先维护行程设计!!");
					return;
				}

				var isdayvalid = true;
				//判断行程天数是否一致
				var dayarray = $("select[name=n_day]");
				for(var i=0;i<dayarray.length-1;i++){
					var value = dayarray[i].value;
					for(var j=i+1;j<dayarray.length;j++){
						if(value == dayarray[j].value){
							isdayvalid = false;
						}
					}
				}
				
				if(!isdayvalid){
					$.alert("行程天数不能重复!");
					return;
				}
				
				var n_day = '0';
				$("select[@name=n_day] option").each(function(){
					if($(this).attr('selected')=='selected'){
						n_day= $(this).val();
					}
				});
				var isdayvalid = true;
				//判断行程天数是否一致
				var dayarray = $("select[name=n_day]");
				for(var i=0;i<dayarray.length-1;i++){
					var value = dayarray[i].value;
					for(var j=i+1;j<dayarray.length;j++){
						if(value == dayarray[j].value){
							isdayvalid = false;
						}
					}
				}
				
				if(!isdayvalid){
					$.alert("行程天数不能重复!");
					return;
				}
				
				var strs= new Array();
				if(n_day=='0'){
			    	alert('请添加航行天数');
			    	return;
			    }		
				var loading = top.pandora.loading("正在努力保存中...");
				$.ajax({
				   url:'/vst_back/prod/compship/routedesign/addRouteDesign.do',
				   type:'post',
				   data: $("#saveForm").serialize(),
				   success:function(data){
				   	   loading.close();
					   if (data.code == "success") {
					   	  $.alert(data.message,function(){
								//searchRouteDesign();
							window.location.reload();
						  });
					   }else{
					   	  $.alert(data.message);
					   }
				   }
				});	
			}
		}
	</script>
</html>
