<?php

// Регистронезависимы, рекомендация: начинать с заглавной, использовать патерн MyBestClass

// declare(encoding='UTF-8');
declare(ticks=1);
// namespace zxc;
// class A
// {
//   static function hi()
//   {
//     echo __CLASS__ . PHP_EOL;
//   }
// }

namespace asd {
  class A {
    static function hi() {
      // $a = get_class();
      // echo '$a: ' . var_export($a, true) . PHP_EOL;
      // echo '$a: ' . print_r($a, true) . PHP_EOL;
      echo __CLASS__ . PHP_EOL;
    }
  }
}
namespace zxc {
  class A {
    static function hi() {echo __CLASS__ . PHP_EOL; }
  }
}
namespace zxc\vbn {
  class A {
    static function hi() { echo __CLASS__ . PHP_EOL; }
  }
}
namespace zxc\vbn {
  class B {
    static function hi() { echo __CLASS__ . PHP_EOL; }
  }
}

namespace
{
  // function tick_handler2()
  // {
  //   echo '> tick_handler2' . PHP_EOL;
  // }
  // function tick_handler()
  // {
  //   echo '> tick_handler' . PHP_EOL;
  // }
  // register_tick_function('tick_handler');
  // register_tick_function('tick_handler2');

  asd\A::hi();
  zxc\A::hi();
  zxc\vbn\A::hi();
  zxc\vbn\B::hi();
  zXc\vBn\B::hi();
  zXc\vBn\b::hi();
  echo phpversion();
}
