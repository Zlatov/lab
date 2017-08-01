-- http://www.inks.ru/support/downloads.html
-- http&#58;//www&#46;inks&#46;ru/support/downloads&#46;html

SELECT
	post_id,
	-- post_text REGEXP '://(www\.)?(zenonline|sign-forum|dgi-net|zeon-net|dilli|vinyls|inks|signtool|neo-neon|zenosvet|led-lamp|neon-neon|screenprint|termotransfer|sheets|zenobond|zenobaner|zenoprofil|standshop|pos-torg|glues|coating|cut-cut|dist|textiller|zenotools|zeon-land|vivid-print|markbric|flag-mast|eps-net|yandex|google|youtube)' as ex
	post_text REGEXP '(:|&#58;)//(www&#46;|www\.)?(zenonline|sign-forum|dgi-net|zeon-net|dilli|vinyls|inks|signtool|neo-neon|zenosvet|led-lamp|neon-neon|screenprint|termotransfer|sheets|zenobond|zenobaner|zenoprofil|standshop|pos-torg|glues|coating|cut-cut|dist|textiller|zenotools|zeon-land|vivid-print|markbric|flag-mast|eps-net|yandex|google|youtube)' as ex
FROM forum_posts
WHERE
	   post_text LIKE '%http:%'
	OR post_text LIKE '%https:%'
	OR post_text LIKE '%http&#58;%'
	OR post_text LIKE '%https&#58;%'
HAVING ex=0
-- LIMIT 10
;
