#!/bin/bash

# comment all lines for a given range in a .tex file
function comment_lines () {
  lines=$(wc -l < $1)
  for i in $(seq 1 $lines);
  do
    sed -i "$i s|^\\\\in|% \\\\in|" $1
  done
}

# declare output directory and levels
output="../_Cours"
declare -a levels=("seconde") # "stssPremiere" "stssTerminale")

# comment all lines
echo "Preparation des fichiers"
comment_lines "seconde.tex"
comment_lines "stssPremiere.tex"
comment_lines "stssTerminale.tex"

# generate pdf for all levels
for level in "${levels[@]}";
do
  # activities
  sh generation.sh $level $output

  # corrections
  for directory in $level/*;
  do
    if [[ -d $directory ]]; then
      chapter=`echo $directory | awk -F "[/]" '{print $2}'`
      sh correction.sh $level $chapter $output
    fi
  done
done
