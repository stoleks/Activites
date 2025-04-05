# Activité 

Dossier contenant tous mes fichiers .tex pour générer mes fiches d'activités pour mes cours de physique-chimie au lycée.
Actuellement trois niveaux existent : seconde générales et technologiques (GT), première sciences et technologies de la santé et du social (ST2S) et terminale ST2S.


## Licence 

Tous les fichiers sont de moi et sont mis à disposition sous [licence creative common (CC-BY-4.0)](https://creativecommons.org/licenses/by/4.0/), à l'exception des images dans images/photos et dans images/donnees. Vous pouvez donc les utiliser comme vous voulez en créditant leur origine.


## Organisation des fichiers

Les fichiers sont organisés par dossiers :

- *accompagnement_personnel* contient des activités pour de l'accompagnement personnel niveau seconde GT.
- *commun* contient des fichiers utilisés sur plusieurs niveaux.
- *images* contient toutes les images utilisées dans les activités. Les versions modifiables se trouvent dans le projet [Cours](https://github.com/stoleks/Cours/images).
- *preparationTP* contient des fiches avec la liste du matériel utilisé pour certains TP.
- *seconde* contient tous les fichiers d'activités pour les secondes GT.
- *stssPremiere* contient tous les fichiers d'activités pour les premières ST2S.
- *stssTerminale* contient tous les fichiers d'activités pour les terminales ST2S.


## Organisation de tex

Les fichiers commençant par un \_ (comme \_commandes.tex) contiennent des commandes pour faciliter l'écriture d'activités ou pour éviter la répétition de morceau de code fastidieux (comme les molécules).
À terme une partie des fichiers va devenir des bibliothèques tex (quand j'aurais le temps).


## Génération des documents .pdf

Personnellement j'utilise overleaf ou TexMaker au quotidien quand j'écris de nouvelles activités. J'ai tendance à préférer overleaf pour pouvoir continuer à travailler sur un autre PC sans avoir à faire un commit.
Pour faciliter la génération de plusieurs .pdf d'un coup, j'utilise generation.sh, appelé comme ça pour chaque niveau :
    
    sh generation.sh "seconde" "../_Cours/"
    sh generation.sh "stssPremiere" "../Cours"
    sh generation.sh "stssTerminale" "../Cours"

Le script extrait les noms des fichiers à partir des commandes \inclusActivite et les déplace dans le dossier "../Cours/", en reprenant donc l'organisation de ce répertoire.
Pour les versions corrigées de chaque chapitre, j'utilise correction.sh, appelé comme ça pour un chapitre :

    sh correction.sh "seconde" "atome" "../Cours"

Le script passe .tex en mode correction et inclus tous les fichiers liés au chapitre et le déplace dans "../Cours/seconde/atome/atome.pdf", pour l'exemple donnée.


## Contact

Si vous avez des questions, vous pouvez me contacter à alexandre[point]jedrecy[at]ac-creteil.fr
