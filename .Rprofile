if (interactive()) {
  suppressMessages(require(devtools))
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
  repos = c(CRAN = "https://stat.ethz.ch/CRAN/"),

  tibble.width = Inf,

  width = 140
)

setHook("rstudio.sessionInit", function(newSession) {
  options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
}, action = "append")
