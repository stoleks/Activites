#!/bin/bash

# generate all pdf for a given range in a .tex file
function generate_pdf () {
  activityCount=0
  for i in $(seq $3 $4);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* && $line != *"plan_de_travail"* || $line == *"%%"* ]]; then
      continue
    fi

    # generate pdf of the current line
    sh generation_pdf.sh $i $1 $2
    let count++
  done
  echo -n "Génération de $count activités. "
}

# generate pdf for a given level
echo "Generation des .pdf dans $1"
start=`date +%s`
generate_pdf "$1.tex" $2 1 $(wc -l < "$1.tex")
end=`date +%s`
echo "Il a fallu $((end - start)) secondes ($(((end - start)/60)) minutes) pour générer tous les fichiers dans $1"
