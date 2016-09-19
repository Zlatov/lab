<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>

<?php


// header( 'Content-type: text/html; charset=utf-8' );
// echo 'Begin ...<br />';
// for( $i = 0 ; $i < 10 ; $i++ )
// {
//     echo $i . '<br />';
//     flush();
//     ob_flush();
//     sleep(1);
// }
// echo 'End ...<br />';

// ob_start();





// echo('1<br>');
// ob_flush();
// flush();

// sleep(1);
// echo('1<br>');
// ob_flush();
// flush();

// sleep(1);
// echo('1<br>');
// ob_end_flush(); 






ob_flush();
flush();

sleep(1);
echo('doing something...<br>');

ob_flush();
flush();

sleep(1);
echo('doing something...<br>');

ob_flush();
flush();




for ($i=0; $i < 3; $i++) { 
	sleep(1);
	echo("$i still going...<br>");

	ob_flush();
    flush();
}

sleep(1);
echo('done.');

// ob_flush();
// flush();

ob_end_flush(); 


?>

</body>
</html>
