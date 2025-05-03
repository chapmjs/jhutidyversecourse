# jhu_tidyverse_course_ch_02
# 20250502

library(tidyverse)

as_tibble(trees)

as_tibble(trees) %>% print(n=5, width = Inf)

slice_sample(trees, n = 10)

slice_head(trees, n = 5)
slice_tail(trees, n = 5)

tibble(
  a = 1:5,
  b = 6:10,
  c = 1,
  z = (a + b)^2 + c
)


tibble(
  `two words` = 1:5,
  `12` = "numeric",
  `:)` = "smile",
)

# 2.2.3 Subsetting

df <- tibble(
  a = 1:5,
  b = 6:10,
  c = 1,
  z = (a + b)^2 + c
)

# Extract by name using $ or [[]]
df$z

df[[4]]


# 2.3.1.1 Readnig Excel files into R

#install.packages("readxl")
library(readxl)

# read example file into R
example <- readxl_example("datasets.xlsx")
df <- read_excel(example)
df
