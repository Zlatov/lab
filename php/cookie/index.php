<?php
session_start();
require_once('check-cookie.php');
?>



<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>

<?php

if (COOKIE_ENABLED) {
	echo "<p>РАЗРЕШЕНЫ</p>";
} else {
	echo "<p>заперщены</p>";
}

?>
	
</body>
</html>
