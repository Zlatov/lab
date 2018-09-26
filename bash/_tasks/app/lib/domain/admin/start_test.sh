# @ test_id domain path port

screen_name="$1"
path="$2"
port="$3"

screen -S "$screen_name" -X stuff "^C"
screen -S "$screen_name" -p 0 -X stuff "cd ${path}^M"
screen -S "$screen_name" -p 0 -X stuff "RAILS_ENV=production rails assets:precompile^M"
screen -S "$screen_name" -p 0 -X stuff "rails s -e production -p $port"
screen -S "$screen_name" -p 0 -X eval "stuff ^M"
