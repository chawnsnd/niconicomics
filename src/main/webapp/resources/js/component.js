/**
 * 
 */
$(function(){
	imageContainer();
})

function imageContainer(){
	$(".image_container").each(function(idx, container){
		var width = $(container).innerWidth();
		var height = $(container).innerHeight();
		var image = $(container).children("img");
		if(width>=height){ //가로로 긴경우
			image.css("max-height", height);
			image.css("margin-left", -((image.width()-width)/2));
		}else{
			image.css("max-width", widht);			
			image.css("margin-top", -((image.height()-height)/2));
		}
	})
}