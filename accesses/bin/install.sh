#!/usr/bin/env bash

set -eu

curl -L -o ~/zaccesses https://raw.githubusercontent.com/Zlatov/lab/master/accesses/bin/zaccesses
curl -L -o ~/zaccesses.man https://raw.githubusercontent.com/Zlatov/lab/master/accesses/src/zaccesses.man
curl -L -o ~/zaccesses.completion https://raw.githubusercontent.com/Zlatov/lab/master/accesses/bin/zaccesses.completion

# Кладём бинарник /usr/local/bin/zaccesses
cp ~/zaccesses /usr/local/bin/zaccesses
chmod g+x /usr/local/bin/zaccesses
chmod a+x /usr/local/bin/zaccesses
rm ~/zaccesses

# Кладём мануал /usr/local/man/man1/zaccesses.1
mkdir -p /usr/local/man/man1
cp ~/zaccesses.man /usr/local/man/man1/zaccesses.1
gzip -f /usr/local/man/man1/zaccesses.1
rm ~/zaccesses.man
# mandb

# Кладём автодополнение /etc/bash_completion.d/zaccesses.completion
cp ~/zaccesses.completion /etc/bash_completion.d/zaccesses.completion

echo 'Перезапустите консоль для корректной работы автодополнения.'
