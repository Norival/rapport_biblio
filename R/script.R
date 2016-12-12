# -----------------------------------------------------------------------------
# file    : R/script.R
# object  : Analysis for bibliographic review
# -----------------------------------------------------------------------------


# --- LOAD PACKAGES -----------------------------------------------------------

library(magrittr)
library(ggplot2)


graphs_dir <- "~/desktop/r_graphs"

# --- LOAD DATA FILES ---------------------------------------------------------

rg_general  <- read.csv("datas/reading_general.csv", stringsAsFactors = FALSE)
rg_protocol <- read.csv("datas/reading_protocol.csv", stringsAsFactors = FALSE)
rg_crops    <- read.csv("datas/reading_crop.csv", stringsAsFactors = FALSE)
rg_weeds    <- read.csv("datas/reading_weeds.csv", stringsAsFactors = FALSE)
rg_results  <- read.csv("datas/reading_results.csv", stringsAsFactors = FALSE)

rg_general$article <- as.factor(rg_general$article)


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
