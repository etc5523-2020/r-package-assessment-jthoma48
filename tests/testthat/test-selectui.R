test_that("selectui01()", {
  inputId <- "state"
  expect_equal(selectui01(inputId = inputId),
               selectInput(inputId, 
                           label = "Which state would you like to select:",
                           choices = data5$State,
                           selected = filter(data5, State=="Victoria")))
})
