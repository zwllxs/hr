/**
*vst_pet工具类
*@author ranlongfei
*@date 2013-11-20
*/

var vst_pet_util = {
		/**
		 * 系统用户类
		 * @param showNode 显示姓名的控件
		 * @param idNode 保存ID的控件，一般是个隐藏域
		 */
		superUserSuggest : function(showNode, idNode) {
			$(showNode).jsonSuggest({
				//url : "/vst_back/supp/supplier/searchSupplierList.do",
				url : "/vst_back/pet/permUser/searchUser.do",
				maxResults : 10,
				minCharacters : 1,
				onSelect : function(item) {
					$(idNode).val(item.id);
				}
			});
		},
		
	       /**
	        * 目的地名称列表
	        * @param showNode
	        * @param idNode
	        * @param _flag 是否需要选中
	        */
	       destListSuggest : function(showNode, idNode, _flag) {
	    	    
				$(showNode).jsonSuggest({
					url : "/vst_back/biz/dest/searchDestList.do",
					//maxResults : 10,
					minCharacters : 1,
					flag:_flag,
					onSelect :  function(item) {
						$(idNode).val(item.id);
					}
				});
			},
			
			 /**
		        * 可换酒店名称列表
		        * @param showNode
		        * @param districtName 行政区划名称
		        */
		       changeHotelListSuggest : function(showNode, districtName) {
		    	   $(showNode).jsonSuggest({
						url : "/vst_back/biz/changeHotel/searchChangeHotelList.do?districtName="+districtName,
						minCharacters : 1,
						onSelect : function(item) {
							fillHotelData(item.id);
						}
					});
				},

       
		/**
		 * 通用列表补全查询
		 * @param showNode 显示姓名的控件
		 * @param idNode 保存ID的控件，一般是个隐藏域
		 */
       commListSuggest : function(showNode,idNode,_url, _data){
    	   $(showNode).jsonSuggest({
				url : _url,
				maxResults : 10,
				minCharacters : 1,
				data:_data,
				onSelect : function(item) {
					if(null != idNode)
					{
						$(idNode).val(item.id);
				
					}
				}
			});
       },
       
       /**
        * 行政区域
        * @param showNode
        * @param idNode
        * @param _flag 是否需要选中
        */
       districtSuggest : function(showNode, idNode, _flag) {
    	    
			$(showNode).jsonSuggest({
				url : "/vst_back/biz/district/seachDistrict.do",
				maxResults : 10,
				minCharacters : 1,
				onSelect : function(item) {
					$(idNode).val(item.id);
				}
			});
		},
       
		/**
		 * 签证国家/地区模糊查询
		 * @param showNode 显示姓名的控件
		 * @param idNode 保存ID的控件，一般是个隐藏域
		 */
		visaCountrySuggest : function(showNode, idNode) {
			$(showNode).jsonSuggest({
				url : "/vst_back/visa/visaDoc/searchVisaCountry.do",
				maxResults : 10,
				minCharacters : 1,
				emptyKeyup:false,
				onSelect : function(item) {
					$(idNode).val(item.text);
				}
			});
		},	
	
       /**
        * 页面转拼音的工具方法
        */
       convert2pinyin : function(param) {
    	   if(!param) {
    		   return "";
    	   }
    	   var result = param;
    	   $.ajax({
    		   url : "/vst_back/pub/utils/getPinYin.do",
    		   type : "POST",
    		   async : false,
    		   data : {param:param},
    		   success : function(dt){
    			   result = dt;
    		   }
    	   });	
    	   return result;
       },
       /**
        * 页面转拼音(简拼)的工具方法
        */
       convert2shortpinyin : function(param) {
    	   if(!param) {
    		   return "";
    	   }
    	   var result = param;
    	   $.ajax({
    		   url : "/vst_back/pub/utils/getPinYin.do?type=short",
    		   type : "POST",
    		   async : false,
    		   data : {param:param},
    		   success : function(dt){
    			   result = dt;
    		   }
    	   });	
    	   return result;
       },
       
       /**
		 * 查询主题信息
		 * @param showNode 显示姓名的控件
		 * @param idNode 保存ID的控件，一般是个隐藏域
		 * @param categoryId 品类ID
		 */
		searchBizSubject : function(showNode, idNode, categoryId) {
			$(showNode).jsonSuggest({
				url : "/vst_back/biz/bizSubject/searchBizSubject.do?categoryId="+categoryId,
				maxResults : 10,
				minCharacters : 1,
				onSelect : function(item) {
					$(idNode).val(item.id);
				}
			});
		},
};
