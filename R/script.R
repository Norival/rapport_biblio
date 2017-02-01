# -----------------------------------------------------------------------------
# file    : R/script.R
# object  : Analysis for bibliographic review
# -----------------------------------------------------------------------------


# --- LOAD PACKAGES -----------------------------------------------------------

library(magrittr)
library(ggplot2)
library(dplyr)
library(stringi)


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

# group coountries by continent
for (i in 1:nrow(rg_general)) {
  rg_general$continent[i] <-
    rg_general$country[i] %>%
    switch(.,
           australia  = "oceania",
           bohemia    = "europe",
           brazil     = "south_america",
           bulgaria   = "europe",
           canada     = "north_america",
           croatia    = "europe",
           denmark    = "europe",
           france     = "europe",
           germany    = "europe",
           india      = "asia",
           iran       = "asia",
           pakistan   = "asia",
           poland     = "europe",
           spain      = "europe",
           turkey     = "asia",
           uk         = "europe",
           usa        = "north_america",
           "unknown")
}

# number of articles per continent
rg_general[!(duplicated(rg_general$article)),] %>%
  group_by(continent) %>%
  summarise(count = length(continent)) %>%
  mutate(percent = count / sum(count) * 100)

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

# get the percentage of each crops, grouped by genus
rg_crops$species %>%
  gsub(pattern = "..\\>", replacement = "XX") %>%
  gsub(pattern = "ZEA[\\+[:upper:][:digit:]]*", replacement = "ZEAXX") %>%
  cbind.data.frame(article = rg_crops$article, genus = .) %>%
  .[.$genus != "",] %>%
  group_by(genus) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100) %>%
  print()
# ggplot(., aes(x = genus, y = count)) +
# geom_bar(stat = 'identity') +
# theme(axis.title = element_text(size = 15),
#       axis.text = element_text(size = 12))

# percentage of each experiment type
rg_protocol %>%
  group_by(experiment_type) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100)

# get the number of herbicide used
n_herb <- numeric(nrow(rg_crops))
for (i in 1:nrow(rg_crops)) {
  n_herb[i] <- length(stri_split(rg_crops$herbicide[i], fixed = "+", simplify = TRUE))
}

cbind(rg_crops, n_herb) %>%
  group_by(n_herb) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100)

# single dose or multiple doses tested ?
rg_crops %>%
  .[!is.na(.$application_rate), ] %>%
  group_by(article, herbicide)  %>%
  summarise(n_dose = length(unique(application_rate))) %>%
  group_by(n_dose) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100)

# mean number of weeds
rg_weeds %>%
  # .[!is.na(.$n_species), ] %>%
  group_by(n_species) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100,
         mean = mean(n_species, na.rm = TRUE))

# percent of studies considering "natural" weeds
rg_weeds %>%
  group_by(origin) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100)

# metrics used to quantify the impact of weeds
rg_crops %>%
  .[.$metric != "", ] %>%
  group_by(metric) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100) %>%
  arrange(desc(count))

# -- results -------------------------------------------------------------------

# results on grain yield
summary_yield_quant <-
  rg_results %>%
  .[!is.na(.$grain_yield_quant), ] %>%
  group_by(article, type) %>%
  summarise(yield = mean(grain_yield_quant))
summary_yield_qual <-
  rg_results %>%
  .[.$grain_yield_qual != "", ] %>%
  group_by(grain_yield_qual) %>%
  summarise(count = length(unique(article)))

results_yield <-
  data.frame(article     = levels(factor(summary_yield_quant$article)),
             percent_dec = numeric(length(levels(factor(summary_yield_quant$article)))))

for (art in levels(as.factor(summary_yield_quant$article))) {
  ttt <-
    summary_yield_quant %>%
    filter(article == art, type == 'treatment') %>%
    .$yield
  control <-
    summary_yield_quant%>%
    filter(article == art, grepl(x = type, pattern = "weedy_control")) %>%
    .$yield

  if (length(ttt) + length(control) == 2) {
    results_yield$percent_dec[results_yield$article == art] <-
      (ttt - control) / ttt * 100
  }
}

results_yield <-
  results_yield %>%
  filter(percent_dec != 0)
mean(results_yield$percent_dec)

summary_yield_quant %>%
  ggplot(aes(x = article, y = yield, fill = type)) +
    geom_bar(stat = "identity", position = "dodge")+
    theme_bw() +
    theme(axis.title  = element_text(size = 15),
          axis.text   = element_text(size = 12),
          axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5))

# results for iqbal
rg_results %>%
  filter(article == "iqbal1999")

# economic analyses
rg_results %>%
  filter(!is.na(net_income), article == "kolb2012")

rg_results$weed_percent_control
summary_percent_control <-
  rg_results %>%
  .[!is.na(.$weed_percent_control), ] %>%
  filter(type == "treatment") %>%
  group_by(article) %>%
  summarise(mean_control = mean(weed_percent_control))
summary_percent_control %>%
  ggplot(aes(x = article, y = mean_control)) +
    geom_bar(stat = "identity", position = "dodge")+
    theme_bw() +
    theme(axis.title  = element_text(size = 15),
          axis.text   = element_text(size = 12),
          axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5))
