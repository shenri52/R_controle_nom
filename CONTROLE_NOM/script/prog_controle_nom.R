######################################################################### 
# Ce script permet de contrôler le respect des règles de nommage        #
# suivantes :                                                           #
#   - un nom de fichier n'excédant pas 32 caractères                    #
#   - un préfixe N (emprise national) ou L (emprise local)              #
#   - un suffixe à 3 caractères (ex : region = R44, département = 052)  #
#   - pas d'espaces, d'accents ou de minuscule                          #
#                                                                       #
# Règles définies dans la doctrine nationale                            #
#########################################################################
# Fonctionnement :                                                      #
#     Lancer le script                                                  #
#                                                                       #
# Résultat :                                                            #
# Un fichier csv nommé 'erreur_nommage_X' dans le dossier "result" avec #
# la liste des fichiers ne respectant pas la règle et le motif de non   #
# respect                                                               #
#                                                                       #
# Le X correspond au lecteur sur lequel sont stockées les données       #
#########################################################################


########## Chargement des librairies

source("./script/librairie.R")

#################### Suppression des fichiers gitkeep

source("script/suppression_gitkeep.R")

########## Lister le contenu de l'arborescence

source("./script/lister_nom.R")

##########  Contrôle du respect des règles de nommages des fichiers

source("./script/controler_nom.R")
