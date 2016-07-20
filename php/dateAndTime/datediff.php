<?php
// Функция возвращающая разницу в годах, месяцах и днях
// Если второй параметр не задан, то он принимает текущую (сегодняшнюю) дату
// Если $delta = 1, то $dateitem<$dateto, то есть $dateitem было в прошлом
// Если $delta = 0, то $dateitem=$dateto, то есть $dateitem сегодня
// Если $delta = -1, то $dateitem>$dateto, то есть $dateitem ещё наступит
// Пример:
// $a = date_d("2011-09-09");
// printf("%d лет %d месяцев %d дней %s<br>", $a[1],$a[2],$a[3],($a[0]===0)?'сейчас':($a[0]>0)?'назад':'вперёд');
function date_d( $dateitem, $dateto = NULL ) {
	// Дата "отсчёта", обычно сегодняшняя - можно не задавать
	if ($dateto === NULL) $dateto = date("Y-m-d");
	// i - сравниваемый элемент
	$i = explode("-",$dateitem);
	$iy = $i[0];
	$im = $i[1];
	$id = $i[2];
	// t - дата "отсчёта"
	$t = explode("-",$dateto);
	$ty = $t[0];
	$tm = $t[1];
	$td = $t[2];
	$strcmp = strcmp($dateto,$dateitem);
	switch ($strcmp) {
		// Если дата события i меньше (раньше, было в прошлом)
		case 1:
			$year = $ty - $iy;
			$month = $tm - $im;
			$day = $td - $id;
			if ( $day < 0 ) {
				$month--;
				$day = (date("t", strtotime($dateitem))+$day);
			}
			if ( $month < 0 ) {
				$year--;
				$month = (12+$dm);
			}
		break;
		// Если дата события i больше (позже, будет в будущем)
		case -1:
			$year = $iy - $ty;
			$month = $im - $tm;
			$day = $id - $td;
			if ( $day < 0 ) {
				$month--;
				$day = (date("t", strtotime($dateto))+$day);
			}
			if ( $month < 0 ) {
				$year--;
				$month = (12+$dm);
			}
		break;
		// Если дата события i равна дате "отсчета" (сейчас)
		case 0:
			$year = 0;
			$month = 0;
			$day = 0;
		break;
	}
	return(array($strcmp,$year,$month,$day));
}


$a = date_d("2011-09-09");
printf("%d лет %d месяцев %d дней %s<br>", $a[1],$a[2],$a[3],($a[0]===0)?'сейчас':($a[0]>0)?'назад':'вперёд');
echo "<br>";


// Функция склонения слов
// Принимает числительное и список слов в склонении 1,2,5: "яблоко яблока яблок" иди array("день","дня","дней")
// Возвращает выбранное слово
// Пример:
// echo declension(13,"яблоко  яблока яблок");
function declension($number,$words) {
	$return = false;
	// Второй параметр преобразуем в массив, если он - не массив
	if ( !is_array($words) ) {
		$words = explode(' ', trim(preg_replace('/\s+/',' ',$words)));
	}
	// Можем ошибиться с пробелами или количеством склонений, добавляем до 3-х элементов
	if ( empty($words[1]) ) {
		$words[1]=$words[0];
	}
	if ( empty($words[2]) ) {
		$words[2]=$words[1];
	}
	// Остаток от деления на 100
	$number = abs($number) % 100;
	if ( $number > 10 && $number < 20 ) {
		$return = $words[2];
	} else {
		// Остаток от деления на 10
		$i = $number % 10;
		switch ($i) {
			case (1): $return = $words[0]; break;
			case (2):
			case (3):
			case (4): $return = $words[1]; break;
			default: $return = $words[2];
		}
	}
	return $return;
}


for ($i=-151;$i<152;$i++) {
echo $i . " " . declension($i,"месяц месяца месяцев");
echo "<br>";
}
echo "<br>";





// Пример разницы дат с помощью класс DateTime (PHP >= ~5.3)
$datePub = "2004-06-01";
$dateFor = "2016-06-01";
$date1 = new DateTime("now");
echo "<pre>";
print_r($date1);
echo "</pre>";
$date2 = new DateTime($datePub);
$interval = $date1->diff($date2);
echo $interval->format("Статья опубликована: %a дней назад<br>");
echo $interval->format("Или: %y лет, %m месяцев, %d дней, %h часов, %i минут и %s секунд<br>");
$date3 = new DateTime($dateFor);
$a = $date3->diff($date1);
echo $a->format("Произойдёт через %y лет, %m месяцев, %d дней, %h часов, %i минут и %s секунд<br>");
echo "<br>";


// До конца акции
$i = preg_split("/[\s,;\.:-]+/","2014-06-10 16:01:59");
$interval = mktime($i[3],$i[4],$i[5],$i[1],$i[2],$i[0])-mktime(date("H"),date("i"),date("s"),date("m"),date("d"),date("Y"));
$days = floor($interval/(24*60*60));
$hours = floor(($interval%(24*60*60))/(60*60));
$minutes = floor(($interval%(60*60))/60);
$seconds = $interval%60;

if ($interval>0) printf("До конца акции %s %s %s %s %s %s %s %s",

($days>0)?$days:'',($days>0)?declension($days,"день дня дней"):'',
($hours>0)?$hours:'',($hours>0)?declension($hours,"час часа часов"):'',
($minutes>0)?$minutes:'',($minutes>0)?declension($minutes,"минута минуты минут"):'',
($seconds>0)?$seconds:'',($seconds>0)?declension($seconds,"секунда секунда секунд"):''

);
echo "<br>";


$datetime1 = new DateTime('2009-10-11 23:00:00');
$datetime2 = new DateTime('2009-10-12 06:00:00');
$interval = $datetime2->diff($datetime1);
echo $interval->format('%R%a дней');
echo "<br>";

$datetime1 = new DateTime('2009-10-11 6:00:00');
$datetime2 = new DateTime('2009-10-12 23:00:00');
$interval = $datetime2->diff($datetime1);
echo $interval->format('%R%a дней');
echo "<br>";

$datetime1 = new DateTime('2009-10-11 6:00:00');
$datetime2 = new DateTime('2009-10-12 23:00:00');
$interval = $datetime1->diff($datetime2); // dt2 - dt1
echo $interval->format('%R%a дней');
echo "<br>";

$datetime1 = new DateTime('2009-10-11');
$datetime2 = new DateTime('2009-10-12');
$interval = $datetime1->diff($datetime2);
echo $interval->format('%R%a дней');
echo "<br>";




?>