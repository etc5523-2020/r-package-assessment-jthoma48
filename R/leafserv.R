#' Generate a leaflet map for a country
#'
#' @description This function is used to create a leaflet map using longitude, latitude coordinates and state names from a dataframe. By parsing this information into the leafserv() function, a leaflet map of the desired country will be generated.
#' 
#' @param Long The longitude coordinate of the country.
#' @param Lat The latitude coordinate of the country.
#' @param State The state(s) within the country. This appears as a popup on the map.
#'
#' @return A leaflet map with the outline of the desired country is displayed. On the map, the longitude and latitude coordinates of the states are plotted.
#' 
#' @import leaflet
#' @importFrom magrittr %>%
#' 
#' @examples
#' \dontrun{
#' leafserv(df$Long, df$Lat, df$State)
#' }
#' 
#' @export
leafserv <- function(Long, Lat, State){
  leaflet(data5) %>% 
    addTiles() %>% 
    addCircleMarkers(~Long, ~Lat, popup = ~State, color = "blue", opacity = 0.7)
}
