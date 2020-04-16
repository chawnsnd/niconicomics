var hide = false;
var footerPositionTop;
var fullScreen = false;
var showDotple;
function initScroll(){
	$(window).on("mousemove", function(e){
		if(hide){
			if(e.pageY<=$("header").outerHeight()){
				$("header").show();
			}else{
				$("header").hide();
			}
			if(e.pageY>=footerPositionTop){
				$("footer").show();
			}else{
				$("footer").hide();
			}
		}
	})
	$("#contents").on("scroll", function(e){
		var st = $(this).scrollTop();
		var sh = $(this)[0].scrollHeight;
		var oh = $(this).outerHeight();
		if(st >= $("header").outerHeight()){
			$("header").hide();
			$("footer").hide();
			hide = true;
		}else{
			$("header").show();
			$("footer").show();
			hide = false;
		}
		if(sh-st == oh){
			$("header").show();
			$("footer").show();
			hide = false;
		}
	});
}
function toggleChatroom(e){
	$("#chatroom").toggle();
}
function toggleDotple(){
	$(".dotple").toggle();
	showDotple = !showDotple;
}
function settingDotple(){
	if(showDotple){
		$(".dotple").show();
	}else{
		$(".dotple").hide();
	}
}
function initShowHide(){
	if(me.showChat == "SHOW"){
		$("#chatroom").show();
	}else if(me.showChat == "HIDE"){
		$("#chatroom").hide();
	}
	if(me.showDotple == "SHOW"){
		showDotple = true;
	}else if(me.showDotple == "HIDE"){
		showDotple = false;
	}
	settingDotple();
}
function initHotKey(){
	$(document).keydown(function(e){
		if(e.keyCode == 27){
			$("#dotpleForm").remove();
		}
	})
}