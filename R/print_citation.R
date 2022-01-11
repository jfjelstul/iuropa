# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' Print the citation for a IUROPA component
#'
#' This function generates the recommended citations for a IUROPA component. You
#' need to provide a component id and a version number. The version number
#' should be the version number for the IUROPA component, not the version number
#' of the \code{R} package.
#'
#' @param component A string. The name of a IUROPA component. Use
#'   \code{list_components()} to get a list of valid values.
#' @param version A string. A version number in the format \code{#.#}, such as
#'   \code{0.1}.
#'
#' @examples
#' \dontrun{
#' print_citation(
#'   component = "cjeu_database_platform",
#'   version = "0.1"
#' )}
#'
#' @export
print_citation <- function(component, version) {

  if (component == "cjeu_database_platform") {
    database <- "the CJEU Database Platform"
  }

  if (component == "cjeu_text_corpus") {
    database <- "the CJEU Text Corpus"
  }

  cat("\n")
  cat("If you use data from ", database, " in a paper or project, please cite the database:\n", sep = "")
  cat("\n")

  if (component == "cjeu_database_platform") {
    cat("Brekke, Stein Arne, Joshua Fjelstul, Silje Synnøve Lyder Hermansen and Daniel Naurin. 2021 \"The CJEU Database Platform: Decisions and Decision-Makers (Stable Release ", version, ")\", in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The Court of Justice of the European Union Database, IUROPA, URL: http://iuropa.pol.gu.se/.\n", sep = "")
  }

  if (component == "cjeu_text_corpus") {
    cat("Fjelstul, Joshua, Johan Lindholm, Daniel Naurin, and Michal Ovádek 2021. \"The CJEU Database Text Corpus (Version ", version, ")\", in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The Court of Justice of the European Union Database, IUROPA, URL: http://iuropa.pol.gu.se/.\n", sep = "")
  }

  if (component == "cjeu_database_platform") {
    cat("\n")
    cat("Please also cite the paper that introduces the CJEU Database Platform:\n")
    cat("\n")
    cat("Stein Arne Brekke, Joshua C. Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. The CJEU Database Platform: Decisions and Decision-Makers. Working paper.\n")
  }

  cat("\n")
  cat("Please also cite the iuropa R package:\n")
  cat("\n")
  cat("Joshua C. Fjelstul (2021). iuropa: An R Interface to the IUROPA CJEU Database. R package version ", as.character(packageVersion("iuropa")), ". https://github.com/jfjelstul/iuropa.\n", sep = "")
}
