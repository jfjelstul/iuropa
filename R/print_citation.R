# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Print the citation for a IUROPA component
#'
#' This function generates the recommended citations for a IUROPA component. You
#' need to provide the code for a component.
#'
#' @param component A string. The code for a component. Use
#'   \code{list_components()} to get a list of valid values.
#'
#' @examples
#' \dontrun{
#' print_citation(
#'   component = "cjeu_database_platform"
#' )}
#'
#' @export
print_citation <- function(component) {

  # make URL
  url <- stringr::str_c(
    get_api_address(),
    "database/documentation/citation/",
    component
  )

  # request citation
  citation <- make_request(url, quietly = TRUE)

  # coerce to a string
  citation <- as.character(citation$value)

  # print citation
  cat(citation)
}
