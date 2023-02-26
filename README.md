# osmscraper
Open Street Map Scraper Data for capturing the environment (shops, squares, trash cans, etc.) around a location


# Dependencies
```r
library(httr)
```

# Usage
```r
# get the function: osm_nearby_locations()
  source("https://raw.githubusercontent.com/SimonRess/osmscraper/main/functions.r")

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

# Settings / Attributes

- **date**: Return results based on the OpenStreetMap database as of the date specified. Can be useful to view an object as it existed in the database at some point in the past.
  - Format: YYYY-MM-DDThh:mm:ssZ (incl. "T" & "C")
  - Example = "2022-10-28T19:20:00Z" # <- Format: YYYY-MM-DDThh:mm:ssZ (incl. "T" & "C")
  - Infos: https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL#Date
- **features**: Features to be extracted
  - List of features: https://wiki.openstreetmap.org/wiki/Map_features <- Use "Key", not "Value" or something else!
  - Example: c("amenity","building","emergency","office","shop")
- **lat**:
  - Example: "51.474785963577936" 
- **lon**:
  - Example: "7.22554295376171"
- **radius**: Radius in meters to be used around a location
  - Example: "150" 
