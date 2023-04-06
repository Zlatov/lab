# GitLab

Сервис с открытым исходным кодом представляющий систему управления
репозиториями (Git) и обеспечивающий процесс сборки, настройки и развёртывания
приложений (CI/CD).

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-gitlab-on-ubuntu-18-04-ru


## CI/CD только с git pull

1. `~/.ssh/id_rsa-app_name` (приватный) установить в качестве переменной окружения
SSH_PRIVATE_KEY в разделе gitlab «Настройки» → «CI/CD» → Переменные.
2. `~/.ssh/id_rsa-app_name.pub` (публичный) добавить в `~/.ssh/authorized_keys`.

```yml
# .gitlab-ci.yml
stages:
  - production

deploy to production:
  environment: deploy
  stage: production
  before_script:
    - which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )
    - mkdir -p ~/.ssh
    - echo "${SSH_PRIVATE_KEY}" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 700 ~/.ssh/id_rsa
    - eval "$(ssh-agent -s)"
    - ssh-add ~/.ssh/id_rsa
    - echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
    # - ssh-keyscan -t rsa ${REMOTE_IP} > ~/.ssh/known_hosts
    # - chmod 644 ~/.ssh/known_hosts
  script:
    - ssh -T deployer@${REMOTE_IP} 'cd app/info && git pull'
    # - hostname
  only:
    - master
  # when: manual
  when: on_success

```
