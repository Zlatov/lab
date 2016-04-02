<?php
$to = "zlatov@ya.ru";
$subject = "С сайта " . preg_replace('/^www\./','',$_SERVER['SERVER_NAME']);
$text = <<<HTML
<h1>h1</h1>
<p><a href="">test</a> test</p>
HTML;
$headers = 
	"MIME-Version: 1.0\r\nContent-type: text/html; charset=utf-8\r\nFrom: noreply <noreply@" .
	preg_replace('/^www\./','',$_SERVER['SERVER_NAME']) .
	">\r\n";
$send = mail($to, $subject, $text, $headers);

if ($send) {
	echo "Отправлено";
} else {
	echo "Не отправлено";
}

?>
