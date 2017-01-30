Rapport Bibliographique
=======================

Ce notebook reprend les méthodes utilisées pour la lecture des articles, le
remplissage des grilles de lecture et les analyses statistiques afin qu'ils
puissent être facilement reproduits.

Articles introuvables
---------------------

[X] Gupta et al 2004: Yield and quality of wheat (triticum aestivum) as
    influenced by sulphur nutrition and weed management
    -> It does not even exist on the journal website
[X] Barrat et Kachroo 2011: Effect of different herbicides on mixed weed flora,
    yield and economics of wheat (triticum aestivum) under irrigated conditions
    of jammu
    -> It exists on the journal website but I cannot find the address of the
       authors
[X] Pandey et Verma 2002: Effect of atrazine, metribuzin, sulfosulfuron and
    tralkoxydim on weeds and yield of wheat (triticum aestivum)
    -> I cannot find any email to contact the author
[X] Pandey et Verma 2004: Effect of isoproturon tank mix with metsulfuron and
    2,4-d on weeds and yield of wheat (triticum aestivum)
    -> I cannot find any email to contact the author
[C] Ahmed et al 2013: Physiological traits and yield of wheat cultivars as
    influenced by establishment methods and weed management practices
    -> Contact Ashok Kumar via researchgate
    -> message sent
[X] Tahmasvand et al 2012: Influence of plant density, planting pattern and weed
    control on yield and yield components of grain corn
    -> Contact Hamid Reza Tohidi-Moghadam via researchgate
    -> There is no way to contact him
[X] Chopra et al 2008: Influence of new broadleaf herbicides on weed control,
    seed yield and quality of some wheat (triticum aestivum) cultivars
    -> Contact NK Chopra via researchgate
    -> There is no way to contact him
[X] Moshaver et al 2011: Effect of separate and tank-mix treatments of
    herbicides on weed control and yield of corn (zea mays l.)
    -> Contact Elham Moshaver via researchgate
    -> There is no way to contact him
[X] Mason et al 1996: Effect of weeds and nitrogen fertiliser on yield and grain
    protein concentration of wheat
    -> I cannot find any email to contact the author


Lecture des articles
--------------------

