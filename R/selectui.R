#' Simplify repetitive calls for selectInputs in the user interface-side of a shiny app
#' 
#' @description This function is used to display a drop-down list of options for a user to select either states/countries to visualize coronavirus statistics. The options to select from come from data2, data3 and data5.
#' 
#' @aliases selectui02 selectui03
#' 
#' @param inputId An id name that is unique in the user interface-side in order for the server side of the shiny app to call on.
#' 
#' @return A selectInput option
#' 
#' @importFrom shiny selectInput
#' @importFrom dplyr filter
#' 
#' @examples 
#' \dontrun{
#' inputId <- "state"
#' selectui01("state")
#' }
#' \dontrun{
#' inputId <- "country"
#' selectui03("country")
#' }
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