load_all()

s = cocoOpenSuite()
p1 = cocoSuiteGetProblem(s, 0)
print(p1)
p2 = cocoSuiteGetNextProblem(s)
print(p2)

