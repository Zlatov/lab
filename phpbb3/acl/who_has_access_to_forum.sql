USE forum;

SELECT ag.*, g.group_name, ao.auth_option, ard.*
FROM forum_acl_groups ag
LEFT JOIN forum_groups g ON g.group_id = ag.group_id
LEFT JOIN forum_acl_options ao ON ao.auth_option_id = ag.auth_option_id
LEFT JOIN forum_acl_roles_data ard ON ard.role_id = ag.auth_role_id AND ( ard.auth_option_id = 14 OR ard.auth_option_id = 20 )
WHERE ag.forum_id = 33;

-- SELECT au.*, u.username
-- FROM forum_acl_users au
-- LEFT JOIN forum_users u ON u.user_id = au.user_id
-- WHERE au.forum_id = 34;
