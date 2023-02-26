require("httr")

#attributes:
  #date = "2022-10-28T19:20:00Z" # <- Format: YYYY-MM-DDThh:mm:ssZ (incl. "T" & "C") -> https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL#Date
  #features = c("amenity","building","emergency","office","shop") # List of features: https://wiki.openstreetmap.org/wiki/Map_features
  #lat = "51.474785963577936"  # lat =51.474785963577936 & lon =7.22554295376171 => Unistr.61
  #lon = "7.22554295376171"
  #radius = "150" # in meter
  #overpass_base_url = "https://lz4.overpass-api.de/api/interpreter" # alternative: "https://overpass-api.de/api/interpreter"
  
  
#build query:
  #  osmcsv <- '[out:csv(::id,::lat,::lon,"name","amenity","shop"; true; ";")][date:"2022-10-28T19:20:00Z"];
  #  node(around: 150, 51.474785963577936, 7.22554295376171);
  #  out meta;'
  
#define function:
  osm_nearby_locations = function(date = "2022-10-28T19:20:00Z", 
                                  features = c("amenity","building","emergency","office","shop"),
                                  lat = "51.474785963577936",
                                  lon = "7.22554295376171",
                                  radius = "150",
                                  overpass_base_url = "https://lz4.overpass-api.de/api/interpreter") {
    
    for(f in features) {
      query = paste0('[out:csv(::id,::lat,::lon,"name","',f,'"; true; "|")][date:"',date,'"];
      node["',f,'"](around: ',radius,', ',lat,', ',lon,');
      out meta;')
      
      
      cat("Downloading nodes: '", f, "'\n", sep="")
      res <- httr::POST(overpass_base_url, body = query)
      res = content(res, as = "text", encoding = "UTF-8")
      res = read.delim(text = res, sep="|", header=TRUE)
      if(length(res>0)){
        res$type = f
        paste(names(res))
        names(res) = c("id", "lat", "lon", "name", "subtype", "type")
        res = res[, c("id", "lat", "lon", "name", "type", "subtype")]
        res$dist = apply(cbind(res$lat, res$lon), 1, \(x) distm(c(as.numeric(lat),as.numeric(lon)), c(x[1], x[2]), fun = distHaversine))
        
        cat("adding data\n", sep="")
        if(!exists("output")) output = res else output = rbind(output, res)
        rm(res)
      } else cat("No data available for nodes: '", f, "'\n", sep="")
    }   
    
    return(output)
  }
  
  
  
#tests
  #test = osm_nearby_locations(date = "2021-10-28T19:20:00Z", 
  #                         features = c("amenity","building","emergency","office","shop"),
  #                         lat = "51.474785963577936",
  #                         lon = "7.22554295376171",
  #                         radius = "150")
  
  #test
