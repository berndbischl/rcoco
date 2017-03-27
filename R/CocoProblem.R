#' @title Coco problem object.
#'
#' @description
#'
#' The S3 class is a list which stores these elements:
#' \describe{
#'   \item{id [\code{character(1)}]}{Short id of problem.}
#'   \item{index [\code{integer(1)}]}{Index of problem in suite.}
#'   \item{fun.nr [\code{integer(1)}]}{Function number.}
#'   \item{inst.nr [\code{integer(1)}]}{Instance number.}
#'   \item{name [\code{character(1)}]}{Longer name of problem.}
#'   \item{nr.of.objectives [\code{integer(1)}}{Number of objectives.}
#'   \item{dimension [\code{integer(1)}}{Dimension of decision space.}
#'   \item{nr.of.constraints [\code{integer(1)}}{Number of constraints.}
#'   \item{lower [\code{numeric}]}{Lower box constraints.}
#'   \item{upper [\code{numeric}]}{Upper box constraints.}
#'   \item{initial.solution [\code{numeric}]}{Initial feasible solution.}
#'   \item{extptr}{External pointer to C object of coco problem.}
#' }
#' @name CocoProblem
#' @rdname CocoProblem
NULL

#' @export
print.CocoProblem = function(x, ...) {
  low = x$lower
  upp = x$upper
  # print single nums if bounds are all the same
  if (length(unique(low)) == 1L) 
    low = unique(low)
  if (length(unique(upp)) == 1L) 
    upp = unique(upp)
  catf("CocoProblem")
  catf("id          : %s", x$id)
  catf("name        : %s", x$name)
  catf("index       : %s", x$index)
  catf("function    : %s", x$fun.nr)
  catf("instance    : %s", x$inst.nr)
  catf("nobj        : %i", x$nr.of.objectives)
  catf("dim         : %i", x$dimension)
  catf("constraints : %i", x$nr.of.constraints)
  catf("lower       : %s", collapse(low))
  catf("upper       : %s", collapse(upp))
  catf("init sol    : %s", collapse(x$initial.solution))
}

