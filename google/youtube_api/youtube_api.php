<?php
include('config.php');

$url = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key={$youtube_api_key}&part=snippet,contentDetails,statistics,status";
$url = "https://www.googleapis.com/youtube/v3/search?key={$youtube_api_key}&channelId={$youtube_channel_id}&part=snippet,id&order=date&maxResults=50";

$ch = curl_init($url);
$options = [
  CURLOPT_URL            => $url,
  CURLOPT_RETURNTRANSFER => true,     // return web page
  CURLOPT_HEADER         => false,    // don't return headers
  CURLOPT_FOLLOWLOCATION => true,     // follow redirects
  CURLOPT_ENCODING       => '',       // handle all encodings
  CURLOPT_USERAGENT      => 'spider', // who am i
  CURLOPT_AUTOREFERER    => true,     // set referer on redirect
  CURLOPT_CONNECTTIMEOUT => 120,      // timeout on connect
  CURLOPT_TIMEOUT        => 120,      // timeout on response
  CURLOPT_MAXREDIRS      => 10,       // stop after 10 redirects
  CURLOPT_SSL_VERIFYPEER => false     // Disabled SSL Cert checks
];
curl_setopt_array($ch, $options);

$content = curl_exec($ch);
$err     = curl_errno($ch);
$errmsg  = curl_error($ch);
$header  = curl_getinfo($ch);
curl_close($ch);

echo '$content: <pre>';
print_r($content);
echo '</pre>';

echo '$err: <pre>';
print_r($err);
echo '</pre>';

echo '$errmsg: <pre>';
print_r($errmsg);
echo '</pre>';

echo '$header: <pre>';
print_r($header);
echo '</pre>';
