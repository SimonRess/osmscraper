# osmscraper
Open Street Map Scraper Data for capturing the environment (shops, squares, trash cans, etc.) around a location


# Dependencies
```r
library(httr)
```

# Usage
```r
# get the function: osm_nearby_locations()
  source()

#test run with predefined attributes
  test = osm_nearby_locations()
  test

#use other attributes
  test2 = osm_nearby_locations(date = "2018-10-01T19:20:00Z", 
                           features = c("office","shop"),
                           lat = "51.446293",
                           lon = "7.075611",
                           radius = "200")
  test2
```
