<a href="">self</a><br>
<form action="" method="post">
	<!-- <input type="text" name="name" value="name"> -->
<br>
		<input name="classMy[phonenumber][]" type="text" value="name">
		<input name="classMy[viber][]" type="hidden" value="next">
		<input name="classMy[viber][]" type="checkbox" value="1">
		<input name="classMy[ese][]" type="hidden" value="next">
		<input name="classMy[ese][]" type="checkbox" value="1">

<br>
		<input name="classMy[phonenumber][]" type="text" value="name">
		<input name="classMy[viber][]" type="hidden" value="next">
		<input name="classMy[viber][]" type="checkbox" value="1">
		<input name="classMy[ese][]" type="hidden" value="next">
		<input name="classMy[ese][]" type="checkbox" value="1">

<br>
		<input name="classMy[phonenumber][]" type="text" value="name">
		<input name="classMy[viber][]" type="hidden" value="next">
		<input name="classMy[viber][]" type="checkbox" value="1">
		<input name="classMy[ese][]" type="hidden" value="next">
		<input name="classMy[ese][]" type="checkbox" value="1">

<br>
		<input name="classMy[phonenumber][]" type="text" value="name">
		<input name="classMy[viber][]" type="hidden" value="next">
		<input name="classMy[viber][]" type="checkbox" value="1">
		<input name="classMy[ese][]" type="hidden" value="next">
		<input name="classMy[ese][]" type="checkbox" value="1">



	<input type="submit" name="submit" value="submit">
	<input type="submit" name="submit2" value="submit2">
	<button type="submit" name="submit3">submit3</button>
	<button type="submit" name="submit4" value="submit4">submit4</button>
</form>

<?php

echo "<pre>";
print_r($_POST);
echo "</pre>";
echo "<pre>";
var_dump($_POST);
echo "</pre>";
die();

?>