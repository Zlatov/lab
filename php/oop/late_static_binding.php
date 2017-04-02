<?php

/**
 * 
 * Позднее статическое связывание
 * 
 */

/**
 * Базовый класс
 */
class MyBaseClass
{
	private static $options = [
		'bar' => 'bar',
	];

	public static function bar()
	{
		echo "<pre>";
		print_r(static::$options);
		echo "</pre>";
		echo "<pre>";
		print_r(self::$options);
		echo "</pre>";
	}
}

/**
 * Класс потомок
 */
class MyClass extends MyBaseClass
{
	protected static $options = [
		'bar' => '2',
	];
}

// Вызываем от потомка метод базового класса,
// в котором имеем доступ к родительскому атрибуту и дочернему
MyClass::bar();
