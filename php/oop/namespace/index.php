<?php
include_once 'include.php';
use Zlatov\Test\Test;
// use zlatov\test\test;  // правильно
// use zlatov\tEst\test;  // правильно
// use \zlatov\test\test; // правильно
// use zlatov\test\test\; // ошибка
Test::test();

// правильно:
// use Zlatov\Test\Test as kkk;
// kkk::test();
