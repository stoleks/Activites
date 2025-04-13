#!/bin/bash

# declare output directory and levels
output="../_Cours"
declare -a levels=("seconde") # "stssPremiere" "stssTerminale")

# generate pdf for all levels
for level in "${levels[@]}";
do
  # sh generation.sh $level $output

  # corrections
  for directory in $level/*;
  do
    if [[ -d $directory ]]; then
      chapter=`echo $directory | awk -F "[/]" '{print $2}'`
      sh correction.sh $level $chapter $output
    fi
  done
done
