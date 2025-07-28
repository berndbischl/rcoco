test_that("coco_set_log_level works correctly", {
  expect_equal(coco_set_log_level("debug"), "info")  # Default is info
  expect_equal(coco_set_log_level(""), "debug")
  # Reset to default
  coco_set_log_level("info")
})
