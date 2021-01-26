<?php

$sql = "
    SELECT u.user_id ...
";
$result = $db->sql_query($sql);
$user_count = $db->sql_affectedrows($result);
$db->sql_freeresult($result);


$sql = "
    SELECT COUNT(u.user_id) AS user_count ...
";
$result = $db->sql_query($sql);
$user_count = (int) $db->sql_fetchfield('user_count');
$db->sql_freeresult($result);


$sql = sprintf(
    "
        SELECT u.user_id, u.username, u.user_email, u.user_lang
        FROM %1\$s g
        LEFT JOIN %2\$s ug on ug.group_id = g.group_id
        LEFT JOIN %3\$s u on u.user_id = ug.user_id
        WHERE
            g.group_name = '%4\$s'
            OR g.group_id = %5\$d
    ",
    GROUPS_TABLE,
    USER_GROUP_TABLE,
    USERS_TABLE,
    $db->sql_escape($this->model['group_for_ip']),
    $this->model['group_for_ip_id']
);
$result = $db->sql_query($sql);

