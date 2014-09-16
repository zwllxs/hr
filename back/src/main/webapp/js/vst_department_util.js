
/**
一二三级部门联动和三级部门下人员查询

*/

$("#firstDepartment").change(function(){

		$("#secondDepartment").html("");
		$("#threeDepartment").html("");
		$("#groupMember").html("");
		
		var firstDepartment=$("#firstDepartment option:selected").val();
		if(firstDepartment=='')
       {
       		$("#secondDepartment").html("");
       		$("#threeDepartment").html("");
       		return;
       }
       
       var param="depId="+firstDepartment+"&nowLevel=first";
       $.ajax({
		   url : "/vst_order/order/ordCommon/findCascadDepartment.do",
		   data : param,
		   type:"POST",
		   dataType:"JSON",
		   success : function(data){
		   
		   		$("#secondDepartment").html("");
		   		$.each(data,function(){
						var departmentName=this.departmentName;
						var orgId=this.orgId;
						if(orgId==0){
							orgId="";
						}
						//alert(orgId+"--"+departmentName);
						$("#secondDepartment").append("<option value="+orgId+">"+departmentName+"</option>");
		        })
		        
		   		/**
		   		  $.each(data[0],function(key,value){

		               //其中key相当于是JAVA中MAP中的KEY，VALUE就是KEY相对应的值
						$("#secondDepartment").append("<option value="+key+">"+value+"</option>");
		               //alert(key+"    "+value);
		        })
		        
		        */
		   		
		   }
		});	
});

$("#secondDepartment").change(function(){

		$("#threeDepartment").html("");
		$("#groupMember").html("");
		
		
		var secondDepartment=$("#secondDepartment option:selected").val();
	  if(secondDepartment=='')
       {
       		$("#threeDepartment").html("");
       		return;
       }
       var param="depId="+secondDepartment+"&nowLevel=second";
      
       $.ajax({
		   url : "/vst_order/order/ordCommon/findCascadDepartment.do",
		   data : param,
		   type:"POST",
		   dataType:"JSON",
		   success : function(data){
		   		//var html = '<option value="">请选择</option>'
		   		$("#threeDepartment").html("");
		   		
		   		var html ="";
		   		$.each(data,function(){
						var departmentName=this.departmentName;
						var orgId=this.orgId;
						if(orgId==0){
							orgId="";
						}
						//alert(orgId+"--"+departmentName);
						$("#threeDepartment").append("<option value="+orgId+">"+departmentName+"</option>");
		        })
		        
		   		/**
		   		for(var i in data[0]){
		   			html+="<option value="+i+">"+data[0][i]+"</option>";
		   		}
		   		
		   		
		   		$("#threeDepartment").append(html);
		   		*/
		   		
		   		
		   }
		});	
});

$("#threeDepartment").change(function(){

		$("#groupMember").html("");
	  var threeDepartment=$("#threeDepartment option:selected").val();
	  if(threeDepartment=='')
       {
       		$("#groupMember").html("");
       		return;
       }
       var param="depId="+threeDepartment+"&nowLevel=three";
       //alert(param=='');
       
       $.ajax({
		   url : "/vst_order/order/ordCommon/findCascadDepartment.do",
		   data : param,
		   type:"POST",
		   dataType:"JSON",
		   success : function(data){
		   
		   		$("#groupMember").html("");
		   		$("#groupMember").append("<option value=''>请选择</option>");
		   		  $.each(data,function(){
						var userName=this.userName;
						//var userId=this.userId;
						$("#groupMember").append("<option value="+userName+">"+userName+"</option>");
		               //alert(key+"    "+value);
		        })
		   		
		   }
		});	
});


