<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<title>frame frameset</title>
</head>
<body style="word-wrap: break-word;">
	<h1>Left</h1>
	<ul>
		<li><a href="/html/frame/right.php" target="frame_right">a = null</a></li>
		<li><a href="/html/frame/right.php?a=1" target="frame_right">a = 1</a></li>
		<li><a href="/html/frame/right.php?a=2" target="frame_right">a = 2</a></li>
	</ul>
	<p>
		<form action="/html/frame/right.php" method="post" target="frame_right">
			<fieldset>
				<legend>From variable:</legend>
				<label>
					b = 
					<input type="text" name="b" value="1">
				</label>
				<input type="submit" name="submitForm" value="Summit form to right frame">
			</fieldset>
		</form>
	</p>
</body>
</html>
