###########################################################################
# Joshua C. Fjelstul, Ph.D.
# CJEU Database Platform
# cjeuniv R Package
###########################################################################

#' @export
generate_citation <- function(id, old = FALSE) {

  if(class(id) != "character") {
    stop("The argument 'id' needs to be a string vector.")
  }
  if(class(old) != "logical" | length(old) != 1) {
    stop("The argument 'old' needs to be TRUE or FALSE.")
  }

  if(is_ecli(id, all = TRUE)) {
    data <- dplyr::filter(decisions, ecli %in% id)
  } else if (is_celex(id, all = TRUE)) {
    data <- dplyr::filter(decisions, celex %in% id)
  } else if (is_iuropa_decision_id(id, all = TRUE)) {
    data <- dplyr::filter(decisions, iuropa_decision_id %in% id)
  } else {
    stop("The argument 'id' needs to be a vector of ECLI numbers, CELEX numbers, or IUROPA decision IDs.")
  }

  if(nrow(data) == 0) {
    stop("There are no documents that match 'id'.")
  }

  data$decision_type[data$decision_type == "AG opinion"] <- "Advocate General opinion"
  data$decision_type[data$decision_type == "AG view"] <- "Advocate General view"
  data$decision_type[data$decision_type == "decision"] <- "Decision"
  data$decision_type[data$decision_type == "judgment"] <- "Judgment"
  data$decision_type[data$decision_type == "opinion"] <- "Opinion of the Court"
  data$decision_type[data$decision_type == "order"] <- "Order"
  data$decision_type[data$decision_type == "ruling"] <- "Ruling"
  data$decision_type[data$decision_type == "seizure order"] <- "Seizure order"
  data$decision_type[data$decision_type == "third-party proceedings"] <- "Third-party proceedings"

  data$decision_date <- lubridate::as_date((data$decision_date))
  data$decision_date <- stringr::str_c(
    lubridate::day(data$decision_date),
    lubridate::month(data$decision_date, label = TRUE, abbr = FALSE),
    lubridate::year(data$decision_date),
    sep = " "
  )

  if(old == FALSE) {

    data$ecli <- stringr::str_remove(data$ecli, "ECLI:")

    data$publication_status[data$publication_status == "unpublished"] <- ", not published"
    data$publication_status[data$publication_status != "unpublished"] <- ""

    data$citation <- stringr::str_c(
      data$decision_type, " of ", data$decision_date, ", ",
      data$usual_name, ", ", data$proceeding_id, data$publication_status, ", ",
      data$ecli, "."
    )

  } else {

    data$ecr_citation <- stringr::str_c(" (", data$ecr_citation, ")")
    data$ecr_citation[stringr::str_detect(data$ecr_citation, "none|not applicable")] <- ""

    data$citation <- stringr::str_c(
      data$decision_type, " of ", data$decision_date, " in Case ",
      data$proceeding_id, " ", data$usual_name, data$ecr_citation, "."
    )
  }

  if(sum(data$in_registry == 0) > 0) {
    warning("Some values are NA because the decision is not listed in the register.")
  }

  data$citation[data$in_registry == 0] <- NA
  data$citation <- stringr::str_squish(data$citation)

  data <- dplyr::select(data, iuropa_decision_id, celex, ecli, citation)

  return(data$citation)
}

###########################################################################
# end R script
###########################################################################
