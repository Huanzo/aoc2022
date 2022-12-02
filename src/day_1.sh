#!/usr/bin/env bash
unset PATH
BASE='.*';until [[ "$(eval "echo $BASE")" =~ \.git ]]; do BASE="../$BASE"; done;BASE="${BASE/'*'}"
source "$BASE/utils.sh"

INPUT="$(<"$BASE/data/day_1.txt")"

cals_per_elf() {
  mapfile -t list <<< "$1"
  local cals=() tmp=0
  for i in "${list[@]}"; do
    [[ "$i" == '' ]] && cals+=("$tmp") && tmp=0 && continue
    ((tmp+=i))
  done
  cals+=("$tmp")
  utils.timsort cals 
  echo "${cals[@]}"
}

p1() {
   read -ra cals <<< "$(cals_per_elf "$1")"
   echo "${cals[@]: -1}"
}

p2() {
   read -ra cals <<< "$(cals_per_elf "$1")"
   utils.sum "${cals[@]: -3}"
}

p1 "$INPUT"
p2 "$INPUT"

