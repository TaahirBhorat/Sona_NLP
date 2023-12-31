# Install and load the stringi package
#install.packages("stringi")
library(stringi)
setwd("/Users/taahir/Downloads/sona-addresses-1994-2023")
# Function to parse text document into sentences excluding the first line
parse_sentences <- function(file_path) {
  # Read the text and exclude the first line
  text_data <- readLines(file_path)
  text_without_first_line <- paste(text_data[-1], collapse = " ")
  
  # Split the text into sentences and remove empty or whitespace-only strings
  sentences <- unlist(stri_split_boundaries(text_without_first_line, type = "sentence"))
  sentences <- sentences[stri_trim_both(sentences) != ""]
  
  return(sentences)
}

# Initialize an empty dataframe
df <- data.frame(Year = integer(), President = character(), Sentences = character())

# List of provided files
files <- c(
  "2023_Ramaphosa.txt", "2022_Ramaphosa.txt", "2021_Ramaphosa.txt", "2020_Ramaphosa.txt", "2019_Ramaphosa.txt", 
  "2019_Ramaphosa_2.txt", "2018_Ramaphosa.txt", "2017_Zuma.txt", "2016_Zuma.txt", "2015_Zuma.txt", 
  "2014_Zuma.txt", "2014_Zuma_2.txt", "2013_Zuma.txt", "2012_Zuma.txt", "2011_Zuma.txt", "2010_Zuma.txt", 
  "2009_Zuma.txt", "2009_ Motlanthe.txt", "2008_Mbeki.txt", "2007_Mbeki.txt", "2006_Mbeki.txt", 
  "2005_Mbeki.txt", "2004_Mbeki.txt", "2004_Mbeki_2.txt", "2003_Mbeki.txt", "2002_Mbeki.txt", 
  "2001_Mbeki.txt", "2000_Mbeki.txt", "1999_Mandela.txt", "1999_Mandela_2.txt", "1998_Mandela.txt", 
  "1997_Mandela.txt", "1996_Mandela.txt", "1995_Mandela.txt", "1994_Mandela.txt", "1994_deKlerk.txt"
)

# Loop through each file and append to dataframe
for (file in files) {
  # Extract year and president's name from filename
  file_info <- strsplit(file, "_")[[1]]
  year <- as.integer(file_info[1])
  president_name <- gsub(".txt", "", file_info[2])
  
  sentences <- parse_sentences(file)
  
  temp_df <- data.frame(Year = year, President = president_name, Sentences = sentences)
  df <- rbind(df, temp_df)
}

# Print the dataframe
print(df)