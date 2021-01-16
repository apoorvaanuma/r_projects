############################### WORKING WITH LEAFLETS AND PIPE OPERATORS#####################################

#Leaflet Map of Alaska Homocides

library(leaflet)
library(dplyr)
library(ggplot2)
library(ggmap)
library(rgdal)
library(htmltools)
library(mapview)
library(htmlwidgets)

library(ggplot2)
library(ggmap)

getwd()

setwd("D:\\Data Analyst\\sample data sets\\r_projects\\R Leaflet\\data")

a <- leaflet()%>% # pipe operator to use value from next function as input to present function and data types should match
  addProviderTiles(providers$Stamen.Toner) 
a

a<- leaflet() %>% # pipe operator to use value from next function as input to present function and data types should match
  addTiles() %>%
  setView(lng= -149.4937, lat = 64.2008, zoom = 4)
a

#Can also be written as follows if dont want to use pipe operators

a <- setView(addTiles(leaflet()),lng= -149.4937, lat = 64.2008, zoom = 4)
a

a<- leaflet() %>%
  addProviderTiles(providers$Stamen.Toner) %>%  # to specify names or use any function from providers package
  setView(lng= -149.4937, lat = 64.2008, zoom = 4)
a

# Installing rgdal to access geo spatial data library

library(rgdal)

counties <- readOGR("tl_2013_02_cousub/tl_2013_02_cousub.shp")

ak_counties <- subset(counties, counties$STATEFP == "02")

# to add county data in map for state of Alaska, changing color and smoothing 

a<- leaflet() %>%
  addProviderTiles(providers$Stamen.Toner) %>%  
  setView(lng= -149.4937, lat = 64.2008, zoom = 4) %>%
  addPolygons(data = ak_counties, color = "#660000", weight =1, smoothFactor = 0.5)
a


#use a different basemap
m <- leaflet(ak_counties) %>%
  addProviderTiles(providers$Thunderforest.Pioneer) %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3)
m

m <- leaflet(ak_counties) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3)
m

m <- leaflet(ak_counties) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3)
m

m <- leaflet() %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 4) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5)
m

#import fbi data

ab_data <- read.csv("database.csv")
ab_data

#filter for Alaska
ak <- filter(ab_data, State == "Alaska")
ak

#missing lat and lon.  We can use geocode to get them, but first need a more complete address.

# Installing package Dplyr to loop querying data

library(dplyr)

ak <- mutate(ak, address = paste(City, State, "United States"))

addresses <- unique(ak$address)

View(addresses)

geocodes <- read.csv("geocodes.csv", header = TRUE)
geocodes

#combine geocodes with address and join to ak data

add_and_coord <- data.frame(address=addresses, 
                            lon = geocodes$lon,
                            lat = geocodes$lat)
add_and_coord

View(add_and_coord)

# to filter any NULL address if present

counter <- 0

while(sum(is.na(add_and_coord$lon))>0 && counter <10) {
  missing_add <- add_and_coord %>% 
  filter(is.na(lon)==TRUE)

addresses <- missing_add$address
geocodes <- geocode(as.character(addresses), source= "Google") # use API key here
add_and_coord <- add_and_coord %>%
  filter(is.ma(lon)==FALSE)

new_address<- data.frame(address= addresses, 
                         lon = geocodes$lon, 
                         lat = geocodes$lat)
add_and_coord <- rbind(add_and_coord, new_address)
counter<- counter+1
}

rm(geocodes, missing_addresses, new_address, counter)

# Merging data frames to add lat and lon

ak_m<- merge(ak, add_and_coord, by = "address")
ak_m


# Add homicides Data to Map ---------------------------------------------------

#let's filter our data so that we're only looking at unsolved murders and manslaughters

ak_unsolved <- ak_m %>%
  filter(Crime.Solved == "No") %>%
  filter(Crime.Type == "Murder or Manslaughter")

View(ak_unsolved)

m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, lat = ak_unsolved$lat)
m


#problem of overlapping markers
#use jitter to add some slight random noise to our coordinates

ak$lon <- jitter(ak$lon, factor = 1)
ak$lat <- jitter(ak$lat, factor = 1)


m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "ffffff",
                   weight = 1,
                   radius = 5,
                   label = ak_unsolved$Year)
m

#note that the label appears blank. this is because Year is an integer, needs to be text.

m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "ffffff",
                   weight = 1,
                   radius = 5,
                   label = as.character(ak_unsolved$Year))
m



#create character vectors in HTML that contain what we want to show in the
#labels

ak_unsolved$label <- paste("<p>", ak_unsolved$City, "</p>",
                           "<p>", ak_unsolved$Month, " ", ak_unsolved$Year, "</p>",
                           "<p>", ak_unsolved$Victim.Sex, ", ", ak_unsolved$Victim.Age, "</p>",
                           "<p>", ak_unsolved$Victim.Race, "</p>",
                           "<p>", ak_unsolved$Weapon, "</p>",
                           sep="")


#map has HTML label but it reads it as plain text.  Need to treat text like HTML code.
m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "gold",
                   weight = 1,
                   radius = 5, 
                   opacity = 0.75,
                   label = ak_unsolved$label)
