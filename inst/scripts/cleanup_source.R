library(stringi)

fn = file.path("src", "coco.c")
x = stri_trim_right(readLines(fn))
x = c(
  "#include <R.h>", 
  "#define rprintf_stdout(fmt, ...) Rprintf(fmt, ##__VA_ARGS__);", 
  "#define rprintf_stderr(fmt, ...) REprintf(fmt, ##__VA_ARGS__);", 
  x
)

x = stri_replace_all_regex(x, "v?fprintf\\((stdout|stderr)[[:space:]]*,[[:space:]]*", "rprintf_$1(")
x = stri_replace_all_fixed(x, "exit(", "error(\"Error no %i\", ")
x = x[!stri_detect_fixed(x, "fflush(stdout);")]

writeLines(x, con = fn)
