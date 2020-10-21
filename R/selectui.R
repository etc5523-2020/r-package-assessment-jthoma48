#' Create functions to simplify repetitive calls for selectInputs in the user interface-side of a shiny app
#' 
#' @aliases selectui02 selectui03
#' 
#' @return A selectInput option
#' 
#' @examples 
#' inputId <- state
#' selectui01("state")
#' inputId <- countriesp
#' selectui02("countriesp")
#' inputId <- country
#' selectui03("country")
#' 
#' @param inputId An id that is unique in the user interface-side in order for the server side of the shiny app to call on.
#'
#' @importFrom shiny selectInput
#' @importFrom dplyr filter
#' 
#' @export
selectui01 <- function(inputId) {
  selectInput(inputId, 
              label = "Which state would you like to select:",
              choices = data5$State,
              selected = filter(data5, State=="Victoria"))
}

#' @export
selectui02 <- function(inputId) {
  selectInput(inputId,
              label = "Please select a country:",
              choices = data2$Country,
              selected = filter(data2, Country=="Mozambique"))
}

#' @export
selectui03 <- function(inputId) {
  selectInput(inputId, 
              label = "Which country's coronavirus statistics do you want to see?", 
              choices = data3$Country,
              selected = filter(data3, Country=="Angola"))
}