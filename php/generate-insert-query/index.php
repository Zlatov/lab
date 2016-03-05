<?php

function translit($text)
{
	$text = mb_strtolower($text, 'UTF-8');
	$replace = array(
		"а"=>"a", "б"=>"b", "в"=>"v", "г"=>"g", "д"=>"d", "е"=>"e", "ё"=>"e", "ж"=>"j", "з"=>"z", "и"=>"i",
		"й"=>"y", "к"=>"k", "л"=>"l", "м"=>"m", "н"=>"n", "о"=>"o", "п"=>"p", "р"=>"r", "с"=>"s", "т"=>"t",
		"у"=>"u", "ф"=>"f", "х"=>"h", "ц"=>"c", "ч"=>"ch","ш"=>"sh","щ"=>"sch","ъ"=>"", "ы"=>"y", "ь"=>"",
		"э"=>"e", "ю"=>"yu", "я"=>"ya", 
		" "=> "-"
	);
	$text = strtr($text,$replace);
	$text = preg_replace('/[^a-z0-9_-]/', '', $text);
	$text = preg_replace('/[-]{2,}/', '-', $text);
	$text = preg_replace('/[_]{2,}/', '_', $text);
	$text = trim($text, '-_');
	return $text;
}


/*
echo "INSERT INTO `publications` ( `sid`,`header`,`text`,`date` ) VALUES <br>";
for ($i=1; $i<201; $i++) {
	// $delimiter = 
	echo "( 'rec-$i','Record $i','Text of record $i.','2016-01-10' )" . (($i===200)?';':',') . "<br>";
}
*/

/*
for ($i=1; $i<50; $i++) {
	$query .= "INSERT INTO `section` ( `sid`,`header` ) VALUES ( 'section-$i','Section $i' );\n";
}
*/

/*
for ($i=1; $i<200; $i++) {
	$date = date("Y-m-d", mktime(0, 0, 0, 0, 1+7*$i+rand(0,14)-7, 2012));
	$query .= "UPDATE `news` SET `date` = '$date'  WHERE `id` = '$i';\n";
}
*/

/*
$fh = fopen('./quote.txt', 'r');
if ($fh) {
	// echo "SET AUTOCOMMIT = 0; SET FOREIGN_KEY_CHECKS = 0; SET UNIQUE_CHECKS = 0;";
	while (!feof($fh)) {
		$quote = fgets($fh);
		$author = fgets($fh);
		$quote = str_replace("\n",'',$quote);
		$author = str_replace("\n",'',$author);
		echo "START TRANSACTION;".PHP_EOL;

		echo "INSERT INTO `author` (`name`) VALUES (";
		echo "'" . addslashes($author) . "'";
		echo ") ON DUPLICATE KEY UPDATE `name` = `name`;" . PHP_EOL;

		echo "SELECT IF(`id` IS NOT NULL,`id`,LAST_INSERT_ID()) FROM `author` where `name` = '{$author}' LIMIT 1 INTO @author;".PHP_EOL;

		echo "INSERT INTO `product` (`header`,`price`,`category_id`) VALUES (";
		$array = preg_split("/[\s]+/",$quote);
		$header = $array[0] . (isset($array[1])?" ".$array[1]:'') . (isset($array[2])?" ".$array[2]:'') . "&#8230;";
		echo "'Цитата: " . addslashes($header) . "', ";
		$price = rand(100,999) * .01;
		echo "" . addslashes($price) . ", ";
		echo "2);".PHP_EOL;

		$quote = addslashes($quote);
		echo "INSERT INTO `quote` (`product_id`,`html`,`author_id`,`content`) VALUES (LAST_INSERT_ID(),0,@author,'{$quote}');".PHP_EOL;

		echo "COMMIT;".PHP_EOL;
		echo PHP_EOL;
	}
	// echo "SET AUTOCOMMIT = 1; SET FOREIGN_KEY_CHECKS = 1; SET UNIQUE_CHECKS = 1;";
}
*/

/*
echo "REPLACE INTO `webhobru_yii`.`news`
(`id`,
`sid`,
`header`,
`text`,
`updated_at`,
`created_at`,
`sec`)
VALUES\n\n";


// if ($fh = fopen("file.txt", "r")) {
// 	$i=0;
// 	$text = '';
// 	$header = '';
// 	$created_at = '';
// 	while (!feof($fh)) {
// 		$i++;
// 		switch ($i%3) {
// 			case 1:
// 				$line = fgets($fh);
// 				$text = "<p>".$line."</p>\n";
// 				$header = explode(".",$line);
// 				$header = $header[0];
// 				$sid = translit($header);
// 				break;
// 			case 2:
// 				$text.= "<p>".fgets($fh)."</p>\n";
// 				break;
// 			case 0:
// 				$text.= "<p>".fgets($fh)."</p>\n";
// 				$text = addslashes($text);
// 				$created_at = date('Y-m-d H:i:s',mktime(rand(0,23),rand(0,59),rand(0,59),2,rand(0,28),2016));
// 				$sec = rand(3,4);
// 				echo "\n(null,\n'{$sid}',\n'{$header}',\n'{$text}',\nnull,\n'{$created_at}',\n'{$sec}'),\n";
// 				break;
// 			default:
// 				break;
// 		}
// 	}
// 	fclose($fh);
// }


if ($fh = fopen("file.txt", "r")) {
	$i=0;
	$text = '';
	$header = '';
	$created_at = '';
	while (!feof($fh)) {
		$line = fgets($fh);
		$text = "<p>".$line."</p>\n";
		$header = explode(".",$line);
		$header = addslashes($header[0]);
		$sid = translit($header);
		$text = addslashes($text);
		$created_at = date('Y-m-d H:i:s',mktime(rand(0,23),rand(0,59),rand(0,59),2,rand(0,28),2016));
		$sec = rand(3,4);
		echo "\n(null,\n'{$sid}',\n'{$header}',\n'{$text}',\nnull,\n'{$created_at}',\n'{$sec}'),\n";
	}
	fclose($fh);
}
*/

