<?php
preg_match('/[a-zA-Z]{1,5}$/','/upload/foto/0/000/000/50/foto.',$matches);
var_dump($matches);
if (is_null($matches[0])) {
	echo "Y";
}

$pathinfo = pathinfo ( '/upload/foto/0/000/000/50/foto', PATHINFO_EXTENSION);
var_dump($pathinfo);
