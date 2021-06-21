#!/bin/bash

count_log=$1
log=$2

n_head=6
exec_str=$(sort -n -r $count_log |head -n $n_head |grep -oh -E '"exec_path.*"' |paste -sd '|' -)
set -x
# <= 2.10.10 
#key:run_strt_d1561a4d-f89a-49bd-a63f-833a1ca95064 crc:0xE78E idx:
#grep -P "$exec_str" $2 |grep -oh -P 'key:run_fini_.*?idx'
# >= 2.10.11
#crcStr:0x7C1D key:run_strt_4718f902-89b6-4078-b88b-99602d366bdc value:
# Keys to be dropped
#grep -E $exec_str $log |grep -oh -P 'crcStr.*key:run_fini_.*? '
grep -E $exec_str $log 
# Keys to be kept
#grep 'exec_path' $log |grep -v -E $exec_str |grep -oh -P 'crcStr.*key:run_fini_.*? '
