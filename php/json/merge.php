<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
	<?php

		$fileNames = [
			'old_dgi.json',
			'old_dilli.json',
			'old_epson.json',
			'old_vivid.json',
			'old_zeon_net.json',
		];
		$fileNames = [];
		if ($handle = opendir(__DIR__)) {
		    while (false !== ($entry = readdir($handle))) {
		    	if ($entry != "." && $entry != "..") {
		    		$pathinfo = pathinfo(__DIR__ . '/' . $entry);
		    		if ($pathinfo['extension']==='json'&&$pathinfo['filename']!=='merged') {
		    			$fileNames[] = $entry;
		    		}
		        }
		    }
		}
		$resultArray = [];
		$add = range('a','z');
		foreach ($fileNames as $key => $value) {
			$array = json_decode(file_get_contents($value), true);
			$array = array_map(function($v){
				global $add, $key;
				$v['id'] = $add[$key] . $v['id'];
				$v['parent'] = ($v['parent']==='#')? '#' : $add[$key] . $v['parent'];
				return $v;
			}, $array);
			$resultArray  = array_merge($resultArray, $array);
		}
		$json = json_encode($resultArray);
		$result = file_put_contents('merged.json', $json);
		echo "<pre>";
		print_r($result);
		echo "</pre>";
		die();
	?>
</body>
</html>