# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Test the API
#'
#' @description This function tests that the IUROPA API is running.
#'
#' @examples
#' \dontrun{
#' ping_api()}
#'
#' @export
ping_api <- function() {
  url = get_api_address()
  cat("Pinging the IUROPA API...\n")
  response <- httr::GET(url)
  if(response$status_code != 200) {
    stop("API ping not successful.")
  }
  out <- jsonlite::fromJSON(rawToChar(response$content), flatten = TRUE)
  cat(out$message)
}

run_quietly <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

get_api_address <- function() {
  "https://api.iuropa.pol.gu.se/"
}

build_api_url <- function(route = NULL, parameters = NULL) {
  url <- get_api_address()
  if (!is.null(route)) {
    url <- stringr::str_c(url, route)
  }
  if (!is.null(parameters)) {
    parameters_vector <- NULL
    for(i in 1:length(parameters)) {
      new_parameter <- parameters[[i]]
      if (length(parameters) > 1) {
        new_parameter <- stringr::str_c(new_parameter, collapse = ",")
      }
      new_parameter <- stringr::str_c(names(parameters)[i], "=", new_parameter)
      # new_parameter <- stringr::str_replace_all(new_parameter, " ", "+")
      parameters_vector <- c(parameters_vector, new_parameter)
    }
    parameters_string <- stringr::str_c(parameters_vector, collapse = "&")
    url <- stringr::str_c(url, "?", parameters_string)
  }
  return(url)
}

get_api_route <- function(component, table = NULL) {
  if (component == "cjeu_database_platform") {
    route_base <- "CJEU-database-platform"
  } else if (component == "cjeu_text_corpus") {
    route_base <- "CJEU-text-corpus"
  } else if (component == "cjeu_database") {
    route_base <- "CJEU-database"
  } else {
    stop("The argument \"component\" is not valid.")
  }
  if (!is.null(table)) {
    route <- stringr::str_c(route_base, "/", table)
  } else {
    route <- route_base
  }
  return(route)
}

clear_console_line <- function() {
  string <- "\r"
  for(i in 1:50) {
    string <- stringr::str_c(string, " ")
  }
  cat(string)
}
