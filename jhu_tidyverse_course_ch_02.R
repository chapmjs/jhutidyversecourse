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

# application: load excel data from Kunzler data or CHristensen data

# 2.3.2 Google Sheets

# install.packages("googlesheets4")
# load package
library(googlesheets4)
gs4_auth()
# list all sheets - gs4_find()

# read Google Sheet into R with URL
survey_sheet <- read_sheet("https://docs.google.com/spreadsheets/d/1FN7VVKzJJyifZFY5POdz_LalGTBYaC4SLB-X9vyDnbY/edit?gid=0#gid=0", sheet=2)

## 2.4.2 Reading CSVs into R
## install.packages("readr")
library(readr)

## read CSV into R
df_csv <- read_csv("sample_data - Sheet1.csv")

## look at the object
head(df_csv)


# 2.10 Relational Databases sql

## install and load packages
## this may take a minute or two
## install.packages("RSQLite")
library(RSQLite)

## Specify driver
sqlite <- dbDriver("SQLite")

## Connect to Database
db <- dbConnect(sqlite, "company.db")

## List tables in database
dbListTables(db)


## 2.10.4 Working with relational data: dplyr & dbplyr
## install and load packages
# install.packages("dbplyr")
library(dbplyr)
library(dplyr)

## get two tables
albums <- tbl(db, "albums")
artists <- tbl(db, "artists")

## do inner join
inner <- inner_join(artists, albums, by = "ArtistId")

## look at output as a tibble
as_tibble(inner)


## do left join
left <- left_join(artists, albums, by = "ArtistId")

## look at output as a tibble
as_tibble(left)


## do right join
right <- right_join(as_tibble(artists), as_tibble(albums), by = "ArtistId")

## look at output as a tibble
as_tibble(right)


## do right join
full <- full_join(as_tibble(artists), as_tibble(albums), by = "ArtistId")

## look at output as a tibble
as_tibble(full)

semi_join(artists, albums)
anti_join(artists, albums)

# 2.10.7 How to connect to a Database Online
## install.packages("RMySQL")
## sudo apt install libmysqlclient-dev

library(RMySQL)
con <- DBI::dbConnect(RMySQL::MySQL(), 
                      host = "mexico.bbfarm.org",
                      dbname = "chapmjs_redcat",
                      user = "chapmjs_chapmjs",
                      password = rstudioapi::askForPassword("database_password")
)

result <- dbGetQuery(con, "SELECT * FROM customer;")
head(result)



# 2.11.3.2 Using rvest

## load package
# install.packages("rvest")
library(rvest) # this loads the xml2 package too!

## provide URL
packages <- read_html("http://jhudatascience.org/stable_website/webscrape.html") # the function is from xml2

## Get Packages
packages %>% 
  html_nodes("strong") %>%
  html_text() 



# 2.12.2.2 API request GET()

## load package
library(httr)
library(dplyr)

## Save GitHub username as variable
username <- 'janeeverydaydoe'

## Save base endpoint as variable
url_git <- 'https://api.github.com/'

## Construct API request
api_response <- GET(url = paste0(url_git, 'users/', username, '/repos'))


## See variables in response
names(api_response)

## Check Status Code of request
api_response$status_code

## Extract content from API response
repo_content <- content(api_response)


## function to get name and URL for each repo
lapply(repo_content, function(x) {
  df <- data_frame(repo = x$name,
                   address = x$html_url)}) %>% 
  bind_rows()


# 2.14.0.1 Reading images in R

# install.packages("magick")
# sudo apt install libmagick++-dev

# install.packages("tesseract")
# sudo apt install libleptonica-dev
# sudo apt install libtesseract-dev
# sudo apt install tesseract-ocr
# sudo apt install libpoppler-cpp-dev

library(tesseract)

# load package
library(magick)

img1 <- image_read("https://ggplot2.tidyverse.org/logo.png")
img2 <- image_read("https://pbs.twimg.com/media/D5bccHZWkAQuPqS.png")
#show the image
print(img1)

#concatenate and print text
cat(image_ocr(img2))
