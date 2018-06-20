<?php
ob_start();
header('HTTP/1.1 503 Service Temporarily Unavailable');
header('Status: 503 Service Temporarily Unavailable');
header('Retry-After: 3600');
header('X-Powered-By:');
?>

<!DOCTYPE HTML>
<html>
<head>
  <title>503 Service Temporarily Unavailable</title>
</head>
<body> 
сюда втыкаем гифку
</body>
</html>
