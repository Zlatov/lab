# Game

Создание этого проекта

```sh
yarn --cwd ./ init
yarn add webpack --dev
yarn add webpack-dev-server --dev
yarn add webpack-cli --dev

yarn add sass-loader node-sass postcss-loader css-loader mini-css-extract-plugin --dev
yarn add html-loader html-webpack-plugin file-loader --dev

yarn add lodash
yarn add jquery
# И колдовство в webpack.config.js
```

Запуск

```sh
# Компиляция (продакшн):
npx webpack --node-env production
# Разработка с вев-сервером:
npx webpack-dev-server --node-env development
# или
NODE_ENV=development npx webpack-dev-server
NODE_ENV=development npx webpack-dev-server --open

# Или

rm -rf dist && npm run build
rm -rf dist && npm run development
```
