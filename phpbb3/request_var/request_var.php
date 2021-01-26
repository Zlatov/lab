<?php

$submit = (isset($_POST['submit'])) ? true : false;
$start = request_var('start', 0);
$message = utf8_normalize_nfc(request_var('message', '', true));
$price = request_var('price', 0.0);

// cookie
$cookie = request_var('cookie_time', 0, false, true);
$cookie = request_var($config['cookie_name'] . '_cookie_name', 0, false, true);

// Получение массивов
$mark_array = request_var('mark', array(0));
$action_ary = request_var('action', array('' => 0));
$attr_auths = request_var('attr_auths', array(
    '' => array(
        '' => ''
    )
));
