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
print_r($a);

$a->name = 'asd';
print_r($a);

$b = $a; // в переменной $b - ссылка на объект (как и в $a)
$a->name = 'zxc';
print_r($b); // zxc
