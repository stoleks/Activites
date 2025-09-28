#!/bin/bash

# comment all lines for a given range in a .tex file
comment_lines () {
  echo "Commente les fichiers dans $1"
  lines=$(wc -l < $1)
  for i in $(seq 1 $lines);
  do
    sed -i "$i s|^\\\\in|% \\\\in|" $1
  done
}

# declare output directory and levels
output=$2
echo "Le répertoire de sortie utilisé est $2. Préparation des fichiers."
declare -a levels=($1)

# comment all lines
if [[ "$3" = "clean" || "$4" = "clean" ]]; then
  comment_lines "fichesTP.tex"
  comment_lines "seconde.tex"
  comment_lines "stssPremiere.tex"
  comment_lines "stssTerminale.tex"
fi

# generate pdf for all levels
for level in "${levels[@]}";
do
  # create all output folders
  for directory in $level/*;
  do
    if [[ -d $directory ]] && ! [[ -z "$( ls -A $directory/ )" ]]; then
      mkdir -p $2/$directory
    fi
  done

  # activities
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    bash generation_niveau.sh $level $output
  else
    sh generation_niveau.sh $level $output
  fi

  # corrections if asked
  if [[ "$3" != "correction" || "$4" != "correction" ]]; then
    continue
  fi
  for directory in $level/*;
  do
    if [[ -d $directory ]] && ! [[ -z "$( ls -A $directory/ )" ]]; then
      chapter=`echo $directory | awk -F "[/]" '{print $2}'`
      if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        bash generation_correction.sh $level $chapter $output
      else
        sh generation_correction.sh $level $chapter $output
      fi
    fi
  done
done
