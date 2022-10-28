<?php
// Recommended way for versions of PHP >= 5.4.0
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
//For versions of PHP < 5.4.0
// if(session_id() == '') {
//     session_start();
// }


// Если нет проверочного гет запроса,
// но нет флага от второго прохождения прохождения
// то запекаем печенье ()
// скармливаем браузеру (пересылаем header()-ом с проверочным гет запросом)
if ( !isset($_GET['checkCookie']) && !isset($_SESSION['cookieIsChecked']) ) {
    // сохраняем ссылку в сессию, если печеньки работаю, то мы сможем восстановить ссылку позже
    $_SESSION['QUERY_STRING'] = $_SERVER['QUERY_STRING'];
    // запекаем
    setcookie('foo', 'bar', time() + 60*60*24);
    // redirecting to the same page to check 
    if (empty($_SERVER['QUERY_STRING'])) {
	    header("location: {$_SERVER['PHP_SELF']}?checkCookie=true");
    } else {
	    header("location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}&checkCookie=true");
    }
}

// Если есть проверочный гет,
// и нет флага второго прохождения
// проверяем печеньки съедины или нет
// если печеньки работают, то восстанавливаем исходный урл методом header()-а (перед этим установив флаг второго прохождения)
// если печеньки не работаю
if ( isset($_GET['checkCookie']) && ($_GET['checkCookie'] == true) && !isset($_SESSION['cookieIsChecked']) ) {
    if (isset($_COOKIE['foo']) && $_COOKIE['foo'] == 'bar') {
    	setcookie('foo', 'bar', time() - 60*60*24);
        $_SESSION['cookieIsChecked'] = true;
        if (!isset($_SESSION['QUERY_STRING']) || empty($_SESSION['QUERY_STRING'])) {
    		header("location: {$_SERVER['PHP_SELF']}");
        } else {
    		header("location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}");
        }
    } else {
    }
}

if (isset($_SESSION['cookieIsChecked']) && $_SESSION['cookieIsChecked'] === true) {
	define('COOKIE_ENABLED', true);
}
if (!defined('COOKIE_ENABLED')) {
    define('COOKIE_ENABLED', false);
}


