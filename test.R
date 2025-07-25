library(devtools)
library(roxygen2)
roxygenize()
load_all()

s = coco_suite("bbob", "year: 2009")
print(suite)
print(str(s))

# ff = coco_fun(s, 1, 2, 1)

# print(str(ff))
# print(ff)

# y = ff$eval(c(1, 2))
# print(y)



