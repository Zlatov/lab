<form action="" method="post">
	<input type="text" name="name" value="name">
	<input type="submit" name="submit" value="submit">
	<input type="submit" name="submit2" value="submit2">
	<button type="submit" name="submit3">submit3</button>
	<button type="submit" name="submit4" value="submit4">submit4</button>
</form>

<?php

echo "<pre>";
print_r($_POST);
echo "</pre>";
die();

?>