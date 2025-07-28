#' @import checkmate
#' @import mlr3misc
#' @import R6
#' @useDynLib rcoco
"_PACKAGE"

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

coco_observers = c(
    "bbob",
    "bbob-biobj",
    "toy"
)

#' Set COCO Log Level
#' 
#' Sets the logging level for COCO operations. Valid levels are "error", "warning", "info", and "debug".
#' 
#' @param log_level A character string specifying the log level. Valid values are "error", "warning", "info", "debug", or "" (empty string to not change the level).
#' @return The previous log level as a character string.
#' @export
coco_set_log_level = function(log_level) {
    assert_choice(log_level, c("error", "warning", "info", "debug", ""))
    .Call("c_coco_set_log_level", log_level)
}

.onLoad = function(libname, pkgname) {
    .Call("c_coco_init_noisy")
}

.onUnload = function(libpath) {
    .Call("c_coco_finit_noisy")
}
