# Dockerfile

```sh
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /zenonline
COPY Pipfile Pipfile.lock /code/
RUN pipenv install --system
COPY . /code/
```

## ENTRYPOINT vs CMD

Требуется определить хотя бы одну инструкцию (ENTRYPOINT или CMD) (для запуска).
Если во время выполнения определена только одна из инструкций, то и CMD и ENTRYPOINT будут иметь одинаковый эффект.
И для CMD, и для ENTRYPOINT существуют режимы shell и exec.

```bash
ENTRYPOINT ["executable", "param1", "param2"] # исполняемая форма (exec), предпочтительна
ENTRYPOINT command param1 param2 # форма оболочки (shell)
```
Режим exec является рекомендуемым.
Это связано с тем, что контейнеры задуманы так, чтобы содержать один процесс. Например, отправленные в контейнер сигналы перенаправляются процессу, запущенному внутри контейнера с идентификатором PID, равным 1. Очень познавательный опыт: чтобы проверить факт перенаправления, полезно запустить контейнер ping и попытаться нажать ctrl + c для остановки контейнера.

Нет оболочки? Нет переменных окружения.

```bash
CMD ["java", "-jar", "*.jar"]  # "exec" format необходимо переписать на:
CMD ["/usr/bin/java", "-jar", "spring.jar"]
```

Аргументы CMD присоединяются к концу инструкции ENTRYPOINT… иногда.

Инструкции ENTRYPOINT и CMD могут быть переопределены с помощью флагов командной строки.

Используйте ENTRYPOINT, если вы не хотите, чтобы разработчики изменяли исполняемый файл, который запускается при запуске контейнера. Вы можете представлять, что ваш контейнер – исполняемая оболочка. Хорошей стратегией будет определить стабильную комбинацию параметров и исполняемого файла как ENTRYPOINT. Для нее вы можете (не обязательно) указать аргументы CMD по умолчанию, доступные другим разработчикам для переопределения.

```bash
FROM alpine
ENTRYPOINT ["ping"]
CMD ["www.google.com"]

###

docker build -t test .
docker run test # запингует гугл
docker run test www.yahoo.com # запингует яху
```

```bash
FROM alpine
CMD ["ping", "www.google.com"]

###

docker build -t test .
docker run -it test sh # не нужен пинг, нужен шелл
```
