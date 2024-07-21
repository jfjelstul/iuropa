# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Download IUROPA data
#'
#' @description This function allows you to download data from the IUROPA CJEU
#'   Database via the IUROPA API. This function provides the same functionality
#'   as the IUROPA Download Tool, which is available on the IUROPA website. You
#'   need to choose a component in the IUROPA CJEU Database and a table in that
#'   component. For example, you could choose the \code{decisions} table of the
#'   CJEU Database Platform. You can specify filters to select specific
#'   observations and you can select specific variables. You can use
#'   \code{describe_variables()} to learn more about the variables available in
#'   each table.
#'
#' @details The IUROPA API has a rate limit, so this function downloads data
#'   from the IUROPA API in batches. It downloads 25,000 observations every 5
#'   seconds. It prints a message to the console that indicates how many
#'   observations you have requested and approximately how long it will take to
#'   download the data. It also prints a message after every batch that
#'   indicates the current progress. After your download is complete, it will
#'   print the suggested citations for the data. Please use these citations if
#'   you use the data in a paper.
#'
#' @param component A string. The code for a component. Use
#'   \code{list_components()} to get a list of valid values.
#'
#' @param table A string. The name of a table in the specified
#'   component. Use \code{list_tables()} to get a list of valid values.
#'
#' @param filters A named list. The default is \code{NULL}. Each element in the
#'   list specifies a filter to apply to the data. The name of each element
#'   should be the name of a variable in the specified table and the
#'   corresponding value should be a value or vector of values that the variable
#'   can take. The results will only include observations where the variable
#'   equals one of the provided values. If you specify multiple filters, the
#'   results will only include observations that match all of the filters. For
#'   numeric variables, you can add \code{_min} or \code{_max} to the end of the
#'   variable name to specify a minimum or maximum value. The API will ignore
#'   invalid filters.
#'
#' @param variables A string vector. The default is \code{NULL}. The results
#'   will only include the variables in the vector. Use \code{list_variables()}
#'   to get a list of valid values. The function will throw an error if you
#'   provide an invalid variable name.
#'
#' @param session An object of class \code{iuropa_session} created by
#'   \code{authenticate()}. This argument is only required for content that is
#'   not yet publicly available.
#'
#' @return This function returns a tibble containing the requested data.
#'
#' @examples
#' \dontrun{
#' data <- download_data(
#'   component = "cjeu_database_platform",
#'   table = "decisions",
#'   filters = list(
#'     court = c("Court of Justice", "General Court")
#'   )
#' )
#'
#' data <- download_data(
#'   component = "cjeu_database_platform",
#'   table = "assignments",
#'   filters = list(
#'     court = "Court of Justice",
#'     decision_date_min = "2015-01-01"
#'   ),
#'   variables = c("iuropa_decision_id", "iuropa_judge_id", "judge")
#' )}
#'
#' @export
download_data <- function(component, table, filters = NULL, variables = NULL, session = NULL) {

  # make API route for the request
  route <- stringr::str_c("database/data", component, table, sep = "/")

  # make an empty list to store parameters to pass to the API
  parameters <- list()

  # if there are filters, add them to parameters list
  if (!is.null(filters)) {

    # loop through filters and create parameter strings
    for (i in 1:length(filters)) {
      parameters[[i]] <- stringr::str_c(filters[[i]], collapse = ",")
    }

    # add names to list
    names(parameters) <- names(filters)
  }

  # if there are variables, add them to parameter list
  if (!is.null(variables)) {
    parameters$variables <- stringr::str_c(variables, collapse = ",")
  }

  # if there are no parameters, code as NULL
  if (length(parameters) == 0) {
    parameters <- NULL
  }

  # build the URL for the query
  url <- build_url(route, parameters)

  # run query
  data <- make_batch_request(url = url, session = session)

  # print citation
  print_citation(component = component)

  return(data)
}
