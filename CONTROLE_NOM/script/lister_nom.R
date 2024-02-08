########## Lister le contenu de l'arborescence

lecteur <- NULL

# Affichage d'une boîte de dialogue pour indiquer le lecteur à analyser
while (is_empty(lecteur))
{
  lecteur <- dlg_dir(default = getwd(), title = "Choisir le dossier à analyser")$res
}

# Récupération de la liste des fichiers et des informations de taille et date de modification
list_dossier <- list.files(path = lecteur,
                           full.names = TRUE,
                           recursive = TRUE) %>%
                as.data.frame() %>%
                rename.variable(".", "Acces")

# Création d'un dataframe avec les colonnes chemins et fichier
list_dossier <- list_dossier %>%
                mutate(Chemin = dirname(list_dossier$Acces)) %>%
                mutate(Fichier = basename(list_dossier$Acces)) %>%
                mutate(Extension = as.factor(toupper(sub("^.+\\.", "", Fichier)))) %>%
                select(-Acces)
  
# Boîte de dialogue "Ne pas lister certaines extensions
ext_list <- dlgInput("Voulez vous choisir les extensions à lister ? (oui ou non)")$res

# Suppression des extensions choisies
if (ext_list == "oui")
{
  # Création d'une liste des extensions
  ext <- list_dossier %>%
         select(Extension) %>%
         group_by(Extension) %>%
         summarize(.Freq = n()) %>%
         spread(Extension, .Freq)
  
  # Affichage d'un message d'information
  dlg_message("Choissisez les extensions à lister")
  
  # Boîte de dialogue pour choisir les extensions à ne pas lister
  ext <- dlg_list(c("Toutes", colnames(ext)), multiple = TRUE, preselect = NULL, title = "Extensions A LISTER ")$res %>%
         as.data.frame() %>%
         mutate(SUP = 1) %>%
         rename.variable(".", "Extension")
  
  # Contrôle vide
  if (is.na(ext[1,1]))
  {
    ext[1,1] <- "Toutes"
  }
  
  # Contrôle si toutes + extension(s)
  if (count(ext) > 1)
  {
    ext <- ext %>%
           filter(Extension != "Toutes")
  }
  
  # Sélection des extensions choisie
  if (ext[1,1] != "Toutes")
  {
    list_dossier <- full_join(list_dossier, ext) %>%
                    filter(!is.na(SUP)) %>%
                    select(-SUP)
  }
}