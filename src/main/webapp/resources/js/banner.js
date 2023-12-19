let bannerIndex=0;
let bannerList=[];
    
function getBanner(contextPath){
	let banner = $(".banner");
    	
    	//서버와 통신
    	$.ajax({
    		url:contextPath+"/banners",
    		type:"get",
    		dataType:"json",
    		success: function(result){
    			
    			console.log("result = "+result)
    	
    			bannerList = result;
    			console.log("bannerList = "+bannerList)
    			
    			let bannerText = bannerList[bannerIndex++];
    			banner.text(bannerText);
    			
    			setInterval(function(){
    				let bannerText = bannerList[bannerIndex++];
        			banner.text(bannerText);
        			
        			if(bannerIndex==bannerList.length) bannerIndex=0;
        			
        			
    			}, 2000);
    			
    		},
			error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
    	
    		
    	});
    	
}// getBannerEnd

/////////////////////////////////////////
















