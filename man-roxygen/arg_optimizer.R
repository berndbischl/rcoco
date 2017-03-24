#' @param optimizer [\code{function(fn, init, problem, ...)}]\cr
#'   Runs an optimizer on a coco problem, verly likely a mini-wrapper for your optimizer of choice.
#'   \code{fn} is the R function to optimize, with signature \code{function(x)}, where \code{x} is the numeric vector to evaluate at.
#'   \code{init}, a numeric vector, is an initial feasible solution that the optimizer can use to start (or ignore).
#'   \code{problem} is a \code{link{CocoProblem}} that the optimizer can access for box constraints and other info (or ignore).
#'   The dotargs \code{...} are further arguments from above that should be passed on to the optimizer.
