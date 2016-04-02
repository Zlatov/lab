<?php

// !!! Use this function!!!
function checkPalindrome( $string )   
{
    // strip out whitespace
    $string = str_replace( ' ', '', $string );
    // return bool
    return $string == strrev( $string );
}

// We havn't function mb_str_split
function mb_str_split($string, $encoding = 'UTF-8')
{
	$len = mb_strlen($string);
	for ($i = 0; $i < $len; $i++)
		$array[] = mb_substr($string, $i, 1, $encoding);
	return ($array);
}

function palindrome_max($string = NULL)
{
	if (is_null($string)) return false;
	$palindrome = $string;
	$string = mb_strtolower(str_replace(' ','',$string),'UTF-8');
	$len = mb_strlen($string);
	if ($len>1) {
		$array = mb_str_split($string);
		$reverse = array_reverse($array);
		if ($array === $reverse) return $palindrome;//$string;
		while ($count = count($array)) {
			unset($array[$count-1]);
			if (mb_substr($palindrome,-1)===' ') {
				$palindrome = rtrim($palindrome);
				$palindrome = mb_substr($palindrome,0,-1);
			} else {
				$palindrome = mb_substr($palindrome,0,-1);
			}
			$reverse = array_reverse($array);
			if ($array === $reverse) return $palindrome;//implode('',$array);
		}
	}else if ($len === 1) {
		echo $string;
	}else{
		return false;
	}
}

echo palindrome_max('Аргентина манит негра')."<br>";
echo palindrome_max('Sum summus mus')."<br>";
echo palindrome_max('А роза упала на лапу Азора мусор  и   куча  пробелов')."<br>";
echo palindrome_max()."<br>";
echo palindrome_max('')."<br>";
echo palindrome_max('as')."<br>";
echo palindrome_max('asa')."<br>";
echo palindrome_max('asad')."<br>";
