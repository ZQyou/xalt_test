#!/bin/bash

trap "exit 1" TERM INT

# Quit if any function returns an non-zero status.
set -eE
set -o pipefail

keylog=$1
log=$2
out=$3

rm -f $out

#IFS=$'\r\n' GLOBIGNORE='*' command eval 'keys=($(cat $keylog))'
#start=0
#l_keys=${#keys[@]}

tmp=$SHMDIR/tmp$$
tmp1=$SHMDIR/tmp1$$

echo $log
rm -f $tmp
#for((i=$start; i<$l_keys; i++))
cat $keylog |while read key
do 
  #key=${keys[$i]}
  status=1
  if [ -f $tmp ]; then
    grep -q "$key" $tmp
    status=$?
  else
    grep -q "$key" $log
    status=$?
  fi
  if [ $status -eq 0 ]; then
    if [ -f $tmp ]; then
      echo $key $tmp
      grep -v "$key" $tmp > $tmp1
      mv $tmp1 $tmp
    else
      echo $key $log
      grep -v "$key" $log > $tmp
    fi
    continue
  else
    if [ -f $tmp ]; then
      cat $tmp >> $out
    fi 
    start=$i
    break
  fi
done
if [ -f $tmp ]; then
  cat $tmp >> $out
fi
