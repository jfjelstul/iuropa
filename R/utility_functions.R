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

  # create base URL
  url = get_api_address()

  # print message
  cat("Pinging the IUROPA API...\n")

  # perform request
  res <- url |>
    httr2::request() |>
    httr2::req_perform()

  # check status
  status <- httr2::last_response() |>
    httr2::resp_status()

  # if request is successful...
  if(status == 200) {

    # extract message
    data <- res |>
      httr2::resp_body_json(simplifyVector = TRUE) |>
      purrr::pluck("data")

    # print message
    cat(data)

  # if not successful...
  } else {

    # throw error
    stop("API ping not successful")
  }
}

run_quietly <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

get_api_address <- function() {
  return("https://api.iuropa.pol.gu.se/")
}

build_url <- function(route = NULL, parameters = NULL) {

  # if there are parameters...
  if (!is.null(parameters)) {

    # create an empty vector
    parameters_vector <- NULL

    # loop through parameters in list
    for(i in 1:length(parameters)) {

      # create a new parameter
      new_parameter <- parameters[[i]]

      # collapse vectors into comma-separated strings
      if (length(parameters) > 1) {
        new_parameter <- stringr::str_c(new_parameter, collapse = ",")
      }

      # assign a value
      new_parameter <- stringr::str_c(names(parameters)[i], "=", new_parameter)

      # add to parameter vector
      parameters_vector <- c(parameters_vector, new_parameter)
    }

    # collapse multiple parameters into one string
    parameters_string <- stringr::str_c(parameters_vector, collapse = "&")

    # add parameters to route
    route <- stringr::str_c(route, "?", parameters_string)
  }

  # add API address to route
  url <- stringr::str_c(get_api_address(), route, sep = "")

  return(url)
}

clear_console_line <- function() {

  # overwrite current line
  string <- "\r"

  # add spaces to clean line
  for(i in 1:50) {
    string <- stringr::str_c(string, " ")
  }

  # print message
  cat(string)
}
