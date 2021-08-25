#!/usr/bin/env bash

set -eu

exit 0

bundle exec rails g rspec:scaffold aticle
bundle exec rails g rspec:model aticle
bundle exec rails g rspec:controller aticle
bundle exec rails g rspec:helper aticle
bundle exec rails g rspec:view aticle
bundle exec rails g rspec:mailer aticle
bundle exec rails g rspec:integration aticle
bundle exec rails g rspec:feature aticle
bundle exec rails g rspec:job aticle
bundle exec rails g rspec:channel aticle
bundle exec rails g rspec:generator aticle
bundle exec rails g rspec:mailbox aticle
bundle exec rails g rspec:request aticle
bundle exec rails g rspec:system aticle
