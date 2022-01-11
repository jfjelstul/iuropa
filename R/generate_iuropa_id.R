# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

#' @export
generate_iuropa_id <- function(court, year, number, type = NULL, date = NULL) {

  if(class(court) != "character") {
    stop("'court' needs to be a string vector")
    if(!(type %in% c("Court of Justice", "General Court", "Civil Service Tribunal"))) {
      "The argument 'court' cannot take this value. See the documentation for possible values."
    }
  }
  if(class(type) != "NULL") {
    if(class(type) != "character") {
      stop("The argument 'type' needs to be a string vector.")
      if(!(type %in% c("AG opinion", "AG view", "decision", "judgment", "opinion", "order", "ruling", "seizure order", "third-party proceedings"))) {
        "The argument 'type' cannot take this value. See the documentation for possible values."
      }
    }
  }
  if(class(year) != "numeric") {
    stop("The argument 'year' needs to be a numeric vector.")
  }
  if(class(number) != "numeric") {
    stop("The argument 'number' needs to be a numeric vector.")
  }
  if(class(date) != "NULL") {
    if(class(date) != "character") {
      stop("The argument 'date' needs to be a string vector.")
      if(!stringr::str_detect(date, "[0-9]{4}-[0-9]{2}-[0-9]{2}")) {
        stop("The argument 'date' needs to have the format YYYY-MM-DD.")
      }
    }
  }

  court[court == "Court of Justice"] <- "C"
  court[court == "General Court"] <- "T"
  court[court == "Civil Service Tribunal"] <- "F"

  if(!is.null(type)) {
    type <- stringr::str_to_lower(type)
    type[type == "ag opinion"] <- "C"
    type[type == "ag view"] <- "P"
    type[type == "decision"] <- "D"
    type[type == "judgment"] <- "J"
    type[type == "opinion"] <- "V"
    type[type == "order"] <- "O"
    type[type == "ruling"] <- "X"
    type[type == "seizure order"] <- "S"
    type[type == "third-party proceedings"] <- "T"
  }

  if(!is.null(date)) {
    date <- stringr::str_replace_all(date, "-", "")
  }

  number <- stringr::str_pad(number, side = "left", width = 4, pad = "0")

  if(!is.null(type)) {
    extension <- rep("", length(type))
    extension[type == "X"] <- ":X"
    extension[type == "V"] <- ":V"
  } else {
    extension <- ""
  }

  if(!is.null(date) & !(is.null(type))) {
    out <- stringr::str_c("CJEU:", court, ":", year, ":", number, ":", type, ":", date)
  } else {
    out <- stringr::str_c("CJEU:", court, ":", year, ":", number, extension)
  }

  return(out)
}

###########################################################################
# end R script
###########################################################################
