# jhu_tidyverse_course_ch_03
# 20250503

library(tidyverse)

airquality <- as_tibble(airquality)
airquality


## use pivot_longer() to reshape from wide to long
gathered <- airquality %>%
  pivot_longer(everything())

## take a look at first few rows of long data
gathered



## to rename the column names that gather provides,
## change key and value to what you want those column names to be
gathered <- airquality %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value")

## take a look at first few rows of long data
gathered 

## in pivot_longer(), you can specify which variables 
## you want included in the long format
## it will leave the other variables as is
gathered <- airquality %>%
  pivot_longer(c(Ozone, Solar.R, Wind, Temp), 
               names_to = "variable", 
               values_to = "value")

## take a look at first few rows of long data
gathered

## use pivot_wider() to reshape from long to wide
spread_data <- gathered %>%
  pivot_wider(names_from = "variable", 
              values_from = "value")

## take a look at the wide data
spread_data

## compare that back to the original
airquality

#install.packages('janitor')
library(janitor)

#install.packages('skimr')
library(skimr)

## take a look at the data
library(ggplot2)
glimpse(msleep)

# filter to only include primates
msleep %>%
  filter(order == "Primates")

filter(msleep, order == "Primates")

msleep %>%
  filter(order == "Primates", sleep_total > 10)

msleep %>%
  filter(order == "Primates" & sleep_total > 10)

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_total, sleep_rem, sleep_cycle)

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, total = sleep_total, rem = sleep_rem, cycle = sleep_cycle)

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  rename(total = sleep_total, rem = sleep_rem, cycle = sleep_cycle)

# 3.4.4.1 reordering columns
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total)

# 3.4.4.2 reordering rows
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(sleep_total)

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(desc(sleep_total))

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(name)

msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(name, sleep_total)

# 3.4.5 creating new columns
msleep %>%
  filter(order == "Primates", sleep_total > 10) %>%
  select(name, sleep_rem, sleep_cycle, sleep_total) %>%
  arrange(name) %>%
  mutate(sleep_total_min = sleep_total * 60)

# 3.4.6 separating columns
## download file 
conservation <- read_csv("https://raw.githubusercontent.com/suzanbaert/Dplyr_Tutorials/master/conservation_explanation.csv")

## take a look at this file
conservation

conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ")

# 3.4.7 Merging columns
conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ") %>%
  unite(united_col, abbreviation, description, sep = " = ")

conservation %>%
  clean_names()

# 3.4.9 combining data across data frames
## take conservation dataset and separate information
## into two columns
## call that new object `conserve`
conserve <- conservation %>%
  separate(`conservation abbreviation`, 
           into = c("abbreviation", "description"), sep = " = ")


## now lets join the two datasets together
msleep %>%
  mutate(conservation = toupper(conservation)) %>%
  left_join(conserve, by = c("conservation" = "abbreviation"))


# 3.4.10 Grouping Data
msleep

msleep %>%
  group_by(order)


# 3.4.11 Summarizing data

msleep %>%
  # here we select the column called genus, any column would work
  select(genus) %>%
  summarize(N=n())

msleep %>%
  # here we select the column called vore, any column would work
  select(vore) %>%
  summarize(N=n())

nrow(msleep)

msleep %>%
  group_by(order) %>% 
  select(order) %>%
  summarize(N=n())

msleep %>%
  group_by(order) %>% 
  select(order, sleep_total) %>%
  summarize(N=n(), mean_sleep=mean(sleep_total))


# 3.4.11.2 tabyl()
msleep %>%
  tabyl(order)

summary(msleep$awake)

# 3.4.11.3 tally()
msleep %>%
  tally()

msleep %>%
  tally(sleep_total)

msleep %>%
  summarize(sum_sleep_total = sum(sleep_total))

msleep %>%
  pull(sleep_total)%>%
  sum()


# 3.4.11.4 add_tally()
msleep %>%
  add_tally() %>%
  glimpse()

msleep %>%
  add_tally(sleep_total) %>%
  glimpse()

# 3.4.11.5
msleep %>%
  count(vore)

# 3.4.11.7
# identify observations that match in both genus and vore
msleep %>% 
  get_dupes(genus, vore)


# 3.4.11.8 skim()
# summarize dataset
skim(msleep)

# see summary for specified columns
skim(msleep, genus, vore, sleep_total)


# 3.4.11.9 summary()
skim(msleep) %>% 
  summary()

# 3.4.12 operations across columns
airquality %>%
  summarize(across(Ozone:Temp, mean, na.rm = TRUE))

airquality %>%
  filter(!is.na(Ozone),
         !is.na(Solar.R))

airquality %>%
  filter(across(Ozone:Solar.R, ~ !is.na(.)))

airquality %>%
  filter(across(Ozone:Temp, ~ !is.na(.)))

airquality %>%
  mutate(across(Ozone:Temp, ~ replace_na(., 0)))
