/*
* 浏览器信息和哪个端判断处理相关方法
* */



//获取当前浏览器信息
function getBrowerInfo() {
    var explorer = window.navigator.userAgent.toLowerCase()//浏览器版本信息并转化成小写
    //ie
    if (explorer.indexOf("msie") >= 0) {
        var ver=explorer.match(/msie ([\d.]+)/)[1]//查找字符串
        return {type:"IE",version:ver}
    }
    //判断是否IE的Edge浏览器
    if (explorer.indexOf("msie") == -1 && explorer.indexOf("Windows NT 6.1; Trident/7.0;") > -1) {
        return {type:"IEEdge",version:0}
    }   
    //edge
    if (explorer.indexOf("edge") >= 0) {
        var ver=explorer.match(/edge ([\d.]+)/)[1]//查找字符串
        return {type:"Edge",version:ver}
    }
    //firefox
    else if (explorer.indexOf("firefox") >= 0) {
        var ver=explorer.match(/firefox\/([\d.]+)/)[1]
        return {type:"Firefox",version:ver}
    }
    //Chrome
    else if(explorer.indexOf("chrome") >= 0){
        var ver=explorer.match(/chrome\/([\d.]+)/)[1]
        return {type:"Chrome",version:ver}
    }
    //Opera
    else if(explorer.indexOf("opera") >= 0){
        var ver=explorer.match(/opera.([\d.]+)/)[1]
        return {type:"Opera",version:ver}
    }
    //Safari
    else if(explorer.indexOf("Safari") >= 0){
        var ver=explorer.match(/version\/([\d.]+)/)[1]
        return {type:"Safari",version:ver}
    }
    //qqbrowser
    if (explorer.indexOf("qqbrowser") >= 0) {
        var ver=explorer.match(/qqbrowser ([\d.]+)/)[1]//查找字符串
        return {type:"QQbrowser",version:ver}
    }
    //baidu
    if (explorer.indexOf("baidu") >= 0) {
        var ver=explorer.match(/baidu ([\d.]+)/)[1]//查找字符串
        return {type:"Baidu",version:ver}
    }
    return {type:"",version:""}
}

//根据不同的端自动跳转到不同的页面
function autoJumpUrl(url,url2,url3,url4) {
    var u = navigator.userAgent
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1 //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/) //ios终端
    var Isweixin = u.indexOf('MicroMessenger') > -1//微信    

    if(isiOS) {
    	location.href = url
    	return    	
    }

    if(isAndroid && Isweixin) {
    	location.href = url2
    	return    	
    } 
    
    if(isAndroid && (!Isweixin)) {
    	location.href = url3
    	return    	
    } 
    
    if(!(isAndroid || isiOS)) {
    	location.href = url4
    	return
    }  
    
    location.href = url4
}




