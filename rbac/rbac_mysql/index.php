<?php 
	include_once 'config.php';
	include_once 'common.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>RBAC_MYSQL</title>
	<link rel="stylesheet" type="text/css" href="../../theme/bower/vis/dist/vis.css"/>
	<link rel="stylesheet" type="text/css" href="css.css"/>
	<script type="text/javascript" src="../../theme/bower/vis/dist/vis.min.js"></script>
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

	if (isset($_POST['submitForm'])) {
		if (check_schema_exist()) {
			schema_select();
		}
		echo '<p><strong>Результат выбранного действия:</strong></p>';
		$_POST['submitForm']();
		echo '<hr>';
	}

	if (check_schema_exist()) {
		schema_select();
	} else {
		die('<p>База данных не существует.</p>');
	}

	if (!check_schema_select()) {
		die('<p>База данных не выбрана.</p>');
	}

	$users = get_users();
	echo get_users_tbale($users);
	$roles = get_roles();
	echo get_roles_tbale($roles);
	$edges = get_edges();
	echo get_edges_tbale($edges);
	$perm = get_perm();
	echo get_perm_tbale($perm);

	?>
	<div id="roles"></div>
	<script type="text/javascript">
		var nodes = new vis.DataSet([
			<?php foreach ($roles as $role): ?>
			{id: <?= $role['id'] ?>, label: <?= $role['name'] ?>},
			<?php endforeach ?>
		]);

		// create an array with edges
		var edges = new vis.DataSet([
			<?php foreach ($edges as $edge): ?>
			{from: <?= $edge['aid'] ?>, to: <?= $edge['did'] ?>, arrows:'to'},
			<?php endforeach ?>
		]);

		// create a network
		var container = document.getElementById('roles');

		// provide the data in the vis format
		var data = {
			nodes: nodes,
			edges: edges
		};
		var options = {

			edges: {
				smooth: {
					type: 'cubicBezier',
					forceDirection: 'vertical',
					roundness: 0.4
				}
			},
			layout: {
				hierarchical: {
					direction: 'UD'
				}
			},
			physics:false				
		};

		// initialize your network!
		var network = new vis.Network(container, data, options);
	</script>
</div>
</body>
</html>