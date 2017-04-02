<?php

/**
 * 
 * Расширение класса трейтом
 * 
 */

/**
 * Трейт
 */
trait TraitClass
{
	private static $defOptions = [
		'bar' => 'bar',
	];

	public static function bar()
	{
		echo "<pre>";
		print_r(self::$defOptions);
		echo "</pre>";
		echo "<pre>";
		print_r(self::$options);
		echo "</pre>";
	}
}

/**
 * Класс
 */
class MyClass2
{
	use TraitClass;

	private static $options = [
		'bar' => '2',
	];
}

MyClass2::bar();
