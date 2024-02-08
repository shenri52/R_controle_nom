# Script R : controle_nom

Ce script permet de contrôler le respect des règles de nommage des fichiers :
  * un nom de fichier n'excédant pas 32 caractères
  * un préfixe N (emprise national) ou L (emprise local)
  * un suffixe à 3 caractères (ex : region = R44, département = 052)
  * pas d'espaces, d'accents ou de minuscule

## Descriptif du contenu

* Racine : emplacement du projet R --> "CONTROLE_NOM.Rproj"
* Un dossier "result" pour le stockage du résultat
* Un dosssier script qui contient :
  * prog_controle_nom.R --> script principal
  * librairie.R --> script contenant les librairies utiles au programme
  * lister_nom.R --> script listant les fichiers
  * controler_nom.R --> script listant les fichiers
  * suppression_gitkeep.R --> script de suppression des .gitkeep

## Fonctionnement

Lancer le script intitulé "prog_controle_nom" qui se trouve dans le dossier "script"

## Résultat

Le fichier contenant la liste des fichiers ne respectant pas les règles de nommage se trouve dans le dossier "result" et se nomme "erreur_nommage_X.csv".

Le X correspond au lecteur sur lequel sont stockées les données.


