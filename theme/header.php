<?php
$pathinfo = pathinfo($_SERVER['REDIRECT_URL']);
$explode = explode('/',$pathinfo['dirname']);
$last = end($explode);
$header = $last?'All ' . $last:'All';
?><!DOCTYPE html>
<html lang="ru">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><?= $header ?></title>
	<!-- Favicon -->
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="/theme/bootstrap/css/bootstrap.css">
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	<!-- TOC -->
	<link rel="stylesheet" type="text/css" href="/theme/toc/css/css.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" type="text/css" href="/theme/font-awesome/css.css">
	<!-- jstree -->
	<link rel="stylesheet" href="/theme/bower/jstree/dist/themes/default/style.min.css" />
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="/theme/css/custom.css">
</head>

<body data-spy="scroll" data-target="#toc">
	<div class="container">
        <div class="row">
            <div class="col-xs-offset-4 col-sm-offset-4 col-md-offset-4 col-lg-offset-4 col-xs-8 col-sm-8 col-md-8 col-lg-8">
                <h1><?= $header ?></h1>
            </div>
        </div>
		<div class="row">
			<div class="hidden-xs col-sm-4 col-md-4 col-lg-4">
				<div id="toc" data-spy="affix" data-offset-top="0" data-offset-bottom="0"></div>
			</div>
			<div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
