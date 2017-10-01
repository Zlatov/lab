<?php if (
	isset($pagination_item_count) &&
	isset($pagination_page_limit) &&
	isset($pagination_page) &&
	isset($pagination_name)
): ?>
	<?php $count = ceil($pagination_item_count/$pagination_page_limit); ?>
	<form method="post" action="">
		Страницы: 
		<?php for ($i=1; $i <= $count; $i++) : ?>
			<button type="submit" name="<?php echo $pagination_name ?>" value="<?php echo $i ?>"><?php echo $i ?></button><?php echo (($i==$count)? '' : ', ') ?>
		<?php endfor ?>
	</form>
<?php endif ?>
