# rcoco - R package for COCO and BBOB

[![CRAN Status Badge](http://www.r-pkg.org/badges/version/rcoco)](https://CRAN.R-project.org/package=rcoco)
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/rcoco)](https://cran.rstudio.com/web/packages/rcoco/index.html)
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/ecr?color=orange)](http://cran.rstudio.com/web/packages/rcoco/index.html)
[![Build Status](https://travis-ci.org/berndbischl/rcoco.svg?branch=master)](https://travis-ci.org/berndbischl/rcoco)

This is an experimental implementation of an R client package for the [COCO framework](https://github.com/numbbo/coco) and the BBOB benchmark.

It allows benchmarking of continuous black-box optimizers on the BBOB functions. You can later run COCO post-processing for standardized evaluation and visualization. The package implements the C API of COCO.

## Installation 

The package is not yet released on [CRAN](https://cran.r-project.org). Install the development version via:

```splus
install.packages("devtools")
devtools::install_github("berndbischl/rcoco")
```

## How to get (newer versions of) coco.c and coco.h

These two files contain the main C code of coco, that we programm against.
The package already contains a version of these files. They are located in the "src" subfolder of the R package. However, if you want to use a the current up-to-date version perform the following steps:

1. Clone this repository or download the source files from CRAN. Say it is located in path_to_rcoco
1. Clone the [main coco repository](https://github.com/numbbo/coco)
1. Navigate into the cloned coco repository via `cd coco`
1. Run `python do.py build-c` from the console
1. Copy coco.{h,c} from code-experiments/build/c/ to the path_to_rcoco/src subfolder of this repository and overwrite the existing files
1. Install rcoco from source 

## Contact 

Found some nasty bugs? Please use the [issue tracker](https://github.com/berndbischl/rcoco/issues) for bug reports, questions and feature requests. Pay attention to explain the problem as good as possible. At its best you provide an example, so we can reproduce your problem quickly.

