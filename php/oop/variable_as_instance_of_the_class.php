<?php

/**
* Переменная в php - ссылка на объект (инстанс, экземпляр класса)
*/

class MyClass
{
	public $name;
	
	function __construct($name)
	{
		$this->name = $name;
	}
}

$a = new MyClass('a');
echo "<pre>";
print_r($a);
echo "</pre>";

$a->name = 'asd';
echo "<pre>";
print_r($a);
echo "</pre>";

$b = $a; // в переменной $b - ссылка на объект (как и в $a)
$a->name = 'zxc';
echo "<pre>";
print_r($b); // zxc
echo "</pre>";
