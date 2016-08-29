<?php
include_once('voting.php');
include_once('comment.php');
$voting1 = new Voting(['id'=>1,'header'=>'Как нам провести корпоратив?',]);
// $voting1->setVariants([
// 	'Как скажут так и проведем',
// 	'В ресторане с самодеятельностью',
// 	'В ресторане с групповыми играми',
// 	'Активный вид спорта',
// 	'Не проводить корпоратив, отпустить домой к родным',
// ]);
// $voting1->setVotes([
// 	0,
// 	0,
// 	0,
// 	0,
// 	0,
// ]);
$voting2 = new Voting(['id'=>2,'header'=>'В каком составе?',]);
// $voting2->setVariants([
// 	'я один(одна) пойду',
// 	'(+1)',
// 	'(+2)',
// 	'не пойду по уважительной причине',
// ]);
// $voting2->setVotes([
// 	0,
// 	0,
// 	0,
// 	0,
// ]);

// $voting1->delCookie();
// $voting1->resetVotes();
// $voting2->resetVotes();

// echo "<pre>";
// print_r($_COOKIE);
// echo "</pre>";


if (isset($_POST)&&!empty($_POST)&&isset($_POST['votingId'])) {
	$votingId = (int)$_POST['votingId'];
	${"voting".$votingId}->addVote($_POST['vote']);
}

if (isset($_POST)&&!empty($_POST)&&isset($_POST['commentadd'])) {
    $text = htmlspecialchars(strip_tags(trim($_POST['text'])));
    if (empty($text)) {
        Comment::addFormError('Сообщение не должно быть пустым.');
    } else {
        Comment::addComment($_POST['text'], $_POST['username']);
        header('Location: index.php');
    }
}



?>
<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Голосование</title>
    <!-- Favicon -->
    <!-- <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"> -->
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../theme/bootstrap/css/bootstrap.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    <!-- TOC -->
    <link rel="stylesheet" type="text/css" href="../../theme/toc/css/css.css">
</head>

<body>

	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<h1><a href="index.php">Голосование</a></h1>
<?php

if ( $voting1->cookieIsSet() || ( isset($_POST['votingId']) && ($_POST['votingId']==1) ) ) {
	echo $voting1->render('result');
} else {
	echo $voting1->render('voting');
}
if ( $voting2->cookieIsSet() || ( isset($_POST['votingId']) && ($_POST['votingId']==2) ) ) {
	echo $voting2->render('result');
} else {
	echo $voting2->render('voting');
}

echo Comment::template('form');
Comment::render('error');
Comment::render('list');


?>

			</div>
		</div>
	</div>


    <!-- jQuery -->
    <script src="//code.jquery.com/jquery.js"></script>
    <!-- Bootstrap JavaScript -->
    <script type="text/javascript" src="../../theme/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>