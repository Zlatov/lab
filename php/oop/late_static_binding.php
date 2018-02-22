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
    // Позднее статическое связывание это процесс обращения к свойствам потомков
    // в методе оисанном в родительском классе:
    echo var_export(static::$options, false) . PHP_EOL;
    // Обычныое обращение чрез self приведет к обращению к свойству своего класса:
    echo var_export(self::$options, false) . PHP_EOL;
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
