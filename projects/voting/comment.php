<?php

/**
* Comment
*/
class Comment
{
	private static $commentPath = 'data/comment.txt';
	private static $templateList = '<div class="col-sm-4">??username??</div><div class="col-sm-8">??text??</div>';

	public static function template($templateName)
	{
		return self::templates()[$templateName];
	}

	public static function templates()
	{
		return [
			'list' => file_get_contents('templates/comment-list.html'),
			'form' => file_get_contents('templates/comment-form.html'),
		];
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
			'text' => $text,
			'datetime' => new DateTime(),
			'username' => $username,
		];
		$data = json_encode($data);
		$data = $data.PHP_EOL;
		self::insertIntoFile($data,self::$commentPath);
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
				    		'??text??' => $data['text'],
				    	];
				        echo str_replace(array_keys($replace),$replace,self::$templateList);
				    }
				    fclose($handle);
				}
				break;
			
			default:
				break;
		}
	}


}