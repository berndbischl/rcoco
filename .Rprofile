# Persistent history for this project
if (interactive()) {
  # Disable colored output for this project, because otherwise
  # in error outputs paths with line-nrs are colored and we cannot ctrl-click on them in vscode
  options(crayon.enabled = FALSE)

  # enable persistent history
  histfile = file.path(getwd(), ".Rhistory") # project-local history
  message(sprintf("Loading history for project at %s", histfile))
  Sys.setenv(R_HISTFILE = histfile, R_HISTSIZE = "100000")
  try(utils::loadhistory(histfile), silent = TRUE)
  # Save after every top-level command to avoid loss on abrupt termination
  if (!exists(".savehist_cb", envir = .GlobalEnv)) {
    .savehist_cb <- function(expr, value, ok, visible) {
      try(utils::savehistory(histfile), silent = TRUE)
      TRUE
    }
    base::addTaskCallback(.savehist_cb, name = "savehistory")
  }

  # autoload devel packages
  devel_packages = c("devtools", "testthat", "roxygen2")
  message(sprintf(
    "Loading devel packages: %s",
    paste(devel_packages, collapse = ", ")
  ))
  lapply(devel_packages, library, character.only = TRUE)
  invisible(TRUE)

  # Define some global settings
  options(width = 150)
}
