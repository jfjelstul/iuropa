% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describe_functions.R
\name{describe_variables}
\alias{describe_variables}
\title{Describe the variables in a table}
\usage{
describe_variables(component, table, session = NULL)
}
\arguments{
\item{component}{A string. The code for a component. Use
\code{list_components()} to get a list of valid values.}

\item{table}{A string. The name of a table in the specified component. Use
\code{list_tables()} to get a list of valid values.}

\item{session}{An object of class \code{iuropa_session} created by
\code{authenticate()}. This argument is only required for content that is
not yet publicly available.}
}
\value{
This function returns a tibble. There is one observation per variable
  in the specified table.
}
\description{
This function provides descriptions for the variables that are
  currently available in a particular table in a component of the IUROPA CJEU
  Database. You have to specify the code for a component and the name of a
  table in that component. The values returned by \code{list_components()}
  and \code{list_tables()} are the values that are valid for these arguments.
}
\examples{
\dontrun{
data <- describe_variables(
  component = "cjeu_database_platform",
  table = "decisions"
)}

}
