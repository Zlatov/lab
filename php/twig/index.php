<?php

require_once($_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php');

/*
// 1
$loader = new Twig_Loader_String();
$twig = new Twig_Environment($loader);

echo $twig->render('Hello {{ name }}!', array('name' => 'Fabien'));
*/


// 2
$loader = new Twig_Loader_Filesystem(__DIR__ . '/tpls');
$twig = new Twig_Environment($loader, array(
    'cache'       => 'compilation_cache',
    'auto_reload' => true
));

$content = [
	'0',
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
];

echo $twig->render('content.html',['content'=>$content,'projectName' => 'Twig PHP']);