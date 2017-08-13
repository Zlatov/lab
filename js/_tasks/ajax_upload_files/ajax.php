<?php
$uploaddir = __DIR__ . '/upload/';

if (isset($_FILES['images'])) {
    foreach ($_FILES['images']['tmp_name'] as $key => $tmp_name) {
        echo "<pre>";
        print_r($_FILES['images']['name'][$key]);
        echo "</pre>";
        echo "<pre>";
        print_r($_FILES['images']['type'][$key]);
        echo "</pre>";
        echo "<pre>";
        print_r($_FILES['images']['tmp_name'][$key]);
        echo "</pre>";
        echo "<pre>";
        print_r($_FILES['images']['error'][$key]);
        echo "</pre>";
        echo "<pre>";
        print_r($_FILES['images']['size'][$key]);
        echo "</pre>";
        if ($_FILES['images']['type'][$key] === 'image/jpeg') {
            $pathinfo = pathinfo($_FILES['images']['name'][$key]);
            $uploadfile = __DIR__ . '/upload/' . $pathinfo['filename'] . '.jpg';
            if (move_uploaded_file($_FILES['images']['tmp_name'][$key], $uploadfile)) {
                echo "<pre>";
                echo "Файл корректен и был успешно загружен.\n";
                echo "</pre>";
            } else {
                echo "<pre>";
                echo "Возможная атака с помощью файловой загрузки!\n";
                echo "</pre>";
            }
        } else {
            echo "<pre>";
            echo "Будем загружать только jpeg!";
            echo "</pre>";
        }
    }
}
