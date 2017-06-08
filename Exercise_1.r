library(readr)
> refine_original <- read_csv("~/Desktop/refine_original.csv")
library(tidyr)
library(dplyr)
tbl_df(refine_original)

#Clean up brand names (lowercase and mispellings)
refine_original %>%
  mutate(company = tolower(company))
refine_original$company[refine_original$company=="Phillips"] <- "philips"
refine_original$company[refine_original$company=="philips"] <- "philips"
refine_original$company[refine_original$company=="phllips"] <- "philips"
refine_original$company[refine_original$company=="phillps"] <- "philips"
refine_original$company[refine_original$company=="phillipS"] <- "philips"
refine_original$company[refine_original$company=="fillips"] <- "philips"
refine_original$company[refine_original$company=="phlips"] <- "philips"
refine_original$company[refine_original$company=="Akzo"] <- "akzo"
refine_original$company[refine_original$company=="akz0"] <- "akzo"
refine_original$company[refine_original$company=="ak zo"] <- "akzo"
refine_original$company[refine_original$company=="AKZO"] <- "akzo"
refine_original$company[refine_original$company=="Van Houten"] <- "van houten"
refine_original$company[refine_original$company=="van Houten"] <- "van houten"
refine_original$company[refine_original$company=="unilver"] <- "unilever"
refine_original$company[refine_original$company=="Unilever"] <- "unilever"

#  Separate product code and number
refine_original %>%
  separate("Product code / number", c("product_code", "product_number"), sep = "-")

refine_original <- refine_original %>%
  separate("Product code / number", c("product_code", "product_number"), sep = "-")

# Add product categories
refine_original %>% 
  mutate(product_category = product_code)
refine_original$category[refine_original$product_code == "p"] <- "Smartphone"
refine_original$category[refine_original$product_code == "v"] <- "TV"
refine_original$category[refine_original$product_code == "x"] <- "Laptop"
refine_original$category[refine_original$product_code == "q"] <- "Tablet"

# Add full address for geocoding
refine_original %>%
  unite(full_address, address, city, country, sep = ",")

refine_original <- refine_original %>%
  unite(full_address, address, city, country, sep = ",")

#Create dummy variables for company and product category
#first for companies

refine_original$company_philips <- as.numeric(refine_original$company == "philips")
refine_original$company_akzo <- as.numeric(refine_original$company == "akzo")
refine_original$company_van_houten <- as.numeric(refine_original$company == "van houten")
refine_original$company_unilever <- as.numeric(refine_original$company == "unilever")

#Second for product categories

refine_original$product_Laptop <- as.numeric(refine_original$category == "Laptop")
refine_original$company_Smartphone <- as.numeric(refine_original$category == "Smartphone")
refine_original$company_Tablet <- as.numeric(refine_original$category == "Tablet")
refine_original$company_TV <- as.numeric(refine_original$category == "TV")

#Export cleaned up dataset to csv
write.csv(refine_original, "refine_original_tidied.csv")
