<?php

// shift each option by 1
define('A', 1);
define('B', 1<<1);
define('C', 1<<2);
define('D', 1<<3);
define('E', 1<<4);
define('F', 1<<5);

printf("<p>Права:</p>");
echo "<pre>";
printf("A = %b // define('A', 1);" . PHP_EOL, A);
printf("B = %b // define('B', 1&lt;&lt;1);" . PHP_EOL, B);
printf("C = %b // define('C', 1&lt;&lt;2);" . PHP_EOL, C);
printf("D = %b // define('D', 1&lt;&lt;3);" . PHP_EOL, D);
printf("E = %b // define('E', 1&lt;&lt;4);" . PHP_EOL, E);
printf("F = %b // define('F', 1&lt;&lt;5);" . PHP_EOL, F);
echo "</pre>";

printf("<p>Сохраняем свойства в \$a имеет свойства B, D, E:</p>");
$a = B | D | E;
echo "<pre>";
printf("\$a = %1\$b | \$a = %1\$d // \$a = B | D | E;", $a);
echo "</pre>";

$a = [0,1,1,0,1,0];
$a = bindec(implode('',$a));
echo "<pre>";
printf('$a = %b', $a); echo ' // $a = [0,1,1,0,1,0]; $a = bindec(implode(\'\',$a));';
echo "</pre>";




// compare with or'ed values to find the combination
echo "<pre>";
switch ($c) {
  case A:
    print "\$c has A only\n";
    break;
  case A|B:
    print "\$c has A and B only\n";
    break;
  case A|C:
    print "\$c has A and C only\n";
    break;
  case E|F:
    print "\$c has F and E only\n";
    break;
}
echo "</pre>";

echo "<pre>";
switch ($d) {
  case A:
    print "\$d has A only" . PHP_EOL;
    break;
  case A|B:
    print "\$d has A and B" . PHP_EOL;
    break;
  case A|C:
    print "\$d has A and C" . PHP_EOL;
    break;
}
echo "</pre>";

// use bitwise and (&) to check if an option is present
echo "<pre>";
if ($c & A) print "Has A // if (\$c &amp; A)".PHP_EOL;
if ($c & B) print "Has B // if (\$c &amp; B)".PHP_EOL;
if ($c & C) print "Has C // if (\$c &amp; C)".PHP_EOL;
if ($c & D) print "Has D // if (\$c &amp; D)".PHP_EOL;
if ($c & E) print "Has E // if (\$c &amp; E)".PHP_EOL;
if ($c & F) print "Has F // if (\$c &amp; F)".PHP_EOL;
echo "</pre>";

echo "<pre>";
if ( ($c & F) === F) print " \$c Has F as 1\n";
if ( ($c & ( F | E )) === ( F | E )) print " \$c Has FE as 11\n";
if ( ($c & ( F | E | D )) === ( F | E | D )) print " \$c Has FED as 111\n";
if ( ($c & ( F | E | D | C )) === ( F | E | D | C )) print " \$c Has FEDC as 1111\n";
if ( ($c & ( F | E | D | C | B )) === ( F | E | D | C | B )) print " \$c Has FEDCB as 11111\n";
if ( ($c & ( F | E | D | C | B | A )) === ( F | E | D | C | B | A )) print " \$c Has FEDCBA as 111111\n";
echo "</pre>";

echo "<pre>";
for ($i = 5; $i >= 0;  $i-- ) {
    $mask = (pow(2, 6-$i) - 1) << $i;
    printf('mask             = %b', $mask); echo PHP_EOL;
    printf('current bit      = %b', pow(2, $i)); echo PHP_EOL;
    printf('$c & current bit = %b', $c & pow(2, $i)); echo PHP_EOL; echo PHP_EOL;
}
echo "</pre>";

define('YMDHIS', 63);
define('YMDHI', 31<<1);
define('YMDH', 15<<2);
define('YMD', 7<<3);
define('YM', 3<<4);
define('Y', 1<<5);

echo "<pre>";
echo 'YMDHIS - '; printf('%b',YMDHIS); echo PHP_EOL;
echo 'YMDHI - '; printf('%b',YMDHI); echo PHP_EOL;
echo 'YMDH - '; printf('%b',YMDH); echo PHP_EOL;
echo 'YMD - '; printf('%b',YMD); echo PHP_EOL;
echo 'YM - '; printf('%b',YM); echo PHP_EOL;
echo 'Y - '; printf('%b',Y); echo PHP_EOL;
echo "</pre>";


/* неверное решение для дат */

        $ts = strtotime('2016-02-08 18:35:15');
        define('YMDHIS', 63);
        define('YMDHI', 31<<1);
        define('YMDH', 15<<2);
        define('YMD', 7<<3);
        define('YM', 3<<4);
        define('Y', 1<<5);
        $Ynow = date("Y");
        $mnow = date("m");
        $dnow = date("d");
        $Hnow = date("H");
        $inow = date("i");
        $snow = date("s");
        $Y = date("Y", $ts);
        $m = date("m", $ts);
        $d = date("d", $ts);
        $H = date("H", $ts);
        $i = date("i", $ts);
        $s = date("s", $ts);
        $a = [];
        $a[] = ($Y === $Ynow)?1:0;
        $a[] = ($m === $mnow)?1:0;
        $a[] = ($d === $dnow)?1:0;
        $a[] = ($H === $Hnow)?1:0;
        $a[] = ($i === $inow)?1:0;
        $a[] = ($s === $snow)?1:0;
        $a = bindec(implode('',$a));
        $mask = 0;
        for ($i = 5; $i >= 0;  $i-- ) {
            if ( !($a & pow(2, $i)) ) {
                break;
            }
            $mask = (pow(2, 6-$i) - 1) << $i;
        }
        switch ($mask) {
            case 0:
                echo date('d.m.Y', $ts);
                break;
            case Y:
                echo date('d.m.Y', $ts);
                break;
            case YM:
                echo date('d.m.Y', $ts);
                break;
            case YMD:
                echo date('d.m.Y', $ts);
                break;
            case YMDH:
                echo date('d.m.Y', $ts);
                break;
            case YMDHI:
                echo date('d.m.Y', $ts);
                break;
            case YMDHIS:
                echo date('d.m.Y', $ts);
                break;
        }