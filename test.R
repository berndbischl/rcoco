library(devtools)
library(roxygen2)
roxygenize()
load_all()

# s = CocoSuite$new("bbob", "year: 2009")
s = CocoSuite$new("bbob-biobj", "year: 2009")
  expect_true(inherits(s, "CocoSuite"))
  expect_equal(s$name, "bbob-biobj")

print(s)

#p = CocoProblem$new(s, 1)

#print(p)
#print(p$eval(c(1, 2)))

# ff = coco_fun(s, 1, 2, 1)

# print(str(ff))
# print(ff)

# y = ff$eval(c(1, 2, 3, 4, 5))
# print(y)



