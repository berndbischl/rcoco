#' @title Get specific coco problem.
#' 
#' @description
#' NB: If the problem index is too large, coco might just issue a warning and return a different
#' problem.
#'
#' @details
#' The following is copied from coco.c:
#'
#'
#' General schema for encoding/decoding a problem index. Note that the index depends on the number of
#' instances a suite is defined with (it should be called a suite-instance-depending index...).
#' Also, while functions, instances and dimensions start from 1, function_idx, instance_idx and dimension_idx
#' as well as suite_dep_index start from 0!
#' 
#' Showing an example with 2 dimensions (2, 3), 5 instances (6, 7, 8, 9, 10) and 2 functions (1, 2):
#' 
#' \preformatted{
#'   index | instance | function | dimension
#'   ------+----------+----------+-----------
#'       0 |        6 |        1 |         2
#'       1 |        7 |        1 |         2
#'       2 |        8 |        1 |         2
#'       3 |        9 |        1 |         2
#'       4 |       10 |        1 |         2
#'       5 |        6 |        2 |         2
#'       6 |        7 |        2 |         2
#'       7 |        8 |        2 |         2
#'       8 |        9 |        2 |         2
#'       9 |       10 |        2 |         2
#'      10 |        6 |        1 |         3
#'      11 |        7 |        1 |         3
#'      12 |        8 |        1 |         3
#'      13 |        9 |        1 |         3
#'      14 |       10 |        1 |         3
#'      15 |        6 |        2 |         2
#'      16 |        7 |        2 |         3
#'      17 |        8 |        2 |         3
#'      18 |        9 |        2 |         3
#'      19 |       10 |        2 |         3
#'
#'   index | instance_idx | function_idx | dimension_idx
#'   ------+--------------+--------------+---------------
#'       0 |            0 |            0 |             0
#'       1 |            1 |            0 |             0
#'       2 |            2 |            0 |             0
#'       3 |            3 |            0 |             0
#'       4 |            4 |            0 |             0
#'       5 |            0 |            1 |             0
#'       6 |            1 |            1 |             0
#'       7 |            2 |            1 |             0
#'       8 |            3 |            1 |             0
#'       9 |            4 |            1 |             0
#'      10 |            0 |            0 |             1
#'      11 |            1 |            0 |             1
#'      12 |            2 |            0 |             1
#'      13 |            3 |            0 |             1
#'      14 |            4 |            0 |             1
#'      15 |            0 |            1 |             1
#'      16 |            1 |            1 |             1
#'      17 |            2 |            1 |             1
#'      18 |            3 |            1 |             1
#'      19 |            4 |            1 |             1
#' }
#'
#' @template arg_suite
#' @param index [\code{integer(1)}]\cr
#'   Problem index. Note that coco indices start at 0!
#' @template ret_problem
#' @export
#' @useDynLib rcoco c_cocoSuiteGetProblem
cocoSuiteGetProblem = function(suite, index) {
  assertClass(suite, "CocoSuite")
  index = asInt(index, lower = 0, upper = suite$nr.of.problems - 1L)
  p = .Call(c_cocoSuiteGetProblem, suite, index)
  createProblem(p)
}


