SELECT LOWER("нижний Новгород") REGEXP "новгород";
SELECT "fo\nfo" REGEXP "^fo$"; 	-- -> 0
SELECT "fofo" REGEXP "^fo"; 	-- -> 1
SELECT "fo\no" REGEXP "^fo\no$"; -- -> 1
SELECT "fo\no" REGEXP "^fo$"; 	-- -> 0
SELECT "fofo" REGEXP "^f.*"; 	-- -> 1
SELECT "fo\nfo" REGEXP "^f.*"; 	-- -> 1
SELECT "Ban" REGEXP "^Ba*n"; 	-- -> 1
SELECT "Baaan" REGEXP "^Ba*n"; 	-- -> 1
SELECT "Bn" REGEXP "^Ba*n"; 	-- -> 1
SELECT "Ban" REGEXP "^Ba+n"; 	-- -> 1
SELECT "Bn" REGEXP "^Ba+n"; 	-- -> 0
SELECT "Bn" REGEXP "^Ba?n"; 	-- -> 1
SELECT "Ban" REGEXP "^Ba?n"; 	-- -> 1
SELECT "Baan" REGEXP "^Ba?n"; 	-- -> 0
SELECT "pi" REGEXP "pi|apa"; 		-- -> 1
SELECT "axe" REGEXP "pi|apa"; 		-- -> 0
SELECT "apa" REGEXP "pi|apa"; 		-- -> 1
SELECT "apa" REGEXP "^(pi|apa)$"; 	-- -> 1
SELECT "pi" REGEXP "^(pi|apa)$"; 	-- -> 1
SELECT "pix" REGEXP "^(pi|apa)$"; 	-- -> 0
SELECT "pi" REGEXP "^(pi)*$"; 	-- -> 1
SELECT "pip" REGEXP "^(pi)*$"; 	-- -> 0
SELECT "pipi" REGEXP "^(pi)*$"; 	-- -> 1
SELECT "aXbc" REGEXP "[a-dXYZ]"; 	-- -> 1
SELECT "aXbc" REGEXP "^[a-dXYZ]$"; 	-- -> 0
SELECT "aXbc" REGEXP "^[a-dXYZ]+$"; 	-- -> 1
SELECT "aXbc" REGEXP "^[^a-dXYZ]+$"; 	-- -> 0
SELECT "gheis" REGEXP "^[^a-dXYZ]+$"; 	-- -> 1
SELECT "gheisa" REGEXP "^[^a-dXYZ]+$"; 	-- -> 0