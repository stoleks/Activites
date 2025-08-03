#!/bin/bash

# generate all pdf for a given range in a .tex file
generate_pdf () {
  activityCount=0
  for i in $(seq $4 $5);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* && $line != *"plan_de_travail"* || $line == *"%%"* || $line != *"$2"* ]]; then
      continue
    fi

    # generate pdf of the current line
    bash generation_pdf.sh $i $1 $3
    let count++
  done
  echo -n "Génération de $count activités. "
}

# generate pdf for a given level
echo "Generation des .pdf dans $1"
start=`date +%s`
generate_pdf "$1.tex" $2 $3 1 $(wc -l < "$1.tex")
end=`date +%s`
echo "Il a fallu $((end - start)) secondes ($(((end - start)/60)) minutes) pour générer tous les fichiers dans $1/$2"
