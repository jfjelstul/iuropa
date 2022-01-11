# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' @export
get_tags <- function(session, level, keys, show_hidden = FALSE) {

  if (level == "paragraph") {
    route <- "CJEU-text-corpus/paragraph-tags"
  } else if (level == "document") {
    route <- "CJEU-text-corpus/document-tags"
  }

  n_keys <- length(keys)
  keys <- stringr::str_c(keys, collapse = ",")

  url = build_api_url(
    route = route,
    parameters = list(
      keys = keys
    )
  )

  cat("Accessing the IUROPA API...\n")

  response <- httr::GET(
    url,
    config = httr::add_headers(authorization = session$token),
    encode = "json"
  )

  response_content <- rawToChar(response$content)

  if(response$status_code != 200) {
    stop(response_content)
  }

  out <- jsonlite::fromJSON(response_content, flatten = TRUE)$results

  if (class(out) == "list") {
    stop(ifelse(n_keys > 1, "One or more of the keys you have specified is not valid.", "The key you have specified is not valid."))
  }

  cat("Tags successfully retrieved.")

  if(show_hidden == FALSE) {
    out$value[out$hidden == 1 & out$coder != session$username] <- "hidden"
  }

  out <- dplyr::select(out, -priority)

  return(out)
}

#' @export
create_tag <- function(session, level, key, type, value, hidden = FALSE) {

  if (level == "paragraph") {
    route <- "CJEU-text-corpus/paragraph-tags"
  } else if (level == "document") {
    route <- "CJEU-text-corpus/document-tags"
  }

  url = build_api_url(
    route = route
  )

  body = list(
    key = key,
    type = type,
    value = value,
    coder = session$username,
    date = Sys.Date(),
    hidden = as.numeric(hidden)
  )

  cat("Accessing the IUROPA API...\n")

  response <- httr::POST(
    url,
    config = httr::add_headers(authorization = session$token),
    body = body,
    encode = "json"
  )

  response_content <- rawToChar(response$content)

  if(response$status_code != 200) {
    stop(response_content)
  } else {
    message <- jsonlite::fromJSON(response_content, flatten = TRUE)$message
    cat(message)
  }
}

#' @export
update_tag <- function(session, level, tag_id, type, value, hidden = FALSE) {

  if (level == "paragraph") {
    route <- "CJEU-text-corpus/paragraph-tags"
  } else if (level == "document") {
    route <- "CJEU-text-corpus/document-tags"
  }

  url = build_api_url(
    route = route,
    parameters = list(
      tag_id = tag_id
    )
  )

  body = list(
    type = type,
    value = value,
    coder = session$username,
    date = Sys.Date(),
    hidden = as.numeric(hidden)
  )

  cat("Accessing the IUROPA API...\n")

  response <- httr::PUT(
    url,
    config = httr::add_headers(authorization = session$token),
    body = body,
    encode = "json"
  )

  response_content <- rawToChar(response$content)

  if(response$status_code != 200) {
    stop(response_content)
  } else {
    message <- jsonlite::fromJSON(response_content, flatten = TRUE)$message
    cat(message)
  }
}

#' @export
delete_tag <- function(session, level, tag_id) {

  if (level == "paragraph") {
    route <- "CJEU-text-corpus/paragraph-tags"
  } else if (level == "document") {
    route <- "CJEU-text-corpus/document-tags"
  }

  url = build_api_url(
    route = route,
    parameters = list(
      tag_id = tag_id
    )
  )

  cat("Accessing the IUROPA API...\n")

  response <- httr::DELETE(
    url,
    config = httr::add_headers(authorization = session$token),
    encode = "json"
  )

  response_content <- rawToChar(response$content)

  if(response$status_code != 200) {
    stop(response_content)
  } else {
    message <- jsonlite::fromJSON(response_content, flatten = TRUE)$message
    cat(message)
  }
}
