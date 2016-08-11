<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
<?php

// SELECT username, user_id as cnt FROM forum_users where username = 'dercar'; -- 35314
// SELECT username, user_id as cnt FROM forum_users where username = 'dercаr'; -- 47705
// SELECT username, user_id as cnt FROM forum_users where user_id = 35314 or user_id = 47705;


echo "<pre>";
foreach (str_split('dercar') as $key => $value) {
	echo  $valaue . ' - ' . ord($value) . PHP_EOL;
}
echo "</pre>";
echo "<pre>";
foreach (str_split('dercаr') as $key => $value) {
	echo  $valaue . ' - ' . ord($value) . PHP_EOL;
}
echo "</pre>";

$string = 'dercar';
// $string = iconv('cp-1251', 'utf-8', $string);
// $string = iconv('utf-8', 'cp-1251', $string);
$len = mb_strlen($string);
for ($i=0; $i < $len; $i++) { 
	echo $string[$i] . ' - ' . ord($string[$i]);
}
echo '<br />';
$string = 'dercаr';
// $string = iconv('cp-1251', 'utf-8', $string);
// $string = iconv('utf-8', 'cp-1251', $string);
$len = mb_strlen($string);
for ($i=0; $i < $len; $i++) { 
	echo $string[$i] . ' - ' . ord($string[$i]);
}


?>	

</body>
</html>
