$(document).ready(function(){
	$(".tooltippressshow").prepend("<div class='tooltippressarr'></div>")

	$(".tooltippress").click(function(){
		var ttp = $(this);
		var ttpsh = $("#tooltippress_"+ttp.data("tooltippressid"));
		var ttpsha = $("#tooltippress_"+ttp.data("tooltippressid")+" .tooltippressarr");
		var d_x = 0;
		var d_x2 = 0;
		
		var ttp_l = ttp.offset().left;
		var ttp_t = ttp.offset().top;
		var ttp_h = ttp.innerHeight();
		var ttp_w = ttp.innerWidth();

		var ttpsh_l = ttpsh.offset().left;
		var ttpsh_t = ttpsh.offset().top;
		var ttpsh_w = ttpsh.innerWidth();

		var parent_w = ttp.parent().width();
		var parent_l = ttp.parent().offset().left;

		if ( ttp_l - parent_l > ttpsh_w ) {
			d_x = ( ttp_l - parent_l - ttpsh_w + ttp_w );
		}

		/* Если смещение кнопки от левого поля больше 20 px, то двигаем ползунок */
		if ( ttp_l - parent_l > 20 ) {
			/* Если ширина подсказки больше смещения кнопки, то двигаем на смещение */
			if ( ttp_l - parent_l - 20 < ttpsh_w ) {
				d_x2 = ( ttp_l - parent_l - 10 );
			} else {
			/* Иначе двигаем на смещение минус ширину */	
				d_x2 = ( ttp_l - parent_l - ttpsh_w );
			}
		}
		
		/* если кнопка совсем совсем справа */
		if ( parent_w - 20 < ttp_l - parent_l ) {
			d_x2 = parent_w - 20;
		}

		/*alert(
		      "parent_l:      " + parent_l + "\n"+
		      "ttp_parent_l:  " + ttp_parent_l + "\n"+
		      "ttpsh_w:       " + ttpsh_w + "\n"+
		      "d_x:           " + d_x
			  
			  );*/

		ttpsh
			.toggle()
			.css({'maxWidth':parent_w-20})
			.offset({top:ttp_t+ttp_h+20,left:parent_l+d_x});
		ttpsha
			.css({'left':d_x2});
	});



});