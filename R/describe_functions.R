# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Describe the components in the IUROPA CJEU Database
#'
#' @description The IUROPA CJEU Database includes a number of components. This
#'   function provides descriptions of the components that are currently
#'   available via the IUROPA API.
#'
#' @return This function returns a tibble. There is one observation per
#'   component.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}. This argument is only required for content that is
#'   not yet publicly available.
#'
#' @examples
#' \dontrun{
#' data <- describe_components()}
#'
#' @export
describe_components <- function(session = NULL) {

  # make URL
  url <- build_url(route = "database/documentation/components")

  # make request
  data <- make_request(url = url, session = session)

  return(data)
}

#' Describe the tables in a component
#'
#' @description This function provides descriptions of the tables that are
#'   currently available in a particular component of the IUROPA CJEU Database.
#'   You have to specify the code for a component. The values returned by
#'   \code{list_components()} are the values that are valid for this argument.
#'
#' @return This function returns a tibble. There is one observation per table in
#'   the specified component.
#'
#' @param component A string. The code for a component. Use
#'   \code{list_components()} to get a list of valid values.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}. This argument is only required for content that is
#'   not yet publicly available.
#'
#' @examples
#' \dontrun{
#' data <- describe_tables(
#'   component = "cjeu_database_platform"
#' )}
#'
#' @export
describe_tables <- function(component, session = NULL) {

  # make route
  route <- stringr::str_c(
    "database/documentation/tables",
    component,
    sep = "/"
  )

  # make URL
  url <- build_url(route = route)

  # make request
  data <- make_request(url = url, session = session)

  return(data)
}

#' Describe the variables in a table
#'
#' @description This function provides descriptions for the variables that are
#'   currently available in a particular table in a component of the IUROPA CJEU
#'   Database. You have to specify the code for a component and the name of a
#'   table in that component. The values returned by \code{list_components()}
#'   and \code{list_tables()} are the values that are valid for these arguments.
#'
#' @return This function returns a tibble. There is one observation per variable
#'   in the specified table.
#'
#' @param component A string. The code for a component. Use
#'   \code{list_components()} to get a list of valid values.
#'
#' @param table A string. The name of a table in the specified component. Use
#'   \code{list_tables()} to get a list of valid values.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}. This argument is only required for content that is
#'   not yet publicly available.
#'
#' @examples
#' \dontrun{
#' data <- describe_variables(
#'   component = "cjeu_database_platform",
#'   table = "decisions"
#' )}
#'
#' @export
describe_variables <- function(component, table, session = NULL) {

  # make route
  route <- stringr::str_c(
    "database/documentation/variables",
    component,
    table,
    sep = "/"
  )

  # make URL
  url <- build_url(route = route, parameters = list(table = table))

  # make request
  data <- make_request(url = url, session = session)

  return(data)
}
