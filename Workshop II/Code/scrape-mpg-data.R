library(readr)
library(rio)

cars <- import("https://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip")
emissions <- import("https://www.fueleconomy.gov/feg/epadata/emissions.csv.zip")

write_csv(cars, path = "Workshop II/Data/cars.csv")
write_csv(emissions, path = "Workshop II/Data/emissions.csv")
