library(tidyverse)
library(tidymodels)
library(doMC)
library(finetune)
library(beepr)
library(treesnip)
library(lightgbm)

store_folds <- read_rds("store_folds.rds")
sliced_set <- read_rds("sliced_set.rds")

# Parallel time!

registerDoMC(cores = 7)

# Run Workflowsets

race <-
  sliced_set %>% 
  workflow_map(
    "tune_race_anova",
    seed = 33,
    resamples = store_folds,
    grid = 20,
    metrics = metric_set(rmse),
    control = control_race(
      save_pred = TRUE,
      parallel_over = "everything",
      save_workflow = TRUE
    )
  )
beep()