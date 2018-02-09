-- source /home/iadfeshchm/projects/my/lab/lab/mysql/_patterns/tree/test/insert_test_data.sql;

-- 1. call categories_tree_descendants(param_id, param_level, param_delta_level);
-- 2. call categories_tree_ancestors(param_id, param_level, param_delta_level);
-- 3. call categories_tree_childrens(param_id);
-- 4. call categories_tree_parent(param_id);
-- 5. call categories_tree_leaf(param_id, param_level, param_delta_level);
-- 6. call categories_tree_level(param_level, param_delta_level);

-- 1.
-- call categories_tree_descendants(1, NULL, NULL);
-- call categories_tree_descendants(1, 2, NULL);
-- call categories_tree_descendants(1, 3, 1);

-- 2.
-- call categories_tree_ancestors(9, NULL, NULL);
-- call categories_tree_ancestors(9, 1, NULL);
-- call categories_tree_ancestors(9, 2, 1);

-- 3.
-- call categories_tree_childrens(4);

-- 4.
-- call categories_tree_parent(2);

-- 5.
call categories_tree_leaf(param_id, param_level, param_delta_level);

-- 6.
-- call categories_tree_level(param_level, param_delta_level);
