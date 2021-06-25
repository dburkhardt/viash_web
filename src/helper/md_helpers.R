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
    gsub("a[ \n]*viash[ \n]*config", "a [viash config](/docs/reference_config/config)", .) %>% 
    gsub("native[ \n]*platform", "[native platform](/docs/reference_config/platform-native)", ., ignore.case=T) %>% 
    gsub("Docker[ \n]*platform", "[Docker platform](/docs/reference_config/platform-docker)", ., ignore.case=T) %>% 
    gsub("custom[ \n]*DSL", "[custom DSL](/docs/advanced/config_mods)", .) %>% 
    gsub("For[ \n]*more[ \n]*information,[ \n]*see[ \n]*the[ \n]*online[ \n]*documentation.", "", .) %>% # We're already in the online docs ;)
    gsub("config[ \n]*mods", "[config mods](/docs/advanced/config_mods/)", .)
}