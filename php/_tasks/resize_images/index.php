<?php

require_once "../../../vendor/autoload.php";
// require_once "../../../vendor/zlatov/resize-img/src/ResizeImg.php";

if (class_exists('Zlatov\ResizeImg')) {
  print('exist.' . PHP_EOL);
} else {
  print('not exist.' . PHP_EOL);
}

use zlatov\ResizeImg;

if (class_exists('Zlatov\ResizeImg')) {
  print('exist.' . PHP_EOL);
} else {
  print('not exist.' . PHP_EOL);
}

print_r(get_declared_classes());
print PHP_EOL;

// class_exists('MyClass')
