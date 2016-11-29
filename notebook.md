Rapport Bibliographique
=======================

Ce notebook reprend les méthodes utilisées pour la lecture des articles, le
remplissage des grilles de lecture et les analyses statistiques afin qu'ils
puissent être facilement reproduits.


Lecture des articles
--------------------

Se référer au fichier latex/biblio.bib pour connaître les références de
l'article à partir de l'identifiant.

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
