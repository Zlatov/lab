<?php
$a = 0b1100;
$b = 0b1010;
echo "<pre>";
printf("a = %b // \$a = 0b1100\n", $a);
printf("b = %b // \$b = 0b1010\n", $b);
echo "</pre>";

$c = $a & $b;
echo "<pre>";
printf("\$c = \$a & \$b :\n");
printf("%b\n", $a);
printf("%b\n", $b);
printf("%b\n", $c);
echo "</pre>";

$c = $a | $b;
echo "<pre>";
printf("\$c = \$a | \$b :\n");
printf("%b\n", $a);
printf("%b\n", $b);
printf("%b\n", $c);
echo "</pre>";

$c = $a ^ $b;
echo "<pre>";
printf("\$c = \$a ^ \$b :\n");
printf("%b\n", $a);
printf("%b\n", $b);
printf("%'.04b\n", $c);
echo "</pre>";

$c = ~$a;
echo "<pre>";
printf("\$c = ~\$a :\n");
printf("%b\n", $a);
printf("%b\n", $c);
printf("%'.04b\n", $c & (1 << 3 | 1 << 2 | 1 << 1 | 1) );
echo "</pre>";

$c = $a << 1;
echo "<pre>";
printf("\$c = \$a << 1 :\n");
printf("%b\n", $a);
printf("%b\n", $c);
echo "</pre>";

$c = $a >> 1;
echo "<pre>";
printf("\$c = \$a >> 1 :\n");
printf("%b\n", $a);
printf("%b\n", $c);
echo "</pre>";
