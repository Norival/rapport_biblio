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
# ggsave("countries.png", path = graphs_dir)


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

# -- maps ----------------------------------------------------------------------

library(maps)
library(tikzDevice)

# define a clear theme for the maps
theme_clean <- function(base_size = 12) {
  require(grid) # Needed for unit() function
  theme_grey(base_size) %+replace%
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.ticks.length = unit(0, "cm"),
          axis.ticks.margin = unit(0, "cm"),
          panel.spacing = unit(0, "lines"),
          plot.margin = unit(c(0, 0, 0, 0), "lines"),
          complete = TRUE)
}

# get the data for world map
# TODO: find another data, this one is buggy for mercator projections...
world <-
  map_data("world") %>%
  mutate(region = tolower(region))

# map the number of articles per country
p <-
  rg_general %>%
  group_by(country) %>%
  summarise(count = length(unique(article))) %>%
  merge(world, ., by.x = "region", by.y = "country", all.x = TRUE) %>%
  arrange(group, order) %>%
  ggplot(aes(x = long, y = lat, group = group, fill = as.factor(count))) +
  geom_polygon(colour = "black") +
  coord_fixed() +
  coord_map() +
  labs(fill = "Nombre d'études") +
  theme_clean() +
  expand_limits(x = world$long, y = world$lat) +
  lims(x = c(-200, 200), y = c(-180, 180)) +
  theme(legend.position = "bottom")
ggsave("../../report/img/map_world.pdf", plot = p, scale = 0.4)
# tikz("map_world.tex")
# p
# dev.off()


# table for the evolution by year and by continent
sum_continent <-
  rg_general %>%
  group_by(continent) %>%
  summarise(n = length(unique(article)),
            year_min = min(year_start),
            year_max = max(year_end),
            duration = round(mean(year_end - year_start + 1), 1))
library(xtable)
con <- file("sum_continent.tex", open = "w")
writeLines(text = print(xtable(x = sum_continent)), con = con)
close(con)


# financing
rg_general %>%
  group_by(financing) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100)

# type of experience
# With dirty hack to show empty levels in summary table: I cannot make
# tidyr::complete() work...
sum_empiric <-
  rg_protocol %>%
  group_by(experiment_type, empiric) %>%
  summarize(count = length(unique(article)),
            n_plots = round(mean(n_plots, na.rm = TRUE), 2),
            min_n_plots = round(min(n_plots, na.rm = TRUE), 2),
            max_n_plots = round(max(n_plots, na.rm = TRUE), 2)) %>%
  rbind.data.frame(., 
                   c("greenhouse", TRUE, 0, 0),
                   c("exp_field", TRUE, 0, 0)) %>%
  mutate(count    = as.numeric(count),
         n_plots  = as.numeric(n_plots)) %>%
  arrange(experiment_type)

con <- file("sum_empiric.tex", open = "w")
writeLines(text = print(xtable(x = sum_empiric), include.rownames = FALSE), con = con)
close(con)

# graph: this graph is weird
# aa %>%
#   ggplot(aes(x = experiment_type, y = n_plots, fill = empiric)) +
#   geom_bar(stat = 'identity', position = "dodge")

# heatmap showing the differences in methods betwenn empiric and expe
# sum_truc <-
#   rg_protocol %>%
#   group_by(experiment_type, empiric) %>%
#   # group_by(experiment_type, empiric, weedfree_control, weedy_control, cropfree_control) %>%
#   summarize(count = length(unique(article)),
#             n_wf = length(filter(weedfree_control == TRUE)),
#             n_plots = round(mean(n_plots, na.rm = TRUE), 2)) %>%
#   rbind.data.frame(., 
#                    c("greenhouse", TRUE, 0, 0),
#                    c("exp_field", TRUE, 0, 0)) %>%
#   mutate(count = as.numeric(count),
#          n_plots = as.numeric(n_plots)) %>%
#   arrange(experiment_type)

# exp field n weed_free
rg_protocol %>%
  # group_by(experiment_type, empiric, weedfree_control, weedy_control, cropfree_control) %>%
  # group_by(experiment_type, empiric, weedfree_control) %>%
  # group_by(experiment_type, empiric, weedy_control) %>%
  group_by(experiment_type, empiric, cropfree_control) %>%
  summarise(count = length(unique(article)))

# generate bibliographic list
con <- file("../../report/tex/ref_list.tex", open = "w")
cat("% list of references generated on", date(), "\n", file = con)
for (bib in levels(as.factor(rg_general$article))) {
  cat("\\nocitesec{", bib, "}\n", sep = "", file = con)
}
close(con)


# get the number of herbicide used
n_herb <- numeric(nrow(rg_crops))

