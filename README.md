# Machine Learning with Tidymodels

A comprehensive introduction to machine learning workflows using the tidymodels ecosystem in R, developed for the Machine Learning intensive course at LCGEJ (January 2024).

## Overview

This project covers essential machine learning concepts and implementations using the tidymodels framework:
- Data preprocessing and tidying with dplyr and tidyr
- Train/test splitting and cross-validation strategies
- Feature engineering with recipes
- Regression and classification modeling
- Hyperparameter tuning (grid search and Bayesian optimization)
- Model evaluation and visualization
- Variable importance analysis

## Data

The course utilizes multiple datasets for hands-on learning:

- **Ames Housing Dataset**: Housing prices in Ames, Iowa with ~2,900 observations and 80+ features including lot area, living area, year built, and neighborhood characteristics
- **Microarray Expression Data**: Gene expression dataset (`microarray_expression_data.csv`) with 5,537 genes and 40 experimental conditions for data tidying exercises
- **Taxi Dataset**: Used for classification tasks and demonstrating decision tree models

## Course Materials

| File | Description |
|------|-------------|
| `00_package_installation.R` | Installation script for required packages (tidyverse, tidymodels, easystats, etc.) |
| `01_tidyng_data.Rmd` | Data tidying fundamentals using dplyr and tidyr with gene expression data |
| `03_test.Rmd` | K-nearest neighbors example with hyperparameter tuning on Ames dataset |
| `04_regression_ames.Rmd` | Complete regression pipeline: linear models, workflows, cross-validation, and metrics |
| `05_tidymodels.Rmd` | Core tidymodels concepts: data splitting, stratification, and classification workflows |

## Key Concepts Covered

### Data Preprocessing
- Data splitting with stratification
- Feature engineering with `recipes`
- Handling missing data and outliers
- Variable transformations (log, Yeo-Johnson, splines)
- Creating dummy variables

### Model Building
- Linear regression with multiple predictors
- K-nearest neighbors (KNN) regression
- Decision trees for classification
- Model specification with `parsnip`
- Workflow creation combining recipes and models

### Model Evaluation
- Cross-validation (v-fold, stratified)
- Performance metrics: RMSE, MAE, R²
- Coefficient visualization with dotwhisker plots
- Variable importance analysis
- QQ plots and diagnostic visualizations

### Hyperparameter Tuning
- Grid search with `tune_grid()`
- Bayesian optimization with `tune_bayes()`
- Parameter space exploration
- Model selection strategies

## Dependencies

```r
# Core packages
install.packages(c(
  "tidyverse",      # Data manipulation and visualization
  "tidymodels",     # ML framework
  "easystats",      # Statistical analysis
  "performance"     # Model diagnostics
))

# Additional packages
install.packages(c(
  "rmdformats",     # R Markdown templates
  "dotwhisker",     # Coefficient plots
  "vip",            # Variable importance
  "DataExplorer",   # Automated EDA
  "kknn",           # KNN implementation
  "AmesHousing",    # Ames dataset
  "embed",          # Feature engineering
  "skimr",          # Data summaries
  "assertr"         # Data validation
))
```

Alternatively, run the installation script:
```r
source("00_package_installation.R")
```

## Usage

### Running Individual Modules

Each R Markdown file can be executed independently:

```r
# Data tidying tutorial
rmarkdown::render("01_tidyng_data.Rmd")

# Regression modeling
rmarkdown::render("04_regression_ames.Rmd")

# Tidymodels fundamentals
rmarkdown::render("05_tidymodels.Rmd")
```

### Example Workflow

```r
library(tidymodels)
library(tidyverse)

# 1. Load and split data
data(ames)
set.seed(123)
ames_split <- initial_split(ames, prop = 0.8, strata = Sale_Price)
ames_train <- training(ames_split)
ames_test <- testing(ames_split)

# 2. Create recipe and model
lm_rec <- recipe(Sale_Price ~ Lot_Area + Year_Built + Gr_Liv_Area, 
                 data = ames_train) %>%
  step_log(Sale_Price, base = 10) %>%
  step_normalize(all_numeric_predictors())

lm_spec <- linear_reg() %>% 
  set_engine("lm")

# 3. Build workflow and fit
ames_wf <- workflow() %>%
  add_recipe(lm_rec) %>%
  add_model(lm_spec)

ames_fit <- fit(ames_wf, data = ames_train)

# 4. Evaluate with cross-validation
ames_cv <- vfold_cv(ames_train, v = 10)
cv_results <- fit_resamples(ames_wf, resamples = ames_cv)
collect_metrics(cv_results)
```

## Output

Each tutorial generates:
- **HTML reports**: Self-contained documents with code, visualizations, and explanations
- **Model objects**: Fitted models with estimated parameters
- **Performance metrics**: RMSE, MAE, R² for model evaluation
- **Visualizations**:
  - Coefficient plots with confidence intervals
  - Variable importance plots
  - Cross-validation performance
  - Model diagnostic plots

## Author

Axel Rodriguez Perez  
Genomic Sciences, UNAM · January 2024
