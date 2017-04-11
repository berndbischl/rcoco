#' @title Wrap coco problem with coco observer.
#'
#' @description
#' See title
#'
#' @template arg_problem
#' @template arg_observer
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoProblemAddObserver
cocoProblemAddObserver = function(problem, observer) {
  assertClass(problem, "CocoProblem")
  assertClass(observer, "CocoObserver")

  p = .Call(c_cocoProblemAddObserver, problem, observer)
  makeCocoProblem(p)
}
