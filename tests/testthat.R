# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where is this file used?
#   * The testthat package uses this file during testing to ensure
#     that the package is properly loaded and that all
#     dependencies are available.
#
#   * The testthat package uses this file to run the tests in
#     the package's tests/testthat directory.

library(testthat)
library(rcoco)

test_check("rcoco")
