<?php
set_time_limit(3*60);
$fh = fopen("./output.txt", 'ab');
if (!$fh)
{
    echo "Не открылся";
}
else
{
	for ($i=0; $i < 99; $i++) {
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://online-generators.ru/quotes");
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$time = mktime();
		$time+= 19360000000;
		curl_setopt($ch, CURLOPT_COOKIE, "beget=begetok;expires=".date('D, j M Y H:i:s',$time)." GMT;path=/");
		$output = curl_exec($ch);
		curl_close($ch);

		$doc = new DOMDocument();
		@$doc->loadHTML($output);
		$xpath = new DOMXpath($doc);
		$p = $xpath->query('//div[@class="quote-text"]/blockquote/p');
		$p = $p[0]->nodeValue;
		$small = $xpath->query('//div[@class="quote-text"]/blockquote/small');
		$small = $small[0]->nodeValue;

	    if (fwrite($fh, $p."\n") === FALSE)
	    {
	        echo "Не записалось";
	    }
	    if (fwrite($fh, $small."\n") === FALSE)
	    {
	        echo "Не записалось";
	    }
		// usleep(1000);
		// set_time_limit(10);
	}
}
fclose($fh);


