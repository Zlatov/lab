<?php

class ClassName {
}

// class_exists() — Проверяем существование класса перед его использованием
if (class_exists('MyClass')) {
  // $myclass = new MyClass();
  print('class MyClass exist.' . PHP_EOL);
} else {
  print('class MyClass not exist.' . PHP_EOL);
}

// get_declared_classes() — Возвращает массив с именами объявленных классов
print_r(get_declared_classes());
print PHP_EOL;

// get_class_methods() — Возвращает массив имен методов класса
$object = [];
print_r(get_class_methods($object));
print PHP_EOL;
