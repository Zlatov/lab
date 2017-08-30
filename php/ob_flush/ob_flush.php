<?php

set_time_limit(60*10);

?>

0<br>

<?php

ob_flush();
// flush();

// ob_start();
$array = range(1,10);
foreach ($array as $value) {
    // $url = "http://audioknigi-online.site/audio/1/LITRPG/Buliuh/Dirty-games/1/{$value}.mp3";
    // file_put_contents("{$value}.mp3", fopen("$url", 'r'));
    // echo $url . ' done.<br>' . PHP_EOL;
    // ob_flush();
    // flush();
    sleep(1);
    echo('doing something...' . $value . '<br>');

    ob_flush();
    // flush();
}
ob_end_flush();
