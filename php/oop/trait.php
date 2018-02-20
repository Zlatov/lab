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
		print_r(self::$defOptions);
		print_r(self::$options);
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
