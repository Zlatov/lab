<?php 

include_once 'config.php';
include_once 'functions.php';

$error = false;
$response = '';

if (isset($_POST['submitForm'])&&!$error) {
	switch ($_POST['submitForm']) {
		case 'recreate_schema':
		case 'recreate_tables':
		case 'recreate_procedures':
		$response = get_response($_POST['submitForm']);
		break;
	}
}

if (!check_schema_exist()) {
	$response = '<p>База данных не существует.</p>';
	$error = true;
} else {
	schema_select();
}

if (!check_schema_select()) {
	$response = '<p>База данных не выбрана.</p>';
	$error = true;
}

if (isset($_POST['submitForm'])&&!$error) {
	$response = get_response($_POST['submitForm']);
}

include_once 'template.php';
