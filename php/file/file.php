<?php
file_put_contents('temp', print_r(["asd" => 0], true));
echo '__DIR__: ' . var_export(__DIR__, true) . PHP_EOL;
file_put_contents('/home/iadfeshchm/projects/my/lab/php/file_put_contents/temp.txt', print_r(["asd" => 0], true));
