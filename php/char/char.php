<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="utf-8">
        <title>HTML5 - Привет, Мир!</title>
        <style type="text/css">
            article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
        </style>
    </head>
    <body>
        <p>Привет, Мир!</p>

<?php
for ($i = 10; $i < 10072; $i++)
{
    echo chr($i) . PHP_EOL;
}
?>
    </body>
</html>
