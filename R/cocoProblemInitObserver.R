#' @title Init coco observer.
#'
#' @description
#' An observer is basically a wrapper around a \code{\link{CocoProblem}}, which
#' keeps track of the optimization process. In order to use the coco postprocessing
#' functionality an observer is mandatory.
#'
#' @param observer.name [\code{character(1)}]\cr
#'   Name of observer.
#'   Default is \dQuote{bbob}.
#' @param algorithm.name [\code{character(1)}]\cr
#'   Name of the algorithm to be used in output.
#'   Default is \dQuote{R_algo}.
#' @param algorithm.info [\code{character(1)}]\cr
#'   Additional information on the algorithm to be used in output.
#'   Default is the empty character string.
#' @param number.target.triggers [\code{integer(1)}]\cr
#'   The number of targets between each 10**i and 10^(i+1).
#'   Default is 100.
#' @param target.precision [\code{numeric}]\cr
#'   The number of targets between each 10**i and 10^(i+1).
#'   Default is 1e8.
#' @param number.evaluation.triggers [\code{integer}]\cr
#'   The number of triggers between each 10**i and 10^(i+1) evaluation number.
#'   Default is 20.
#' @param base.evaluation.triggers [\code{integer}]\cr
#'   defines the base evaluations used to produce an additional evaluation-based logging.
#'   The numbers of evaluations that trigger logging are every base_evaluation * dimension * (10^i).
#'   Default is \code{c(1, 2, 5)}.
#' @param precision.x [\code{numeric}]\cr
#'   Output precision for decision variables.
#'   Default is 8.
#' @param precision.f [\code{numeric}]\cr
#'   Output precision for function values.
#'   Default is 15.
#' @param result.folder [\code{character(1)}]\cr
#'   Directory for the observer to write the output.
#'   If the directory already exists the observer will automatically append \dQuote{-001} to the name.
#'   Default is \dQuote{R_on_<observer.name>}.
#' @return [\code{CocoObserver}].
#' @export
#' @useDynLib rcoco c_cocoInitObserver
cocoInitObserver = function(observer.name = "bbob",
  algorithm.name = "R_algo", algorithm.info = NULL,
  number.target.triggers = 100L,
  target.precision = 1e8,
  number.evaluation.triggers = 20,
  base.evaluation.triggers = c(1, 2, 5),
  precision.x = 8L,
  precision.f = 15L,
  result.folder = paste0("R_on_", observer.name)
  ) {

  assertChoice(observer.name, c("toy", "bbob")) # LATER: "bbob-biobj", "bbob-biobj-ext", "bbob-largescale"
  assertString(algorithm.name)
  assertString(algorithm.info, null.ok = TRUE)
  assertString(result.folder)
  assertNumber(target.precision, lower = 0, finite = TRUE)

  observer.options = list(
    number.target.triggers = asInt(number.target.triggers, lower = 1L),
    target.precision = target.precision,
    number.evaluation.triggers = asInt(number.evaluation.triggers, lower = 1L),
    base.evaluation.triggers = asInteger(base.evaluation.triggers, lower = 1L, min.len = 1L, any.missing = FALSE, all.missing = FALSE),
    precision.x = asInt(precision.x, lower = 0L),
    precision.f = asInt(precision.f, lower = 0L),
    result.folder = result.folder,
    algorithm.name = algorithm.name,
    algorithm.info = algorithm.info
  )

  observer.options2 = observer.options
  observer.options2 = BBmisc::filterNull(observer.options2)
  # e.g., algorithm.name here, algorithm_name in C coco
  names(observer.options2) = gsub("\\.", "\\_", names(observer.options2))
  #FIXME: ugly! do we have something to collapse a named list in BBmisc?
  observer.options2 = collapse(sapply(names(observer.options2), function(option.name) {
    sprintf("%s: %s", option.name, collapse(observer.options2[[option.name]]))
  }), sep = " ")

  observer = .Call(c_cocoInitObserver, observer.name, observer.options2)
  names(observer) = "observer.extptr"
  observer = c(observer, observer.options)
  class(observer) = "CocoObserver"
  return(observer)
}