m


#map has HTML label but it reads it as plain text.  Need to treat text like HTML
#code.  To do this, we use the HTML function from the htmltools package.
m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "gold",
                   weight = 1,
                   radius = 5, 
                   opacity = 0.75,
                   label = lapply(ak_unsolved$label, HTML))
m

#add clustering
m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "gold",
                   weight = 1,
                   radius = 5, 
                   opacity = 0.75,
                   label = lapply(ak_unsolved$label, HTML),
                   clusterOptions =  markerClusterOptions())
m


# Interactive Layers -----------------------------------------


#Show both solved and unsolved cases
ak_solved <- ak_m %>%
  filter(Crime.Solved == "Yes") %>%
  filter(Crime.Type == "Murder or Manslaughter")

#Create label for solved cases
ak_solved$label <- paste("<p>", ak_solved$City, "</p>",
                         "<p>", ak_solved$Month, " ", ak_solved$Year, "</p>",
                         "<p>", ak_solved$Victim.Sex, ", ", ak_solved$Victim.Age, "</p>",
                         "<p>", ak_solved$Victim.Race, "</p>",
                         "<p>", ak_solved$Weapon, "</p>",
                         sep="")


#add checkbox control.
m <- leaflet() %>%
  setView(lng = -149.4937, lat = 64.2008, zoom = 3) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = ak_counties,
              color = "#660000", 
              weight = 1, 
              smoothFactor = 0.5) %>%
  addCircleMarkers(lng = ak_unsolved$lon, 
                   lat = ak_unsolved$lat,
                   color = "gold",
                   weight = 1,
                   radius = 5, 
                   opacity = 0.75,
                   label = lapply(ak_unsolved$label, HTML),
                   group = "Unsolved") %>%
  addCircleMarkers(lng = ak_solved$lon, 
                   lat = ak_solved$lat,
                   color = "blue",
                   weight = 1,
                   radius = 5, 
                   opacity = 0.75,
                   label = lapply(ak_solved$label, HTML),
                   group = "Solved") %>%
  addLayersControl(overlayGroups = c("Unsolved", "Solved"),
                   options = layersControlOptions(collapsed = FALSE))
m


##################### Chloropleths ##################################


#Let's create a chloropleth to show the number of solved and unsolved murders for each state

#Get shapefile for states
states <- readOGR("cb_2016_us_state_500k/cb_2016_us_state_500k.shp")

m <- leaflet() %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = states,
              weight = 1, 
              smoothFactor = 0.5)
m



#We need to calculate our summary stats
us <- ab_data %>%
  mutate(Solved = ifelse(Crime.Solved == "Yes", 1, 0)) %>%
  filter(Crime.Type == "Murder or Manslaughter") %>%
  group_by(State) %>%
  summarise(Num.Murders = n(),
            Num.Solved = sum(Solved)) %>%
  mutate(Num.Unsolved = Num.Murders - Num.Solved,
         Solve.Rate = Num.Solved/Num.Murders)

#line up the states between our data and the shapefile
is.element(us$State, states$NAME)

#rename Rhodes Island
levels(us$State)[40] <- "Rhode Island"

#should now be all true
is.element(us$State, states$NAME)

#now check that all shapefile states are in us data
is.element(states$NAME, us$State)

#we see that we're missing the following: 33, 34, 54, 55, 56
states <- subset(states, is.element(states$NAME, us$State))

#now order the crime stats so that its the same order as the shapefile states
us <- us[order(match(us$State, states$NAME)),]

bins <- c(0.30, 0.40,0.50,0.60,0.70,0.80,0.90, 1.0)
pal <- colorBin("RdYlBu", domain = us$Solve.Rate, bins = bins)

#add our color pallete to our map
m <- leaflet() %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = states,
              fillColor = pal(us$Solve.Rate),
              weight = 1, 
              smoothFactor = 0.5,
              color = "white",
              fillOpacity = 0.8)
m


#add highlight options
m <- leaflet() %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = states,
              fillColor = pal(us$Solve.Rate),
              weight = 1, 
              smoothFactor = 0.5,
              color = "white",
              fillOpacity = 0.8,
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE))
m


labels <- paste("<p>", us$State, "</p>",
                "<p>", "Solve Rate: ", round(us$Solve.Rate, digits = 3), "</p>",
                sep="")

m <- leaflet() %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = states,
              fillColor = pal(us$Solve.Rate),
              weight = 1, 
              smoothFactor = 0.5,
              color = "white",
              fillOpacity = 0.8,
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = lapply(labels, HTML))
m


#add a legend
m <- leaflet() %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(data = states,
              fillColor = pal(us$Solve.Rate),
              weight = 1, 
              smoothFactor = 0.5,
              color = "white",
              fillOpacity = 0.8,
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = lapply(labels, HTML)) %>%
  addLegend(pal = pal, 
            values = us$Solve.Rate, 
            opacity = 0.7, 
            title = NULL,
            position = "topright")
m


#save static version of map
#important to run webshot::install_phantomjs() if haven't already installed phantomjs()
mapshot(m, file ="static_map.png")

#save dynamic version of map
saveWidget(m, file = "dynamic_map.html")


