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
<h1><a href="">RBAC_MYSQL</a></h1>
<div style="float: left; width: 50%; box-sizing: border-box; padding-right: 8px;">
	<h2>Обзор/управление</h2>
	<fieldset>
		<legend>Управление БД</legend>
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
		<legend>Пользователи</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_user">Создать</button> <strong>пользователя</strong> <input type="text" name="name" value="" placeholder="Имя">.
		</form>
	</fieldset>
	<fieldset>
		<legend>Роли</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_role">Создать</button> <strong>роль</strong> <input type="text" name="name" value="" placeholder="Имя">.
		</form>
	</fieldset>
	<fieldset>
		<legend>Объекты</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_perm">Создать</button> <strong>объект</strong> прав <input type="text" name="name" value="" placeholder="строковый ID">, <input type="text" name="description" value="" placeholder="Имя">.
		</form>
	</fieldset>
</div>
<div style="float: left; width: 50%; box-sizing: border-box; padding-left: 8px;">
	<h2>Ответ</h2>
	<?= $response ?>
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
