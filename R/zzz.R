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
