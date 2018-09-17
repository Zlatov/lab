# @ path
function get_realpath {
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}
