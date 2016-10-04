<?php
preg_match('/[a-zA-Z]{1,5}$/','/upload/foto/0/000/000/50/foto.',$matches);
echo "<pre>";
var_dump($matches);
echo "</pre>";
if (is_null($matches[0])) {
	echo "Y";
}

// $pathinfo = pathinfo ( '/upload/foto/0/000/000/50/foto', PATHINFO_EXTENSION);
// var_dump($pathinfo);

// [youtube]http://www.youtube.com/watch?v=kXPTwEpW73Q[/youtube]
$message = $str = 'Универсальность применения раскройных комплексов iEcho демонстрируется очередной инсталляцией данного вида оборудования нашей компанией. Ведь раскроем материалов, которые применяются в рекламной индустрии, использование данных планшетных раскройщиков не ограничивается. Промышленный комплекс серии SC был инсталлирован на крупной фабрике по пошиву чехлов для автомобилей. Раскрой кожи, кожзама, ткани, лекал  - вот его основная задача. 
Привожу небольшой видеоролик с данной инсталляции, который демонстрирует данный раскройный комплекс в работе:

 [youtube]http://www.youtube.com/watch?v=QmM07BrhQ1E[/youtube]';

$pattern = '#\[youtube\](http://(?:www\.)?youtube.com/watch\?v=([0-9A-Za-z-_]{11}))[^[]*\[/youtube\]#is';

$replacement = '
<!-- BEGIN youtube --> 
<object width="425" height="350"> 
   <param name="movie" value="http://www.youtube.com/v/$2"></param> 
   <embed src="http://www.youtube.com/v/$2" type="application/x-shockwave-flash" width="425" height="350"></embed> 
</object><br /> 
<a href="http://youtube.com/watch?v=$2" target="_blank">$1</a><br /> 
<!-- END youtube -->
';

preg_match($pattern,$message,$matches);
echo "<pre>";
print_r($matches);
echo "</pre>";

$message = preg_replace($pattern,$replacement,$message);
echo $message;
// print_r($message);
