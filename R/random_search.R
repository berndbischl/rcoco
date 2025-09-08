library(rcoco)
library(R6)
library(checkmate)

source("R/coco_problem.R")
source("R/coco_suite.R")
source("R/zzz.R")

suite <- CocoSuite$new(name = 'bbob', instance = 'year: 2009')

num_problems <- nrow(suite$data)

random_search <- function(problem, max_evaluations) {
  cat(sprintf("Optimizing %s with target value %.6f.\n", problem$name, problem$target))
  dimension <- problem$dim
  lower_bounds <- problem$lower
  upper_bounds <- problem$upper
  best_value <- Inf
  best_solution <- NULL
  evaluations <- 0
  while (evaluations < max_evaluations) {
    solution <- runif(dimension, lower_bounds, upper_bounds)
    value <- problem$eval(solution)
    ver = problem$ver()
    print(ver)
    readline()
    if (value < best_value) {
      best_value <- value
      best_solution <- solution
    }
    evaluations <- evaluations + 1
    if (evaluations %% 10 == 0) {
      cat(sprintf("Evaluation %d done. Best value is %.6f so far.\n", evaluations, best_value))
    }
  }
  print("Best solution:")
  print(best_solution)
  print("Best value:")
  print(best_value)
}

for (i in 1:num_problems) {
  problem <- CocoProblem$new(suite = suite, problem_idx = i - 1)
  random_search(problem, 100)
  readline()
}
