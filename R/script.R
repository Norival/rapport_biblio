# -----------------------------------------------------------------------------
# file    : R/script.R
# object  : Analysis for bibliographic review
# -----------------------------------------------------------------------------


# --- LOAD PACKAGES -----------------------------------------------------------

library(magrittr)
library(ggplot2)
library(plyr)


graphs_dir <- "~/desktop/r_graphs"

# --- LOAD DATA FILES ---------------------------------------------------------

rg_general  <- read.csv("data/reading_general.csv", stringsAsFactors = FALSE)
rg_protocol <- read.csv("data/reading_protocol.csv", stringsAsFactors = FALSE)
rg_crops    <- read.csv("data/reading_crop.csv", stringsAsFactors = FALSE)
rg_weeds    <- read.csv("data/reading_weeds.csv", stringsAsFactors = FALSE)
rg_results  <- read.csv("data/reading_results.csv", stringsAsFactors = FALSE)

rg_general$article <- as.factor(rg_general$article)

# get crop species from rg_crops dataframe
for (i in 1:nrow(rg_results)) {
  rg_results$crop_species[i] <-
    rg_crops$species[rg_crops$article == rg_results$article[i]][1]
}


# --- GENERAL INFORMATIONS ABOUT ARTICLES -------------------------------------

# number of articles
unique(rg_general$article) %>%
  length()
# number of different countries
unique(rg_general$country) %>%
  length()

# representation of different countries
aggregate(rg_general$country,
          by  = list(id = rg_general$article, country = rg_general$country),
          FUN = "length")[,2:3] %>%
  ggplot(., aes(x = country)) +
  geom_bar() +
  theme(axis.title = element_text(size = 15),
        axis.text = element_text(size = 12))
ggsave("countries.png", path = graphs_dir)


# --- GENERAL INFORMATIONS ABOUT CROPS ----------------------------------------

# representation of different crops
aggregate(rg_crops$species,
          by  = list(id = rg_crops$article, species = rg_crops$species),
          FUN = "length")[,2:3] %>%
  ggplot(., aes(x = species)) +
  geom_bar() +
  theme(axis.title = element_text(size = 15),
        axis.text = element_text(size = 12))
ggsave("crops.png", path = graphs_dir)

# metrics used on crop
aggregate(rg_crops$metric,
          by  = list(id = rg_crops$article, metric = rg_crops$metric),
          FUN = "length")[,2:3] %>%
  ggplot(., aes(x = metric)) +
  geom_bar() +
  theme(axis.title  = element_text(size = 15),
        axis.text   = element_text(size = 12),
        axis.text.x = element_text(angle = 90))
ggsave("metrics_crops.png", path = graphs_dir)

## Various tests
#
# rg_protocol[!(is.na(rg_protocol$farmer)) & rg_protocol$farmer, ] %>%
#   unique() %>%
#   nrow()
# rg_crops
#
# unique(rg_protocol$article)
# rg_protocol[!duplicated(rg_protocol$article),]
# 
# rg_protocol[!(is.na(rg_protocol$experiment_type)) &
#             !(duplicated(rg_protocol$article)), ] %>%
#   ddply(., c("experiment_type", "farmer"), summarise,
#         n = length(article))
# 
# rg_crops[!(duplicated(rg_crops$article)), ] %>%
#   ddply(., c("species", "gmo"), summarise,
#         n = length(gmo))
# 
# 
# nrow(rg_protocol[rg_protocol$farmer,])
# 
# rg_weeds[!(is.na(rg_weeds$n_species)) &
#          !(duplicated(rg_weeds$article)), ] %>%
#   .$n_species %>%
#   mean()
#   ddply(., c("article"), summarise,
#         n = n_species)
# 
# rg_results[!(is.na(rg_results$grain_yield_quant)) &
#            !(duplicated(rg_results$article)), ] %>%
#   nrow()
# rg_results[is.na(rg_results$grain_yield_quant) &
#            !(duplicated(rg_results$article)), ] %>%
#   nrow()
# 
# rg_results[!(is.na(rg_results$weed_density_quant)) &
#            !(duplicated(rg_results$article)), ] %>%
#   nrow()

# --- GENERAL INFORMATIONS ABOUT WEEDS ----------------------------------------

# metrics used on weeds
aggregate(rg_weeds$metric,
          by  = list(id = rg_weeds$article, metric = rg_weeds$metric),
          FUN = "length")[,2:3] %>%
  ggplot(., aes(x = metric)) +
  geom_bar() +
  theme(axis.title  = element_text(size = 15),
        axis.text   = element_text(size = 12),
        axis.text.x = element_text(angle = 90))
ggsave("metrics_weeds.png", path = graphs_dir)

# number of weed speies
aggregate(rg_weeds$n_species,
          by  = list(id = rg_weeds$article, n_species = rg_weeds$n_species),
          FUN = "length")[,2:3] %>%
  ggplot(., aes(x = n_species)) +
  geom_bar() +
  theme(axis.title  = element_text(size = 15),
        axis.text   = element_text(size = 12)) +
  scale_x_continuous(breaks = seq(1, 18))
ggsave("weeds_species.png", path = graphs_dir)


# -- RESULTS ------------------------------------------------------------------

# mean grain yield by treatment and crop species
aggregate(data = rg_results,
          grain_yield_quant ~ article + type + crop_species,
          FUN = "mean", na.rm = TRUE) %>%
  aggregate(data = .,
            grain_yield_quant ~ type + crop_species,
            FUN = "mean", na.rm = TRUE) %>%
  ggplot(., aes(x = type, y = grain_yield_quant, fill = crop_species)) +
  geom_bar(stat = "identity", position = "dodge")

# grain_yield_qual

rg_results[nchar(rg_results$grain_yield_qual) != 0, ] %>%
  ddply(., c('article'), summarise,
        grain_yield_qual = grain_yield_qual)

# weed_percent_control
# I need to compute percent of decrease when quantitative data is available

rg_results[!(is.na(rg_results$weed_percent_control)) &
           !(is.na(rg_results$application_rate)), ] %>%
  ddply(., c('article', 'crop_species'), summarise,
        weed_control = mean(weed_percent_control),
        rate = mean(application_rate, na.rm = TRUE)) %>%
  ggplot(., aes(x = rate, y = weed_control, colour = crop_species)) +
    geom_point()
