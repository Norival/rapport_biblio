# Rapport bibliographique

## Description des données

### Grilles de lecture

Ces fichiers de données reprennent les données extraites de la lecture des
articles.

#### reading_general.csv

Informations générales sur les articles.

- article [string]  : identifiant unique de l'article, le même que dans la base
                      de données bibtex
- country [string]  : pays où s'est déroulée l'étude
- year_start [num]  : première année de l'étude
- year_end [num]    : dernière année de l'étude
- financing [string]: orgine du financement de l'étude [public/private/both]

#### reading_protocol.csv

Informations sur le protocole utilisé.
- article [string]        : identifiant unique de l'article, le même que dans
                            la base de données bibtex
- year [num]              : année
- experiment_type [string]: type de l'expérience [field/greenhouse]
- famer [bool]            : l'expérience s'est-elle déroulée chez un
                            agriculteur ou dans une ferme expérimentale
                            [TRUE/FALSE]
- n_fields [num]          : nombre de champs différents
- n_plots [num]           : nombre de plots différents
- size_plots [num]        : taille des plots (en hectares)
- weedfree_control [bool] : présence d'un témoin sans adventice
- weedy_control [bool]    : présence d'un témoin sans herbicide

#### reading_crop.csv

Informations sur les cultures.

- article [string]              : identifiant unique de l'article, le même que
                                  dans la base de données bibtex
- year [num]                    : année
- n [num]                       : nombre de cultures différentes
- species [string]              : espèces de cultures
- gmo [bool]                    : culture OGM ou non [TRUE/FALSE]
- gmo_type [string]             : type d'OGM (résistant à un herbicide, etc.)
- density [num]                 : densité de semis de la culture (en graines /
                                       hectare)
- fertilizer [bool]             : utilisation d'un fertilisant [TRUE/FALSE]
- soil_work [string]            : travail du sol mis en oeuvre [ploughing/hoeing]
- weed_control [string]         : type de contrôle des adventices
                                  [manual/mechanic/chemical/no_control]
- treatment_timing [string]     : timing du traitement herbicide
                                  [POST/PRE/LPOST/EPOST]
- herbicide [string]            : quel herbicide a été utilisé
- n_treatments [num]            : nombre de traitements effectués
- metric [string]               : donnée mesurée sur la culture
- adjustment [string]           : ajustement effectué sur la métrique (ex:
                                  ajustment d'humidité pour le rendement)

#### reading_weeds.csv

Informations sur les adventices trouvées.

- article [string]                : identifiant unique de l'article, le même que
                                    dans la base de données bibtex
- year [num]                      : année
- n [num]                         : nombre d'espèces d'adventices
- species [string]                : espèces d'adventices retrouvées [code EPPO]
- type [string]                   : comment sont échantillonnées les adventices
                                    [plants/seed_bank]
- metric [string]                 : donnée mesurée sur les adventices


#### reading_results.csv

Résultats trouvés sur les adventices et les cultures.

- weed_species [string]   : espèce d'adventice
- type [string]           : type de résultat (traitement ou contrôle)
- herbicide [string]      : herbicide analysé
- application_rate [num]  : taux d'application de l'herbicide considéré
- percent_control [num]   : pourcentage de contrôle effectué sur les adventices
- grain_yield [num]       : rendement en graines de la culture
