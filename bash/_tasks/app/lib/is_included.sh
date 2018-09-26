function is_included {
  local element wanted="$1"
  shift
  for element
  do
    [[ "$element" == "$wanted" ]] && return 0
  done
  return 1
}

function get_index {
  local key wanted="$1"
  shift
  local array=("$@")
  for key in "${!array[@]}"
  do
    if [[ "${array[$key]}" == "$wanted" ]]
    then
      echo $key
      return 0
    fi
  done
  return 1
}
