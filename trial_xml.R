# Load required libraries
library(xml2)
library(dplyr)

# Load the XML file
# xml_file <- read_xml("Orphanet_trial.xml")
xml_file <- read_xml("en_product1.xml")

# Extract Disorder nodes
disorders <- xml_find_all(xml_file, ".//Disorder")

# Initialize an empty data frame to store results
results <- data.frame(
  OrphaCode = character(),
  Name = character(),
  ICD10_Reference = character(),
  stringsAsFactors = FALSE
)

# Loop through each Disorder node
for (disorder in disorders) {
  # Extract OrphaCode
  orpha_code <- xml_text(xml_find_first(disorder, ".//OrphaCode"))
  
  # Extract Name in English
  name <- xml_text(xml_find_first(disorder, ".//Name[@lang='en']"))
  
  # Find all ExternalReference nodes within the disorder
  external_references <- xml_find_all(disorder, ".//ExternalReference")
  
  # Initialize an empty ICD-10 reference
  icd10_ref <- NA
  
  # Search for ICD-10 Reference
  for (ref in external_references) {
    source <- xml_text(xml_find_first(ref, ".//Source"))
    if (source == "ICD-10") {
      icd10_ref <- xml_text(xml_find_first(ref, ".//Reference"))
      break
    }
  }
  
  # Append data to results
  results <- rbind(results, data.frame(
    OrphaCode = orpha_code,
    Name = name,
    ICD10_Reference = icd10_ref,
    stringsAsFactors = FALSE
  ))
}

# View the results
print(results)
