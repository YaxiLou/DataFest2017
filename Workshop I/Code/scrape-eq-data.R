## Function which grabs and formats data from SCEC's earthquake catalogs.

## Note: Defaults based on SCEC catalog search defaults (http://service.scedc.caltech.edu/eq-catalogs/date_mag_loc.php)

## Required pacakges
library(readr)
library(lubridate)
library(dplyr)

# Scraping function
scedc_eqs <- function(start_date = (Sys.Date() - 30), end_date = Sys.Date(), event_type = "eq", geographic_type = c("l", "r", "t"), min_mag = -1, max_mag = 9, min_lat = 30, max_lat = 39, min_lon = -124, max_lon = -111, min_depth = -5, max_depth = 700) {
  
  # Scrape all relevant eq catalogs by year
  min_year <- ifelse(start_date < "1932-01-01", 1932, year(start_date))
  max_year <- ifelse(end_date > year(Sys.Date()), year(Sys.Date()), year(end_date))
  years <- min_year:max_year
  catalog_urls <- paste0("https://service.scedc.caltech.edu/ftp/catalogs/SCEC_DC/", years, ".catalog")
  
  yearly_data <- lapply(catalog_urls, read.table, stringsAsFactors = FALSE)
  raw_data <- bind_rows(yearly_data)
  return(raw_data)
}

# Run the function to get the entire earthquake catalog and write it as a eqs.csv
eqs <- scedc_eqs(start_date = "1932-01-01")
write_csv(eqs, path = "Workshop I/Data/eqs.csv")
