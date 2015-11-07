$(document).ready(function(){
						   
						   
		$("a.splash").hover(function() {
			$(this).stop().animate({opacity: "0"}, 300);
		}, function() {
			$(this).stop().animate({opacity: "1"}, 200);
		});

		$("a.iimg").hover(function() {
			$(this).stop().animate({opacity: "0"}, 300);
		}, function() {
			$(this).stop().animate({opacity: "1"}, 200);
		});



/****
MENU
***
	$("#mainmenu li:has(ul) a").hover(function() {
		
		$(this).parent().find("ul").width($(this).parent().width()).stop(true,true).slideDown({ duration: 'fast', easing: "easeInOutQuint"}).show(); 
 
		$(this).parent().hover(function() {
		}, function(){	
			$(this).parent().find("ul").fadeOut('slow'); 
		});
 
		});*/

	$("#mainmenu li:has(ul) a").hover(function() {
		
		$(this).parent().find("ul").stop(true,true).slideDown({ duration: 'fast', easing: "easeInOutQuint"}).show(); 
 
		$(this).parent().hover(function() {
		}, function(){	
			$(this).parent().find("ul").fadeOut('slow'); 
		});
 
		});








/****
MAIN IMAGES SjQS
***

slideSwitch = function() {
	$("#advnext").unbind('click');

	var $active = $('#advimg div.current');
    var $activet = $('#advtext div.current');

    if ( $active.length == 0 ) $active = $('#advimg div:last');
    if ( $activet.length == 0 ) $activet = $('#advtext div:last');

    // use this to pull the images in the order they appear in the markup
    var $next =  $active.next().length ? $active.next()
        : $('#advimg div:first');
    var $nextt =  $activet.next().length ? $activet.next()
        : $('#advtext div:first');

    // uncomment the 3 lines below to pull the images in random order
    
    // var $sibs  = $active.siblings();
    // var rndNum = Math.floor(Math.random() * $sibs.length );
    // var $next  = $( $sibs[ rndNum ] );


    $active.addClass('last-active');
    $activet.addClass('last-active');

    $next.css({opacity: 0.0})
        .addClass('current')
        .animate({opacity: 1.0}, 1000, function() {
            $active.removeClass('current last-active');
        });
    $activet
        .animate({left:-425}, 1000, function() {
		    $activet
				.removeClass('current last-active');
			$nextt
				.css({left:-425})
				.addClass('current')
				.animate({left:0}, 1000);
			$("#advnext").click(function() {clicknext();
			});	
        });


}

slideSwitchprev = function() {
}

$(function() {
    play = setInterval( "slideSwitch()", 8000 );
});

clicknext = function() {
		clearInterval(play);
		slideSwitch();
}
clickprev = function() {
		clearInterval(play);
		slideSwitchprev();
}


$("#advnext").click(function() {clicknext();
});	
$("#advprev").click(function() {clickprev();
});	
*/
/*$('#advnext').unbind('click');*/










});





