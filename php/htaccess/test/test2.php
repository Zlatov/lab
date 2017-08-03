<!DOCTYPE html>
<html lang="ru">
	<head>
		<meta charset="utf-8">
		<title>Вход выполнен успешно</title>
	</head>
	<body>
		<h1>Вход выполнен успешно</h1>
		<p>Приветствую тебя, <strong><?= $_SERVER['PHP_AUTH_USER'] ?></strong>!</p>
		<p>Ты ввёл правильный пароль: <var><?= $_SERVER['PHP_AUTH_PW'] ?></var></p>
		<p><a href="test.php">test</a></p>
		<ul>
			<li>$_SERVER['REMOTE_USER']: <?= $_SERVER['REMOTE_USER'] ?></li>
			<li>$_SERVER['PHP_AUTH_USER']: <?= $_SERVER['PHP_AUTH_USER'] ?></li>
		</ul>
	</body>
</html>
