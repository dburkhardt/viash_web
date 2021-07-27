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

extract_help_from_command <- function(command) {
  out <- processx::run("viash", c(command, "-h"))
  txt <- out$stdout %>% strsplit("\n") %>% first()

  return(txt)
}

extract_description_from_help <- function(txt) {
out <- txt[seq(
  2,
  grep("^Usage:", txt)-2
)] %>% gsub("^viash ", "# viash ", .) %>% 
  detect_links 

return(out)
}

extract_usage_from_help <- function(txt) {
  out <- txt[seq(
  grep("^Usage:", txt)+1,
  grep("^Arguments:", txt)-2
)] %>% 
  {paste0("```bash\n", paste(str_trim(.),collapse = "\n"),"\n```\n")} %>% 
  detect_links

  return(out)
}

extract_arguments_from_help <- function(txt) {
  trail <- grep("^ trailing arguments:", txt)
  if (length(trail) == 0) trail <- length(txt)+1
  out <- txt[seq(
    grep("^Arguments:", txt)+1,
    trail-1
  )] %>% 
    gsub("\\s\\s(-[^A-Z]*)\\s\\s", "\n### \\1 \n\n", .) %>% 
    gsub(" *$", "", .) %>%
    gsub("--", "\\-\\-", .) %>%  
    paste(., collapse = "\n") %>% 
    detect_links

  return(out)
}