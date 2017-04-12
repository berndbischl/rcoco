#' @title Coco observer object.
#'
#' @description
#' The S3 class is a list which stores these elements:
#' \describe{
#'   \item{observer.name [\code{character(1)}]}{Name of the observer.}
#'   \item{algorithm.name [\code{character(1)}]}{Name of the algorithm interfaced by R.}
#'   \item{algorithm.info [\code{character(1)}]}{Textual description of \code{algorithm.name}.}
#'   \item{number.target.triggers [\code{integer(1)}]}{The number of targets between each 10**i and 10^(i+1)}
#'   \item{number.evaluation.triggers [\code{integer(1)}]}{The number of triggers between each 10**i and 10^(i+1) evaluation number.}
#'   \item{base.evaluation.triggers [\code{integer}]}{Defines the base evaluations used to produce an additional evaluation-based logging.}
#'   \item{precision.x [\code{integer(1)}]}{Output precision for decision variables.}
#'   \item{precision.f [\code{integer(1)}]}{Output precision for function values.}
#'   \item{result.folder [\code{character(1)}]}{Directory for the observer to write the output.}
#'   \item{observer.extptr}{External pointer to C object of coco observer.}
#' }
#' @name CocoObserver
#' @rdname CocoObserver
NULL

#' @export
print.CocoObserver = function(x, ...) {
  catf("CocoObserver")
  catf("observer                  : %s", x$observer.name)
  catf("algorithm                 : %s", x$algorithm.name)
  catf("result.folder             : %s", x$result.folder)
  if (!is.null(x$algorithm.info))
    catf("                            %s", x$algorithm.info)
  catf("number.target.triggers    : %i", x$number.target.triggers)
  catf("number.evaluation.triggers: %i", x$number.evaluation.triggers)
  catf("base.evaluation.triggers  : %s", collapse(x$base.evaluation.triggers))
  catf("precision.x               : %i", x$precision.x)
  catf("precision.f               : %i", x$precision.f)
}
