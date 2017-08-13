<?php include_once 'config.php'; ?>
<?php include_once 'common.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>RBAC_MYSQL</title>
	<style type="text/css">
		#control, #control input, #control button {
			font-size: 0.8em;
		}
		#control {
			padding-right: 8px;
		}
		#state {
			padding-left: 8px;
		}
		#control, #state {
			float: left;
			width: calc(50% - 8px);
		}
	</style>
</head>
<body>
<h2><a href="">RBAC_MYSQL</a></h2>
<div id="control">
	<h2>Управление</h2>
	<fieldset>
		<legend>Пересоздать</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_schema">Пересоздать</button> <strong>базу данных</strong>.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_tables">Пересоздать</button> <strong>таблицы и триггеры</strong>.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_procedures">Пересоздать</button> <strong>процедуры</strong>.
		</form>
	</fieldset>
	<fieldset>
		<legend>Создать</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_user">Создать</button> <strong>пользователя</strong> <input type="text" name="name" value="" placeholder="Имя">.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_perm">Создать</button> <strong>разрешение</strong> <input type="text" name="name" value="" placeholder="строковый ID">, <input type="text" name="description" value="" placeholder="Имя">.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_role">Создать</button> <strong>роль</strong> <input type="text" name="name" value="" placeholder="Имя">.
		</form>
	</fieldset>
	<fieldset>
		<legend>Связать</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="connect_role">Вложить</button> <strong>роль</strong> <input type="text" name="did" placeholder="ID"> в <input type="text" name="aid" placeholder="ID">.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="assign_role">Связать</button> <strong>пользователя</strong> <input type="text" name="user_id" placeholder="ID"> с ролью <input type="text" name="role_id" placeholder="ID роли">.<br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="assign_perm">Связать</button> <strong>разрешение</strong> <input type="text" name="perm_id" placeholder="ID разрешения"> с ролью <input type="text" name="role_id" placeholder="ID роли">.
		</form>
	</fieldset>
</div>
<div id="state">
	<h2>Состояние</h2>
	<?php


	if (check_schema_exist()) {
		schema_select();
	} else {
		echo '<p>База данных не существует.</p>';
		exit();
	}

	if (isset($_POST['submitForm'])) {
		echo '<p><strong>Результат выбранного действия:</strong></p>';
		$_POST['submitForm']();
	}

	?>
	<h3></h3>
</div>
