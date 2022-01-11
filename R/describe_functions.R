# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Describe the IUROPA components
#'
#' @description The IUROPA project includes a number of components. This
#'   function provides descriptions of all of the components that are currently
#'   available via the IUROPA API.
#'
#' @return This function returns a tibble containing 5 variables. There is one
#'   observation per IUROPA component.
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
#' out <- describe_components(session = session)}
#'
#' @export
describe_components <- function(session) {
  route <- get_api_route(component = "cjeu_database", dataset = "components")
  url <- build_api_url(route = route)
  out <- make_simple_request(session = session, url = url)
  return(out)
}

#' Describe datasets in a IUROPA component
#'
#' @description This function provides descriptions of all of the datasets that
#'   are currently available in a particular IUROPA component. You have to
#'   specify a IUROPA component.
#'
#' @return This function returns a tibble containing 5 variables. There is one
#'   observation per dataset in the specified component.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}.
#' @param component A string. The name of a IUROPA component. Use
#'   \code{list_components()} to get a list of valid values.
#'
#' @examples
#' \dontrun{
#' session <- authenticate(
#'   username = "USERNAME",
#'   password = "PASSWORD"
#' )
#'
#' out <- describe_datasets(
#'   session = session,
#'   component = "cjeu_database_platform"
#' )}
#'
#' @export
describe_datasets <- function(session, component) {
  route <- get_api_route(component = component, dataset = "datasets")
  url <- build_api_url(route = route)
  out <- make_simple_request(session = session, url = url)
  return(out)
}

#' Describe variables in a IUROPA dataset
#'
#' @description This function provides descriptions of all of the variables that
#'   are currently available in a particular IUROPA dataset. You have to specify
#'   a IUROPA component and a IUROPA dataset in that component.
#'
#' @return This function returns a tibble containing 7 variables. There is one
#'   observation per variable in the specified dataset.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}.
#' @param component A string. The name of a IUROPA component. Use
#'   \code{list_components()} to get a list of valid values.
#' @param dataset A string. The name of a IUROPA dataset in the specified IUROPA
#'   component. Use \code{list_datasets()} to get a list of valid values.
#'
#' @examples
#' \dontrun{
#' session <- authenticate(
#'   username = "USERNAME",
#'   password = "PASSWORD"
#' )
#'
#' out <- describe_variables(
#'   session = session,
#'   component = "cjeu_database_platform",
#'   dataset = "decisions"
#' )}
#'
#' @export
describe_variables <- function(session, component, dataset) {
  route <- get_api_route(component = component, dataset = "variables")
  url <- build_api_url(route = route, parameters = list(dataset = dataset))
  out <- make_simple_request(session = session, url = url)
  return(out)
}
