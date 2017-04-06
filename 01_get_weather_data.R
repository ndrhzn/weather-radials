library(httr)
library(dplyr)
library(plyr)

get_weather_data <- function(start, end, 
                             country = "Ukraine", 
                             city = "Kyiv", 
                             key = "") {
  
  df <- data.frame()
  
  dates <- seq.Date(from = as.Date(start), 
                    to = as.Date(end),
                    by = 1)
  
  dates <-  format(dates, "%Y%m%d")
    
  
  for (i in dates) {
    
    url <- paste0("http://api.wunderground.com/api/",
                  key, "/history_", i, "/q/", country, "/", city, ".json")
    
    print(paste0("Requesting ", url))
    
    request <- GET(url)
    
    if (status_code(request) == 200) {
      
      content <- content(request)$history$observations
      
      content <- plyr::ldply(content, data.frame)
      
      df <- rbind.data.frame(df, content)
      
      Sys.sleep(7)
      
    } else {
      
      return(paste0("Error ", status_code(content)))
      
    }
    
  }
  
  return(df)
  
}
