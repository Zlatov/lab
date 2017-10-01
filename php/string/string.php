<?php
$a = <<< STRING
asd
asddas
STRING;
echo $a;

$a = <<< STRING
	asddasasd;
	DELIMITER ;;
	asdsa;
	asdsa;;
	DELIMITER ;
STRING;

echo str_replace(';;',';',$a);
