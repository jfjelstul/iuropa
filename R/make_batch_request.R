# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

make_batch_request <- function(session, url) {

  # API response limit
  api_limit <- 10000

  # API rate limit
  api_rate_limit <- 12 * 2

  # clean URL
  if (!stringr::str_detect(url, "\\?")) {
    url <- stringr::str_c(url, "?")
  }

  # get total number of observations -------------------------------------------

  # construct the query
  n_url <- stringr::str_c(url, "&count=1")
  n_url <- stringr::str_replace(n_url, "\\?&", "?")

  cat("Requesting data via the IUROPA API...\n")

  response <- httr::GET(
    n_url,
    config = httr::add_headers(authorization = session$token),
    encode = "json"
  )

  response_content <- rawToChar(response$content)

  if(response$status_code != 200) {
    stop("API query not successful.")
  }

  # parse response
  n <- jsonlite::fromJSON(response_content, flatten = TRUE)$results |> as.numeric()

  # message
  cat("Response received.\n")

  # estimate time --------------------------------------------------------------

  # number of batches
  batches <- ceiling(n / api_limit)

  # frequency of batch requests
  freq <- 60 / api_rate_limit * 2

  # print to console
  cat("Observations requested: ", n, ".\n", sep = "")
  cat("Downloading", api_limit, "observations every", freq, "seconds.\n")
  cat("Total estimated time: ", round(freq * (batches - 1) / 60, 2), " minutes (", freq * (batches - 1), " seconds).\n", sep = "")

  # empty list to hold batches
  out <- list()

  # loop through batches -------------------------------------------------------

  for(i in 1:batches) {

    # print to console
    clear_console_line()
    cat("\rDownloading...", sep = "")

    # limit condition
    limit_condition <- stringr::str_c("&limit=", api_limit)

    # offset condition
    offset_condition <- stringr::str_c("&offset=", api_limit * (i - 1))

    # batch query
    batch_url <- stringr::str_c(url, limit_condition, offset_condition)
    batch_url <- stringr::str_replace(batch_url, "\\?&", "?")

    # fetch data
    response <- httr::GET(
      batch_url,
      config = httr::add_headers(authorization = session$token),
      encode = "json"
    )

    response_content <- rawToChar(response$content)

    # error handling
    if(response$status_code != 200) {
      stop("API query not successful.")
    }

    # parse response and coerce to a tibble
    batch <- jsonlite::fromJSON(response_content, flatten = TRUE)$results |> dplyr::as_tibble()

    # print to console
    progress <- stringr::str_c("\rBatch ", i, " of ", batches, " complete (observations ", api_limit * (i - 1) + 1, " to ", min(i * api_limit, n), " of ", n, ").\n")
    cat(progress)

    # countdown
    if(i != batches) {
      for(j in freq:1) {
        clear_console_line()
        message <- stringr::str_c("\rNext batch in: ", j, sep = "")
        message <- stringr::str_pad(message, side = "right", pad = " ", width = 40)
        cat(message)
        Sys.sleep(1)
      }
    }

    # add tibble to output list
    out[[i]] <- batch
  }

  # print completion message ---------------------------------------------------

  clear_console_line()
  cat("\rYour download is complete!\n")

  # prepare the output ---------------------------------------------------------

  out <- dplyr::bind_rows(out)

  return(out)
}
