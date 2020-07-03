DROP PROCEDURE IF EXISTS `getLastPosts`;
DROP PROCEDURE IF EXISTS `getMostDiscussedTopics`;

DELIMITER ;;

CREATE PROCEDURE `getLastPosts`(in param_group_id int, in param_limit int)
BEGIN

  --  Запрос с IN, логика: Выбрать посты с forum_id IN (выбрать доступные форумы)
  --  Выполняется более 100 секунд
  -- SELECT
  --  p.post_id, p.topic_id, p.forum_id, p.poster_id, p.poster_ip, p.post_time, p.post_subject, p.post_text
  --  , u.username, u.user_id, u.user_rank, u.user_avatar, u.user_avatar_type, u.user_avatar_width, u.user_avatar_height, u.user_posts, u.user_regdate, u.user_lastvisit
  -- FROM forum_posts p
  -- INNER JOIN forum_users u ON u.user_id = p.poster_id
  -- WHERE p.forum_id IN (
  --  SELECT
  --    f.forum_id
  --  -- выбрать группу с id в where условии:
  --  FROM forum_groups g
  --  -- присоединяем смежную таблицу (назначение группе ролей и опций)
  --  LEFT JOIN forum_acl_groups ag ON ag.group_id = g.group_id
  --  -- присоединяем таблицу опций (назначение группе ролей и )
  --  LEFT JOIN forum_acl_options ao ON ao.auth_option_id = ag.auth_option_id
  --  INNER JOIN forum_forums f ON f.forum_id = ag.forum_id
  --  WHERE g.group_id = param_group_id
  --    AND (
  --      -- опции не назначены - назначены роли (любая кроме 16-ой нам подойдет)
  --      ( ag.auth_option_id = 0 AND ag.auth_role_id <> 16 )
  --      -- или назначена опция чтение и оция выставлена в 1
  --      OR (
  --        ao.auth_option = 'f_read' AND ag.auth_setting = 1
  --      )
  --    )
  -- )
  --  AND p.post_visibility = 1
  --  AND p.post_hidden_for_other = 0
  -- -- ORDER BY p.post_time DESC
  -- ORDER BY p.post_id DESC
  -- LIMIT param_limit;

  --  Запрос с INNER JOIN, логика: выбрать доступные форумы INNER JOIN посты
  --  Выполняется более 7 секунд
  -- SELECT
  --  p.post_id, p.topic_id, p.forum_id, p.poster_id, p.poster_ip, p.post_time, p.post_subject, p.post_text
  --  , u.username, u.user_id, u.user_rank, u.user_avatar, u.user_avatar_type, u.user_avatar_width, u.user_avatar_height, u.user_posts, u.user_regdate, u.user_lastvisit
  -- FROM forum_groups g
  -- LEFT JOIN forum_acl_groups ag ON ag.group_id = g.group_id
  -- LEFT JOIN forum_acl_options ao ON ao.auth_option_id = ag.auth_option_id
  -- INNER JOIN forum_forums f ON f.forum_id = ag.forum_id
  -- INNER JOIN forum_posts p ON p.forum_id = f.forum_id
  -- INNER JOIN forum_users u ON u.user_id = p.poster_id
  -- WHERE g.group_id = param_group_id
  --    AND (
  --      -- опции не назначены - назначены роли (любая кроме 16-ой нам подойдет)
  --      ( ag.auth_option_id = 0 AND ag.auth_role_id <> 16 )
  --      -- или назначена опция чтение и оция выставлена в 1
  --      OR (
  --        ao.auth_option = 'f_read' AND ag.auth_setting = 1
  --      )
  --    )
  --  AND p.post_visibility = 1
  --  AND p.post_hidden_for_other = 0
  -- ORDER BY p.post_time DESC
  -- LIMIT param_limit;

  --  Запрос с INNER JOIN, логика: выбрать посты за неделю INNER JOIN выбрать доступные форумы по группе
  --  Выполняется более 7 секунд
  SELECT
    p.post_id, p.topic_id, p.forum_id, p.poster_id, p.poster_ip, p.post_time, p.post_subject, p.post_text
    , u.username, u.user_id, u.user_rank, u.user_avatar, u.user_avatar_type, u.user_avatar_width, u.user_avatar_height, u.user_posts, u.user_regdate, u.user_lastvisit,
    t.topic_title
  FROM forum_posts p
  INNER JOIN (
    SELECT
      f.forum_id
    FROM forum_groups g
    LEFT JOIN forum_acl_groups ag ON ag.group_id = g.group_id
    LEFT JOIN forum_acl_options ao ON ao.auth_option_id = ag.auth_option_id
    INNER JOIN forum_forums f ON f.forum_id = ag.forum_id
    WHERE
      -- g.group_id = 49334
      g.group_id = 49441
      AND (
        -- опции не назначены - назначены роли (любая кроме 16-ой нам подойдет)
        ( ag.auth_option_id = 0 AND ag.auth_role_id <> 16 )
        -- или назначена опция чтение и оция выставлена в 1
        OR (
          ao.auth_option = 'f_read' AND ag.auth_setting = 1
        )
      )
  ) aaa ON aaa.forum_id = p.forum_id
  INNER JOIN forum_users u ON u.user_id = p.poster_id
  INNER JOIN forum_topics t ON t.topic_id = p.topic_id
  WHERE
    p.post_time > ( UNIX_TIMESTAMP(NOW()) - 14*24*60*60 )
    AND p.post_visibility = 1
    AND p.post_hidden_for_other = 0
  ORDER BY p.post_id DESC
  LIMIT param_limit;

  --  Запрос с INNER JOIN, логика: выбрать посты за неделю INNER JOIN выбрать подфорумы указанных форумов
  --  Выполняется более 0 секунд
  -- SELECT
  --  p.post_id, p.topic_id, p.forum_id, p.poster_id, p.poster_ip, p.post_time, p.post_subject, p.post_text
  --  , u.username, u.user_id, u.user_rank, u.user_avatar, u.user_avatar_type, u.user_avatar_width, u.user_avatar_height, u.user_posts, u.user_regdate, u.user_lastvisit
  -- FROM forum_posts p
  -- INNER JOIN (
  --  SELECT
  --    ff.forum_id
  --  FROM forum_forums f
  --  LEFT JOIN forum_forums ff ON ff.left_id > f.left_id AND ff.left_id < f.right_id
  --  WHERE
  --    f.forum_id = 495
  --    or f.forum_id = 496
  --    or f.forum_id = 497
  --    or f.forum_id = 498
  --    or f.forum_id = 499
  -- ) aaa ON aaa.forum_id = p.forum_id
  -- INNER JOIN forum_users u ON u.user_id = p.poster_id
  -- WHERE
  --  p.post_time > ( UNIX_TIMESTAMP(NOW()) - 7*24*60*60 )
  --  AND p.post_visibility = 1
  --  AND p.post_hidden_for_other = 0
  -- ORDER BY p.post_id DESC
  -- LIMIT param_limit;

