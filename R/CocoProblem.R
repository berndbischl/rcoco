#' @title Coco problem object.
#'
#' @description
#'
#' The S3 class is a list which stores these elements:
#' \describe{
#'   \item{id [\code{character(1)}]}{Short id of problem.}
#'   \item{name [\code{character(1)}]}{Longer name of problem.}
#'   \item{nr.of.objectives [\code{integer(1)}}{Number of objectives.}
#'   \item{dimension [\code{integer(1)}}{Dimension of decision space.}
#'   \item{nr.of.constraints [\code{integer(1)}}{Number of constraints.}
#'   \item{lower [\code{numeric}]}{Lower box constraints.}
#'   \item{upper [\code{numeric}]}{upper box constraints.}
#'   \item{extptr}{External pointer to C object of coco problem.}
#' }
#' @name CocoProblem
#' @rdname CocoProblem
NULL

#' @export
print.CocoProblem = function(x, ...) {
  catf("CocoProblem")
  catf("id          : %s", x$id)
  catf("index       : %s", x$index)
  catf("name        : %s", x$name)
  catf("nobj        : %i", x$nr.of.objectives)
  catf("dim         : %i", x$dimension)
  catf("constraints : %i", x$nr.of.constraints)
  catf("lower       : %s", collapse(x$lower))
  catf("upper       : %s", collapse(x$upper))
}

