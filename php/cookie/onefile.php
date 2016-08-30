<?php
session_start();


if ( !isset($_GET['checkCookie']) && !isset($_SESSION['cookieIsChecked']) ) {
    // save the referrer in session. if cookie works we can get back to it later.
    $_SESSION['QUERY_STRING'] = $_SERVER['QUERY_STRING'];
    // die();
    // set a cookie to test
    setcookie('foo', 'bar', time() + 60*60*24);
    // redirecting to the same page to check 
    if (empty($_SERVER['QUERY_STRING'])) {
	    header("location: {$_SERVER['PHP_SELF']}?checkCookie=true");
    } else {
	    header("location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}&checkCookie=true");
    }
}


if ( isset($_GET['checkCookie']) && ($_GET['checkCookie'] == true) && !isset($_SESSION['cookieIsChecked']) ) {
    if (isset($_COOKIE['foo']) && $_COOKIE['foo'] == 'bar') {
    	setcookie('foo', 'bar', time() - 60*60*24);
        $_SESSION['cookieIsChecked'] = true;
        if (!isset($_SESSION['QUERY_STRING']) || empty($_SESSION['QUERY_STRING'])) {
    		header("location: {$_SERVER['PHP_SELF']}");
        } else {
    		header("location: {$_SERVER['PHP_SELF']}?{$_SESSION['QUERY_STRING']}");
        }
        // echo 'cookie is working';
    } else {
        // echo 'show the message "cookie is not working"';
    }
}

if (isset($_SESSION['cookieIsChecked']) && $_SESSION['cookieIsChecked'] === true) {
	define('COOKIE_ENABLED', true);
}

if (!defined('COOKIE_ENABLED')) {
    define('COOKIE_ENABLED', false);
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>

<?php

if (COOKIE_ENABLED) {
	echo "<p>РАЗРЕШЕНЫ</p>";
} else {
	echo "<p>заперщены</p>";
}

?>
	
</body>
</html>
