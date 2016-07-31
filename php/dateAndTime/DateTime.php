<?php

$dt1 = new DateTime();

echo "<pre>";
print_r($dt1);
echo "</pre>";

echo "<pre>";
print_r($a = $dt1->getTimestamp().PHP_EOL);
print_r($dt1->format('Y m d H i s'));
echo "</pre>";

echo "<pre>";
print_r($dt1->setTimestamp($a+0));
print_r(PHP_EOL.$dt1->format('Y m d H i s'));
echo "</pre>";

////////////////

$dt2 = new DateTime();
$dt2->setTimestamp(time() + 6666);

$diff = $dt1->diff($dt2);

echo "<pre>";
print_r($diff);
echo "</pre>";

echo "<pre>";
print_r($diff->format('%s'));
echo "<pre>";

echo "</pre>";
print_r($dt2->getTimestamp() - $dt1->getTimestamp());
echo "</pre>";



