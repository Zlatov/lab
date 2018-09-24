<form action="" method="post">
    <fieldset>
        <legend>Подготовить дерево</legend>
        <p><button type="submit" name="submit" value="create_tables">Пересоздать</button> таблицы.</p>
        <p><button type="submit" name="submit" value="insert_test">Вставить</button> тестовые данные вместо существующих.</p>
        <p><button type="submit" name="submit" value="insert_million">Вставить</button> <input type="text" name="count" placeholder="количество" value="100"> записей вместо существующих.</p>
    </fieldset>
    <fieldset>
        <legend>Тест API</legend>
        <p><button type="submit" name="submit" value="add">Добавить</button> в <input type="text" name="pid" placeholder="идентификатор" value="1"> «<input type="text" name="header" placeholder="текст элемента" value="e">».</p>
        <p><button type="submit" name="submit" value="select_ancestors">Выбрать</button> предков <input type="text" name="select_ancestors_id" value="9" placeholder="идентификатор">.</p>
        <p><button type="submit" name="submit" value="select_descendants">Выбрать</button> потомков <input type="text" name="select_descendants_id" value="1" placeholder="идентификатор">.</p>
        <p><button type="submit" name="submit" value="get_childrens">Выбрать</button> детей <input type="text" name="pid" value="1" placeholder="идентификатор">.</p>
        <p><button type="submit" name="submit" value="move">Переместить</button> <input type="text" name="eid" value="3" placeholder="идентификатор"> в <input type="text" name="tid" value="6" placeholder="идентификатор">.</p>
        <p><button type="submit" name="submit" value="delete">Удалить</button> <input type="text" name="id" value="1" placeholder="идентификатор"> <label>рекурсивно <input type="checkbox" name="recursively" value="1"></label>.</p>
        <p><button type="submit" name="submit" value="order_after">Поставить</button> <input type="text" name="id" value="2" placeholder="идентификатор"> после <input type="text" name="after_id" value="3" placeholder="идентификатор">.</p>
        <p><button type="submit" name="submit" value="order_first">Поставить</button> <input type="text" name="id" value="7" placeholder="идентификатор"> в начало <input type="text" name="pid" value="4" placeholder="идентификатор">.</p>
    </fieldset>
</form>
