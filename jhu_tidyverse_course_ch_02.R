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


# 2.3.1.1 Reading Excel files into R

#install.packages("readxl")
library(readxl)

# read example file into R
example <- readxl_example("datasets.xlsx")
df <- read_excel(example)
df

# I have a tibble of 32 x 11 (not the 150 x 5 in the book:
# https://jhudatascience.org/tidyversecourse/get-data.html#reading-excel-files-into-r

# read_excel(example, col_names = LETTERS[1:5])
read_excel(example, col_names = LETTERS[1:11])

# read example file into R using .name_repair default
read_excel(
  readxl_example("deaths.xlsx"),
  range = "arts!A5:F8",
  .name_repair = "unique"
)


# require use of universal naming conventions
read_excel(
  readxl_example("deaths.xlsx"),
  range = "arts!A5:F8",
  .name_repair = "universal"
)

# pass function for column naming
read_excel(
  readxl_example("deaths.xlsx"),
  range = "arts!A5:F8",
  .name_repair = toupper
)

# pass function for column naming
deaths <-  read_excel(
    readxl_example("deaths.xlsx"),
    range = "arts!A5:F11",
    .name_repair = "universal"
  )




