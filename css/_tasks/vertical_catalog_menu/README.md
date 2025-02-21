## Как делалось

```sh
yarn --cwd ./ init -y
yarn add sass --dev # error … "node" is incompatible … Expected version ">= 14.16.0". Got "12.22.12"
node --version # v12.22.12
nvm list # … stable (-> v18.17.1)
nvm use v18.17.1
nvm alias default v18.17.1
nvm use default
node --version # v18.17.1
yarn add sass --dev # Команда «yarn» не найдена
npm install -g yarn
yarn add sass --dev
# Нахрена мне sass в node_modules если он не работает из консоли?
yarn remove sass
yarn add jquery

npm install -g node-sass
node-sass --watch --recursive --output css --source-map true --source-map-contents sass
```
