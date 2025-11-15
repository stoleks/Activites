# Activité 

Dossier contenant tous mes fichiers .tex pour générer mes fiches d'activités pour mes cours de physique-chimie au lycée.
Actuellement trois niveaux existent : seconde générales et technologiques (GT), première sciences et technologies de la santé et du social (ST2S) et terminale ST2S.


## Licence 

Tous les fichiers sont de moi et sont mis à disposition sous [licence creative common (CC-BY-4.0)](https://creativecommons.org/licenses/by/4.0/), à l'exception des images dans images/exterieures/. Vous pouvez donc les utiliser comme vous voulez en créditant leur origine.


## Organisation des fichiers

Les fichiers sont organisés par dossiers :

- *accompagnement_personnel* contient des activités pour de l'accompagnement personnel niveau seconde GT.
- *commun* contient des fichiers utilisés sur plusieurs niveaux.
- *images* contient toutes les images utilisées dans les activités. Les versions modifiables se trouvent dans le projet [cours_physique-chimie_Lycee_GT](https://forge.apps.education.fr/jedrecyalexandre/cours_physique-chimie_Lycee_GT).
- *preparationTP* contient des fiches avec la liste du matériel utilisé pour certains TP.
- *seconde* contient tous les fichiers d'activités pour les secondes GT.
- *stssPremiere* contient tous les fichiers d'activités pour les premières ST2S.
- *stssTerminale* contient tous les fichiers d'activités pour les terminales ST2S.

Note : les chapitres ne sont pas numérotés, car parfois je fais voter aux élèves l'ordre des chapitres.


## Organisation de LaTeX

Les fichiers commençant par un \_ (comme \_commandes.tex) contiennent des commandes pour faciliter l'écriture d'activités ou pour éviter la répétition de morceau de code fastidieux (comme les molécules).
À terme une partie des fichiers va devenir des bibliothèques tex (quand j'aurais le temps).


## Génération des documents .pdf

Personnellement j'utilise overleaf ou TexMaker au quotidien quand j'écris de nouvelles activités. J'ai tendance à préférer overleaf pour pouvoir continuer à travailler sur un autre PC sans avoir à faire un commit.

Pour générer plusieurs .pdf rapidement, j'utilise generateur.sh, qui va générer toutes les activités et toutes les corrections pour chaque niveau et pour chaque chapitre. Le script s'appelle simplement :
  
    sh/bash generateur.sh -n "niveaux1 niveaux2 niveaux3 etc." -o "../Cours" -rc

où chaque niveau doit être accompagné d'un fichier .tex qui inclut les activités à générer avec \input ou \inclusActivite.
Le script va automatiquement commenter les lignes nécessaires dans main.tex et les fichiers de niveaux si -r est spécifié, puis il va appeler generation\_niveau.sh pour chaque niveau avec la sortie demandée ("../Cours" ici) et generation\_correction.sh pour chaque niveau et chaque chapitre si -c est spécifié.

Pour générer les activités d'un seul niveau, il suffit de donner un seul niveau à generateur.sh :
    
    sh/bash generateur.sh -n "seconde" -o "../Cours"

Le script extrait les noms des fichiers à partir des commandes \inclusActivite et les déplace dans le dossier "../Cours/", en reprenant l'organisation des dossiers et les noms de fichiers dans ce répertoire, avec la numérotation demandée dans la commande \inclusActivite. (\inclusActivite[1]{seconde/atome/A\_structure.tex} génère cours/seconde/atome/A1\_structure.pdf par exemple)

Pour générer les activités d'un chapitre d'un niveau, j'utilise generation\_chapitre.sh, appelé comme ça :
    
    sh/bash generation_chapitre.sh seconde atome "../Cours"

Pour être inclus dans un chapitre, il faut que le script trouve le nom du chapitre dans la ligne contenant le fichier. Ajouter "% \_mon\_chapitre" en fin de ligne permet donc d'inclure un fichier dans le chapitre, même s'il n'est pas dans le bon dossier.

Pour les versions corrigées de chaque chapitre, j'utilise generation\_correction.sh, appelé comme suit pour un chapitre :

    sh/bash generation_correction.sh seconde atome "../Cours"

Le deuxième argument et le nom du dossier qui contient le chapitre. Le script passe main.tex en mode correction, inclus tous les fichiers liés au chapitre (cf. script précédent) et déplace le fichier .pdf généré dans "../Cours/seconde/atome/correction\_atome.pdf", pour l'exemple donnée.


## Contact

Si vous avez des questions, vous pouvez me contacter à alexandre[point]jedrecy[at]ac-creteil.fr
