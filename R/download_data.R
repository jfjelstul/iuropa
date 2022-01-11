# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Download IUROPA data
#'
#' @description This function allows you to download data from the IUROPA API.
#'   You need to choose a IUROPA component and a dataset in that component. For
#'   example, you could choose the \code{decisions} dataset of the CJEU Database
#'   Platform. You can also specify filters and select specific variables. You
#'   can use \code{describe_variables()} to learn more about the variables
#'   available in each dataset.
#'
#' @details The IUROPA API has a rate limit, so this function downloads data
#'   from the IUROPA API in batches. It downloads 10,000 observations every 5
#'   seconds. It prints a message to the console that indicates how many
#'   observations you have requested and approximately how long it will take to
#'   download the data. It also prints a message after every batch that
#'   indicates the current progress. After your download is complete, it will
#'   print the suggested citations for the data. Please use these citations if
#'   you use the data in a paper or project.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}.
#' @param component A string. The name of a IUROPA component. Use
#'   \code{list_components()} to get a list of valid values.
#' @param dataset A string. The name of a IUROPA dataset in the specified IUROPA
#'   component. Use \code{list_datasets()} to get a list of valid values.
#' @param filters A named list. The default is \code{NULL}. Each element in the
#'   list specifies a filter to apply to the data. The name of each element
#'   should be the name of a variable in the specified dataset and the
#'   corresponding value should be a value or vector of values that the variable
#'   can take. The results will only include observations where the variable
#'   equals one of the provided values. If you specify multiple filters, the
#'   results will only include observations that match all of the filters. For
#'   numeric variables, you can add \code{_min} or \code{_max} to the end of the
#'   variable name to specify a minimum or maximum value.
#' @param variables A string vector. The default is \code{NULL}. The results
#'   will only include the variables in the vector. Use \code{list_variables()}
#'   to get a list of valid values. The function will throw an error if you
#'   provide an invalid variable name.
#'
#' @return This function returns a tibble that contains the requested data.
#'
#' @examples
#' \dontrun{
#' session <- authenticate(
#'   username = "USERNAME",
#'   password = "PASSWORD"
#' )
#'
#' out <- download_data(
#'   session = session,
#'   component = "cjeu_database_platform",
#'   dataset = "decisions",
#'   filters = list(
#'     court = c("Court of Justice", "General Court")
#'   )
#' )
#'
#' out <- download_data(
#'   session = session,
#'   component = "cjeu_database_platform",
#'   dataset = "assignments",
#'   filters = list(
#'     court = "Court of Justice",
#'     decision_date_min = "2015-01-01"
#'   ),
#'   variables = c("ecli", "judge_id", "last_name")
#' )}
#'
#' @export
download_data <- function(session, component, dataset, filters = NULL, variables = NULL) {
  route <- get_api_route(component = component, dataset = dataset)
  parameters <- filters
  parameters$variables <- variables
  url <- build_api_url(route = route, parameters = parameters)
  out <- make_batch_request(session = session, url = url)
  print_citation(component = component, version = "0.1")
  return(out)
}
