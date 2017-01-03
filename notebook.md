Rapport Bibliographique
=======================

Ce notebook reprend les méthodes utilisées pour la lecture des articles, le
remplissage des grilles de lecture et les analyses statistiques afin qu'ils
puissent être facilement reproduits.


Description des données
-----------------------

### Grilles de lecture

Ces fichiers de données reprennent les données extraites de la lecture des
articles.

#### reading_crop.csv

Informations sur les cultures.

- article [string] : identifiant unique de l'article, le même que dans la base
  de données bibtex
- year [num] : année
- n [num] : nombre de cultures différentes
- species [string] : espèces de cultures
- gmo [bool] : culture OGM ou non [TRUE/FALSE]
- gmo_type [string] : type d'OGM (résistant à un herbicide, etc.)
- density [num] : densité de semis de la culture (en graines / hectare)
- fertilizer [bool] : utilisation d'un fertilisant [TRUE/FALSE]
- soil_work [string] : travail du sol mis en oeuvre [ploughing/hoeing]
- weed_control [string] : type de contrôle des adventices
  [manual/mechanic/chemical/no_control]
- treatment_timing [string] : timing du traitement herbicide
  [POST/PRE/LPOST/EPOST]
- herbicide [string] : quel herbicide a été utilisé
- n_treatments [num] : nombre de traitements effectués
- metric [string] : donnée mesurée sur la culture
- adjustment [string] : ajustement effectué sur la métrique (ex: ajustment
  d'humidité pour le rendement)

#### reading_general.csv

Informations générales sur les articles.

- article [string] : identifiant unique de l'article, le même que dans la base
  de données bibtex
- country [string] : pays où s'est déroulée l'étude
- year_start [num] : première année de l'étude
- year_end [num] : dernière année de l'étude
- financing [string] : orgine du financement de l'étude [public/private/both]

#### reading_protocol.csv

Informations sur le protocole utilisé.

- article [string] : identifiant unique de l'article, le même que dans la base
  de données bibtex
- year [num] : année
- experiment_type [string] : type de l'expérience [field/greenhouse]
- famer [bool] : l'expérience s'est-elle déroulée chez un agriculteur ou dans
  une ferme expérimentale [TRUE/FALSE]
- n_fields [num] : nombre de champs différents
- n_plots [num] : nombre de plots différents
- size_plots [num] : taille des plots (en hectares)
- weedfree_control [bool] : présence d'un témoin sans adventice
- weedy_control [bool] : présence d'un témoin sans herbicide

#### reading_results.csv

Résultats trouvés sur les adventices et les cultures.

- weed_species [string] : espèce d'adventice
- type [string] : type de résultat (traitement ou contrôle)
- herbicide [string] : herbicide analysé
- application_rate [num] : taux d'application de l'herbicide considéré
- percent_control [num] : pourcentage de contrôle effectué sur les adventices
- grain_yield [num] : rendement en graines de la culture

#### reading_weeds.csv

Informations sur les adventices trouvées.

- article [string] : identifiant unique de l'article, le même que dans la base
  de données bibtex
- year [num] : année
- n [num] : nombre d'espèces d'adventices
- species [string] : espèces d'adventices retrouvées [code EPPO]
- type [string] : comment sont échantillonnées les adventices
  [plants/seed_bank]
- metric [string] : donnée mesurée sur les adventices


Lecture des articles
--------------------

Se référer au fichier biblio.bib pour connaître les références de l'article à
partir de l'identifiant.
Les codes utilisés pour identifier les espèces d'adventices sont les codes EPPO
([EPPO Global Database](https://gd.eppo.int/)).

### solie1991

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (37.07 g/1000 graines, depuis http://data.kew.org).

67000 * 1000 / 37.07 = 1 807 391 graines/ha.

Le rendement en grain du blé a été pris dans le tableau 3 (1989), colonne
"locations means".
Pour l'année 1990, Les résultats sont extraits du tableau 5, et la moyenne est
faite des trois locations.

Les autres résultats présentés ne sont pas en rapport directement avec le
sujet, ils sont ignorés pour le moment.

### cox2006

L'origine du financement n'a pas été trouvée pour cet article.

Il y a trois traitements herbicides différents : EPOST (stades V3-V4), MPOST
(mid-postemergence, stades V5-V6) et LPOST (stades V7-V8).

Le poids moyen des grains est donné en mg et le rendement est donné en Mg/ha.

Les résultats sont poolés sur les deux années de culture, les données pour
chaque année ne sont fournies.

La surface foliare et l'accumulation de matière sèche du maïs ont été regroupé
entre les 2 stages de croissance V8 et R1 (tableau 3).

Je n'ai pas récupéré les résultats sur les hauteurs des adventices car ils ne
sont pas donnés complètement. Seuls les hauteurs au moment du traitement sont
donnés et il n'y a pas de donnée sur la réduction due aux herbicides.

### rueda2011

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (37.07 g/1000 graines, depuis http://data.kew.org) et du taux
médian de 155-165 kg/ha indiqué dans l'article (160 kg/ha).

160 000 * 1000 / 37.07 =  4 316 159 graines/ha.

L'ajustement d'humidité pour le rendement du blé est 12-13%. J'ai choisi 12.5%
pour remplir la grille.

crop_soil_cover

### monks1996

Il y a trois traitements herbicides différents : EPOST (2 WAP), MPOST
(4 WAP) et LPOST (6 WAP). WAP = Weeks After Planting.

Les taux d'application sont exprimés en g/ha.

Les résultats concernant les pourcentages de contrôle des 3 espèces
d'adventices et du rendment sont extraits des tableaux. Les résultats pour 1993
sont regroupés entre les 2 locations.

### zhang1996

Il y a très peu de résultats quantitatifs dans cette étude.
Les résultats principaux portent sur l'effet des successions culturales et non
sur l'effet des adventices.
Les résultats concernant le rendement du maïs sont extraits de la figure 1b.

### nurse2007

Les taux d'application d'herbicide sont en g ai/ha.

J'ai considéré les trois adventices principales mentionnées dans l'étude
(CHEAL, SETVI et AMBEL).
Le pourcentage de contrôle est calculé à partir de la figure 1.

Concernant le rendement, étant donné que seule la moyenne pour la dose 35 était
donnée, j'ai pris la moyenne des 4 locations dans le tableau 3 pour le
contrôle. Pour le traitement, j'ai pris la valeur dans le tableau 4.

### kolb2012

Le taux de semis est donné en graines par m^2, je l'ai converti en graines par
hectare.

### gholamhoseini2013

La densité de semis d'adventices est de 8 plants par mètre dans chaque
interrang.
Sachant que les rangs sont séparés de 0.75 m, cela fait une densité de
10.7 plants/m^2.

Le rendement moyen est extrait du tableau 4, j'ai fait la moyenne entre les
deux traitements d'irrigation pour chaque année.

### iffat2010

Les densités de semis de la culture et des adventices ne osnt pas indiquées
mais le rapport entre les 2 est de 1:1.

Les pourcentages de diminution sont extraits du tableau 2.
J'ai fait la moyenne entre les deux variétés et entre les deux stades de
croissance.

### clay1998

Le taux de semis du maïs est extrait du tableau 2, j'ai fait la moyenne des
deux cultivars pour l'année 1992.

Les résultats sur la densité d'adventices sont extraits du tableau 5 et les
résultats sur le rendement du tableau 6.
La moyenne a été faite sur les deux locations.

### scott1995

La taille de plots indiquée est la taille moyenne sur tous les traitements.

Les taux d'application des herbicides sont donnés en g/ha, il est converti en
kg/ha.
Ils sont convertis en kg/ha.

### epperlein2014

La densité de semis du blé est convertie de 350 plants/m^2 en plants/ha.

Il y a peu de résultats dans cet article qui s'intéresse surtout au
développement d'une adventice rare (LEGSV), en présence de blé, dans un but de
conservation.

### garcia2007

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (depuis http://data.kew.org).

TRZTU (41.41 g/100 graines) :
180 000 * 1000 / 41.41 = 4 346 776 graines/ha.

VICSA (31.8 g/100 graines) :
90 000 * 1000 / 31.8 = 4 346 776 graines/ha.

HORVX (41.9 g/100 graines) :
150 000 * 1000 / 41.9 = 3 579 952 graines/ha.

### iqbal1999

Conversion du taux de semis de graines/m^2 en graines/hectare (x10000).

Ajout des colonnes crop/weed_n_uptake (mg/plante).
Ajout des colonnes crop/weed_height (cm).

La masse de graines est en g/plantes.

Conversion de graines/épi en graines/plante (tableau 2) :
grains/ear * ears/plant

### ponce1995

L'herbicide utilisé (Primextra) est un mélange de metholachlor (30%) et
d'atrazine (15%).
4 L/ha
