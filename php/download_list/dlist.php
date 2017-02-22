<?php

function getCurlData($url, $opt = [])
{
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, 0);
    // curl_setopt($curl, CURLOPT_PROXY, 'proxy.newstar.ru:3128');
    // curl_setopt($curl, CURLOPT_POSTFIELDS, "postvar1=value1&postvar2=value2&postvar3=value3");
    // curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($opt));
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_TIMEOUT, 30);
    $curlData = curl_exec($curl);
    if($curlData === false)
    {
        printf( chr(27) . '[31mОшибка curl: %s' . chr(27) . '[0m' . PHP_EOL, curl_error($curl));
    }
    curl_close($curl);
    return $curlData;
}

$array = range(1,24);

$color_red = chr(27) . '[31m';
$color_green = chr(27) . '[32m';
$style_default = chr(27) . '[0m';

foreach ($array as $value) {
    $value = sprintf('%02d', $value);
    $url = "http://audioknigi-online.site/audio/1/LITRPG/Osadchuk/Zazerkalie/2/0{$value}.mp3";
    $data = getCurlData($url);
    if ($data) {
        file_put_contents($value . ".mp3", $data);
        echo $color_green . $url . $style_default . PHP_EOL;
    } else {
        echo $color_red . $value . ".mp3 - что-то пошло нетак." . $style_default;
    }
}
