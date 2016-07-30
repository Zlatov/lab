<?php

/**
* 
*/
class MyClass
{
	public $name;
}

class MyClass2
{
	public $name;
	
	function __construct($name)
	{
		$this->name = $name;
	}
}

$a = new MyClass();
echo "<pre>";
print_r($a);
echo "</pre>";

$a2 = new MyClass2('a2');
$a2->name = 'asd';

$b = $a2;
$a2->name = 'zxc';
echo "<pre>";
print_r($b); // zxc
echo "</pre>";