for (i in 1:nrow(rg_crops)) {
  n_herb[i] <- length(stri_split(rg_crops$herbicide[i], fixed = "+", simplify = TRUE))
}
cbind(rg_crops, n_herb) %>%
  group_by(n_herb) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = round(count / sum(count) * 100, 1)) %>%
  print()
mean(n_herb)

# single dose or multiple doses tested ?
aa <-
  rg_crops %>%
  .[!is.na(.$application_rate), ] %>%
  group_by(article, herbicide)  %>%
  summarise(n_dose = length(unique(application_rate))) %>%
  group_by(n_dose) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = round(count / sum(count) * 100, 2)) %>%
  mutate(mean = mean(n_dose))

weighted.mean(aa$n_dose, w = aa$count)

herbs <- numeric(0)

for (i in 1:nrow(rg_crops)) {
  herbs[i] <- length(stri_split(rg_crops$herbicide[i], fixed = "+", simplify = TRUE))
}
herbs <-
  rg_crops %>%
  filter(herbicide != "no_herbicide", herbicide != "") %>%
  .$herbicide %>%
  stri_split(fixed = "+", simplify = TRUE) %>%
  as.character() %>%
  unique() %>%
  sort()
herbs <- herbs[herbs != ""]

rg_crops %>%
  filter(herbicide != "no_herbicide", herbicide != "") %>%
  stri_split(fixed = "+", simplify = TRUE) %>%
  as.character() %>%
  unique() %>%
  sort()
herbs <- herbs[herbs != ""]

rg_crops$herbicide %>%
  stri_split(fixed = "+", simplify = TRUE)

tab_herbs <- data.frame(article = character(0),
                        herb    = character(0),
                        dose = numeric(0),
                        stringsAsFactors = FALSE)
for (i in 1:nrow(rg_crops)) {
  herb <-
    stri_split(rg_crops$herbicide[i], fixed = "+", simplify = TRUE) %>%
    as.character()
  dose <-
    stri_split(rg_crops$application_rate[i], fixed = "+", simplify = TRUE) %>%
    as.character()

  tab_herbs <-
    rbind.data.frame(tab_herbs, cbind(rg_crops$article[i], herb, dose),
                     stringsAsFactors = FALSE)
}
colnames(tab_herbs) <- c("article", "herb", "dose")

tab_herb_sum <-
  tab_herbs %>%
  mutate(dose = as.numeric(dose)) %>%
  group_by(herb) %>%
  summarise(count = length(unique(article)),
            dose = mean(dose, na.rm = TRUE))

con <- file("sum_herbs.tex", open = "w")
writeLines(text = print(xtable(x = tab_herb_sum, include.rownames = FALSE)), con = con)
close(con)

# -- cutlures ------------------------------------------------------------------
# get the percentage of each crops, grouped by genus
rg_crops$genus <-
  rg_crops$species %>%
  gsub(pattern = "..\\>", replacement = "XX") %>%
  gsub(pattern = "ZEA[\\+[:upper:][:digit:]]*", replacement = "ZEAXX")

p <-
  rg_crops %>%
  filter(genus != "") %>%
  group_by(genus, gmo) %>%
  # group_by(genus, gmo) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = count / sum(count) * 100) %>%
  ggplot(aes(x = genus, y = count, fill = gmo)) +
    geom_bar(stat = 'identity') +
    xlab("Espèce cultivée") +
    ylab("Nombre d'études") +
    theme_bw() +
    labs(fill = "OGM") +
    theme(axis.title  = element_text(size = 12),
          axis.text   = element_text(size = 9),
          panel.grid = element_blank(),
          axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1.1)) +
    scale_x_discrete(labels = c("\\textit{B. napus}", "\\textit{H. vulgare}",
                                "\\textit{T. aestivum}", "\\textit{V. sativa}",
                                "\\textit{Z. mays}")) +
  scale_fill_discrete(labels = c("Non", "Oui"))

tikz("../../report/img/crops.tex", height = 3, width = 4)
plot(p)
dev.off()


# -- adventices ----------------------------------------------------------------

# mean number of weeds
rg_weeds %>%
  filter(!is.na(species)) %>%
  group_by(n_species) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = round(count / sum(count) * 100, 2),
         mean = round(mean(n_species, na.rm = TRUE), 2),
         sum = sum(count)) %>%
  knitr::kable()

rg_weeds %>%
  filter(species != "NA") %>%
  group_by(article) %>%
  mutate(n_cons = length(unique(species))) %>%
  group_by(n_cons) %>%
  summarise(n = length(unique(article))) %>%
  mutate(mean = mean(n_cons)) %>%
  knitr::kable()

# percent of studies considering "natural" weeds
rg_weeds %>%
  group_by(origin) %>%
  summarise(count = length(unique(article))) %>%
  mutate(percent = round(count / sum(count) * 100, 2)) %>%
  arrange(desc(percent)) %>%
  knitr::kable()
