<?php
set_time_limit(3*60);

$config = [
	// 'url' => 'http://www.zlatov.net',
	// 'url' => 'https://colorscheme.ru/pantone-colors.html',
	'url' => '',
	'urls' => [
		'https://colorscheme.ru/pantone-colors.html',
		'https://colorscheme.ru/pantone-colors-2.html',
		'https://colorscheme.ru/pantone-colors-3.html',
		'https://colorscheme.ru/pantone-colors-4.html',
		'https://colorscheme.ru/pantone-colors-5.html',
		'https://colorscheme.ru/pantone-colors-6.html',
		'https://colorscheme.ru/pantone-colors-7.html',
		'https://colorscheme.ru/pantone-colors-8.html',
		'https://colorscheme.ru/pantone-colors-9.html',
		'https://colorscheme.ru/pantone-colors-10.html',
		'https://colorscheme.ru/pantone-colors-11.html',
		'https://colorscheme.ru/pantone-colors-12.html',
		'https://colorscheme.ru/pantone-colors-13.html',
		'https://colorscheme.ru/pantone-colors-14.html',
		'https://colorscheme.ru/pantone-colors-15.html',
		'https://colorscheme.ru/pantone-colors-16.html',
		'https://colorscheme.ru/pantone-colors-17.html',
		'https://colorscheme.ru/pantone-colors-18.html',
	],
	'output' => './output.txt',
	'param_time' => false,
	'search' => [
		// 'header' => [
		// 	'xpath' => '//div[@class="pub-short"]/h3/a'
		// ],
		'pantone_name' => [
			'xpath' => '//*[@id="default"]/tr/td[2]'
		],
		'hex' => [
			'xpath' => '//*[@id="default"]/tr/td[7]'
		],
		// 'pantone' => ['xpath' => '/html/body/div[1]/div[2]/div[2]/div[1]/p[1]'],
	],
];

function open_output()
{
	global $config, $fh;
	// $fh = fopen("./output.txt", 'ab');
	$fh = fopen($config['output'], 'w+b');
	if (!$fh)
	{
		die("Не открылся");
	}
}

function close_output()
{
	global $config, $fn;
	if ($fn) {
		fclose($fh);
	}
}

function get_content($url)
{
	global $config, $fn;
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	if ($config['param_time']) {
		$time = mktime();
		$time+= 19360000000;
		curl_setopt($ch, CURLOPT_COOKIE, "beget=begetok;expires=".date('D, j M Y H:i:s',$time)." GMT;path=/");
	}
	$output = curl_exec($ch);
	if ($output===false) {
		die('Контент страницы не получен.');
	}
	echo "<pre>";
	print_r(strlen($output));
	echo "</pre>";
	curl_close($ch);
	return $output;
}

function content_to_data($content)
{
	global $config, $data;
	$doc = new DOMDocument();
	@$doc->loadHTML($content);
	$xpath = new DOMXpath($doc);

	foreach ($config['search'] as $fieldname => $parser_config) {
		if (array_key_exists('xpath', $parser_config)) {
			$parser = $xpath->query($parser_config['xpath']);
			echo "<pre>";
			print_r($parser);
			echo "</pre>";
			// die();
			foreach ($parser as $value) {
				$data[$fieldname][] = $value->nodeValue;
			}
		}
	}
}

function save_data()
{
	global $fh, $data;
	if (fwrite($fh, json_encode($data, JSON_PRETTY_PRINT)) === FALSE) {
		echo "Не записалось";
	} else {
		echo "<a href='output.txt' target='_blank'>output.txt</a>";
	}
}


$fh = null;
$data = [];
open_output();
if (!empty($config['url'])) {
	echo "<pre>";
	print_r($config['url']);
	echo "</pre>";
	$content = get_content($config['url']);
	content_to_data($content);
} elseif (!empty($config['urls'])) {
	foreach ($config['urls'] as $url) {
		echo "<pre>";
		print_r($url);
		echo "</pre>";
		$content = get_content($url);
		content_to_data($content);
	}
}
save_data();
close_output();
