# rare-diseases-codes

- Website contaning mappings between Orphacodes and ICD10 codes: https://www.orphadata.com/alignments/ --> file `en_product1.xml` was downloaded from here (description of its content is available in `OrphadataFreeAccessProductsDescription.pdf`)
- `xml_conversion_orphanet.R` --> script used to convert xml file into a csv file for upload on Google Cloud Platform
- `Orphanet_2_ICD10.csv` --> csv file containing mappings between OrphaCodes and ICD10 plus some extra metadata (e.g. type of alignment, Exact or Broader to Narrower or Broader to Narrower)
- https://pubmed.ncbi.nlm.nih.gov/39468681/
