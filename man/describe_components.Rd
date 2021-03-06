% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/describe_functions.R
\name{describe_components}
\alias{describe_components}
\title{Describe the IUROPA components}
\usage{
describe_components(session)
}
\arguments{
\item{session}{An object of class \code{iuropa_session} created by
\code{authenticate()}.}
}
\value{
This function returns a tibble containing 5 variables. There is one
  observation per IUROPA component.
}
\description{
The IUROPA project includes a number of components. This
  function provides descriptions of all of the components that are currently
  available via the IUROPA API.
}
\examples{
\dontrun{
session <- authenticate(
  username = "USERNAME",
  password = "PASSWORD"
)

out <- describe_components(session = session)}

}
