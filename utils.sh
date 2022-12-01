#!/usr/bin/env bash

_int.insertion_sort() {
  local -n _int_isort_arr="$1"
  local left="$2" right="$3"

  for (( i=left+1; i<=right; i+=1 )) do
    local value="${_int_isort_arr["$i"]}" j=$((i-1))
    while (( j>=left && "${_int_isort_arr["$j"]}" > value )); do
      _int_isort_arr[$((j+1))]="${_int_isort_arr["$j"]}"
      ((j-=1))
    done
    _int_isort_arr[$((j+1))]="$value"
  done
}

_int.merge() {
  local -n _int_merge_arr="$1"
  local l="$2" m="$3" r="$4" left=() right=()
  local left_len=$((m-l+1)) right_len=$((r-m))

  for (( i=0; i < left_len; i+=1 )); do
    left[$i]="${_int_merge_arr[$((l+i))]}"
  done

  for (( i=0; i < right_len; i+=1 )); do
    right[$i]="${_int_merge_arr[$((m+1+i))]}"
  done

  local i=0 j=0 k="$l"

  while (( i < left_len && j < right_len )); do
    if (( left[i] <= right[i] )); then
      _int_merge_arr[$k]="${left[$i]}"
      ((i+=1))
    else
      _int_merge_arr[$k]="${right[$j]}"
      ((j+=1))
    fi
    ((k+=1))
  done

  while (( i < left_len )); do
    _int_merge_arr[$k]="${left[$i]}"
    ((k+=1))
    ((i+=1))
  done

  while (( j < right_len )); do
    _int_merge_arr[$k]="${right[$j]}"
    ((k+=1))
    ((j+=1))
  done
}

utils.timsort() {
  local -n _utils_timsort_arr="$1"
  local len="${#_utils_timsort_arr[@]}"

  for (( i=0; i < len; i+=32 )); do
    _int.insertion_sort _utils_timsort_arr "$i" "$(utils.min2 "$((i+32-1))" "$((len-1))")"
    for (( size=32; size < len; size=2*size )); do
      for (( left=0; left < len; left+=2*size )); do
        local mid="$((left+size-1))"
        local right="$(utils.min2 "$((left+2*size-1))" "$((len-1))")"
        (( mid < right )) && _int.merge _utils_timsort_arr "$left" "$mid" "$right"
      done
    done
  done
}

utils.insertion_sort() {
  local -n _utils_isort_arr="$1"
  _int.insertion_sort _utils_isort_arr 0 "$((${#_utils_isort_arr[@]}-1))"
}

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

utils.min() {
  read -ra input <<< "$@"
  echo "${input[0]}"
}

utils.min2() {
  (( $1 < $2 )) && echo "$1" && return
  echo "$2"
}
