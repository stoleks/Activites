#!/bin/bash

# generate all pdf for a given range in a .tex file
generate_pdf () {
  activityCount=0
  for i in $(seq $3 $4);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* && $line != *"plan_de_travail"* && $line != *"fichesTP"* || $line == *"%%"* ]]; then
      continue
    fi

    # generate pdf of the current line
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      bash generation_pdf.sh $i $1 $2
    else
      sh generation_pdf.sh $i $1 $2
    fi
    let activityCount++
  done
  echo -n "Génération de $activityCount activités. "
}

# generate pdf for a given level
echo "Generation des .pdf dans $1"
start=`date +%s`
generate_pdf "$1.tex" $2 1 $(wc -l < "$1.tex")
end=`date +%s`
echo "Il a fallu $((end - start)) secondes ($(((end - start)/60)) minutes) pour générer tous les fichiers dans $1"
