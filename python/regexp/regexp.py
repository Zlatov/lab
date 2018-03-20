# -*- coding: utf-8 -*-
import re
# re.match(pattern, string)               — ищет в начале строки.
# re.search(pattern, string)              — ищет не только в начале строки.
# re.findall(pattern, string)             — возвращает список всех найденных совпадений.
# re.split(pattern, string, [maxsplit=0]) — разделяет строку по заданному шаблону [не более maxsplit раз].
# re.sub(pattern, repl, string)           — ищет в строке шаблон и заменяет на подстроку.
# re.compile(pattern, repl, string)       — собрать регулярное выражение в объект, для поисков.

a = re.match(r'a', 'asd')
b = (a != None) ? 1 : 2
print "a:", a.group(0)
a = re.match(r'f', 'asd')
print "a:", a.group(0)

result = re.search(r'Analytics', 'AV Analytics Vidhya AV')
print result.group(0)

result = re.findall(r'AV', 'AV Analytics Vidhya AV')
print result

result = re.split(r'y', 'Analytics')
print result

result = re.sub(r'India', 'the World', 'AV is largest Analytics community of India')
print result

pattern = re.compile('AV')
result = pattern.findall('AV Analytics Vidhya AV')
print result
result2 = pattern.findall('AV is largest analytics community of India')
print result2

# finditer(), который возвращает список объектов типа 'результат поиска'. 
# Получая эти загадочные объекты вместо обычных строк (которые может вернуть, к примеру, метод findall), 
# мы получаем возможность не только ознакомиться с фактом что текст найден, 
# но и узнать где именно он найден — для этого у объекта типа 'результат поиска' 
# есть специально обученный метод span(), возвращающий точное положение найденного фрагмента в исходном тексте.
