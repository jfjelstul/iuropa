# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Authenticate with the IUROPA API
#'
#' @description This function allows users with a IUROPA account to authenticate
#'   with the IUROPA API in order to access components of the IUROPA CJEU
#'   Database that have not yet been publicly released. This function creates
#'   a session. You need to provide your IUROPA username and password to
#'   authenticate.
#'
#' @return This function returns an object of class \code{iuropa_session} that
#'   contains the credentials necessary to access password-protected data from
#'   the IUROPA API. You can pass this session object into any function that
#'   takes a \code{session} argument. If your session times out, you will need
#'   to run this function again to create a new session. You can have multiple
#'   active sessions at the same time.
#'
#' @param username A string. Your IUROPA username.
#' @param password A string. Your IUROPA password.
#'
#' @examples
#' \dontrun{
#' session <- authenticate(
#'   username = "USERNAME",
#'   password = "PASSWORD"
#' )}
#'
#' @export
authenticate <- function(username, password) {

  # print message
  cat("Authenticating credentials with the IUROPA API...\n")

  # make URL
  url <- stringr::str_c(get_api_address(), "authenticate")

  # make request body
  body = list(
    username = username,
    password = password
  )

  # create request
  req <- url |>
    httr2::request() |>
    httr2::req_body_json(body)

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

    # extract content
    token <- res |>
      httr2::resp_body_json(simplifyVector = TRUE) |>
      purrr::pluck("token")

    # create session
    session <- list(
      username = username,
      token = token
    )

    # assign class
    class(session) <- "iuropa_session"

    # print message
    cat("Authentication successful!")

  # if no successful...
  } else {

    # throw error
    stop(stringr::str_c("Authentication not successful"))
  }

  return(session)
}

#' Check authentication with the IUROPA API
#'
#' @description This function checks whether you are currently authenticated
#'   with the IUROPA API. You need to provide an object of class
#'   \code{iuropa_session} created by the function \code{authenticate()}.
#'
#' @return This function prints a message to the console but does not return an
#'   object.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}.
#'
#' @examples
#' \dontrun{
#' session <- authenticate(
#'   username = "USERNAME",
#'   password = "PASSWORD"
#' )
#'
#' check_authentication(session)}
#'
#' @export
check_authentication <- function(session) {

  # print message
  cat("Checking authentication with the IUROPA API...\n")

  # make URL
  url <- stringr::str_c(get_api_address(), "check-authentication")

  # make request
  req <- url |>
    httr2::request() |>
    httr2::req_headers(
      authorization = session$token
    )

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

  # print message if check is successful
  if (status == 200) {

    # print message
    cat("Authentication successful!")

  } else {

    # throw error
    stop(stringr::str_c("Authentication unsuccessful"))
  }
}
