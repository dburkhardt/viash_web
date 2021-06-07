print_file <- function(path, path_text = path, format = "bash", show_filename = TRUE) {
  code <-
    readLines(path, warn = FALSE) %>%
    paste0(collapse = "\n")

  if (show_filename) {
    markdown <- paste0(

      "Contents of [`", path_text, "`](", path, "):\n",
      "```", format, "\n",
      code, "\n",
      "```"
    )
  }
  else {
    markdown <- paste0(
      "```", format, "\n",
      code, "\n",
      "```"
    )
  }


  knitr::asis_output(markdown)
}


# Detects certain combinations of words in generated texts and replaces them with links to documentation pages.
# Heavily used in the command pages.
detect_links <- function(x) {
  x %>% 
    gsub("the[ \n]*config", "the [viash config](/docs/reference_config/config)", .) %>% 
    gsub("config[ \n]*mods", "[config mods](/docs/reference_config/config_mods/)", .)
}