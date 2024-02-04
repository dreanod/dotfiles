if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(tidyverse))
}

options(
  usethis.full_name = "Denis Dreano",
  usethis.description = list(
    "Authors@R" = utils::person(
      "Denis", "Dreano",
      email = "denis.dreano@protonmail.ch",
      role = c("aut", "cre")
    ),
    Version = "0.0.0.9000"
  ),
  usethis.destdir = "~",
  usethis.overwrite = TRUE,
  repos = c(CRAN = "https://stat.ethz.ch/CRAN/")

  # languageserver.server_capabilities = list(
  #   completionProvider = FALSE,
  #   completionItemResolve = FALSE
)

setHook("rstudio.sessionInit", function(newSession) {
  options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
  # options(shiny.launch.browser = .rs.invokeShinyPaneViewer)
}, action = "append")

# utils::assignInNamespace(
#   "q", 
#   function(save = "no", status = 0, runLast = TRUE) 
#   {
#     .Internal(quit(save, status, runLast))
#   }, 
#   "base"
# )
#
