##########  Contrôle du respect des règles de nommages des fichiers
list_erreur <- list_dossier %>%
               # Comptage du nombre de caractere
               mutate(TOTAL_CAR = nchar(Fichier)-nchar(as.character(Extension))-1) %>%
               mutate(NB_CAR = case_when( 
                                          nchar(Fichier)-nchar(as.character(Extension))-1 <= 32 ~ NA,
                                          .default = "Nombre de caractères supérieur à 32"
                      )) %>%
               # Contrôle de la premiere lettre
               mutate(START_CAR = case_when( 
                                            substr(Fichier,1 , 1) == "L" ~ NA,
                                            substr(Fichier,1 , 1) == "N" ~ NA,
                                            .default = "Problème avec le premier carctère"
                                            )) %>%
               # Controle des 3 derniers caracteres
               mutate(END_CAR = case_when(
                                          substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), (TOTAL_CAR-2)) == "R" | substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), (TOTAL_CAR-1)) %in% c("0", "1", "2", "3","4", "5", "6", "7", "8", "9") | substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), TOTAL_CAR) %in% c("0", "1", "2", "3","4", "5", "6", "7", "8", "9") ~ NA,
                                          substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), (TOTAL_CAR-2)) %in% c("0", "1", "2", "3","4", "5", "6", "7", "8", "9") | substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), (TOTAL_CAR-1)) %in% c("0", "1", "2", "3","4", "5", "6", "7", "8", "9") | substr(substr(Fichier, 1, TOTAL_CAR), (TOTAL_CAR-3+1), TOTAL_CAR) %in% c("0", "1", "2", "3","4", "5", "6", "7", "8", "9") ~ NA,
                                          .default = "Problème avec les 3  derniers carctères"                                                                                                                                      
                                          )) %>%
               # Controle de la présence de minuscules, espaces ou accents
               mutate(NOM = case_when(
                                      substr(Fichier, 1, TOTAL_CAR) == toupper(substr(Fichier, 1, TOTAL_CAR))  & str_detect(Fichier, " ") == FALSE & str_detect(Fichier, "[^ -~]") == FALSE~ NA,
                                      .default = "Présence de minuscules ou espaces ou accents" 
                                      )) %>%
               filter(TOTAL_CAR > 32 | START_CAR == "Problème avec le premier carctère" | END_CAR == "Problème avec les 3  derniers carctères" | NOM == "Présence de minuscules ou espaces ou accents" ) %>%
               select(-TOTAL_CAR)

# Export
write.table(list_erreur,
            file = paste("result/erreur_nommage_", substr(lecteur,1,1), ".csv", sep = ""),
            fileEncoding = "UTF-8",
            sep =";",
            row.names = FALSE)