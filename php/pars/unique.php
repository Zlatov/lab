<?php
$uarray = [];

if ($fh = fopen("output.txt", "r")) {
	$i = 0;
	while (!feof($fh)) {
		$i++;
		$line = fgets($fh);
		$name = fgets($fh);
		$uarray[$line] = $name;
	}
	fclose($fh);
}

echo "Количество пройденных цитат: " . $i . "<br>";
echo "Размер массива уникальных цитат: " . count($uarray) . "<br>";

$fh = fopen('./unique.txt', "wb");
foreach ($uarray as $key => $value) {
	fputs($fh, $key . $value );
}
fclose($fh);
