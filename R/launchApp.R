#' Launch a shiny app
#'
#' @description This function launches a shiny app when executed by the user
#' 
#' @examples 
#' \dontrun{
#' launch_app()
#' }
#'
#' @return A shiny app about coronavirus statistics around the world
#' 
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "Test")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `Test`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}

