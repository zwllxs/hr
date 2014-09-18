<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div id="showAdd" style="overflow:scroll;height: 400px;width: 800px;">
<#assign photo_len_d = photo.photoUrl?length - 4/>
<br/><span>第0张图：</span>
<img src="http://pic.lvmama.com${photo.photoUrl}"/>
<br/><span>第1张图：</span>
<img src="http://pic.lvmama.com${photo.photoUrl?substring(0,photo_len_d)+'_480_320.jpg'}"/>
<br/><span>第2张图：</span>
<img src="http://pic.lvmama.com${photo.photoUrl?substring(0,photo_len_d)+'_300_200.jpg'}"/>
<br/><span>第3张图：</span>
<img src="http://pic.lvmama.com${photo.photoUrl?substring(0,photo_len_d)+'_180_120.jpg'}"/>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
</script>