Se référer au fichier biblio.bib pour connaître les références de l'article à
partir de l'identifiant.
Les codes utilisés pour identifier les espèces d'adventices sont les codes EPPO
([EPPO Global Database](https://gd.eppo.int/)).

### vangessel1995

Les adventices sont issues de la population naturelle mais leur densité est
contrée manuellement.

### tharp1999

Les taux d'herbicides sont en kg/ha, ils sont convertis en g/ha:
  `* 1000`

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

### iqbal1999

Conversion du taux de semis de graines/m^2 en graines/hectare (x10000).

Ajout des colonnes crop/weed_n_uptake (mg/plante).
Ajout des colonnes crop/weed_height (cm).

La masse de graines est en g/plantes.

Conversion de graines/épi en graines/plante (tableau 2) :
  `grains/ear * ears/plant`

### ponce1995

L'herbicide utilisé (Primextra) est un mélange de metholachlor (30%) et
d'atrazine (15%).

Ajout de la colonne crop_ag_biomass dans reading_results.csv

Conversion de la masse aérienne de g/m^2 en g/plante :
  `* 1/8`

Conversion du rendement de g/m^2 en kg/ha :
  `(*10000/1000 = * 10)`

Conversion du nombre d'épis par m^2 en nombre d'épis par plante (8 plantes par
m^2) :
  `n_ears / 8`

Conversion de graines/épi en graines/plante (tableau 2) :
  `grains/ear * ears/plant`

Conversion du poids de 1000 graines en poids d'une graine (en mg) :
  `* 1000/1000 = * 1`

Ajout des colonnes crop_[pk]_uptake dans reading_results.csv.
Conversion de crop_[npk]_uptake de g/m^2 en mg/plante :
  `* 1000/8`

### khaliq2013

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (depuis http://data.kew.org).
  `125 000 * 1000 / 37.07 = 3 371 998  graines/ha`

Ajout des colonnes soil_work et days_after_sowing à reading_results.csv.

weed_density et weed_ag_biomass_quant sont extraits de la figure 2.

kernels_per_plant, kernel_weight et crop_yield sont extraits de la figure 4.

crop_grain_yield est en t/ha et est converti en kg/ha.

net_income est extrait du tableau 1.

### bijanzadeh2010interrelationships

Ajout de la colonne oil_yield en tonnes/ha.

### hamouz2013

Il faut rechercher les codes EPPO des espèces adventices.
`other_dicot` et `other_monocot` correspondent à l'ensemble des adventices de la
parcelle autre que les trois nommées.

Conversion du taux d'application du taux d'herbicides en g/Ha.

Ajout de deux nouvelles métriques pour les adventices :

- `weed_patchiness_index`: indice défini par Lloyd (1976), s'il est plus grand
  que 1, cela signifie que la population est agrégée
- `weed_coverage`: représente le pourcentage de sol recouvert par l'espèce.

### bijanzadeh2010effect

Cet article est un doublons de bijanzadeh2010interrelationships, les mêmes
données sont présentées.
Il n'est donc pas étudié.

### fahad2015

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (37.07 g/1000 graines, depuis http://data.kew.org).

125000 * 1000 / 37.07 = 3 371 998 graines/ha.

### lima2010

Calcul de la taille des plots : les rangs sont espacés de 1 m et un plot
consisteen 6 rangs sur une longueur de 0.6 m. Les plots font donc `6 * 0.6 = 36
m^2`.

### malik2009

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (37.07 g/1000 graines, depuis http://data.kew.org), et de la
moyenne entre 125 et 175 kg/ha (125-175 kg/ha est ndiqué dans l'article).

150000 * 1000 / 37.07 = 4 046 398 graines/ha.

Aucune donnée sur les adventices n'est donnée dans cet article.

### knevzevic2008effects

Nombre de plots : 3 traitements * 4 répétitions = 12 plots.

### sharma2011seed

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (37.07 g/1000 graines, depuis http://data.kew.org).

75000 * 1000 / 37.07 =  2 023 199 graines/ha.
100000 * 1000 / 37.07 = 2 697 599 graines/ha.
125000 * 1000 / 37.07 = 3 371 998 graines/ha.
150000 * 1000 / 37.07 = 4 046 398 graines/ha.

### weber2013influence

Conversion du taux de semis de graines par m^2 en graines/hectare : `* 10000`.

Il n'y acune informations sur les adventices dans cet article.

### delchev2015durum

Renomage de la colonne `fertilizer` en `fertilization` et ajout de la colonne
`fertilizer` pour rentrer le fertilisant utilisé dans `reading_crop`

Il n'y acune informations sur les adventices dans cet article.

### gaba2016herbicides

Les résultats de cet article sont tirés d'un questionnaire auprès
d'agriculteurs.

### khan2013

Ajout de trois nouvelles métriques :

- `crop_tillers_per_ha` : nombre de pousses par hectare
- `crop_biological_yield` : rendement en biomasse totale (t/ha)
- `crop_harvest_index` : `(crop_yield / crop_biological_yield) * 100` (%)

Ils ont mesuré la densité d'adventices avant et après le traitement herbicide,
j'utilise ces mesures pour calculer le pourcentage de contrôle des adventices.

### rosa2015

Conversion du taux de semis de kg/ha à graines/ha : utilisation du poids moyen
d'une graine (depuis http://data.kew.org).
La densité indiquée dans l'article est de 12 kg/ha, ce doit être une erreur car
cela donne un densité de semis de 47 graines/ha.
Pour que le résultat soit cohérent avec les résultats des autres études, je
suppose que la densité est donnée en tonnes/ha.

  `12000 * 1000 / 252 = 47 000 graines/ha`

Aucune métrique n'est mesurée sur les adventices.

Ajout de nouvelles métriques :

- `crop_ear_length`
- `crop_ear_diameter`
- `crop_ascorbic_acid_content`
- `kernels_row_per_ear`

### begna2001

Ajout d'une nouvelle syntaxe pour l'espèce de culture : `EPPO_CODE+INFO`.
Le champ info permet d'avoir une info supplémentaire sur l'espèce, ici des
hybrides différents.
Besoin d'ajouter de quoi les séparer dans R.

Calcul de la dose d'herbicides. Herbicide appliqué à 7.7 l/ha à une
concentration de 500 g/L.

`7.7*500 = 3850 g/ha`

Ajout de trois nouvelles métriques sur les cultures :

- `crop_height`
- `crop_stem_weight`
- `crop_leaf_weight`

Cet article ne fournit aucune information sur les adventices.

### black1996

Cet article ne teste pas l'effet des adventices sur le rendement, ni l'effet des
herbicides sur le contrôle.
Il traite de l'augmentation du rendement par les herbicides en absence
d'adventices dans la culture.

### freeman2004

Conversion des taux de semis de graines/m^2 à graines/ha.

Ajout d'une nouvelle métrique pour les adventices : `crop_pod_per_plant` pour le
nombre de cosses par pante.

### unay2006

Il n'y a aucune information sur les adventices dans cet article.

### young1994

Il n'y a acune informations sur les adventices dans cet article.

### smiley1992

Cette article ne concerne pas directement l'effet des herbicides sur le
rendement des cultures mais l'effet du traitement au chlorsulfuron sur le
développement d'une maladie racinaire : Rhizoctonia root rot.
Je garde cet article pour la discussion.

### cox2005weed

Ajout de métriques:

- `crop_ndf` : neutral detergent fiber
- `crop_starch_content` : contenu en amidon
- `crop_potential_milk` : rendement en lait potentiel du fourrage

### mueller2013winter

Ajout de la métrique `weed_c_uptake`.
