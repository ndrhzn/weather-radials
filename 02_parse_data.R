library(dplyr)
library(lubridate)

parse_data <- function(directory = "data/") {
  
  files = list.files(directory, full.names = TRUE)
  
  data = data.frame(stringsAsFactors = FALSE)
  
  for (file in files) {
    
    df = read.csv(file, stringsAsFactors = FALSE, na.strings = '-9999')
    
    df = df %>% 
      select(date.year:date.mday, tempm) %>% 
      mutate(date = paste(date.year, date.mon, date.mday, sep = "-")) %>% 
      select(date, tempm)
    
    data = rbind.data.frame(data, df)
    
    
  }
  
  data$date <- as.Date(data$date)
  
  return(data)
   
}