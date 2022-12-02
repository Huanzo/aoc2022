#!/usr/bin/env bash
unset PATH
BASE='.*';until [[ "$(eval "echo $BASE")" =~ \.git ]]; do BASE="../$BASE"; done;BASE="${BASE/'*'}"
source "$BASE/utils.sh"

INPUT="$(<"$BASE/data/day_2.txt")"

declare -A COMBINATION_TO_POINTS=(
  ['A X']=3
  ['A Y']=6
  ['A Z']=0
  ['B X']=0
  ['B Y']=3
  ['B Z']=6
  ['C X']=6
  ['C Y']=0
  ['C Z']=3
)

declare -A SHOULD_PLAY=(
  ['A X']=Z
  ['A Y']=X
  ['A Z']=Y
  ['B X']=X
  ['B Y']=Y
  ['B Z']=Z
  ['C X']=Y
  ['C Y']=Z
  ['C Z']=X
)

declare -A SCORES=([X]=1 [Y]=2 [Z]=3)

p1() {
  mapfile -t scores <<< "$(
    while read -r i; do
      echo $(( COMBINATION_TO_POINTS[$i] + SCORES[${i:2}] ))
    done <<< "$1"
  )"
  utils.sum "${scores[@]}"
}

p2() {
  mapfile -t scores <<< "$(
    while read -r i; do
      i="${i::1} ${SHOULD_PLAY["$i"]}"
      echo $(( COMBINATION_TO_POINTS[$i] + SCORES[${i:2}] ))
    done <<< "$1"
  )"
  utils.sum "${scores[@]}"
}

p1 "$INPUT"
p2 "$INPUT"
