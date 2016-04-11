<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="UTF-8">
	<title>Доска объявлений</title>
	<style type="text/css">
		textarea {width: 100%}
	</style>
</head>
<body>
	<h1><a href="./admin.php">Панель администрирования</a></h1>

	<?php
		if (isset($_POST['submit'])) {
			file_put_contents('ads.txt',$_POST['text']);
		}
	?>

	<form action="" method="post">
		<textarea name="text" rows="10"><?= file_get_contents('ads.txt') ?></textarea><br>
		<input type="submit" name="submit" value="Сохранить">
	</form>
</body>
</html>
