#!/usr/bin/env bash

utils.qsort() {
  read -ra arr <<< "$@"
  ((${#arr[@]} == 0)) && echo && return
  local smaller=() bigger=() pivot="${arr[0]}" res=()

  for i in "${arr[@]}"; do
    if ((i < pivot)); then
      smaller+=("$i")
    elif ((i > pivot)); then
      bigger+=("$i")
    fi
  done

  read -ra smaller_sorted <<< "$(utils.qsort "${smaller[@]}")"
  read -ra bigger_sorted <<< "$(utils.qsort "${bigger[@]}")"

  res=("${smaller_sorted[@]}" "$pivot" "${bigger_sorted[@]}")

  echo "${res[@]}"
}

utils.sum() {
  read -ra input <<< "$@"
  local result=0
  for i in "${input[@]}"; do ((result+=i)); done
  echo "$result"
}
