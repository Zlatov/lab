<?php
/* Парсинг страниц Яндекса "Компания" с помощью simple_html_dom.php */


//$query = '';
//$query = file_get_contents('http://maps.yandex.ru/org/1241285531/');
//echo $query;

require_once $_SERVER['DOCUMENT_ROOT']."/lab/simple_html_dom.php";

$html = file_get_contents($_SERVER['DOCUMENT_ROOT'].'/lab/temp.html');
preg_match_all("%oid=(\d{1,})%",$html,$result);

$array = array();
foreach ($result[1] as $val) { echo $array[]='http://maps.yandex.ru/org/'.$val.'/'; echo '<br>'; }

/*$array = array(
'http://maps.yandex.ru/org/1241285531/',
'http://maps.yandex.ru/org/1070445136/',
'http://maps.yandex.ru/org/1145837662/',
'http://maps.yandex.ru/org/1018427705/',
'http://maps.yandex.ru/org/1036233593/',
'http://maps.yandex.ru/org/1042043103/',
'http://maps.yandex.ru/org/1052102939/',
'http://maps.yandex.ru/org/1105798238/',
'http://maps.yandex.ru/org/1064106023/',
'http://maps.yandex.ru/org/1093004591/',
'http://maps.yandex.ru/org/1004929233/',
'http://maps.yandex.ru/org/1033622703/',
'http://maps.yandex.ru/org/1186922492/',
'http://maps.yandex.ru/org/1011157679/',
'http://maps.yandex.ru/org/1080487310/',
'http://maps.yandex.ru/org/1134673621/',
'http://maps.yandex.ru/org/1155205409/',
'http://maps.yandex.ru/org/1053020983/',
'http://maps.yandex.ru/org/1001239762/',
'http://maps.yandex.ru/org/1036242855/',
'http://maps.yandex.ru/org/1109637795/'
);*/



echo '<table border="1">';
	echo '        <tr>
            <th>Название</th>
            <th>Телефон</th>
            <th>Чем занимается</th>
            <th>Адрес</th>
        </tr>';

foreach ($array as $val) {
	$html = file_get_html($val);
	$item = array();
	$item['name'] = $html->find('h1.b-page-title__title', 0)->plaintext;
	$item['phone'] = $html->find('ul.b-contacts', 0)->plaintext;
	$item['adres'] = $html->find('p.b-address', 0)->plaintext;
	$item['site'] = $html->find('a.b-serp-item__title-link', 0)->plaintext;
	$item['obl'] = $html->find('div.b-rubrics', 0)->plaintext;
	echo '<tr>';
	echo "<td><a href='http://$item[site]'>$item[name]</a></td><td>$item[phone]</td><td>$item[obl]</td><td>$item[adres]</td>";
	echo '</tr>';
}
echo '</table>';

?>