-- SELECT 1 as kk, 2 as kkk

SELECT post_id, post_text REGEXP '://(www\.)?(zenonline|sign-forum|dgi-net|zeon-net|dilli|vinyls|inks|signtool|neo-neon|zenosvet|led-lamp|neon-neon|screenprint|termotransfer|sheets|zenobond|zenobaner|zenoprofil|standshop|pos-torg|glues|coating|cut-cut|dist|textiller|zenotools|zeon-land|vivid-print|markbric|flag-mast|eps-net|yandex|google|youtube)' as ex
FROM forum_posts
WHERE
	post_text like '%http:%' or post_text like '%https:%'
HAVING ex=0;
