################################################################################
# Joshua C. Fjelstul, Ph.D.
# The CJEU Database
# iuropa R Package
################################################################################

scrape_registry <- function() {

  # scrape HTML files ----------------------------------------------------------

  cat("Scraping Court of Justice registry...\n")
  html_raw_1 <- rvest::read_html("https://curia.europa.eu/en/content/juris/c1_juris.htm")
  html_raw_2 <- rvest::read_html("https://curia.europa.eu/en/content/juris/c2_juris.htm")

  cat("Scraping General Court registry...\n")
  html_raw_3 <- rvest::read_html("https://curia.europa.eu/en/content/juris/t2_juris.htm")

  cat("Scraping Civil Service Tribunal registry...\n")
  html_raw_4 <- rvest::read_html("https://curia.europa.eu/en/content/juris/f1_juris.htm")

  # parse HTML -----------------------------------------------------------------

  cat("Parsing Court of Justice HTML...\n")
  html_parsed_1 <- html_raw_1 |> rvest::html_nodes("td")
  html_parsed_2 <- html_raw_2 |> rvest::html_nodes("td")

  cat("Parsing General Court HTML...\n")
  html_parsed_3 <- html_raw_3 |> rvest::html_nodes("td")

  cat("Parsing Civil Service Tribunal HTML...\n")
  html_parsed_4 <- html_raw_4 |> rvest::html_nodes("td")

  # make tibbles ---------------------------------------------------------------

  cat("Combining HTML data...\n")

  # Court of Justice (1951-1989)
  data_1 <- dplyr::tibble(
    court = "Court of Justice",
    case_id = html_parsed_1[seq(1, length(html_parsed_1) - 1, 2)] |> rvest::html_text(),
    text = html_parsed_1[seq(2, length(html_parsed_1) - 1, 2)] |> rvest::html_text()
  )

  # Court of Justice (1990-2020)
  data_2 <- dplyr::tibble(
    court = "Court of Justice",
    case_id = html_parsed_2[seq(1, length(html_parsed_2) - 1, 2)] |> rvest::html_text(),
    text = html_parsed_2[seq(2, length(html_parsed_2) - 1, 2)] |> rvest::html_text()
  )

  # General Court
  data_3 <- dplyr::tibble(
    court = "General Court",
    case_id = html_parsed_3[seq(1, length(html_parsed_3) - 1, 2)] |> rvest::html_text(),
    text = html_parsed_3[seq(2, length(html_parsed_3) - 1, 2)] |> rvest::html_text()
  )

  # Civil Service Tribunal
  data_4 <- dplyr::tibble(
    court = "Civil Service Tribunal",
    case_id = html_parsed_4[seq(1, length(html_parsed_4) - 1, 2)] |> rvest::html_text(),
    text = html_parsed_4[seq(2, length(html_parsed_4) - 1, 2)] |> rvest::html_text()
  )

  # stack tibbles --------------------------------------------------------------

  registry <- rbind(data_1, data_2, data_3, data_4)
  registry$text <- stringr::str_squish(registry$text)
  registry$case_id <- stringr::str_squish(registry$case_id)

  # drop rows with no case id
  n0 <- nrow(registry)
  registry <- dplyr::filter(registry, case_id != "")
  n1 <- nrow(registry)

  cat("Dropping", n0 - n1, ifelse(n0 - n1 > 1, "rows", "row"), "with a missing case number...\n")

  # case id --------------------------------------------------------------------

  registry$case_id_raw <- registry$case_id
  registry$case_id_raw <- stringr::str_replace_all(registry$case_id_raw, "([0-9])-([0-9])", "\\1/\\2") # replace dashes in case number with forward slashes
  registry$case_id_raw <- stringr::str_replace(registry$case_id_raw, "[[:space:]]*-[[:space:]]*", "-") # remove spaces around dashes in prefix
  registry$case_id_raw <- stringr::str_replace_all(registry$case_id_raw, "\\.", "") # remove periods
  registry$case_id_raw <- stringr::str_replace_all(registry$case_id_raw, "[*]", "") # remove asterisks
  registry$case_id_raw <- stringr::str_squish(registry$case_id_raw) # remove extra white space
  registry$case_id_raw[stringr::str_detect(registry$case_id_raw, "^[0-9]")] <- stringr::str_c("C-", registry$case_id_raw[stringr::str_detect(registry$case_id_raw, "^[0-9]")]) # add prefix to CJ entries

  # fix inconsistently formatted opinions --------------------------------------

  registry$case_id_raw[registry$case_id_raw == "C-1/12 OPINION"] <- "OPINION 1/12"
  registry$case_id_raw[registry$case_id_raw == "C-1/15 OPINION"] <- "OPINION 1/15"
  registry$case_id_raw[registry$case_id_raw == "C-1/17 OPINION"] <- "OPINION 1/17"
  registry$case_id_raw[registry$case_id_raw == "C-1/19 OPINION"] <- "OPINION 1/19"
  registry$case_id_raw[registry$case_id_raw == "C-2/15 OPINION"] <- "OPINION 2/15"
  registry$case_id_raw[registry$case_id_raw == "C-3/15 OPINION"] <- "OPINION 3/15"

  # case id --------------------------------------------------------------------

  registry$case_id <- stringr::str_extract(registry$case_id_raw, "(C-)?(T-)?(F-)?[0-9]+/[0-9]+")
  registry$case_id <- stringr::str_squish(registry$case_id)
  registry$case_id[stringr::str_detect(registry$case_id, "^[0-9]")] <- stringr::str_c("C-", registry$case_id[stringr::str_detect(registry$case_id, "^[0-9]")])
  registry$case_id[stringr::str_detect(registry$case_id_raw, "OPINION|RULING")] <- registry$case_id_raw[stringr::str_detect(registry$case_id_raw, "OPINION|RULING")]

  # year -----------------------------------------------------------------------

  registry$case_year <- stringr::str_extract(registry$case_id, "[0-9]+( |$)")
  registry$case_year <- ifelse(registry$case_year > 50, stringr::str_c("19", registry$case_year, sep = ""), stringr::str_c("20", registry$case_year, sep = ""))
  registry$case_year <- as.numeric(registry$case_year)

  # case number ----------------------------------------------------------------

  registry$case_number <- stringr::str_extract(registry$case_id, "[0-9]+")
  registry$case_number <- as.numeric(registry$case_number)

  # case prefix ----------------------------------------------------------------

  registry$case_prefix <- stringr::str_extract(registry$case_id, "[CTF]")
  registry$case_prefix[is.na(registry$case_prefix)] <- "None"

  # proceeding suffix ----------------------------------------------------------

  registry$proceeding_suffix <- registry$case_id_raw
  registry$proceeding_suffix <- stringr::str_replace(registry$proceeding_suffix, "([A-Z]-)?[0-9]+/[0-9]+", "")
  registry$proceeding_suffix <- stringr::str_squish(registry$proceeding_suffix)
  registry$proceeding_suffix[registry$proceeding_suffix == ""] <- "None"
  registry$proceeding_suffix[stringr::str_detect(registry$case_id_raw, "OPINION|RULING")] <- "None"
  registry$proceeding_suffix <- stringr::str_replace(registry$proceeding_suffix, "\\.$", "")
  registry$proceeding_suffix <- stringr::str_squish(registry$proceeding_suffix)

  # entry type -----------------------------------------------------------------

  registry$entry_type <- "Missing"
  registry$entry_type[stringr::str_detect(registry$text, "^Removed from the register")] <- "Order"
  registry$entry_type[stringr::str_detect(registry$text, "^Pending")] <- "Pending"
  registry$entry_type[stringr::str_detect(registry$text, "see Case")] <- "Reference"
  registry$entry_type[stringr::str_detect(registry$text, "^Judgment")] <- "Judgment"
  registry$entry_type[stringr::str_detect(registry$text, "^Order")] <- "Order"
  registry$entry_type[stringr::str_detect(registry$text, "^Decision")] <- "Decision"
  registry$entry_type[stringr::str_detect(registry$text, "(^Opinion)|^(C-3/15 Opinion)")] <- "Opinion"
  registry$entry_type[stringr::str_detect(registry$text, "^Ruling")] <- "Ruling"
  registry$entry_type[stringr::str_detect(registry$text, "^Seizure order")] <- "Seizure order"
  registry$entry_type[stringr::str_detect(registry$text, "^Third-party proceedings")] <- "Third-party proceedings"

  # drop rows with no entry type
  n0 <- nrow(registry)
  registry <- dplyr::filter(registry, entry_type != "Missing")
  n1 <- nrow(registry)
  cat("Dropping", n0 - n1, "observations with a missing entry type...\n")

  # ECLI number ----------------------------------------------------------------

  registry$ecli <- stringr::str_extract(registry$text, "ECLI:EU:[CTF]:[0-9]+:[0-9]+")
  registry$ecli[is.na(registry$ecli)] <- "Missing"
  registry$ecli[registry$entry_type %in% c("Pending", "Reference")] <- "Not applicable"

  # publication ----------------------------------------------------------------

  registry$publication_status <- "Published"
  registry$publication_status[stringr::str_detect(registry$text, "Unpublished")] <- "Unpublished"
  registry$publication_status[registry$entry_type %in% c("Pending", "Reference")] <- "Not applicable"

  # entry date -----------------------------------------------------------------

  registry$entry_date <- stringr::str_extract(registry$text, "[0-9]+ [A-Z][a-z]+ [0-9]+")
  registry$entry_date <- lubridate::dmy(registry$entry_date)
  registry$entry_date <- as.character(registry$entry_date)
  registry$entry_date[is.na(registry$entry_date)] <- "Missing"
  registry$entry_date[registry$entry_type %in% c("Pending", "Reference")] <- "Not applicable"

  # joins ----------------------------------------------------------------------

  cat("Calculating joins...\n")

  # joined to
  registry$case_id_joined <- stringr::str_extract(registry$text, "see Case (C-)?(T-)?(T )?(C )?(F-)?(F )?[0-9]+[-/][0-9]+")
  registry$case_id_joined <- stringr::str_replace(registry$case_id_joined, "see Case", "")
  registry$case_id_joined <- stringr::str_squish(registry$case_id_joined)

  # mark missing ID numbers
  registry$case_id_joined[is.na(registry$case_id_joined)] <- "Missing"

  # add prefixes
  registry$case_id_joined[stringr::str_detect(registry$case_id_joined, "^[0-9]")] <- stringr::str_c("C-", registry$case_id_joined[stringr::str_detect(registry$case_id_joined, "^[0-9]")])
  registry$case_id_joined <- stringr::str_replace(registry$case_id_joined, "^([CTF]) ", "\\1-")

  # if the entry doesn't contain a reference, use the case ID
  registry$case_id_joined[registry$entry_type != "Reference"] <- registry$case_id[registry$entry_type != "Reference"]

  # transferred
  registry$entry_type[registry$entry_type == "Reference" & stringr::str_extract(registry$case_id, "[CTF]") != stringr::str_extract(registry$case_id_joined, "[CTF]")] <- "Transferred"
  registry$transferred <- as.numeric(registry$entry_type == "Transferred")

  # joined
  registry$entry_type[registry$entry_type == "Reference"] <- "Joined"
  registry$joined <- as.numeric(registry$entry_type == "Joined")

  # remove self-joins
  registry$self_join <- as.numeric(registry$entry_type == "Joined" & registry$case_id == registry$case_id_joined)

  # drop self-joins
  n0 <- nrow(registry)
  registry <- dplyr::filter(registry, !self_join)
  n1 <- nrow(registry)
  cat("Dropping", n0 - n1, "self-joins...\n")

  # mark cases joined to a case that is then joined to another case
  registry$joined_again <- as.numeric(registry$entry_type == "Joined" & registry$case_id_joined %in% registry$case_id[registry$entry_type == "Joined"])

  # fix double joins
  registry$case_id_final <- registry$case_id_joined
  for(i in 1:nrow(registry)) {
    if(registry$joined_again[i] == 1) {
      registry$case_id_final[i] <- unique(registry$case_id_joined[registry$entry_type == "Joined" & registry$case_id == registry$case_id_joined[i]])
    }
  }
  rm(i)

  # fix proceeding ID joined and proceeding ID transferred
  registry$case_id_transferred <- registry$case_id_joined
  registry$case_id_joined[registry$entry_type != "Joined"] <- "Not applicable"
  registry$case_id_transferred[registry$entry_type != "Transferred"] <- "Not applicable"

  # proceeding ID
  registry$proceeding_id <- registry$case_id_final

  # proceeding number
  registry$proceeding_number <- stringr::str_extract(registry$proceeding_id, "[0-9]+")
  registry$proceeding_number <- as.numeric(registry$proceeding_number)

  # proceeding year
  registry$proceeding_year <- stringr::str_extract(registry$proceeding_id, "[0-9]+$")
  registry$proceeding_year <- ifelse(as.numeric(registry$proceeding_year) <= 20, stringr::str_c("20", registry$proceeding_year), stringr::str_c("19", registry$proceeding_year))
  registry$proceeding_year <- as.numeric(registry$proceeding_year)

  # usual name -----------------------------------------------------------------

  registry$usual_name <- registry$text
  registry$usual_name <- stringr::str_replace(registry$usual_name, "^.*?(of|on) [0-9]+ [A-Z][a-z]+ [0-9]{4}, ", "")
  registry$usual_name <- stringr::str_replace(registry$usual_name, "Pending Case, ", "")
  registry$usual_name <- stringr::str_replace(registry$usual_name, "\\(([0-9]|T-|C-|F-).*", "")
  registry$usual_name <- stringr::str_squish(registry$usual_name)
  registry$usual_name[registry$usual_name == ""] <- "Missing"
  registry$usual_name[registry$entry_type == "Opinion"] <- "Not applicable"
  registry$usual_name[registry$entry_type == "Ruling"] <- "Not applicable"

  # check for duplicates -------------------------------------------------------

  registry$id <- stringr::str_c(registry$case_id, registry$entry_type, registry$entry_date, registry$ecli, registry$proceeding_id, sep = " - ")
  registry$duplicate <- duplicated(registry$id)

  # drop duplicates
  n0 <- nrow(registry)
  registry <- dplyr::filter(registry, !duplicate)
  n1 <- nrow(registry)
  cat("Dropping", n0 - n1, "duplicates...\n")

  # ECR citation ---------------------------------------------------------------

  cat("Extracting European Court Reports citations...\n")

  # decision
  registry$decision <- as.numeric(registry$entry_type %in% c("Judgment", "Order", "Decision", "Opinion", "Ruling", "Seizure order", "Third-party proceedings"))

  # extract citation
  registry$ecr_citation <- stringr::str_extract(registry$text, "ECR(-SC)? *[0-9]{4}( *- *[0-9]{4})? *p[.]? *([-A-Z]+)?[0-9]+")
  registry$ecr_citation[is.na(registry$ecr_citation)] <- "None"
  registry$ecr_citation[registry$decision == 0] <- "Not applicable"

  # IUROPA proceeding ID -------------------------------------------------------

  cat("Creating IUROPA ID numbers...\n")

  registry$iuropa_proceeding_id <- generate_iuropa_id(
    court = registry$court,
    type = registry$entry_type,
    year = registry$proceeding_year,
    number = registry$proceeding_number
  )

  # IUROPA case ID -------------------------------------------------------------

  registry$iuropa_case_id <- generate_iuropa_id(
    court = registry$court,
    type = registry$entry_type,
    year = registry$case_year,
    number = registry$case_number
  )

  # IUROPA decision ID ---------------------------------------------------------

  registry$iuropa_decision_id <- generate_iuropa_id(
    court = registry$court,
    type = registry$entry_type,
    date = registry$entry_date,
    year = registry$proceeding_year,
    number = registry$proceeding_number
  )

  registry$iuropa_decision_id[registry$decision == 0] <- "Not applicable"
  registry$iuropa_decision_id[stringr::str_detect(registry$iuropa_decision_id, "Missing")] <- "Missing"

  # court ID -------------------------------------------------------------------

  registry$court_id <- 0
  registry$court_id[registry$court == "Court of Justice"] <- 1
  registry$court_id[registry$court == "General Court"] <- 2
  registry$court_id[registry$court == "Civil Service Tribunal"] <- 3

  # organize tibble ------------------------------------------------------------

  cat("Preparing output...\n")

  registry$key_id <- 1:nrow(registry)

  registry <- dplyr::select(
    registry, key_id, court_id, court,
    iuropa_case_id, case_id, case_year, case_number, usual_name,
    joined, case_id_joined,
    transferred, case_id_transferred,
    iuropa_proceeding_id, proceeding_id, proceeding_year, proceeding_number,
    entry_type, entry_date, decision, iuropa_decision_id, ecli, publication_status,
    ecr_citation
  )

  cat("Done!\n")

  message("Please note that the CJEU Registry is not an authoritative list of cases and decisions and does contain errors. There are cases and decisions that appear in InfoCuria and EUR-Lex that are not included in the Registry, and data from the Registry sometimes conflicts with data from InfoCuria and EUR-Lex. This function corrects formatting errors, but it does not correct the data itself.")

  return(registry)
}

################################################################################
# end R script
################################################################################
