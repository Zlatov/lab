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

// $file_get_contents = file_get_contents("file.txt");
// if ($file_get_contents !== false) {
//     echo $file_get_contents;
// }


// INSERT INTO `webhobru_yii`.`news`
// (`id`,
// `sid`,
// `header`,
// `text`,
// `updated_at`,
// `created_at`,
// `sec`)
// VALUES
// (<{id: }>,
// <{sid: }>,
// <{header: }>,
// <{text: }>,
// <{updated_at: CURRENT_TIMESTAMP}>,
// <{created_at: 0000-00-00 00:00:00}>,
// <{sec: }>);



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
