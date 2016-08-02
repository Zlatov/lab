<?php

$p = [
	'+7 926 140 74 33	',
	'8 (926)-140-74-33',
	' 7 926 140 74 33',
	'	8(926) 140 74 33',
	'+7+926+-- 1я40  	74 33',
	'7 926_140 adsa   74 33',
];


function toPhonenumber($phonenumber)
{
	$phonenumber = trim($phonenumber);
	$phonenumber = preg_replace('/[^+0-9]/','',$phonenumber);
	$phonenumber = preg_replace('/^8/','7',$phonenumber);
	$phonenumber = preg_replace('/[+]/','',$phonenumber);
	// $phonenumber = preg_replace('/[+]/','',$phonenumber);
	return $phonenumber;
}


foreach ($p as $key => $value) {

echo "<pre>";
print_r(toPhonenumber($value));
echo "</pre>";

}
