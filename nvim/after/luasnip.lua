local ls = require('luasnip')

ls.config.set_config({
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true
})

-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/luasnip.lua<CR>")
vim.keymap.set("n", "<leader>es", require("luasnip.loaders").edit_snippet_files)
--
-- ls.add_snippets("r", {
--   s("shinymod", fmt(
--     [[
-- mod_[name]_ui <- function(id) {
--   ns <- shiny::NS(id)
--   shiny::tagList(
--
--   )
-- }
--
-- mod_[name]_server <- function(id) {
--   shiny::moduleServer(id, function(input, output, session) {
--     ns <- session$ns
--   })
-- }
--
-- mod_[name]_app <- function() {
--   ui <- shiny::fluidPage(
--     shiny::titlePanel("[name]"),
--     mod_ui("app"),
--   )
--
--   server <- function(input, output, sesssion) {
--     mod_server("app")
--   }
--   shiny::shinyApp(ui, server)
-- }
--     ]],
--     { name = i(1, "module_name") },
--     { delimiters = "[]" }
--   ))
-- })
--
