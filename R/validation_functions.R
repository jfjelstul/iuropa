# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

is_component <- function(session, component) {
  components <- list_components(session)
  component %in% components
}

is_dataset <- function(session, component, dataset) {
  datasets <- list_datasets(session, component)
  dataset %in% datasets
}

is_celex <- function(id, all = FALSE) {

  if(class(id) != "character") {
    stop("The argument 'id' needs to be a string vector.")
  }
  if(class(all) != "logical" | length(all) != 1) {
    stop("The argument 'all' needs to be TRUE or FALSE.")
  }

  check <- stringr::str_detect(id, "^6[0-9]{4}(CJ|CO|CC|CS|CT|CP|CX|CD|CV|TJ|TO|TC|TT|FJ|FO|FT)[0-9]{4}(\\([0-9]{2}\\))?$")
  if(all == TRUE) {
    return(all(check))
  } else {
    return(check)
  }
}

is_ecli <- function(id, all = FALSE) {

  if(class(id) != "character") {
    stop("The argument 'id' needs to be a string vector.")
  }
  if(class(all) != "logical" | length(all) != 1) {
    stop("The argument 'all' needs to be TRUE or FALSE.")
  }

  check <- stringr::str_detect(id, "^ECLI:EU:[CTF]:[0-9]{4}:[0-9]{1,4}$")
  if(all == TRUE) {
    return(all(check))
  } else {
    return(check)
  }
}

is_iuropa_case_id <- function(id, all = FALSE) {

  if(class(id) != "character") {
    stop("The argument 'id' needs to be a string vector.")
  }
  if(class(all) != "logical" | length(all) != 1) {
    stop("The argument 'all' needs to be TRUE or FALSE.")
  }

  check <- stringr::str_detect(id, "^CJEU:[CTF]:[0-9]{4}:[0-9]{4}(:(V|X))?$")
  if(all == TRUE) {
    return(all(check))
  } else {
    return(check)
  }
}

is_iuropa_decision_id <- function(id, all = FALSE) {

  if(class(id) != "character") {
    stop("The argument 'id' needs to be a string vector.")
  }
  if(class(all) != "logical" | length(all) != 1) {
    stop("The argument 'all' needs to be TRUE or FALSE.")
  }

  check <- stringr::str_detect(id, "^CJEU:[CTF]:[0-9]{4}:[0-9]{4}:(C|P|D|J|V|O|X|S|T):[0-9]{8}$")
  if(all == TRUE) {
    return(all(check))
  } else {
    return(check)
  }
}

is_iuropa_proceeding_id <- function(id, all = FALSE) {
  is_iuropa_case_id(id, all)
}
