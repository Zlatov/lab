<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="UTF-8">
	<title>Доска объявлений</title>
	<style type="text/css">
		textarea {width: 100%}
		.red {font-weight: bold; color: red}
	</style>
</head>
<body>
	<h1><a href="">Доска объявлений</a></h1>

	<?php
		$red = false;
		if (isset($_POST['submit'])) {
			$text = strip_tags($_POST['text']);
			$red = (mb_strlen($text,'utf8')<=100)?false:true;
			if ($text!=='' && !$red) {
				file_put_contents('ads.txt',$text.PHP_EOL.'<hr>',FILE_APPEND);
			}
		}
		echo nl2br(file_get_contents("ads.txt"));
	?>

	<h2>Добавить объявление</h2>
	<form action="" method="post">
		<p<?= $red?' class="red"':'' ?>>Текст объявления не более 100 символов.</p>
		<textarea name="text" rows="5"><?= $red?$text:'' ?></textarea><br>
		<input type="submit" name="submit" value="Добавить">
	</form>
</body>
</html>
