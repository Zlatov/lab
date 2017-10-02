<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>RBAC_MYSQL</title>
	<link rel="stylesheet" type="text/css" href="../../theme/bower/vis/dist/vis.css"/>
	<link rel="stylesheet" type="text/css" href="css.css"/>
	<script type="text/javascript">
		String.prototype.split_with_line_breaks = function(max_string_length) {
		  if (!max_string_length) {
		    return this.valueOf()
		  }
		  var words = this.valueOf().split(' ')
		  if (words.length==1) {
		    return words[0]
		  }
		  var new_text = words[0]
		  var line_length = words[0].length
		  for(var i=1, l=words.length; i<l; i++) {
		    if ((line_length + 1 + words[i].length) > max_string_length) {
		      new_text+= '\n' + words[i]
		      line_length = words[i].length
		    } else {
		      new_text+= ' ' + words[i]
		      line_length+= 1 + words[i].length
		    }
		  }
		  return new_text
		}
	</script>
	<script type="text/javascript" src="../../theme/bower/vis/dist/vis.min.js"></script>
</head>
<body>
<h1><a href="">RBAC_MYSQL</a></h1>
<div style="float: left; width: 50%; box-sizing: border-box; padding-right: 8px;">
	<h2>Обзор/управление</h2>
	<fieldset>
		<legend>Управление БД</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_schema">Пересоздать базу данных.</button><br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_tables_triggers_procedures">Пересоздать таблицы, триггеры и процедуры.</button><br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="recreate_procedures">Пересоздать процедуры.</button><br><br>
		</form>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="insert_test_data_with_api">Вставить тестовые данные с помощью mysql_api.</button>
		</form>
	</fieldset>

	<h3>Пользователи</h3>
	<fieldset>
		<legend>Управление пользователями</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_user">Создать</button> <strong>пользователя</strong> <input type="text" name="name" value="" placeholder="Имя">.
		</form>
	</fieldset>
	<?php users(); ?>

	<h3>Роли</h3>
	<fieldset>
		<legend>Управление ролями</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_role">Создать</button> <strong>роль</strong> <input type="text" name="name" value="" placeholder="Имя">.
		</form>
	</fieldset>
	<?php roles(); ?>

	<h3>Объекты</h3>
	<fieldset>
		<legend>Управление объектами</legend>
		<form action="" method="post">
			<button type="submit" name="submitForm" value="add_perm">Создать</button> <strong>объект</strong> прав <input type="text" name="name" value="" placeholder="строковый ID">, <input type="text" name="description" value="" placeholder="Имя">.
		</form>
	</fieldset>
</div>
<div style="float: left; width: 50%; box-sizing: border-box; padding-left: 8px;">
	<h2>Ответ</h2>
	<?php echo $response ?>
</div>
</body>
</html>
