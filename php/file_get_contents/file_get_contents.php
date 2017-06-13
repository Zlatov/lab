<?php
echo "<pre>";
print_r(file_get_contents('http://sign-forum.ru/api/v1/api.php?action=getLastPosts'));
echo "</pre>";
die();

