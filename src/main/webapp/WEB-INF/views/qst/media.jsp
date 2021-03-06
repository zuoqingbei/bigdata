<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <link rel="shortcut icon" href=""/>
    <title>媒体聚焦</title>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="title" content="IT教育 软件培训 安卓开发 移动开发" />
    <meta name="Keywords" content="IT教育 软件培训 安卓开发 移动开发" />
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <style>

    </style>
</head>
<body>
<%@ include  file="./hade.jsp"%>
<div class="mainWrapper informationWrapper">
    <div class="main-title">
        <div class="title-box">
            <div class="title-name">
                <h4>青软资讯</h4>
                <p class="f14 pt10 pb5">做中国最值得信赖的教育集成服务提供商</p>
                <p>TO BE THE BEST</p>
            </div>
            <div class="title-pic">
                <img src="/qst/images/information-top.png" alt="">
            </div>
        </div>
    </div>
    <ul class="tabs">
    	<li class="active">媒体聚焦</li>
    	<a href="/qst/r/newsInformation"><li>新闻资讯</li></a> 
        <a href="/qst/r/qstViewpoint"><li>青软观点</li></a>
        <a href="/qst/r/concern"><li>各界关怀</li></a>
    </ul>
    <div class="section-wrapper">
        <div class="location-now">
            <span>当前位置：</span>
            <a href="/">首页</a>
            <span>&gt;</span>
            <a href="javascript:void(0);">青软资讯</a>
            <span>&gt;</span>
            <span>媒体聚焦</span>
        </div>
    </div>
    <div class="tab media">
        <div class="section-wrapper media-list">
        </div>
        <div class="pages">
                <div id="Pagination"></div>
        </div>
    </div>
</div>
<form method="post" action="/qst/news/newsDetail" id="form" >
	<input type="hidden"  name="ids"  id="newsId"/>
	<input type="hidden"  name="messageType" value="3"/>
</form>
<%@ include  file="./footer.jsp"%>
<script type="text/javascript" src="/qst/js/page/jquery.pagination.js"></script>
<link type="text/css" rel="stylesheet" href="/qst/css/page/pagination.css"/>
<script>
function showNewsDetail(ids){
	$("#newsId").val(ids);
	$("#form").submit();
}
function getNewsList(currentPage){
	$.ajax({
		type : "post",
		url : "/qst/news/getNewsList",
		data:"messageType=3&status=0&currentPage="+currentPage+"&pageSize=20",
		dataType:'json',
		success : function(data) {
			if(data.statusCode==200){
				var result=data.resData;
				var htmls='<ul class="clearfix">';
				$.each(result.list,function(index,item){
                    if(item.title.length>15){
                        htmls+='<li class="list-li" onclick="showNewsDetail('+item.id+')"><a href="javascript:void(0);">'+item.title.substring(0,13)+'...</a>';
                    }else{
                        htmls+='<li class="list-li" onclick="showNewsDetail('+item.id+')"><a href="javascript:void(0);">'+item.title+'</a>';
                    }
                    /*if(item.descContent.length>20){
                        htmls+='<p>'+item.descContent.substring(0,18)+'...</p>';
                    }else{
                        htmls+='<p>'+item.descContent+'</p>';
                    }*/
                    htmls+='<p>'+item.descContent+'</p>';

				});
				htmls+='</ul>';
				$(".media-list").html(htmls);
				$("#Pagination").html("").pagination(parseInt(result.totalPage),{
		            current_page:parseInt(result.currentPage)-1,
		            callback:function(new_current_page, containers){
		            	currentPage=new_current_page+1;
		            	getNewsList(currentPage);
		            }
		        });
			}
		}			
	});
}
var currentPage=1;
 $(document).ready(function () {
     $(".map-list li").each(function(){
         $(this).find(".map-index").css({background:getRgbColor()});
     });
     getNewsList(currentPage);
 });
</script>
</body>
</html>