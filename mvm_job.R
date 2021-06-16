library(tidyverse)
library(tidymodels)
library(doMC)
library(beepr)

store_folds <- read_rds("store_folds.rds")
xg_wf <- read_rds("xg_wf.rds")

# Parallel time!

registerDoMC(cores = 7)

# Run CV

xg_rs <- 
  xg_wf %>% 
  fit_resamples(store_folds, control = control_resamples(save_pred = TRUE))