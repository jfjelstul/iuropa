# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' List the components in the IUROPA CJEU Database
#'
#' @description The IUROPA CJEU Database includes a number of components. This
#'   function lists the components that are currently available via the IUROPA
#'   API. A number of functions in the \code{iuropa} package have a
#'   \code{component} argument. The values returned by \code{list_components()}
#'   are the values that are valid for this argument.
#'
#' @return This function returns a string vector containing the names of the
#'   components that are currently available via the IUROPA API.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}. This argument is only required for content that is
#'   not yet publicly available.
#'
#' @examples
#' \dontrun{
#' data <- list_components()}
#'
#' @export
list_components <- function(session = NULL) {
  data <- describe_components(session)
  data <- data$component
  return(data)
}

#' List the tables in a component
#'
#' @description This function lists the tables that are currently available in a
#'   particular component of the IUROPA CJEU Database. You have to specify the
#'   code for a component. The values returned by \code{list_components()} are
#'   the values that are valid for this argument. A number of functions in the
#'   \code{iuropa} package have a \code{tables} argument. The values returned by
#'   \code{list_tables()} are the values that are valid for this argument.
#'
#' @return This function returns a string vector containing the names of the
#'   tables in the specified component.
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
#' data <- list_tables(
#'   component = "cjeu_database_platform"
#' )}
#'
#' @export
list_tables <- function(component, session = NULL) {
  data <- describe_tables(component, session)
  data <- data$table
  return(data)
}

#' List the variables in a table
#'
#' @description This function lists the variables that are currently available
#'   in a particular table in a component of the IUROPA CJEU Database. You have
#'   to specify the code for a component and the name of a table in that
#'   component. The values returned by \code{list_components()} and
#'   \code{list_tables()} are the values that are valid for these arguments.
#'
#' @return This function returns a string vector containing the names of the
#'   variables in the specified table.
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
#' data <- list_variables(
#'   component = "cjeu_database_platform",
#'   table = "decisions"
#' )}
#'
#' @export
list_variables <- function(component, table, session = NULL) {
  data <- describe_variables(component, table, session)
  data <- data$variable
  return(data)
}
