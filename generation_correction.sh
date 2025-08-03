#!/bin/bash

# comment all lines for a given range in a .tex file
comment_lines () {
  lines=$(wc -l < $1)
  for i in $(seq 1 $lines);
  do
    sed -i "$i s|^\\\\in|% \\\\in|" $1
  done
}

# generate all pdf for a given range in a .tex file
uncomment_lines () {
  for i in $(seq $3 $4);
  do
    # skip lines that don't include a file
    local start=`date +%s`
    line=`awk "NR==$i" $1`
    if [[ $line != *"inclusActivite"* || $line != *"$2"* || $line == *"%%"* ]]; then
      continue
    fi

    # test if .tex file exist
    filename=`awk "NR==$i" $1 | awk -F "[{}]" '{print $2}'`
    if [[ ! -f "$filename.tex" ]]; then
      echo "$filename.tex n'existe pas !"
      continue
    fi

    # Uncomment current line
    sed -i "$i s|^% ||" $1
  done
}

# comment all lines
comment_lines "seconde.tex"
comment_lines "stssPremiere.tex"
comment_lines "stssTerminale.tex"
# pass in correction mode
sed -i "s|% \\\\modeCorrection|\\\\modeCorrection|" main.tex

# generate pdf for a given chapter
printf "%-71s" "Génére la correction de $2..."
start=`date +%s`
uncomment_lines "$1.tex" $2 1 $(wc -l < "$1.tex")
# generate pdf (two call for references)
pdflatex -interaction=nonstopmode main.tex > log_$2.out
pdflatex -interaction=nonstopmode main.tex > log_$2.out
file="$3/$1/$2/correction_$2.pdf"
cp main.pdf $file

# go back to previous file state
comment_lines "$1.tex"
sed -i "s|\\\\modeCorrection|% \\\\modeCorrection|" main.tex
end=`date +%s`
echo "Il a fallu $((end - start)) secondes pour générer $file"
