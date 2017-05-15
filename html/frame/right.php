<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<title>frame frameset</title>
</head>
<body>
	<h1>Right</h1>
	<?php if (isset($_GET['a'])): ?>
		<p>a = <?= $_GET['a'];$c=3 ?></p>
		<p>c = <?= $c ?></p>
	<?php endif; ?>
	<?php if (isset($_POST['submitForm'])): ?>
		<p>b = <?= $_POST['b'] ?></p>
	<?php endif ?>
</body>
</html>
