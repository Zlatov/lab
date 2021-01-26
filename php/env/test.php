<?php



echo "<pre>";
print_r($_ENV['REMOTE_ADDR']);
echo "</pre>";

echo "<pre>";
print_r(getenv("REMOTE_ADDR"));
echo "</pre>";

echo "<pre>";
print_r($_ENV['REMOTE_ADDR']);
echo "</pre>";




// phpinfo();

echo "<pre>";
print_r($_ENV);
echo "</pre>";

$a = getenv('DB_FORUM');
echo '$a: <pre>';
var_export($a);
echo '</pre>';
