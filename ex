#!/bin/sh
# my dev system is FreeBSD so tests are actually run via /usr/local/bin/dash
math() {
  unset m n
  n=1; [ "$2" -gt 1 ] && until [ "$n" -eq "$2" ]; do
    export m=$(( ${m:-$1}*$1 ))
    : $((n+=1))
  done
  echo "${m:-$1}"
}
IFS="^"; set -- $1
# $1 should be "?^?.*" # thus this splits it into $@ with ^ removed
od="$1"; shift 1; while :; do
  # a manual break always occurs 
  # : should be in theory faster than [ : ] 
  [ "$2" ] || {
    ex=$(math $od ${ex:-$1})
    echo "$ex"
    break
  } && {
    ex=$(math ${ex:-$1} $2)
  }
  # $od^$1^$@
  shift 1 # shift argument 1 over # prev $? is lost 
done
