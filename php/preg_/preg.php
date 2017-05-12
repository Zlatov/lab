<?php

$pattern = '/\?\?(\w+)\?\?/';
$subject = 'asdf asdf??header?? ??id?? ????';
preg_match($pattern, $subject, $matches);
print_r($matches);
preg_match_all($pattern, $subject, $matches);
print_r($matches);
