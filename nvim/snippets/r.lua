local ls = require('luasnip')
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.i

return {
  s("shinymod", fmt(
    [[
mod_[name]_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(

  )
}

mod_[name]_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

mod_[name]_app <- function() {
  ui <- shiny::fluidPage(
    shiny::titlePanel("[name]"),
    mod_ui("app"),
  )

  server <- function(input, output, sesssion) {
    mod_server("app")
  }
  shiny::shinyApp(ui, server)
}
    ]],
    { name = i(1, "module_name") },
    { delimiters = "[]" }
  ))
}
