library(testthat)
library(processx)

# check 1
cat(">>> Checking whether output is correct\n")
out <- processx::run("./md_url_checker_r", c("--inputfile", "Testfile.md", "--domain", "https://viash.io"))
expect_equal(out$status, 0)
expect_match(out$stdout, regexp = "https://www.google.com")
expect_match(out$stdout, regexp = "ERROR! URL cannot be reached")

# check 2
cat(">>> Checking whether output file is correct\n")
output_file <- paste(readLines("output.txt"), collapse="\n")
expect_match(output_file, regexp = "https://www.google.com")
expect_match(output_file, regexp = "ERROR! URL cannot be reached.")
expect_match(output_file, regexp = "Link name: install viash here")

cat(">>> Test finished successfully!\n")
