<?php

class My {
	// private static $_hide = 'hide';
	// private static $hide;
	// public static function getHide()
	// {
	// 	return self::$_hide;
	// }
	// private $val;
	public static $a;
	public $b;
}

// var_dump(My::$hide);
$m = new My();
$m->b = 'f';
var_dump($m->b);
My::$a = 'h';
var_dump(My::$a);


