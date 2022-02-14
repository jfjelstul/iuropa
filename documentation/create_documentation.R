# Joshua C. Fjelstul, Ph.D.
# iuropa R Package

# read in data
datasets <- read.csv("documentation/CJEU-database-platform/codebook-data/CJEU-database-platform-datasets.csv", stringsAsFactors = FALSE)
variables <- read.csv("documentation/CJEU-database-platform/codebook-data/CJEU-Database-Platform-variables.csv", stringsAsFactors = FALSE)
components <- read.csv("documentation/CJEU-database/CJEU-database-components.csv", stringsAsFactors = FALSE)

# write data for server
write.csv(datasets, "build/CJEU-database-platform/version-0-1/CSV-database/datasets.csv", row.names = FALSE, quote = TRUE)
write.csv(variables, "build/CJEU-database-platform/version-0-1/CSV-database/variables.csv", row.names = FALSE, quote = TRUE)
write.csv(components, "build/CJEU-database/CSV-database/components.csv", row.names = FALSE, quote = TRUE)

# read in data
datasets <- read.csv("documentation/CJEU-database-platform/codebook-data/CJEU-database-platform-datasets.csv", stringsAsFactors = FALSE)
variables <- read.csv("documentation/CJEU-database-platform/codebook-data/CJEU-database-platform-variables.csv", stringsAsFactors = FALSE)

# create a codebook
codebookr::create_codebook(
  file_path = "documentation/CJEU-database-platform/codebook/CJEU-database-platform-codebook.tex",
  datasets_input = datasets,
  variables_input = variables,
  title_text = "The CJEU Database Platform",
  version_text = "0.1",
  footer_text = "The CJEU Database Platform Codebook \\hspace{5pt} | \\hspace{5pt} The IUROPA Project",
  author_names = c("Stein Arne Brekke", "Joshua Fjelstul", "Silje Synnøve Lyder Hermansen", "Daniel Naurin"),
  theme_color = "#5D92E0",
  heading_font_size = 35,
  subheading_font_size = 12,
  title_font_size = 16,
  table_of_contents = TRUE,
  include_variable_type = TRUE
)
