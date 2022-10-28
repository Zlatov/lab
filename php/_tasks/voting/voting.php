<?php

/**
* Voting
*/

class Voting
{
	private $id;
	private $header;

	private $variants = null;
	private $variantsPath = null;
	private $votes = null;
	private $votesPath = null;
	private $ips = null;
	private $ipsPath = null;

	private $template = [];

	function __construct($config)
	{
		$this->id = (int)$config['id'];
		$this->header = $config['header'];

		$this->variantsPath = "data/voting-" . $this->id . "-variants.txt";
		$this->votesPath = "data/voting-" . $this->id . "-votes.txt";
		$this->ipsPath = "data/voting-" . $this->id . "-ips.txt";

		$this->template['vote'] = file_get_contents('templates/vote.html');
		$this->template['form'] = file_get_contents('templates/form.html');
		$this->template['table'] = file_get_contents('templates/table.html');
		$this->template['row'] = file_get_contents('templates/row.html');
		// if ( file_exists($this->variantsPath) && file_exists($this->resultPath) && file_exists($this->ipPath) ) {

		// 	if ( !$file_handle = fopen($this->variantsPath, 'rb') ) {
		// 		throw new Exception("2", 2);
		// 	}
		// 	$this->variants = unserialize( fread($file_handle, filesize($this->variantsPath)) );
		// 	fclose($file_handle);

		// 	if ( !$file_handle = fopen($this->resultPath, 'rb') ) {
		// 		throw new Exception("2", 2);
		// 	}
		// 	$this->votingResult = unserialize( fread($file_handle, filesize($this->resultPath)) );
		// 	fclose($file_handle);
			
		// } else {
		// 	throw new Exception("1", 1);
		// }
	}

	public function insertIntoFile($value, $filePath)
	{
		if (!$file_handle = fopen($filePath, 'wb')) {
			throw new Exception("3", 3);
		}
		flock($file_handle, LOCK_EX);
		if (fwrite($file_handle, serialize($value)) === false) {
			throw new Exception("4", 4);
		}
		flock($file_handle, LOCK_UN);
		fclose($file_handle);
	}

	public function selectFromFile($filePath)
	{
		if ( file_exists($filePath) ) {

			if ( !$file_handle = fopen($filePath, 'rb') ) {
				throw new Exception("2", 2);
			}
			$return = unserialize( fread($file_handle, filesize($filePath)) );
			fclose($file_handle);

		} else {
			throw new Exception("1", 1);
		}
		return $return;
	}

	public function setVariants($value)
	{
		$this->insertIntoFile($value, $this->variantsPath);
	}

	public function getVariants()
	{
		if (filesize($this->variantsPath) === 0) {
			return null;
		}
		$this->variants = $this->selectFromFile($this->variantsPath);
		return $this->variants;
	}

	public function setVotes($value)
	{
		$this->insertIntoFile($value, $this->votesPath);
	}

	public function resetVotes()
	{
		$variants = $this->getVariants();
		$value = array_fill(0, count($variants), 0);
		$this->insertIntoFile($value, $this->votesPath);
	}

	public function getVotes()
	{
		if (filesize($this->votesPath) === 0) {
			return null;
		}
		$this->votes = $this->selectFromFile($this->votesPath);
		return $this->votes;
	}

	public function addVote($value)
	{
		if ($this->cookieIsSet()) {
			return;
		}
		$value = intval($value);
		if ($value === false) {
			return;
		}
		$value = (int)$value;
		$votes = $this->getVotes();
		foreach ($votes as $k => $v) {
			if ($value === $k) {
				$votes[$k]++;
				break;
			}
		}
		$this->setVotes($votes);
		$this->addCookie();
	}

	private function addCookie()
	{
		if ( isset($_COOKIE) && isset($_COOKIE['voting']) ) {
			$cookieVoting = unserialize($_COOKIE['voting']);
		} else {
			$cookieVoting = [];
		}
		$cookieVoting[$this->id] = true;
		setcookie("voting", serialize($cookieVoting), time()+60*60*24*7, "/");
	}

