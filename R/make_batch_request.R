# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

make_batch_request <- function(session, url) {

  # API response limit
  api_limit <- 25000

  # Clean URL
  if (!stringr::str_detect(url, "\\?")) {
    url <- stringr::str_c(url, "?")
  }

  # Construct the query
  n_url <- stringr::str_c(url, "&count=1")
  n_url <- stringr::str_replace(n_url, "\\?&", "?")

  # Print message
  cat("Requesting data via the IUROPA API...\n")

  # Fire get request
  response <- httr::GET(
    n_url,
    config = httr::add_headers(authorization = session$token),
    encode = "json"
  )

  # Convert raw to string
  response_content <- rawToChar(response$content)

  # Error handling
  if (response$status_code != 200) {
    stop("API query not successful.")
  }

  # Parse response
  n <- jsonlite::fromJSON(response_content, flatten = TRUE)$results |> as.numeric()

  # Print message
  cat("Response received.\n")

  # Number of batches
  batches <- ceiling(n / api_limit)

  # Frequency of batch requests
  freq <- 5

  # Print to console
  cat("Observations requested: ", n, ".\n", sep = "")
  cat("Downloading", api_limit, "observations every", freq, "seconds.\n")
  cat("Total estimated time: ", round(freq * (batches - 1) / 60, 2), " minutes (", freq * (batches - 1), " seconds).\n", sep = "")

  # Empty list to hold batches
  out <- list()

  # Loop through batches
  for (i in 1:batches) {

    # Print to console
    clear_console_line()
    cat("\rDownloading...", sep = "")

    # Limit condition
    limit_condition <- stringr::str_c("&limit=", api_limit)

    # Offset condition
    offset_condition <- stringr::str_c("&offset=", as.integer(api_limit * (i - 1)))

    # Batch query
    batch_url <- stringr::str_c(url, limit_condition, offset_condition)
    batch_url <- stringr::str_replace(batch_url, "\\?&", "?")

    # Fetch data
    response <- httr::GET(
      batch_url,
      config = httr::add_headers(authorization = session$token),
      encode = "json"
    )

    # Convert raw to string
    response_content <- rawToChar(response$content)

    # Error handling
    if (response$status_code != 200) {
      stop("API query not successful.")
    }

    # Parse response and coerce to a tibble
    batch <- jsonlite::fromJSON(response_content, flatten = TRUE)$results |> dplyr::as_tibble()

    # Print to console
    progress <- stringr::str_c("\rBatch ", i, " of ", batches, " complete (observations ", api_limit * (i - 1) + 1, " to ", as.integer(min(i * api_limit, n)), " of ", n, ").\n")
    cat(progress)

    # Countdown
    if (i != batches) {
      for (j in freq:1) {
        clear_console_line()
        message <- stringr::str_c("\rNext batch in: ", j, sep = "")
        message <- stringr::str_pad(message, side = "right", pad = " ", width = 40)
        cat(message)
        Sys.sleep(1)
      }
    }

    # Add tibble to output list
    out[[i]] <- batch
  }

  # Print completion message
  clear_console_line()
  cat("\rYour download is complete!\n")

  # Prepare the output
  out <- dplyr::bind_rows(out)

  return(out)
}
