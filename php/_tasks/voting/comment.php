<?php

/**
* Comment
*/
class Comment
{
	private static $commentPath = 'data/comment.txt';
	private static $templates = null;
	private static $formError = null;

	public static function template($templateName)
	{
		if (self::$templates) {
			return self::$templates[$templateName];
		}
		self::$templates = [
			'list' => file_get_contents('templates/comment-list.html'),
			'form' => file_get_contents('templates/comment-form.html'),
			'error' => file_get_contents('templates/comment-error.html'),
		];
		return self::$templates[$templateName];
	}

	public static function insertIntoFile($value, $filePath)
	{
		if (!$file_handle = fopen($filePath, 'ab')) {
			throw new Exception("3", 3);
		}
		flock($file_handle, LOCK_EX);
		if (fwrite($file_handle, $value) === false) {
			throw new Exception("4", 4);
		}
		flock($file_handle, LOCK_UN);
		fclose($file_handle);
	}

	public static function addComment($text, $username = null)
	{
		$data = [
			'text' => htmlspecialchars(strip_tags(trim($text))),
			'datetime' => new DateTime(),
			'username' => htmlspecialchars(strip_tags($username)),
		];
		$data = json_encode($data);
		$data = $data.PHP_EOL;
		self::insertIntoFile($data,self::$commentPath);
	}

	public static function addFormError($text)
	{
		if (self::$formError) {
			$errors = self::$formError;
		} else {
			$errors = [];
		}
		$errors[] = $text;
		self::$formError = $errors;
	}

	public static function render($value)
	{
		switch ($value) {
			case 'list':
				$return = '';
				$handle = fopen("data/comment.txt", "rb");
				if ($handle) {
				    while (($buffer = fgets($handle)) !== false) {
				    	$data = json_decode($buffer, true);
				    	$replace = [
				    		'??username??' => $data['username'],
				    		'??text??' => nl2br($data['text']),
				    	];
				        echo str_replace(array_keys($replace),$replace,self::template('list'));
				    }
				    fclose($handle);
				}
				break;

			case 'error':
				// echo "<pre>";
				// print_r(self::$formError);
				// echo "</pre>";
				// die();
				if (!empty(self::$formError)) {
					foreach (self::$formError as $key => $value) {
						$replace = [
							'??errorText??' => $value,
						];
				        echo str_replace(array_keys($replace),$replace,self::template('error'));
					}
				}
				break;
			
			default:
				break;
		}
	}


}