	public function cookieIsSet()
	{
		if ( isset($_COOKIE) && isset($_COOKIE['voting']) ) {
			$cookieVoting = unserialize($_COOKIE['voting']);
			if ( isset($cookieVoting[$this->id]) && ($cookieVoting[$this->id] === true) ) {
				return true;
			}
		}
		return false;
	}

	public function delCookie()
	{
		if ( isset($_COOKIE) && isset($_COOKIE['voting']) ) {
			setcookie("voting", null, time()-60*60*24, "/");
		}
	}

	public function render($view)
	{
		switch ($view) {
			case 'voting':
				$variants = $this->getVariants();
				$return = '';
				foreach ($variants as $k => $v) {
					$replace = [
						'??variantKey??' => $k,
						'??variantText??' => $v,
					];
					$return.= str_replace(array_keys($replace),$replace,$this->template['vote']);
				}
				$replace = [
					'??id??' => $this->id,
					'??header??' => $this->header,
					'??votes??' => $return,
				];
				$return = str_replace(array_keys($replace),$replace,$this->template['form']);
				return $return;
				break;

			case 'result':
				$variants = $this->getVariants();
				$votes = $this->getVotes();
				$return = '';
				foreach ($votes as $k => $v) {
					$replace = [
						'??variantText??' => $variants[$k],
						'??votesNumber??' => $v,
					];
					$return.= str_replace(array_keys($replace),$replace,$this->template['row']);
				}
				$replace = [
					'??id??' => $this->id,
					'??header??' => $this->header,
					'??rows??' => $return,
				];
				$return = str_replace(array_keys($replace),$replace,$this->template['table']);
				return $return;
				break;
		
			default:
				# code...
				break;
		}
	}

}





/*


// получаем файлы по определенному голосованию
$id =  (int) $_GET['id']; //приводим к целому числу идентификатор голосования
$vote = (int) $_GET['vote']; //приводим к целому числу передаваемое значение голосования

//проверяем, существует ли такое голосование
if (file_exists("$id.dat")) {

$ip= $_SERVER['REMOTE_ADDR']; //получаем ip адрес
$ip_file = file_get_contents("ip$id.dat");//читаем содержимое файла ip адресов и помещаем в строку
$ip_abbr = explode(",", $ip_file);//получаем в массив имеющиеся ip адреса

$data = file("$id.dat"); //читаем содержимое файла результатов и помещаем в массив

// если это не просто просмотр результатов
if ($vote) {

//сравниваем ip с уже записанными
foreach($ip_abbr as $value) 
if ($ip == $value) {echo "<p><b><font color=red> Вы уже голосовали! </font></b></p>";
exit;
}
// выводим благодарность
echo "<p><b><font color=green> Спасибо! </font></b><br /><i>*Показаны результаты до Вашего голосования:</i><p>";
}

// выводим заголовок голосования - 1я строка файла
echo "<b>$data[0]</b><p>";

// печатаем список ответов и результатов - остальные строки
for ($i=1;$i<count($data);$i++) {
	$votes = explode("~", $data[$i]); // значение~ответ
	echo "$votes[1]: <b>$votes[0]</b><br>"; //поменяйте местами 0 и 1 в $votes и в результатах цифры будут первыми
}
echo "<br>Всего проголосовало: <b>".(count($ip_abbr)-1)."</b>";

// если это не просмотр результатов, а голосование,
// производим необходимые действия для учета голоса
if ($vote) {
	$f = fopen("$id.dat","w");
	flock($f,LOCK_EX);
	fputs($f, "$data[0]");
	for ($i=1;$i<count($data);$i++) {
		$votes = explode("~", $data[$i]);
		if ($i==$vote) $votes[0]++;
		fputs($f,"$votes[0]~$votes[1]");
	fflush($f);
flock($f,LOCK_UN);
	}
	fclose($f);
	
//и записываем ip
	$ip_adr = fopen("ip$id.dat","a++");
	flock($ip_adr,LOCK_EX);
 fputs($ip_adr, "$ip".",");
 fflush($ip_adr);
	flock($ip_adr,LOCK_UN);
fclose($ip_adr);
	}

	} else {
//передан id несуществующего голосования
		 echo "Такого голосования не существует.";
	exit;
}




*/

?>