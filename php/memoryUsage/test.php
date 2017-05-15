<?php

// +
include('memoryUsage.php');
$mu_base = memory_get_usage();
$mu_cur = memory_get_usage();
$mu_base = memory_get_usage();
$mu_cur = memory_get_usage();
// +


$mu_cur = memoryUsage(memory_get_usage(), $mu_base, $mu_cur, "Старт.");

$a = someBigValue();

$mu_cur = memoryUsage(memory_get_usage(), $mu_base, $mu_cur, "Установили a.");
$mu_cur = memoryUsage(memory_get_usage(), $mu_base, $mu_cur, "Без изменений.");

unset($a);

$mu_cur = memoryUsage(memory_get_usage(), $mu_base, $mu_cur, "Освободили от a.");

$b = someBigValue();

$mu_cur = memoryUsage(memory_get_usage(), $mu_base, $mu_cur, "Установили b.");
