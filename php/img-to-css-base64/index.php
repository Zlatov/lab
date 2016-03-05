<!DOCTYPE html>
<html lang="ru">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Кодирование изображения</title>

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<h1 class="text-center">Кодирование изображения в base64</h1>
					<form action="" method="POST" role="form" enctype="multipart/form-data">
						<div class="form-group">
							<input type="file" name="file1" class="form-control" id="" placeholder="Выбрать изображение">
						</div>
						<button type="submit" name="submit" class="btn btn-primary">Закодировать</button>
					</form>
					<hr>
					<?php
					if (isset($_POST['submit'])) {
						if (is_uploaded_file($_FILES["file1"]['tmp_name'])) {
							if($fp = fopen($_FILES["file1"]['tmp_name'],"rb", 0)) {
								$picture = fread($fp,filesize($_FILES["file1"]['tmp_name']));
								fclose($fp);
								$base64 = base64_encode($picture);
								echo "<pre>";
								echo "background-image: url('data:image/png;base64,";
								echo $base64;
								echo "');";
								echo "</pre>";
							}else{
								die("error");
							}
						}
					}
					?>
				</div>
			</div>
		</div>

		<!-- jQuery -->
		<script src="//code.jquery.com/jquery.js"></script>
		<!-- Bootstrap JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
 		<script src="Hello World"></script>
	</body>
</html>
