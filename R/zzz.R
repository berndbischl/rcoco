#' @import checkmate
#' @import mlr3misc
#' @import R6
#' @useDynLib rcoco
"_PACKAGE"

#' @title COCO Suites
#' 
#' @description
#' List of available COCO suites.
#' 
#' @export
coco_suites = c(
  "bbob",
  "bbob-biobj",
  "bbob-biobj-ext",
  "bbob-noisy",
  "bbob-largescale",
  "bbob-mixint",
  "bbob-biobj-mixint",
  "bbob-constrained"
)

#' @title COCO Observers
#' 
#' @description
#' List of available COCO observers.
#' 
#' @export
coco_observers = c(
  "bbob",
  "bbob-biobj",
  "toy"
)

#' @title Set COCO Log Level
#'
#' @description
#' Sets the logging level for COCO operations. 
#'
#' @param log_level `[character(1)]`\cr
#'   A character string specifying the log level. 
#'   Valid values are "error", "warning", "info", "debug", or "" (empty string to not change the level).
#' @return `[character(1)]`\cr 
#'   The previous log level as a character string.
#' @export
coco_set_log_level = function(log_level) {
  assert_choice(log_level, c("error", "warning", "info", "debug", ""))
  .Call("c_coco_set_log_level", log_level)
}

# .onLoad = function(libname, pkgname) {
#     .Call("c_coco_init_noisy")
# }

# .onUnload = function(libpath) {
#     .Call("c_coco_finit_noisy")
# }
