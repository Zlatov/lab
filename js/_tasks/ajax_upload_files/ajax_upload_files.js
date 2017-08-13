;(function(){

$(document).ready(function(){

	$('#js_form').on('submit', function(event) {
		event.stopPropagation();
		event.preventDefault();

		console.log('this',this)
		console.log('this.images',this.images)
		console.log('this.images.files',this.images.files)

		var url = $(event.target).attr('action');
		console.log('url',url);
		var url = $(this).attr('action');
		console.log('url',url);

		var formData = new FormData();
		$.each(this.images.files, (index,image)=>{
			// formData.append('images[' + index + ']', image)
			formData.append('images[]', image)
		})
		// var formData = new FormData(this);
		// var formData = new FormData(this.images);
		console.log('formData',formData);

		$.ajax({
			url: url,
			type: 'POST',
			data: formData,
			dataType: 'html',

			beforeSend: function() {
			},
			success: function(data, textStatus, jqXHR){
				if(typeof data.error === 'undefined')
				{
					$('#js_response').html(data);
				}
				else
				{
					console.log('ERRORS: ' + data.error);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				console.log('ERRORS: ' + textStatus);
				console.log('ERRORS: ' + errorThrown);
			},
			cache: false,
			contentType: false,
			processData: false
		});

	});






	function showCoords(c) { 
		// console.log(c);
		$('#x1').val(c.x);
		$('#y1').val(c.y);
		$('#x2').val(c.x2);
		$('#y2').val(c.y2);
		$('#aw').val(c.w);
		$('#ah').val(c.h);
		// variables can be accessed here as
		// c.x, c.y, c.x2, c.y2, c.w, c.h
	};
	function clearInfo() {
		$('#x1').val('');
		$('#y1').val('');
		$('#x2').val('');
		$('#y2').val('');
		$('#aw').val('');
		$('#ah').val('');
	};


	function bytesToSize(bytes) {
		var sizes = ['Bytes', 'KB', 'MB'];
		if (bytes == 0) return 'n/a';
		var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
		return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
	};

	var jcrop_api, boundx, boundy;

	function previewFile(event) {
		// var preview = document.querySelector('img');
		// var file = document.querySelector('input[type=file]').files[0];
		// var file    = document.getElementById('fileinput').files[0];
		var file = $(event.target)[0].files[0];
		var img = document.getElementById('js_profilefoto_img');
		// var div     = $('#filediv');
		var reader  = new FileReader();

		reader.onloadend = function () {
			var img = $('#js_profilefoto_img')[0];
			img.src = reader.result;
			$('#filesize').val(bytesToSize(file.size));
			$('#filetype').val(file.type);
		}

		img.onload = function () {
			clearInfo();
			var img = $('#js_profilefoto_img');
			var minImgWidht = 250;
			var minImgHeight = 300;


			// var previeHeight = 300;
			// var k = previeHeight/this.naturalHeight;
			// var previeWidth = Math.floor(k*this.naturalWidth);

			// var minAreaWidth = Math.ceil(k*minImgWidht);
			// var minAreaHeight = Math.ceil(k*minImgHeight);

			// img.width(previeWidth);
			// img.height(previeHeight);

			var maxPrevieWidth = 600;
			var maxPrevieHeight = 300;
			var maxk = maxPrevieWidth/maxPrevieHeight;

			var imgWidth = this.naturalWidth;
			var imgHeight = this.naturalHeight;
			var imgk = imgWidth/imgHeight;

			if (imgk > maxk) {
				// ограничивать по ширине
				var previeWidth = maxPrevieWidth;
				var k = previeWidth/imgWidth;
				var previeHeight = Math.floor(k*imgHeight);
			} else {
				// ограничивать по высоте
				var previeHeight = maxPrevieHeight;
				var k = previeHeight/imgHeight;
				var previeWidth = Math.floor(k*imgWidth);
			}

			var minAreaWidth = Math.ceil(k*minImgWidht);
			var minAreaHeight = Math.ceil(k*minImgHeight);

			img.width(previeWidth);
			img.height(previeHeight);






			$('#pw').val(previeWidth);
			$('#ph').val(previeHeight);

			$('#iw').val(this.naturalWidth);
			$('#ih').val(this.naturalHeight);

			// div.slideDown();

			if (typeof jcrop_api != 'undefined') {
				jcrop_api.destroy();
				jcrop_api = null;
			}

			img.Jcrop({
				// maxSize: [300,300],
				minSize: [minAreaWidth,minAreaHeight],
				onSelect: showCoords,
				onChange: showCoords,
				bgColor: 'black',
				bgOpacity: .4,
				setSelect:   [ Math.ceil(previeWidth/2 - (minAreaWidth/2)), Math.ceil(previeHeight/2 - (minAreaHeight/2)), Math.ceil(previeWidth/2 + (minAreaWidth/2) +1 ), Math.ceil(previeHeight/2 + (minAreaHeight/2) + 1) ],
				aspectRatio: 250 / 300,
				// persistent: true
				// onRelease: clearInfo
			}, function(){
				jcrop_api = this;
			});
		}

		if (file) {
			reader.readAsDataURL(file);
		} else {
			img.src = "";
			// div.slideUp();
		}
	}

	$('#js_profilefoto_popup').on('change', '#js_profilefoto_file', previewFile);






});

})();