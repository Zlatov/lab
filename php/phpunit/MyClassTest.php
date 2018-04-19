<?php

require_once '../../vendor/autoload.php';
require_once 'MyClass.php';

print_r(get_declared_classes());

class MyClassTest extends PHPUnit_Framework_TestCase {

  public function testPower() {
    $my = new MyClass();
    $this->assertEquals(8, $my->power(2, 3));
  }

}
