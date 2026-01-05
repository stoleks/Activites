#!/bin/bash

# generate all pdf for a given range in a .tex file
# 1: level ; 2: chapter ; 3: output ; 4-5: line range
generate_pdf () {
  activityCount=0
  for i in $(seq $4 $5);
  do
    # skip lines that don't include a file and are not in the chapter
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* && $line != *"plan_de_travail"* || $line == *"%%"* || $line != *"$2"* ]]; then
      continue
    fi

    # generate pdf of the current line
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      bash generation_pdf.sh $i $1 $3
    else
      sh generation_pdf.sh $i $1 $3
    fi
    let activityCount++
  done
  echo -n "Génération de $activityCount activités. "
}

# generate pdf for a given chapter
echo "Generation des .pdf du chapitre $2 dans $3/$1/$2"
start=`date +%s`
if [[ -e $3 ]]; then
  mkdir -p $3/$1/$2
fi
pdflatex -ini -jobname="preambule" "&pdflatex preambule.tex\dump" > preambule.log
generate_pdf "$1.tex" $2 $3 1 $(wc -l < "$1.tex")
end=`date +%s`
echo "Il a fallu $((end - start)) secondes ($(((end - start)/60)) minutes) pour générer tous les fichiers dans $3/$1/$2"
