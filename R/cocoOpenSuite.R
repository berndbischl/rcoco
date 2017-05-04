#' @title Open a coco problem suite.
#'
#' @description
#' Must be called before problems can be accessed.
#' For further info on suites, instances and options please see \url{http://numbbo.github.io/coco-doc/C/}.
#'
#' The suite contains a collection of problems constructed by a Cartesian product of the suite's
#' optimization functions, dimensions and instances. The functions and dimensions are defined by the
#' suite name, while the instances are defined with the \code{instances} parameter.
#' The suite can be filtered by specifying functions, dimensions and instances.
#'
#FIXME: this should be unit tested
#' If both year and instances appear in the \code{suite.instance} string, only the first one
#' is taken into account.
#' If no \code{suite.instance} is given, it defaults to the year of the current BBOB workshop.
#'
#'
#FIXME: the next sentence seems wrong?
#' If both dimensions and dimension_indices appear in the \code{suite.options} string,
#' only the first one is taken into account.
#'
#' @param name [\code{character(1)}]\cr
#'   Name of coco problem suite.
#'   Default is \dQuote{bbob}.
#' @param result.folder [\code{character(1)}]\cr
#'   Prefix for the folder the actual coco output is written to.
#' @param year [\code{integer(1)}]\cr
#'   Year of the corresponding BBOB workshop, defining the instances used in that year's benchmark.
#'   Default is 2017.
#' @param instances [\code{integer}]\cr
#'   Instances for the suite, starting from 1.
#'   Default is all instances chosen in BBOB in \code{year}.
#' @param dims [\code{integer}]\cr
#'   Selected dimensions.
#'   Default is all.
#' @param dim.inds [\code{integer}]\cr
#'   Selected dimension indices to keep in the suite, starting from 1.
#'   Default is all.
#' @param fun.inds [\code{integer}]\cr
#'   Selected function indices to keep in the suite, starting from 1.
#'   Default is all.
#' @param inst.inds [\code{integer}]\cr
#'   Selected instance indices to keep in the suite, starting from 1.
#'   Default is all.
# @param observer.name [\code{character(1)}]\cr
#   Name of observer.
#   Default is \dQuote{bbob}.
# @param result.folder [\code{character(1)}]\cr
#   Directory for the observer to write the output.
#   If the directory already exists the observer will automatically append \dQuote{-001} to the name.
#   Default is \dQuote{R_on_<name>}.

#' @return [\code{\link{CocoSuite}}].
#' @export
#' @useDynLib rcoco c_cocoOpenSuite
cocoOpenSuite = function(name = "bbob", result.folder = "exdata/", year = 2017L, instances = NULL, dims = NULL,
  dim.inds = NULL, fun.inds = NULL, inst.inds = NULL) {
  assertString(name)
  assertString(result.folder)
  mycheck = function(x, key) {
    if (is.null(x)) {
      s = ""
    } else {
      x = asInteger(x, lower = 1L, any.missing = FALSE)
      s = sprintf("%s: %s ", key, collapse(x))
    }
    list(vals = x, string = s)
  }
  zy = mycheck(year, "year")
  zinsts = mycheck(instances, "instances")
  zdims = mycheck(dims, "dimensions")
  zdi = mycheck(dim.inds, "dimension_indices")
  zfi = mycheck(fun.inds, "function_indices")
  zii = mycheck(inst.inds, "instance_indices")
  #assertPathForOutput(result.folder, overwrite = TRUE)
  suite.instance = sprintf("%s%s", zy$string, zinsts$string)
  suite.options = sprintf("%s%s%s%s", zdims$string, zdi$string, zfi$string, zii$string)
  s = .Call(c_cocoOpenSuite, name, suite.instance, suite.options)#, result.folder)
  names(s) = c("suite.extptr", "nr.of.problems") #"observer.extptr",
  class(s) = "CocoSuite"
  s$name = name
  s$instances = zinsts$vals
  s$dims = zdims$vals
  s$dim.inds = zdi$vals
  s$fun.inds = zfi$vals
  s$inst.inds = zii$vals
  s$result.folder = result.folder
  return(s)
}
