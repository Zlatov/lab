<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
<pre>
&lt;?php
	$array = [
		&quot;ActionScript&quot;,
		&quot;AppleScript&quot;,
		&quot;Asp&quot;,
		&quot;BASIC&quot;,
		&quot;C&quot;,
		&quot;C++&quot;,
		&quot;Clojure&quot;,
		&quot;COBOL&quot;,
		&quot;ColdFusion&quot;,
		&quot;Erlang&quot;,
		&quot;Fortran&quot;,
		&quot;Groovy&quot;,
		&quot;Haskell&quot;,
		&quot;Java&quot;,
		&quot;JavaScript&quot;,
		&quot;Lisp&quot;,
		&quot;Perl&quot;,
		&quot;PHP&quot;,
		&quot;Python&quot;,
		&quot;Ruby&quot;,
		&quot;Scala&quot;,
		&quot;Scheme&quot;
	];
	$json = json_encode($array);
?&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
	var text = '&lt;?= $json ?&gt;';
	var data = eval(&quot;(&quot; + text + &quot;)&quot;);
	var data2 = JSON.parse(text);
	console.log(data);
	console.log(data2);
&lt;/script&gt;
</pre>
	<?php
		$array = [
			"ActionScript",
			"AppleScript",
			"Asp",
			"BASIC",
			"C",
			"C++",
			"Clojure",
			"COBOL",
			"ColdFusion",
			"Erlang",
			"Fortran",
			"Groovy",
			"Haskell",
			"Java",
			"JavaScript",
			"Lisp",
			"Perl",
			"PHP",
			"Python",
			"Ruby",
			"Scala",
			"Scheme"
		];
		$json = json_encode($array);
	?>
	<script type="text/javascript">
		var text = '<?= $json ?>';
		var data = eval("(" + text + ")");
		var data2 = JSON.parse(text);
		console.log(data);
		console.log(data2);
	</script>
</body>
</html>