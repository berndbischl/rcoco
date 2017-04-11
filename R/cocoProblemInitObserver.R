#' @title Init coco observer.
#'
#' @description
#' See title
#' @param observer.name [\code{character(1)}]\cr
#'   Name of observer.
#'   Default is \dQuote{bbob}.
#' @param algorithm.name [\code{character(1)}]\cr
#'   Name of the algorithm.
#'   Default is \dQuote{R_algo}.
#' @param algorithm.info [\code{character(1)}]\cr
#'   Optional description of the algorithm.
#'   Default is the empty character string.
#' @param result.folder [\code{character(1)}]\cr
#'   Directory for the observer to write the output.
#'   If the directory already exists the observer will automatically append \dQuote{-001} to the name.
#'   Default is \dQuote{R_on_<observer.name>}.
#' @return [\code{CocoObserver}].
#' @export
#' @useDynLib rcoco c_cocoInitObserver
cocoInitObserver = function(observer.name = "bbob", algorithm.name = "R_algo", algorithm.info = "", result.folder = paste0("R_on_", observer.name)) {
  #FIXME: checks
  assertString(observer.name)
  assertString(algorithm.name)
  assertString(algorithm.info)
  assertString(result.folder)

  #FIXME: allow other options
  observer.options = sprintf("algorithm_name: %s algorithm_info: %s result_folder: %s", algorithm.name, algorithm.info, result.folder)

  observer = .Call(c_cocoInitObserver, observer.name, observer.options)
  names(observer) = "observer.extptr"
  observer[["result.folder"]] = result.folder
  class(observer) = "CocoObserver"
  return(observer)
}
