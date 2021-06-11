setwd(par$viash_docs)

# start docker daemon
system("dockerd", ignore.stdout = TRUE, ignore.stderr = TRUE, wait = FALSE)

# Rmd files under the root directory
rmds <- c(
  list.files("content_raw/", '[.]Rmd$', recursive = TRUE, full.names = TRUE)
)

# get corresponding mds
mds <- gsub("content_raw/", "content/", blogdown:::with_ext(rmds, '.md'))


for (i in seq_along(rmds)) {
  rmd <- rmds[[i]]
  md <- mds[[i]]

  # if output is not older than input, skip the compilation
  if (par$force || blogdown:::require_rebuild(md, rmd)) {
    message('* knitting ', rmd)

    if (file.exists(md)) {
       before <- readLines(md)
    } else {
       before <- ''
    }

    
    rmarkdown::render(
      input = rmd,
      output_file = basename(md),
      output_dir = dirname(md),
      output_format = rmarkdown::md_document(
        variant = "gfm",
        preserve_yaml = TRUE
      )
    )
    after <- readLines(md)

    # if only the date has changed,
    # revert changes
    if (
      !par$dont_revert &&
      length(before) == length(after) &&
      sum(before != after) == 1 &&
      grepl("^lastmod: ", before[before != after])
    ) {
      writeLines(before, md)
    }
  }
}

message('DONE!')
