# @ test_id domain path port

screen_name="$1"
path="$2"
port="$3"

screen -S "$screen_name" -X stuff "^C"
screen -S "$screen_name" -p 0 -X stuff "cd ${path}^M"
screen -S "$screen_name" -p 0 -X stuff "yarn^M"
screen -S "$screen_name" -p 0 -X stuff "./bin/webpack^M"
screen -S "$screen_name" -p 0 -X stuff "CLI=1 rails assets:precompile^M"
screen -S "$screen_name" -p 0 -X stuff "ERRORS=1 STATIC=1 WEB_CONCURRENCY=1 rails s -e production -p $port"
screen -S "$screen_name" -p 0 -X eval "stuff ^M"
