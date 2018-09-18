<?php

$dt1 = new DateTime();
print_r($dt1);

print_r($a = $dt1->getTimestamp().PHP_EOL);
print_r($dt1->format('Y m d H i s'));

print_r($dt1->setTimestamp($a+0));
print_r(PHP_EOL.$dt1->format('Y m d H i s'));

////////////////

$dt2 = new DateTime();
$dt2->setTimestamp(time() + 6666);

$diff = $dt1->diff($dt2);

print_r($diff);

print_r($diff->format('%s'));

print_r($dt2->getTimestamp() - $dt1->getTimestamp());



