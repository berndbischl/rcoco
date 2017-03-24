#' @title Set log level for coco platform.
#' 
#' @description
#' See title
#'
#' @param level [\code{character(1)}]\cr
#'   Log level, can be \dQuote{debug}, \dQuote{info}, \dQuote{warn}, \dQuote{error}.
#'   Default is \dQuote{info}.
#' @template ret_invnull
#' @export
#' @useDynLib rcoco c_cocoSetLogLevel
cocoSetLogLevel = function(level = "info") {
  assertChoice(level, c("debug", "info", "warning", "error"))
  .Call(c_cocoSetLogLevel, level)
  invisible(NULL)
}

