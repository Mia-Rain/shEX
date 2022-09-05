#!/bin/sh
# my dev system is FreeBSD so tests are actually run via /usr/local/bin/dash
math() {
  IFS=""
  unset m n
  [ "$2" -eq 1 ] && {
    echo "$1"
    return 0
  }
  n=1; until [ "$n" -eq "$2" ]; do
    export m=$(( ${m:-$1}*$1 ))
    : $((n+=1))
  done
  echo "$m"
}
org="$1"; IFS="^" # set org to $1
set -- $1 # $1 should be "?^?.*" # thus this splits it into $@ with ^ removed
od="$1"; shift 1; 
while [ "$1" ]; do # loop over ever argument 
  [ "$2" ] || {
    ex=$(math $od ${ex:-$1} 1)
    echo "$ex"
    break
  } && {
    ex=$(math ${ex:-$1} $2)
  }
  # $od^$1^$@
  shift 1 # shift argument 1 over # prev $? is lost 
done
