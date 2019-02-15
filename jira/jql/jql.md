# JQL запросы

__Пример JQL запроса__:


```
created < endOfDay(180d) AND reporter = maxim.z
```

__Краткая справка по синтаксису__:

* Времени создания: `created < endOfDay(180d)`;
* Автор: `reporter = maxim.z`;
* Исполнитель: `assignee = maxim.z`;
* Категория статуса: `statusCategory = "To Do"|"In Progress"|Done`;
* Статус: `status = "…"`, список можно подсмотреть в редакторе запросов, список там, судя по всему, не полный, можно вводить имя статуса по русски.

Необходимые виды для тимлида:

1. Бизнес Задачи
    * Автор: eugene.k; исполнитель: maxim.z;
    * Я их распределяю по тиме создавая связанные задачи;
    * Беру в работу назначаю время исполнения связанным задачам;
    * Принимаю работу связанных задач и завершаю работу по БД.
    * ```
      created < endOfDay(180d) AND 
      reporter = eugene.k AND assignee = maxim.z AND 
      statusCategory != Done AND
      status != "Отложено"
      ```
2. План Задач
    * Показать все объекты с запросом:
      ```
      created < endOfDay(180d) AND
      reporter = maxim.z AND
      (
          assignee is EMPTY OR
          (
              assignee = maxim.z OR
              assignee = ramis.z OR
              assignee = dmitri.m
          )
      ) AND
      statusCategory != Done
      ```
      Автор: maxim.z; исполнители: тима, в том числе я;
3. Прогресс выполнения Плана Задач
    * Автор: maxim.z; исполнители: тима, в том числе я;
    * `created < endOfDay(180d) AND reporter = maxim.z AND (assignee is EMPTY OR (assignee = maxim.z OR assignee = ramis.z OR assignee = dmitri.m))`
