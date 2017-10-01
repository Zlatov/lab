<?php if (count($users)): ?>
	<table>
		<caption>Список пользователей</caption>
		<thead>
			<tr>
				<th>Идетнификатор</th>
				<th>Имя</th>
				<th>Удалить</th>
				<th>Редактировать</th>
			</tr>
		</thead>
		<tfoot>
			<tr colspan="4">
				<td>
					<?php $pagination_item_count = $users_count; ?>
					<?php $pagination_page_limit = $config['user']['limit']; ?>
					<?php $pagination_page = $users_page; ?>
					<?php $pagination_name = 'users_page'; ?>
					<?php include 'view/partial/pagination.php'; ?>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<?php foreach ($users as $user): ?>
				<tr>
					<td><?php echo $user['id'] ?></td>
					<td><?php echo $user['name'] ?></td>
					<td>
						<form method="post">
							<input type="hidden" name="id" value="<?php echo $user['id'] ?>">
							<button name="submitForm" value="del_user">Удалить</button>
						</form>
					</td>
					<td>
						<form method="post">
							<input type="hidden" name="id" value="<?php echo $user['id'] ?>">
							<button name="submitForm" value="edit_user">Редактировать</button>
						</form>
					</td>
				</tr>
			<?php endforeach ?>
		</tbody>
	</table>
<?php else: ?>
	<p>Нет пользователей</p>
<?php endif ?>
