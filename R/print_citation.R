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

  if (component == "cjeu_database_platform") {
    database <- "the IUROPA CJEU Database Platform"
  }

  if (component == "cjeu_text_corpus") {
    database <- "the IUROPA CJEU Text Corpus"
  }

  if (component == "issues_and_positions") {
    database <- "the IUROPA CJEU Database: Issues and Positions Component"
  }

  cat("\n")
  cat("If you use data from ", database, " in a paper, please cite the database:\n", sep = "")
  cat("\n")

  if (component == "cjeu_database_platform") {
    cat("Brekke, Stein Arne, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2023. \"The IUROPA CJEU Database Platform: Decisions and Decision-Makers\" (Release 1.0), in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The IUROPA CJEU Database, The IUROPA Project, https://iuropa.pol.gu.se/.\n", sep = "")
  }

  if (component == "cjeu_text_corpus") {
    cat("Fjelstul, Joshua, Johan Lindholm, Daniel Naurin, and Michal Ovádek. 2023. \"The IUROPA CJEU Text Corpus\" (Release 1.0), in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The IUROPA CJEU Database, The IUROPA Project, https://iuropa.pol.gu.se/.\n", sep = "")
  }

  if (component == "issues_and_positions") {
    cat("Larsson, Olof, Johan Lindholm, Daniel Naurin, Andreas Moberg, Philipp Schroeder, Anna Wallerman Ghavanini, Sebastian Björnberg, Aaron Coster, Moa Näsström, and Irene Otero. 2023. \"The IUROPA CJEU Database: Issues and Positions Component\" (Release 1.0), in Lindholm, Johan, Daniel Naurin, Urška Šadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The IUROPA CJEU Database, The IUROPA Project, https://iuropa.pol.gu.se/.\n", sep = "")
  }

  if (component == "cjeu_database_platform") {
    cat("\n")
    cat("Please also cite the article that introduces the IUROPA CJEU Database Platform:\n")
    cat("\n")
    cat("Stein Arne Brekke, Joshua C. Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2023. \"The CJEU Database Platform: Decisions and Decision-Makers.\" The Journal of Law and Courts. Forthcoming.\n")
  }

  cat("\n")
  cat("Please also cite the iuropa R package:\n")
  cat("\n")
  cat("Joshua C. Fjelstul (2023). iuropa: An R Interface to the IUROPA API. R package version ", as.character(packageVersion("iuropa")), ". https://github.com/jfjelstul/iuropa.\n", sep = "")
}
