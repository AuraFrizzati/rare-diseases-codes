## Author: AF
## data source: https://www.orphadata.com/alignments/

# Load required libraries
library(xml2)
library(dplyr)

# Load the XML file
#xml_file <- read_xml("Orphanet_trial.xml")
xml_file <- read_xml("en_product1.xml")

# Extract Disorder nodes
disorders <- xml_find_all(xml_file, ".//Disorder")

# Initialize an empty data frame to store results
results <- data.frame(
  OrphaCode = character(),
  Name = character(),
  DisorderType = character(),
  DisorderGroup = character(),
  ICD10_Reference = character(),
  ICD10_MappingRelation = character(),
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
  
  # Extract DisorderType
  disorder_type <- xml_text(xml_find_first(disorder, ".//DisorderType"))
  
  # Extract DisorderGroup
  disorder_group <- xml_text(xml_find_first(disorder, ".//DisorderGroup"))
  
  # Initialize empty ICD-10 reference and mapping relation
  icd10_ref <- NA
  icd10_mapping_relation <- NA
  
  # Search for ICD-10 Reference
  for (ref in external_references) {
    source <- xml_text(xml_find_first(ref, ".//Source"))
    if (source == "ICD-10") {
      icd10_ref <- xml_text(xml_find_first(ref, ".//Reference"))
      
      # Find the DisorderMappingRelation for this ICD-10 reference
      mapping_relation <- xml_find_first(ref, ".//DisorderMappingRelation/Name[@lang='en']")
      icd10_mapping_relation <- xml_text(mapping_relation)
      
      break # Exit the loop after finding the first ICD-10 reference
    }
  }
  
  # Append data to results
  results <- rbind(results, data.frame(
    OrphaCode = orpha_code,
    Name = name,
    DisorderType = disorder_type,
    DisorderGroup = disorder_group,
    ICD10_Reference = icd10_ref,
    ICD10_MappingRelation = icd10_mapping_relation,
    stringsAsFactors = FALSE
  ))
}

# View the results
# print(results)

write.csv(results,"Orphanet_2_ICD10.csv", row.names = F)
