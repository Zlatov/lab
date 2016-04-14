<?php
$url = 'https://80.252.130.250/stats/?method=auth';

$params = json_decode(file_get_contents(__DIR__ . DIRECTORY_SEPARATOR . 'params.json'), true);

$result = file_get_contents($url, false, stream_context_create(array(
    'http' => array(
        'method'  => 'POST',
        'header'  => 'Content-type: application/x-www-form-urlencoded',
        'content' => http_build_query($params)
    )
)));
if ($result === false) die('false file_get_contents');

$pattern = '/Баланс лицевого счета: \<strong\>([0-9,]+) руб.\<\/strong\>/';
$subject = $result;
$result = preg_match($pattern, $subject, $matches);
if ($result === false) die('false preg_match userBalans');

$userBalans = (float)str_replace(',', '.', $matches[1]);
if ($userBalans<65) {
	$to = "zlatov@ya.ru";
	$subject = "С сайта " . preg_replace('/^www\./','',$_SERVER['SERVER_NAME']);
	$message = "<p>Пора пополнить баланс Интернета!</p>\n";
	$message .= sprintf("<p>Баланс составляет <strong><big>%.2F</big></strong> рублей.</p>",$userBalans);
	$headers = "MIME-Version: 1.0\r\n" .
		"Content-type: text/html; charset=utf-8\r\n" .
		"From: noreply <noreply@" .
		preg_replace('/^www\./','',$_SERVER['SERVER_NAME']) .
		">\r\n";
	$send = mail($to, $subject, $message, $headers);
}

printf("<p>Баланс составляет <strong><big>%.2F</big></strong> рублей.</p>",$userBalans);