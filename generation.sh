#!/bin/bash

# comment all lines for a given range in a .tex file
function comment_lines () {
  lines=$(wc -l < $1)
  for i in $(seq 1 $lines);
  do
    sed -i "$i s|^\\\\in|% \\\\in|" $1
  done
}

# generate all pdf for a given range in a .tex file
function generate_pdf () {
  for i in $(seq $3 $4);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* || $line == *"%%"* ]]; then
      continue
    fi

    # test if .tex file exist
    filename=`awk "NR==$i" $1 | awk -F "[{}]" '{print $2}'`
    if [[ ! -f "$filename.tex" ]]; then
      echo "$filename.tex n'existe pas !"
      continue
    fi

    # extract pdf name and activity number
    fileCount=`awk "NR==$i" $1 | awk -F[ '{print $2}' | awk -F] '{print $1}'`
    if [[ $filename == *"A_"* ]]; then
      activityName=`echo $filename | sed "s|A|&$fileCount|"`
    elif [[ $filename == *"TP_"* ]]; then
      activityName=`echo $filename | sed "s|TP|&$fileCount|"`
    else
      activityName=$filename
    fi

    # Uncomment current line and generate pdf (two call for references)
    sed -i "$i s|^% ||" $1
    printf "Génération de $activityName... "
    pdflatex main.tex > log.out
    pdflatex main.tex > log.out

    # copy the pdf in the set directory
    file="$2$activityName.pdf"
    local end=`date +%s`
    echo "Il a fallu $((end - start)) secondes pour générer $file."
    cp main.pdf $file

    # comment current line, we need to use \\\\ instead of \\ because we use "" for the sed scope
    sed -i "$i s|\\\\in|% \\\\in|" $1
  done
}

# comment all lines
echo "Preparation des fichiers"
comment_lines "seconde.tex"
comment_lines "stssPremiere.tex"
comment_lines "stssTerminale.tex"

# generate pdf for a given year
echo "Generation des .pdf dans $1"
start=`date +%s`
generate_pdf $1 "../_Cours/" 1 $(wc -l < $1)
end=`date +%s`
echo "Il a fallu $((end - start)) secondes ($(((end - start)/60)) minutes) pour generer tous les fichiers dans $1"
