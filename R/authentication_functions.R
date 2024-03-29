# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Authenticate with the IUROPA API
#'
#' @description This function allows users with a IUROPA account to authenticate
#'   with the IUROPA API in order to access components of the IUROPA CJEU
#'   Database that have not yet been publically released. This function creates
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
  cat("Authenticating credentials with the IUROPA API...\n")
  url <- build_api_url(route = "authenticate")
  body = list(
    username = username,
    password = password
  )
  response <- httr::POST(url, body = body, encode = "json")
  response_content <- rawToChar(response$content)
  if(response$status_code != 200) {
    stop(response_content)
  } else {
    cat("Authentication successful! You will stay connected for 2 hours.")
    token <- jsonlite::fromJSON(response_content, flatten = TRUE)$token
  }
  session <- list(
    username = username,
    token = token
  )
  class(session) <- "iuropa_session"
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
  if(class(session) != "iuropa_session") {
    stop("The aurgument session must be an object of class \"iuropa_session\" generated by authenticate().")
  }
  cat("Checking authentication with the IUROPA API...\n")
  url <- build_api_url(route = "check-authentication")
  response <- httr::GET(
    url,
    httr::add_headers(authorization = session$token),
    encode = "json"
  )
  if(response$status_code != 200) {
    stop(rawToChar(response$content))
  } else {
    cat("You are currently authenticated.")
  }
}
