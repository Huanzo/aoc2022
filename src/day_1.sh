#!/usr/bin/env bash
unset PATH

INPUT="$(<data/day_1.txt)"

qsort() {
  read -ra arr <<< "$@"
  [[ "${#arr[@]}" == 0 ]] && echo "" && return
  local smaller=() bigger=() pivot="${arr[0]}" res=()

  for i in "${arr[@]}"; do
    if [[ "$i" -lt "$pivot" ]]; then
       smaller+=("$i")
    elif [[ "$i" -gt "$pivot" ]]; then
       bigger+=("$i")
    fi
  done

  read -ra smaller_sorted <<< "$(qsort "${smaller[@]}")"
  read -ra bigger_sorted <<< "$(qsort "${bigger[@]}")"
  res=("${smaller_sorted[@]}" "$pivot" "${bigger_sorted[@]}")
  echo "${res[@]}"
}

cals_per_elf() {
  mapfile -t list <<< "$1"
  local cals=() tmp=0
  for i in "${list[@]}"; do
    [[ "$i" == '' ]] && cals+=("$tmp") && tmp=0 && continue
    ((tmp+=i))
  done
  cals+=("$tmp")
  qsort "${cals[@]}"
}

p1() {
   read -ra cals <<< "$(cals_per_elf "$1")"
   echo "${cals[@]: -1}"
}
p2() {
   read -ra cals <<< "$(cals_per_elf "$1")"
   local result=0
   for i in "${cals[@]: -3}"; do ((result+=i)); done
   echo "$result"
}

p1 "$INPUT"
p2 "$INPUT"

