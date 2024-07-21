# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

make_request <- function(url, session = NULL, quietly = FALSE) {

  # print message
  if (quietly == FALSE) {
    cat("Connecting to the IUROPA API...\n")
  }

  # if no session...
  if (is.null(session)) {

    # make request without headers
    req <- url |>
      stringr::str_replace_all(" ", "%20") |>
      httr2::request()

  # if session...
  } else {

    # make request with headers
    req <- url |>
      stringr::str_replace_all(" ", "%20") |>
      httr2::request() |>
      httr2::req_headers(
        authorization = session$token
      )
  }

  # create object to store response
  res <- NULL

  # try to perform request
  try(
    {
      res <- req |>
        httr2::req_perform()
    },
    silent = TRUE
  )

  # check status
  status <- httr2::last_response() |>
    httr2::resp_status()

  # if request is successful...
  if (status == 200) {

    # print message
    if (quietly == FALSE) {
      cat("Response received\n")
    }

    # extract data
    data <- res |>
      httr2::resp_body_json(simplifyVector = TRUE) |>
      purrr::pluck("data") |>
      dplyr::as_tibble()

  # if not authorized...
  } else if (status == 401) {

    # throw error
    stop(stringr::str_c("Query not successful: Unauthorized"))

  # if not found...
  } else if (status == 404) {

    # throw error
    stop(stringr::str_c("Query not successful: Not found"))

  # if internal server error...
  } else if (status == 500) {

    # extract error message
    error <- httr2::last_response() |>
      httr2::resp_body_json()

    # if server error message...
    if (class(error$error) == "character") {

      # throw error
      stop(stringr::str_c("Query not successful: Internal server error: ", error$error))

    # if database error message...
    } else if (class(error$error$text) == "character") {

      # throw error
      stop(stringr::str_c("Query not successful: Internal server error: ", error$error$text))

    # if other error...
    } else {

      # throw error
      stop(stringr::str_c("Query not successful: Internal server error"))
    }

  # if other error status...
  } else {

    # throw error
    stop(stringr::str_c("Query not successful: Other"))
  }

  return(data)
}
