# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

make_simple_request <- function(session, url, quietly = FALSE) {

  # message
  if (quietly == FALSE) {
    cat("Connecting to the IUROPA API...\n")
  }

  # fetch data
  if (is.null(session)) {
    response <- httr::GET(
      url,
      encode = "json"
    )
  } else {
    response <- httr::GET(
      url,
      config = httr::add_headers(authorization = session$token),
      encode = "json"
    )
  }


  # get response content
  response_content <- rawToChar(response$content)

  # error handling
  if (response$status_code != 200) {
    stop(stringr::str_c("API query not successful."))
  }

  # parse response and coerce to a tibble
  out <- jsonlite::fromJSON(response_content, flatten = TRUE)$results |> dplyr::as_tibble()

  # message
  cat("Response received.\n")

  return(out)
}
