#!/bin/bash

# generate all pdf for a given range in a .tex file
function generate_pdf () {
  activityCount=0
  for i in $(seq $4 $5);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* && $line != *"plan_de_travail"* || $line == *"%%"* || $line != *"$2"* ]]; then
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
    pdflatex -interaction=nonstopmode main.tex > log.out
    pdflatex -interaction=nonstopmode main.tex > log.out

    # copy the pdf in the set directory
    file="$3/$activityName.pdf"
    local end=`date +%s`
    echo "Il a fallu $((end - start)) secondes pour générer $file."
    cp main.pdf $file

    # comment current line, we need to use \\\\ instead of \\ because we use "" for the sed scope
    sed -i "$i s|\\\\in|% \\\\in|" $1
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
