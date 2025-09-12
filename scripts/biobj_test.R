library(rcoco)
library(R6)
library(checkmate)
library(mco)

source("R/coco_problem.R")
source("R/coco_suite.R")
source("R/zzz.R")

suite = CocoSuite$new(
  name = 'bbob-biobj',
  instance = 'year: 2009',
  # observer_name = 'bbob',
  # observer_options = paste(
  #  'result_folder: my_results',
  #  'algorithm_name: RandomSearch',
  #  'algorithm_info: "Random search implementation in R"',
  #  'record_time: 1',
  #  sep = " "
  # )
)

num_problems = nrow(suite$data)

biobj_search = function(problem) {
  cat(sprintf("Optimizing %s.", problem$name))
  dimension = problem$dim
  lower_bounds = problem$lower
  upper_bounds = problem$upper

  eval_fn = function(x) {
    if (is.matrix(x)) {
      # Handle matrix input (multiple individuals)
      result = matrix(NA, nrow = nrow(x), ncol = 2)
      for (i in 1:nrow(x)) {
        result[i, ] = problem$eval(x[i, ])
      }
      return(result)
    } else {
      # Handle vector input (single individual)
      return(problem$eval(x))
    }
  }

  result = nsga2(
    fn = eval_fn,
    idim = dimension,
    odim = 2,
    lower.bounds = lower_bounds,
    upper.bounds = upper_bounds,
    popsize = 100,
    generations = 50,
  )
  plot(result)
}

for (i in 1:num_problems) {
  problem = CocoProblem$new(suite = suite, problem_idx = i - 1)
  biobj_search(problem)
  problem$finalize()
}
