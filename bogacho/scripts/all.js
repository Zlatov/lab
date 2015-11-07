// JavaScript Document
	$(document).ready(function(){

/****
EFECT 
****/

		$("#aimg").hover(function() {
			$(this).stop().animate({width: "122px", height: "104px", top: "-10px"}, { duration: 300, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({width: "99px", height: "85px", top: "0px"}, { duration: 200, easing: "easeInOutCubic" });
		});

		$("#hpimg").hover(function() {
			$(this).stop().animate({left: "0"}, { duration: 400, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({left: "50px"}, { duration: 250, easing: "easeInOutCubic" });
		});
		
		$("#nimg").hover(function() {
			$(this).stop().animate({opacity: "0"}, { duration: 300, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({opacity: "1"}, { duration: 200, easing: "easeInOutCubic" });
		});
		
		$("#g1img").hover(function() {
			$(this).stop().animate({opacity: "0"}, { duration: 300, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({opacity: "1"}, { duration: 200, easing: "easeInOutCubic" });
		});
		
		$("#f1img").hover(function() {
			$(this).stop().animate({opacity: "0"}, { duration: 300, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({opacity: "1"}, { duration: 200, easing: "easeInOutCubic" });
		});
		
		$("#oimg").hover(function() {
			$(this).stop().animate({top: "10px"}, { duration: 400, easing: "easeInOutCubic" });
		}, function() {
			$(this).stop().animate({top: "80px"}, { duration: 250, easing: "easeInOutCubic" });
		});
		





/****
REEL PRODUCT
****/
/*	//Get size of images, how many there are, then determin the size of the image reel.
	var imageWidth = $("#win").width();
	var imageSum = $(".reel img").size();
	var imageReelWidth = imageWidth * imageSum;

	//Adjust the image reel to its new size
	$(".reel").css({'width' : imageReelWidth});

	//Paging + Slider Function
	rotate = function(){	
		var triggerID =  $active.attr("rel") - 1; //Get number of times to slide
		var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide

		$(".reel img").removeClass('active'); //Remove all active class
		$active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

		//Slider Animation
		$(".reel").animate({ 
			left: -image_reelPosition
		}, { duration: 1500, easing: "easeInOutCubic" } );

	}; 

	rotateSwitch = function(){		
		play = setInterval(function(){
			$active = $('.reel img.active').next();
			if ( $active.length === 0) {
				$active = $('.reel img:first');
			}
			rotate();
		}, 5000);
	};
	
	rotateSwitch(); //Run function on launch
*/	

	//Paging + Slider Function
	rotate = function(itemreel){	
		//Get size of images, how many there are, then determin the size of the image reel.
		var imageWidth = 939;
		var imageSum = $("#"+itemreel+" .reel .ireel").size();
		var imageReelWidth = imageWidth * imageSum;
	
		//Adjust the image reel to its new size
		$("#"+itemreel+" .reel").css({'width' : imageReelWidth});

		var triggerID =  $active.attr("rel") - 1; //Get number of times to slide
		var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide

		$("#"+itemreel+" .reel .ireel").removeClass('active'); //Remove all active class
		$active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

		//Slider Animation
		$("#"+itemreel+" .reel").animate({ 
			left: -image_reelPosition
		}, { duration: 1500, easing: "easeInOutCubic" } );

	}; 
/*
	$("#topbar #products span.rightprod").click(function(){
			$active = $('.reel div.ireel.active').next(".ireel");
			if ( $active.length === 0) {
				$active = $('.reel .ireel:first');
			}
			rotate();
	});
	$("#topbar #products span.leftprod").click(function(){
			$active = $('.reel div.ireel.active').prev(".ireel");
			if ( $active.length === 0) {
				$active = $('.reel .ireel:last');
			}
			rotate();
	});
*/	
	reelright = function(itemreel) {
		$active = $('#'+itemreel+' .reel div.ireel.active').next(".ireel");
		if ( $active.length === 0) {
			$active = $('#'+itemreel+' .reel .ireel:first');
		}
		rotate(itemreel);
	}
	reelleft = function(itemreel) {
		$active = $('#'+itemreel+' .reel div.ireel.active').prev(".ireel");
		if ( $active.length === 0) {
			$active = $('#'+itemreel+' .reel .ireel:last');
		}
		rotate(itemreel);
	}
	

/****
CLICK REEL PRODUCT
****/
	$("#topbar #products span.rightprod").css('cursor', 'pointer');
	$("#topbar #products span.leftprod").css('cursor', 'pointer');
	$("#topbar #products span.closeprod").css('cursor', 'pointer');

/*	$("#topbar #products span.closeprod").click(phide = function(){
        $('#topbar #products.pshow').removeClass("pshow").addClass("phide")
			.stop()
			.animate({height: "0px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() { 
				$(this).css('position', 'absolute');
				$(this).css('visibility', 'hidden');
				$(this).css('border-top', 'none');
				$(this).addClass("phide");
		}});
	});
*/

	$("#topbar #products span.closeprod").click(phide = function(){
        $('#topbar #products.pshow')
//			.stop()
			.animate({height: "0px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
				$(this).removeClass("pshow").addClass("phide");
				$('#topbar #products .psi.psishow').removeClass("psishow").addClass("psihide");
		}});
	});

/****
CLICK MENU TO SHOW REEL PRODUCT
****/
/*
	showp = function(itemname) {
		if($('#topbar #products.pshow').length) {
			$('#topbar #products.pshow').removeClass("pshow").addClass("phide")
				.stop()
				.animate({height: "0px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
					$('#topbar #products .psi').removeClass("psishow").addClass("psihide");
					$('#topbar #products #'+itemname).removeClass("psihide").addClass("psishow");
					$(this)
						.stop()
						.animate({height: "375px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
							$(this).removeClass("phide").addClass("pshow");
					}});
			}});
		} else {
			$('#topbar #products #'+itemname).removeClass("psihide").addClass("psishow");
			$('#topbar #products').removeClass("phide").addClass("pshow")
				.stop()
				.animate({height: "375px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
				}});
		}
	};

*/
	showp = function(itemname) {
		if($('#topbar #products.pshow').length) {
			$('#topbar #products')
//				.stop()
				.animate({height: "0px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
					$('#topbar #products .psi.psishow').removeClass("psishow").addClass("psihide");
					$('#topbar #products #'+itemname).removeClass("psihide").addClass("psishow");
					$(this)
//						.stop()
						.animate({height: "375px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
						}});
				}});
		} else {
			$('#topbar #products #'+itemname).removeClass("psihide").addClass("psishow");
			$('#topbar #products').removeClass("phide").addClass("pshow")
//				.stop()
				.animate({height: "375px"}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
				}});
		}
	};

/****
HOVER PRODUCT
****/
$("#topbar #products a.item").hover( function(){
		$(this).stop().animate({opacity: "1"}, { duration: 200, easing: "easeInOutCubic" });
    }, function(){
		$(this).stop().animate({opacity: ".7"}, { duration: 200, easing: "easeInOutCubic" });
    });


/****
MENU
****/
$(function(){
    $("ul.dropdown li.flvl").hover(function(){
        $(this).addClass("hover");
        $('ul:first',this)
			.css('visibility', 'visible')
			.css('height', '0px')
			.css('overflow', 'visible')
			.stop()
			.animate({height: "400px"}, { queue:false, duration: 800, easing: "easeInOutQuint"});
    }, function(){
        $(this).removeClass("hover");
        $('ul:first',this)
			.stop()
			.animate({height: "0px"}, { queue:false, duration: 400, easing: "easeInOutQuint", complete: function() { 
				$(this).css('visibility', 'hidden');
		}});
    
    });

    $("ul.dropdown li.tlvl").hover( function(){
        $(this).addClass("hover");
        $('ul:first',this)
			.css('visibility', 'visible')
			.css('width', '0px')
			.stop()
			.animate({width: "481px"}, { queue:false, duration: 800, easing: "easeInOutQuint"});
    }, function(){
        $(this).removeClass("hover");
        $('ul:first',this)
			.stop()
			.animate({width: "0px"}, { queue:false, duration: 400, easing: "easeInOutQuint", complete: function() { 
				$(this).css('visibility', 'hidden');
		}});
    
    });

    $("ul.dropdown li ul li:has(ul)").find("span:first").append(" &raquo; ");
    $("ul.dropdown li ul li:has(ul)").find("a:first").append(" &raquo; ");
});


/****
PRODUCTITEM MENU
****/
$(function(){
    $("#escho li").hover(function(){
//		var hmi = $('ul:first',this).height();
        $(this).addClass("hover");
        $('ul:first',this)
			.css('visibility', 'visible')
			.css('height', '0px')
			.css('overflow', 'visible')
			.stop()
			.animate({height: '380px'}, { queue:false, duration: 800, easing: "easeInOutQuint", complete: function() {
			}});
    }, function(){
        $(this).removeClass("hover");
        $('ul:first',this)
			.stop()
			.animate({height: "0px"}, { queue:false, duration: 400, easing: "easeInOutQuint", complete: function() { 
				$(this).css('visibility', 'hidden');
		}});
    
    });

    $("#escho li:has(ul)").find("span:first").append(" &raquo; ");
    $("#escho li:has(ul)").find("a:first").append(" &raquo; ");
});



	
	});



/****
MAIN IMAGES SjQS
****/

function slideSwitch() {
    var $active = $('#slideshow IMG.active');

    if ( $active.length == 0 ) $active = $('#slideshow IMG:last');

    // use this to pull the images in the order they appear in the markup
    var $next =  $active.next().length ? $active.next()
        : $('#slideshow IMG:first');

    // uncomment the 3 lines below to pull the images in random order
    
    // var $sibs  = $active.siblings();
    // var rndNum = Math.floor(Math.random() * $sibs.length );
    // var $next  = $( $sibs[ rndNum ] );


    $active.addClass('last-active');

    $next.css({opacity: 0.0})
        .addClass('active')
        .animate({opacity: 1.0}, 1000, function() {
            $active.removeClass('active last-active');
        });
}

$(function() {
    setInterval( "slideSwitch()", 5000 );
});




