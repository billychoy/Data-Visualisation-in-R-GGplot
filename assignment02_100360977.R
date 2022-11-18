# Package names
packages <- c("canlang", "readxl", "repurrrsive", "testthat", "tidyverse", "openxlsx", "readr")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading-------------------------------------------------"
invisible(lapply(packages, library, character.only = TRUE))

library(canlang)
library(readxl)
library(repurrrsive)
library(testthat)
library(tidyverse)
library(openxlsx)
library(readr)
options(repr.matrix.max.rows = 10)

##Exercise 1: Reading data into R ----------------------------------------------"
#Read worksheet named data from abbotsford_lang.xlsx file
abbotsford <- read_excel("abbotsford_lang.xlsx", sheet="data")

#Read calgary csv
calgary <- read_csv("calgary_lang.csv")

##Read worksheet named data from github
edmonton = read.xlsx("https://github.com/ttimbers/canlang/blob/master/inst/extdata/edmonton_lang.xlsx?raw=true", sheet="data")

# Skip first seven rows from kelowna_lang.csv, add colName when reading the file content and save into dataframe
colName = c("category","language","mother_tongue","most_at_home","most_at_work","lang_known")
kelowna <- read_csv2("kelowna_lang.csv", skip=7, col_names = colName)

#Read vancouver csv
vancouver <- read_csv("vancouver_lang.csv")

# reading a TSV file direct from github
victoria = read_tsv(file = "https://github.com/ttimbers/canlang/raw/master/inst/extdata/victoria_lang.tsv")
##[END] Exercise 1: Reading data into R ---------------------------------------"


##Exercise 2: Data wrangling with {dplyr}--------------------------------------"
#Install canlang
Sys.setenv(PATH=paste("C:\\rtools40\\usr\\bin", Sys.getenv("PATH"), sep=";"))
write('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', file = "~/.Renviron", append = TRUE)
Sys.which("make")
install.packages("devtools")

#Call canlang library
library(canlang)
library('dplyr')

#Use pipe to select language is Mandarine and apply decsending order on Most at home with top 5 rows
mandarin <- region_lang %>% 
  filter(language == "Mandarin") %>%
  slice_max(most_at_home, n=5) 

# Slice row 2, column 1 out from madarin dataset
mandarin1 <- mandarin[2,1]
 
# filter out the value from mandarin1 and store as mandaring2
mandarin2 <- filter(mandarin1)$region

# Check datatype and length
typeof(mandarin2)
length(mandarin2)
##[END] Exercise 2: Data wrangling with {dplyr}--------------------------------"


##Exercise 3: More data wrangling with {dplyr} --------------------------------"
# Find top 5 language use at home in Vancouver
van_top5lang <- region_lang %>% 
  filter(region == "Vancouver") %>%
  slice_max(most_at_home, n=5) 

#Find the Vancouver population
vanPop <- region_data%>% filter(region == "Vancouver")

#Save language from van_top5lang table
language <- van_top5lang$language

# Create prec_pop apply calculation on most_at_home over population
# covert into percentage with 2 decimal places for display
prec_pop <- round((van_top5lang$most_at_home/vanPop$population)*100,2)

# Create data frame with language and prec_pop variables and view the results
result <- data.frame(language, prec_pop)
View(result)
##[END] Exercise 3: More data wrangling with {dplyr} --------------------------"


##Exercise 4: Tidying data with {tidyr} ---------------------------------------"
#Read departure_bay_temperature csv
tidy <- read_csv("departure_bay_temperature.csv", skip = 2)

#Check is Null, no null data is dataset
is.null(tidy)

#Check NAs, there are number of NA appearance in the dataset
is.na(tidy)

#We drop those data as we cannot study the changes on NA data
# 13 rows dropped
tidy1 <- drop_na(tidy)
tidy1$Year <- as.factor(tidy1$Year)

temps_tidy <- tidy1
  
#Plot the monthly trend graph
ggplot(temps_tidy, aes(x = Year, y = Jan, group = 1)) + geom_line(color = "#00AFBB", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Feb, group = 1)) + geom_line(color = "#800080", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Mar, group = 1)) + geom_line(color = "#00008B", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Apr, group = 1)) + geom_line(color = "#BCC6CC", size = 2)
ggplot(temps_tidy, aes(x = Year, y = May, group = 1)) + geom_line(color = "#ADD8E6", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Jul, group = 1)) + geom_line(color = "#07FFD4", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Aug, group = 1)) + geom_line(color = "#00FF00", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Sep, group = 1)) + geom_line(color = "#969083", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Oct, group = 1)) + geom_line(color = "#7FFFD4", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Nov, group = 1)) + geom_line(color = "#FF80AA", size = 2)
ggplot(temps_tidy, aes(x = Year, y = Dec, group = 1)) + geom_line(color = "#C4AEAD", size = 2)
##[END] Exercise 4: Tidying data with {tidyr}    ------------------------------"


##Exercise 5: Tidying more data with {tidyr} ----------------------------------"
langDev <- read.csv("language_diversity.csv", sep="\t")

#Rearrange langDev on Continent column
arrange(langDev, Continent)

# Use pipe to convert rows into columns
tidy_lang <- langDev %>%
  spread(key =  "Measurement",
         value = "Value")
 
#Create scatterplot with Langs against Population, use country as legend
ggplot(tidy_lang, aes(x = Langs, y = Population)) +
  geom_point(aes(color = Country))
##[END] Exercise 5: Tidying more data with {tidyr} ----------------------------"


##Exercise 6: Subsetting with base R ------------------------------------------"
# Create a matrix with 60 random generation from the exponential distribution and form results in 5 rows
small_matrix<-matrix(rexp(60),nrow=5)
small_matrix
 
##[END] Exercise 6: Subsetting with base R ------------------------------------"


