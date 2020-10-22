test_that("leafserv()", {
  long <- data5$Long
  lat <- data5$Lat
  state <- data5$State
  expect_equal(leafserv(Long = long, Lat = lat, State = state),
               leaflet(data5) %>% 
                 addTiles() %>% 
                 addCircleMarkers(~Long, ~Lat, popup = ~State, color = "blue", opacity = 0.7) )
})