END;;

CREATE PROCEDURE `getMostDiscussedTopics`(in param_limit int)
BEGIN
  SELECT
    t.*
  FROM (
    SELECT
      count(*) as posts_count
      ,p.topic_id
      -- , t.*
    FROM forum_posts p
    INNER JOIN (
      SELECT
        f.forum_id
      FROM forum_groups g
      LEFT JOIN forum_acl_groups ag ON ag.group_id = g.group_id
      LEFT JOIN forum_acl_options ao ON ao.auth_option_id = ag.auth_option_id
      INNER JOIN forum_forums f ON f.forum_id = ag.forum_id
      WHERE
        g.group_name = 'GUESTS'
        AND (
          -- опции не назначены - назначены роли (любая кроме 16-ой нам подойдет)
          ( ag.auth_option_id = 0 AND ag.auth_role_id <> 16 )
          -- или назначена опция чтение и оция выставлена в 1
          OR (
            ao.auth_option = 'f_read' AND ag.auth_setting = 1
          )
        )
    ) aaa ON aaa.forum_id = p.forum_id
    -- INNER JOIN forum_topics t on t.topic_id = p.topic_id
    WHERE
      p.post_time > ( UNIX_TIMESTAMP(NOW()) - 60*24*60*60 )
      AND p.post_time < ( UNIX_TIMESTAMP(NOW()) - 59*24*60*60 )
      AND p.post_visibility = 1
      AND p.post_hidden_for_other = 0
    GROUP BY
      p.topic_id
    ORDER BY
      posts_count DESC
    LIMIT param_limit
  ) bbb
  INNER JOIN forum_topics t on t.topic_id = bbb.topic_id;
END;;
