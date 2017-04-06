library(dplyr)
source("02_parse_data.R")


summarise_data <- function(dir = 'data/') {
  
  df <- parse_data(directory = dir)
  
  df <- df %>% 
    group_by(date) %>% 
    summarise(mint = min(tempm, na.rm = T), 
              maxt = max(tempm, na.rm = T), 
              meant = mean(tempm, trim = 1, na.rm = T))
  
  
  return(df)
  
}

