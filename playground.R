library(tidyverse)
library(glue)
library(stringi)
library(knitr)

source <- 'py'
target <- 'r'

source_lang_logo <- glue("<img src=\"../images/{source}_logo.png\" class=\"language-icon\">")
target_lang_logo <- glue("<img src=\"../images/{target}_logo.png\" class=\"language-icon\">")

# topic breakdown
topic <- "How do I inspect data?"
subtopics <- c("Print the first few rows", "Print the last few rows")

# code / concept comparisons per topic / subtopic

default_opts <- list(echo = TRUE, eval = FALSE)
# generate options string from a list of key:boolean mapping
generate_code_options <- function(opts) {
  vars <- names(opts)
  as_strings <- map_chr(vars, function(x) paste(x, "=", opts[x][[1]]))
  paste(as_strings, collapse=', ')
}
options <- list(echo = TRUE, eval = FALSE, include = FALSE)
options_as_str <- generate_code_options(options)
print(options_as_str)

# generating code chunk using a template
generate_code_chunk <- function(language, options, code) {
  language_options <- glue("{language}", "{options}", .sep=" ")
  header <- glue("```{", language_options, "}", .open="{{", .close="}}")
  glue(header, "{{code}}", "```", .open="{{", .close="}}", .sep="\n")
}

py_side <- generate_code_chunk("python", 
                               generate_code_options(default_opts), 
                               "mtcars.head()")
py_side <- paste(source_lang_logo, py_side, sep="\n\n")
py_side
r_side <- generate_code_chunk("r", 
                              generate_code_options(list(exercise = TRUE, exercise.lines = 3)), 
                              "head()")
r_side <- paste(target_lang_logo, r_side, sep="\n\n")
r_side

final <- paste(py_side, r_side, sep="\n\n")
fileConn <- file("file.Rmd")
writeLines(final, fileConn)
close(fileConn)












