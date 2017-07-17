<?php
$header = template('header', ['title' => 'Hello World!']);
$content = template('content', ['content' => "Lorem ipsum...", 'meta' => 'Author info']);
$footer = template('footer', ['copy' => "Copyright ". date('Y')]);
 
// ...skipped logic
 
echo $header, $content, $footer;
 
/**
 * @param  string $template
 * @param  array  $vars
 * @return string
 */
function template($template, $vars) {
	foreach ($vars as $key => $value) {
		$$key = $value;
	}
	ob_start();
	include "3/${template}.html";
	return ob_get_clean();
}
