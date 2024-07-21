# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

make_batch_request <- function(url, session) {

  # API response limit
  limit <- 25000

  # set frequency of batch requests
  frequency <- 5

  # clean URL
  if (!stringr::str_detect(url, "\\?")) {
    url <- stringr::str_c(url, "?")
  }

  # make URL for count of observations
  count_url <- stringr::str_c(url, "&count=1")

  # print message
  cat("Requesting data via the IUROPA API...\n")

  # get number of rows
  count_rows <- make_request(url = count_url, session = session, quietly = TRUE)
  count_rows <- as.numeric(count_rows)

  # error handling
  if (count_rows == 0) {
    cat("There is no data that matches your search parameters\n\n")
    return(NULL)
  }

  # print message
  cat("Response received\n")

  # number of batches
  count_batches <- ceiling(count_rows / limit)

  # print messages
  cat("Observations requested: ", count_rows, "\n", sep = "")
  cat("Downloading", limit, "observations every", frequency, "seconds\n")
  cat("Number of batches: ", count_batches, "\n", sep = "")
  cat("Total estimated time: ", round(frequency * (count_batches - 1) / 60, 2), " minutes (", frequency * (count_batches - 1), " seconds)\n", sep = "")

  # empty list to hold batches
  data <- list()

  # loop through batches
  for (i in 1:count_batches) {

    # print message
    clear_console_line()
    cat("\rDownloading...", sep = "")

    # limit parameter
    limit_parameter <- stringr::str_c("&limit=", limit)

    # offset parameter
    offset_parameter <- stringr::str_c("&offset=", as.integer(limit * (i - 1)))

    # construct batch URL
    batch_url <- stringr::str_c(url, limit_parameter, offset_parameter)

    # make request
    data[[i]] <- make_request(batch_url, session = session, quietly = TRUE)

    # print message
    progress <- stringr::str_c("\rBatch ", i, " of ", count_batches, " complete (observations ", limit * (i - 1) + 1, " to ", as.integer(min(i * limit, count_rows)), " of ", count_rows, ")\n")
    cat(progress)

    # print countdown
    if (i != count_batches) {
      for (j in frequency:1) {
        clear_console_line()
        message <- stringr::str_c("\rNext batch in: ", j, sep = "")
        message <- stringr::str_pad(message, side = "right", pad = " ", width = 40)
        cat(message)
        Sys.sleep(1)
      }
    }
  }

  # print message
  clear_console_line()
  cat("\rYour download is complete!\n\n")

  # prepare the output
  data <- dplyr::bind_rows(data)

  return(data)
}
