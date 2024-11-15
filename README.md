# rare-diseases-codes

- Website contaning mappings between Orphacodes and ICD10 codes: https://www.orphadata.com/alignments/ --> file `en_product1.xml` was downloaded from here (description of its content is available in `OrphadataFreeAccessProductsDescription.pdf`)
- `xml_conversion_orphanet.R` --> script used to convert xml file into a csv file for upload on Google Cloud Platform
- `Orphanet_2_ICD10.csv` --> csv file containing mappings between OrphaCodes and ICD10 plus some extra metadata (e.g. type of alignment, Exact or Broader to Narrower or Broader to Narrower)
- "Measuring the impact of rare diseases in Tasmania, Australia" (example of using ICD10 codes to measure impact of Rare Diseases on hospital admissions etc): https://pubmed.ncbi.nlm.nih.gov/39468681/
