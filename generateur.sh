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

# Parse inputs
output="../activite_pdf_images"
levels=""
clean=false
correction=false
while getopts ":hn:o:rc" option; do
  case $option in
    h) # Display Help
      echo "-n : déclarations des niveaux ;"
      echo "-o : spécification du dossier de sortie ;"
      echo "-r : récure les fichiers de niveaux ;"
      echo "-c : génère la correction des chapitres ;"
      echo "-h : affiche l'aide."
      exit;;
    n)
      levels=($OPTARG);;
    o)
      output=$OPTARG;;
    r)
      clean=true;;
    c)
      correction=true;;
    \?) # Invalid option
       echo "Error: Invalid option"
       exit;;
  esac
done

# declare output directory and levels
if [[ $output = "" ]]; then
  echo "Vous devez spécifier un répertoire de sortie avec -o"
  exit
fi
echo "Le répertoire de sortie utilisé est $output. Préparation des fichiers."

# comment all lines
if [[ $clean = true ]]; then
  sed -i "s|^\\\\modeCorrection|% \\\\modeCorrection|" main.tex
  comment_lines "fichesTP.tex"
  comment_lines "seconde.tex"
  comment_lines "stssPremiere.tex"
  comment_lines "stssTerminale.tex"
  comment_lines "AP/AP.tex"
fi
exit

# generate pdf for all levels
for level in "${levels[@]}";
do
  # create all output folders
  for directory in $level/*;
  do
    if [[ -d $directory ]] && ! [[ -z "$( ls -A $directory/ )" ]]; then
      mkdir -p $output/$directory
    fi
  done

  # activities
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    bash generation_niveau.sh $level $output
  else
    sh generation_niveau.sh $level $output
  fi

  # corrections if asked
  if [[ $correction = false ]]; then
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
