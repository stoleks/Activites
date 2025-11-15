#!/bin/bash

# test if .tex file exist
start=`date +%s`
filename=`awk "NR==$1" $2 | awk -F "[{}]" '{print $2}'`
if [[ ! -f "$filename.tex" ]]; then
  echo "Le fichier $filename.tex n'existe pas, pas de pdf généré."
  exit
fi

# test if output directory exist
if [[ ! -d $3 ]]; then
  echo "Le répertoire $3 n'existe pas, pas de pdf généré."
  exit
fi

# extract pdf name and activity number
fileCount=`awk "NR==$1" $2 | awk -F[ '{print $2}' | awk -F] '{print $1}'`
activity=`basename $filename`
if [[ $filename == *"A_"* ]]; then
  activityName=`echo $filename | sed "s|A|&$fileCount|"`
elif [[ $filename == *"TP_"* ]]; then
  activityName=`echo $filename | sed "s|TP|&$fileCount|"`
else
  activityName=$filename
fi

# Uncomment current line and generate pdf (two call for references)
sed -i "$1 s|^% ||" $2
printf "%-71s" "Génération de $activity... "
pdflatex -fmt=preambule.fmt -interaction=nonstopmode -draftmode main.tex > out/temp.out
pdflatex -fmt=preambule.fmt -interaction=nonstopmode main.tex > out/log.out 
# comment current line, we need to use \\\\ instead of \\ because we use "" for the sed scope
sed -i "$1 s|\\\\in|% \\\\in|" $2

# copy the pdf in the set directory
file="$3/$activityName.pdf"
end=`date +%s`
printf "%-13s %s\n" "Il a fallu $((end - start))" "secondes pour générer $file."
cp main.pdf $file
