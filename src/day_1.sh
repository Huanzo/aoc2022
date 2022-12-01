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
  utils.qsort "${cals[@]}"
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

