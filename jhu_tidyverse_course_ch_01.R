# Install packages
# install.packages("tidyverse")
# install.packages("here")
# install.packages("ProjectTemplate")
# install.packages("usethis")

library(tidyverse)
library(here)
library(ProjectTemplate)

# 1.6.3.1
getwd()
here()

# 1.6.5
create.project(project.name = "health_expenditures",
               template = "minimal")
