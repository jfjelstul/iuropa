# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' List the IUROPA components
#'
#' @description The IUROPA project includes a number of components. This
#'   function lists the components that are currently available via the IUROPA
#'   API. A number of functions in the \code{iuropa} package have a
#'   \code{component} argument. The values returned by \code{list_components()}
#'   are those that are valid for this argument.
#'
#' @return This function returns a string vector containing the names of the
#'   IUROPA components.
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
#' out <- list_components(session)}
#'
#' @export
list_components <- function(session) {
  out <- describe_components(session)
  out <- out$component
  return(out)
}

#' List datasets in a IUROPA component
#'
#' @description This function lists all of the datasets that are currently
#'   available in a particular IUROPA component. You have to specify a IUROPA
#'   component. A number of functions in the \code{iuropa} package have a
#'   \code{dataset} argument. The values returned by \code{list_datasets()} are
#'   those that are valid for this argument.
#'
#' @return This function returns a string vector containing the names of the
#'   datasets in the specified component.
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
#' out <- list_datasets(
#'   session = session,
#'   component = "cjeu_database_platform"
#' )}
#'
#' @export
list_datasets <- function(session, component) {
  out <- describe_datasets(session, component)
  out <- out$dataset
  return(out)
}

#' List variables in a IUROPA dataset
#'
#' @description This function lists all of the variables that are currently
#'   available in a particular IUROPA dataset. You have to specify a IUROPA
#'   component and a IUROPA dataset in that component.
#'
#' @return This function returns a string vector containing the names of the
#'   variables in the specified dataset.
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
#' out <- list_variables(
#'   session = session,
#'   component = "cjeu_database_platform",
#'   dataset = "decisions"
#' )}
#'
#' @export
list_variables <- function(session, component, dataset) {
  out <- describe_variables(session, component, dataset)
  out <- out$variable
  return(out)
}
