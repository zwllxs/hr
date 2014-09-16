<style>
</style>
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>请先选择所属品类，然后创建产品</div>
<div class="iframe_content mt10">
    <div class="p_box">
        <div class="add_product">
            <ul>
            	<#if bizCategoryList??>
            		<#list bizCategoryList as category>
            			<li><a href="javascript:void(0);"  data="${category.categoryId}">${category.categoryName}</a></li>
            		</#list>
                </#if>
            </ul>
        </div>
    </div>
</div>
<input type="hidden" id="category" value="">
<script>
	$(".add_product li a").bind("click",function(){
		$(".add_product li a").css({"background-color":"#F0F8FD","color":"#528CD7"}); 
		$(this).css({"background-color":"#7BB7F2","color":"#fff"});
		$("#category").val($(this).attr("data"));
		var categoryId = $("#category").val();
		if(categoryId==""){
			alert("请先选择品类");
			return;
		}
		$("#iframeMain").attr("src","/vst_back/visa/product/showAddProduct.do?categoryId="+categoryId);
		//为父窗口设置CategoryId
		$("#categoryId",window.parent.document).val(categoryId);
		categorySelectDialog.close();
	});
	
	$("#next").click(function(){
		
	});
</script>