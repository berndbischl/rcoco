#' @param optimizer [\code{function(fn, problem, ...)}]\cr
#'   Runs an optimizer on a coco problem, verly likely a mini-wrapper for your optimizer of choice.
#'   \code{fn} is the R function to optimize, with signature \code{function(x)}, where \code{x} is the numeric vector to evaluate at.
#'   \code{problem} is a \code{link{CocoProblem}} that the optimizer can access for box constraints, initial solution and other info (or ignore).
#'   The dotargs \code{...} are further arguments from above that should be passed on to the optimizer.
