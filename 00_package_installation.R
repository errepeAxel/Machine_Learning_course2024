# ene 20, 2024
# Axel Rodriguez

# Install required packages
packages_to_install <- c("tidyverse", "tidymodels", "easystats", "embed", "skimr", "DataExplorer", "assertr")

# Check if the packages are already installed, if not, install them
for (package in packages_to_install) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package, dependencies = TRUE)
  } else {
    cat(paste("Package", package, "is already installed.\n"))
  }
}

# Load the installed packages
library(tidyverse)
library(tidymodels)
library(easystats)
library(performance)
library(embed)
library(skimr)
library(DataExplorer)
library(assertr)
