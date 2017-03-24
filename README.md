# rcoco - R package for COCO and BBOB.

[![Build Status](https://travis-ci.org/berndbischl/rcoco.svg?branch=master)](https://travis-ci.org/berndbischl/rcoco)
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/rcoco)](https://CRAN.R-project.org/package=rcoco)
[![CRAN Downloads](http://cranlogs.r-pkg.org/badges/rcoco)](https://cran.rstudio.com/web/packages/rcoco/index.html)
* [R Documentation in HTML](http://rpackages.ianhowson.com/cran/rcoco/)
* Install the development version

    ```splus
    devtools::install_github("berndbischl/rcoco")
    ```

# General overview

This is an experimental implementation of an R client package for the COCO framework and the BBOB benchmark.

https://github.com/numbbo/coco

It allows benchmarking of continuous black-box optimizers on the BBOB functions. You can later run COCO post-processing for standardized evaluation and plots. The package implements the C API of COCO.

# How to get (newer versions of) coco.c and coco.h

These two files contain the main C code of coco, that we programm against.
They are located in the "src" subfolder. They are created like this:

1. Clone main coco repo
1. Run python do.py build-c from the console
1. Copy coco.{h,c} from code-experiments/build/c/ to the src subdir of this repo




