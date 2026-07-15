# 01_build_dataset.R
#
# Builds the recipient-donor-year Aid for Trade (AfT) panel from OECD CRS
# data and merges in the bargaining-power covariates: UN voting alignment,
# colonial history, geographic proximity, trade costs/flows, WGI, economic
# complexity, migration, tariff concessions, reserves/GDP/debt, etc.
#
# Input:  data/raw/CRS/, data/raw/aft-bargaining-power/
# Output: data/processed/CRS_Data.xlsx

source(here::here("code/00_packages.R"))


# AfT Data ----

CRS_2006 <- read_excel(here::here("data/raw/CRS/crs_2006.xlsx"))
CRS_2007 <- read_excel(here::here("data/raw/CRS/crs_2007.xlsx"))
CRS_2008 <- read_excel(here::here("data/raw/CRS/crs_2008.xlsx"))
CRS_2009 <- read_excel(here::here("data/raw/CRS/crs_2009.xlsx"))
CRS_2010 <- read_excel(here::here("data/raw/CRS/crs_2010.xlsx"))
CRS_2011 <- read_excel(here::here("data/raw/CRS/crs_2011.xlsx"))
CRS_2012 <- read_excel(here::here("data/raw/CRS/crs_2012.xlsx"))
CRS_2013 <- read_excel(here::here("data/raw/CRS/crs_2013.xlsx"))
CRS_2014 <- read_excel(here::here("data/raw/CRS/crs_2014.xlsx"))
CRS_2015 <- read_excel(here::here("data/raw/CRS/crs_2015.xlsx"))
CRS_2016 <- read_excel(here::here("data/raw/CRS/crs_2016.xlsx"))
CRS_2017 <- read_excel(here::here("data/raw/CRS/crs_2017.xlsx"))
CRS_2018 <- read_excel(here::here("data/raw/CRS/crs_2018.xlsx"))
CRS_2019 <- read_excel(here::here("data/raw/CRS/crs_2019.xlsx"))
CRS_2020 <- read_excel(here::here("data/raw/CRS/crs_2020.xlsx"))
CRS_2021 <- read_excel(here::here("data/raw/CRS/crs_2021.xlsx"))
CRS_2022 <- read_excel(here::here("data/raw/CRS/crs_2022.xlsx"))
CRS_2023 <- read_excel(here::here("data/raw/CRS/crs_2023.xlsx"))

#### AfT flows total:

CRS_2006 <- CRS_2006 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2007 <- CRS_2007 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2008 <- CRS_2008 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2009 <- CRS_2009 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2010 <- CRS_2010 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2011 <- CRS_2011 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2012 <- CRS_2012 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2013 <- CRS_2013 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2014 <- CRS_2014 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2015 <- CRS_2015 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2016 <- CRS_2016 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2017 <- CRS_2017 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2018 <- CRS_2018 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2019 <- CRS_2019 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2020 <- CRS_2020 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2021 <- CRS_2021 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2022 <- CRS_2022 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

CRS_2023 <- CRS_2023 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, ChannelCode, SectorName)

AfT_data <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)


AfT_data <- AfT_data %>%
  filter(DonorName %in% c("France", "Germany", "Japan", "United Kingdom", "United States")) %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants")) %>%
  group_by(DonorName, RecipientName, Year) %>%
  summarise(
    USD_Disbursement = sum(USD_Disbursement, na.rm = TRUE),
    .groups = "drop"
  )

#### Delivery channel balance:

Channel_data <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)


Channel_data <- Channel_data %>%
  filter(DonorName %in% c("France", "Germany", "Japan", "United Kingdom", "United States")) %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants")) %>%
  group_by(DonorName, RecipientName, Year, ChannelCode) %>%
  summarise(
    USD_Disbursement = sum(USD_Disbursement, na.rm = TRUE),
    .groups = "drop"
  )

Channel_data$USD_Disbursement <- as.numeric(Channel_data$USD_Disbursement)
Channel_data <- Channel_data %>%
  mutate(ChannelCode = ifelse(is.na(ChannelCode), "NA", as.character(ChannelCode))) %>%
  pivot_wider(
    names_from = ChannelCode,
    values_from = USD_Disbursement,
    values_fill = 0
  )

Channel_data <- Channel_data %>%
  mutate(
    `Donor channels` = rowSums(across(starts_with(c("11", "22", "61"))), na.rm = TRUE),
    `Recipient channels` = rowSums(across(starts_with(c("12", "23", "62"))), na.rm = TRUE),
    `Other channels` = rowSums(across(-c(DonorName, RecipientName, Year,
                                         starts_with(c("11", "22", "61", 
                                                       "12", "23", "62")))),
                               na.rm = TRUE)
  )

Channel_data <- Channel_data %>%
  dplyr::select(Year, DonorName, RecipientName, `Donor channels`, `Recipient channels`, `Other channels`)

# `ChannelBalance` as a bounded share for robustness:
## Zero-handling: when donor channels = 0, the log-ratio measure conflates
## "all recipient-delivered" with "large recipient flows". A bounded share is
## cleaner and more interpretable, so it is retained as a robustness check
## alongside the primary log-ratio measure.

Channel_data <- Channel_data %>%
  mutate(
    donor_channel_log   = log1p(`Donor channels`),
    recipient_channel_log = log1p(`Recipient channels`),
    ChannelBalance = recipient_channel_log - donor_channel_log,
    channel_share = `Recipient channels` / (`Recipient channels` + `Donor channels`),
    # optional logit for unbounded support; guard the 0/1 endpoints:
    channel_share_logit = qlogis(pmin(pmax(channel_share, 0.001), 0.999))
  )

Channel_data <- Channel_data %>%
  dplyr::select(Year, DonorName, RecipientName, `Donor channels`, `Recipient channels`, `Other channels`, donor_channel_log, recipient_channel_log, ChannelBalance)

AfT_data$Year <- as.character(AfT_data$Year)
Channel_data$Year <- as.character(Channel_data$Year)

CRS_Data <- AfT_data %>%
  left_join(Channel_data, by = c("DonorName", "RecipientName", "Year"))


write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# UN voting data ----

AgreementScores <- read_csv(here::here("data/raw/aft-bargaining-power/un_voting_agreement_scores_2024-06.csv"))

AgreementScores <- filter(AgreementScores, year >= 2006)

AgreementScores <- AgreementScores %>%
  filter(ccode1 %in% c(2, 220, 255, 740, 200))

AgreementScores <- AgreementScores %>%
  mutate(ccode1 = case_when(
    ccode1 == 2 ~ "United States",
    ccode1 == 220 ~ "France",
    ccode1 == 255 ~ "Germany",
    ccode1 == 740 ~ "Japan",
    ccode1 == 200 ~ "United Kingdom"
  ))

AgreementScores <- AgreementScores %>%
  rename(DonorName = ccode1)

AgreementScores <- AgreementScores %>%
  rename(RecipientName = ccode2)

COW_country_codes <- read_csv(here::here("data/raw/aft-bargaining-power/cow_country_codes.csv"))

COW_country_codes <- COW_country_codes %>%
  distinct(CCode, .keep_all = TRUE)

AgreementScores <- AgreementScores %>%
  left_join(COW_country_codes, by = c("RecipientName" = "CCode"))

AgreementScores <- AgreementScores %>%
  mutate(RecipientName = StateNme) %>%
  dplyr::select(-StateNme) 

unique_database <- unique(CRS_Data$RecipientName)
unique_agreement <- unique(AgreementScores$RecipientName)

in_database_not_in_agreement <- setdiff(unique_database, unique_agreement)

in_agreement_not_in_database <- setdiff(unique_agreement, unique_database)

print("Values in Database but not in AgreementScores:")
print(in_database_not_in_agreement)

print("Values in AgreementScores but not in Database:")
print(in_agreement_not_in_database)

AgreementScores <- AgreementScores %>%
  mutate(RecipientName = case_when(
    RecipientName == "Antigua & Barbuda" ~ "Antigua and Barbuda",
    RecipientName == "Cape Verde" ~ "Cabo Verde",
    RecipientName == "St. Lucia" ~ "Saint Lucia",
    RecipientName == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    RecipientName == "Syria" ~ "Syrian Arab Republic",
    RecipientName == "Turkey" ~ "Türkiye",
    RecipientName == "China" ~ "China (People's Republic of)",
    RecipientName == "Ivory Coast" ~ "Côte d'Ivoire",
    RecipientName == "North Korea" ~ "Democratic People's Republic of Korea",
    RecipientName == "St. Kitts and Nevis" ~ "Saint Kitts and Nevis",
    RecipientName == "St. Helena" ~ "Saint Helena",
    RecipientName == "East Timor" ~ "Timor-Leste",
    RecipientName == "Swaziland" ~ "Eswatini",
    RecipientName == "Federated States of Micronesia" ~ "Micronesia",
    RecipientName == "Vietnam" ~ "Viet Nam",
    RecipientName == "Macedonia" ~ "North Macedonia",
    RecipientName == "Laos" ~ "Lao People's Democratic Republic",
    TRUE ~ RecipientName
  ))

AgreementScores <- AgreementScores %>%
  dplyr::select(-c(...1, session.x, NVotesAll.x, NVotesAll.y, StateAbb, IdealPointAll.x, IdealPointAll.y))

AgreementScores$year <- as.character(AgreementScores$year)
CRS_Data$Year <- as.character(CRS_Data$Year)

CRS_Data <- CRS_Data %>%
  left_join(AgreementScores, by = c("RecipientName", "DonorName", "Year"="year"))

# Colonial history ----

CRS_Data$COL_FR <- ifelse(CRS_Data$RecipientName == "Algeria", "62", 
                     ifelse(CRS_Data$RecipientName == "Benin", "60",
                     ifelse(CRS_Data$RecipientName == "Burkina Faso", "60",
                     ifelse(CRS_Data$RecipientName == "Cambodia", "53", 
                     ifelse(CRS_Data$RecipientName == "Cameroon", "60",
                     ifelse(CRS_Data$RecipientName == "Central African Republic", "60", 
                     ifelse(CRS_Data$RecipientName == "Chad", "60",
                     ifelse(CRS_Data$RecipientName == "Comoros", "75",
                     ifelse(CRS_Data$RecipientName == "Congo", "60",
                     ifelse(CRS_Data$RecipientName == "Côte d'Ivoire", "60",
                      ifelse(CRS_Data$RecipientName == "Djibouti", "77",
                      ifelse(CRS_Data$RecipientName == "Gabon", "60",
                      ifelse(CRS_Data$RecipientName == "Guinea", "58",
                      ifelse(CRS_Data$RecipientName == "Lao People's Democratic Republic", "53",
                      ifelse(CRS_Data$RecipientName == "Lebanon", "43",
                      ifelse(CRS_Data$RecipientName == "Madagascar", "60",
                      ifelse(CRS_Data$RecipientName == "Mali", "60",
                      ifelse(CRS_Data$RecipientName == "Mauritania", "60",
                      ifelse(CRS_Data$RecipientName == "Morocco", "56",
                      ifelse(CRS_Data$RecipientName == "Niger", "60",
                      ifelse(CRS_Data$RecipientName == "Senegal", "60",
                      ifelse(CRS_Data$RecipientName == "Syrian Arab Republic", "46",
                      ifelse(CRS_Data$RecipientName == "Togo", "60",
                      ifelse(CRS_Data$RecipientName == "Tunisia", "56",
                      ifelse(CRS_Data$RecipientName == "Viet Nam", "45", "0")))))))))))))))))))))))))

CRS_Data$COL_UK <- ifelse(CRS_Data$RecipientName == "Afghanistan", "19", 
                     ifelse(CRS_Data$RecipientName == "Antigua and Barbuda", "81",
                     ifelse(CRS_Data$RecipientName == "Bahrain", "71",
                     ifelse(CRS_Data$RecipientName == "Barbados", "66",
                     ifelse(CRS_Data$RecipientName == "Belize", "81",
                     ifelse(CRS_Data$RecipientName == "Botswana", "66",
                     ifelse(CRS_Data$RecipientName == "Dominica", "78",
                     ifelse(CRS_Data$RecipientName == "Egypt", "56",
                     ifelse(CRS_Data$RecipientName == "Eswatini", "68",
                     ifelse(CRS_Data$RecipientName == "Fiji", "70",
                     ifelse(CRS_Data$RecipientName == "Gambia", "65",
                     ifelse(CRS_Data$RecipientName == "Ghana", "57",
                     ifelse(CRS_Data$RecipientName == "Grenada", "74",
                     ifelse(CRS_Data$RecipientName == "Guyana", "66",
                     ifelse(CRS_Data$RecipientName == "India", "47",
                     ifelse(CRS_Data$RecipientName == "Iraq", "32",
                     ifelse(CRS_Data$RecipientName == "Jamaica", "62",
                     ifelse(CRS_Data$RecipientName == "Jordan", "46",
                     ifelse(CRS_Data$RecipientName == "Kenya", "63",
                     ifelse(CRS_Data$RecipientName == "Kiribati", "79",
                     ifelse(CRS_Data$RecipientName == "Lesotho", "66",
                     ifelse(CRS_Data$RecipientName == "Malawi", "64",
                     ifelse(CRS_Data$RecipientName == "Malaysia", "57",
                     ifelse(CRS_Data$RecipientName == "Maldives", "65",
                     ifelse(CRS_Data$RecipientName == "Mauritius", "68",
                     ifelse(CRS_Data$RecipientName == "Nauru", "68",
                     ifelse(CRS_Data$RecipientName == "Nigeria", "60",
                     ifelse(CRS_Data$RecipientName == "Pakistan", "47",
                     ifelse(CRS_Data$RecipientName == "Saint Kitts and Nevis", "83",
                     ifelse(CRS_Data$RecipientName == "Saint Lucia", "79",
                     ifelse(CRS_Data$RecipientName == "Saint Vincent and the Grenadines", "79",
                     ifelse(CRS_Data$RecipientName == "Seychelles", "76",
                     ifelse(CRS_Data$RecipientName == "Sierra Leone", "61",
                     ifelse(CRS_Data$RecipientName == "Solomon Islands", "78",
                     ifelse(CRS_Data$RecipientName == "Somalia", "60",
                     ifelse(CRS_Data$RecipientName == "South Africa", "94",
                     ifelse(CRS_Data$RecipientName == "Sri Lanka", "48",
                     ifelse(CRS_Data$RecipientName == "Sudan", "56",
                     ifelse(CRS_Data$RecipientName == "Tanzania", "63",
                     ifelse(CRS_Data$RecipientName == "Tonga", "70",
                     ifelse(CRS_Data$RecipientName == "Trinidad and Tobago", "62",
                     ifelse(CRS_Data$RecipientName == "Tuvalu", "78",
                     ifelse(CRS_Data$RecipientName == "Uganda", "62",
                     ifelse(CRS_Data$RecipientName == "Vanuatu", "80",
                     ifelse(CRS_Data$RecipientName == "Yemen", "67",
                     ifelse(CRS_Data$RecipientName == "Zambia", "64",
                     ifelse(CRS_Data$RecipientName == "Zimbabwe", "80",
                     ifelse(CRS_Data$RecipientName == "Burma", "48", "0"))))))))))))))))))))))))))))))))))))))))))))))))

CRS_Data$COL_US <- ifelse(CRS_Data$RecipientName == "Cuba", "2", 
                     ifelse(CRS_Data$RecipientName == "Marshall Islands", "86",
                     ifelse(CRS_Data$RecipientName == "Micronesia", "86",
                     ifelse(CRS_Data$RecipientName == "Palau", "94",
                     ifelse(CRS_Data$RecipientName == "Philippines", "46", "0")))))

CRS_Data$COL_JP <- ifelse(CRS_Data$RecipientName == "Democratic People's Republic of Korea", "45", "0")

# Geographical proximity ----

dist_cepii_2 <- read_excel(here::here("data/raw/aft-bargaining-power/cepii_geodist.xls"))

dist_cepii_2 <- dist_cepii_2 %>%
  rename(RecipientName = iso_o)

dist_cepii_2 <- dist_cepii_2 %>%
  rename(DonorName = iso_d)

dist_cepii_2_filtered <- dist_cepii_2 %>%
  filter(DonorName %in% c('DEU', 'FRA', 'GBR', 'USA', 'JPN'))

dist_cepii_2_filtered$DonorName <- ifelse(dist_cepii_2_filtered$DonorName == "DEU", "Germany",
                                   ifelse(dist_cepii_2_filtered$DonorName == "FRA", "France",
                                   ifelse(dist_cepii_2_filtered$DonorName == "USA", "United States",
                                   ifelse(dist_cepii_2_filtered$DonorName == "GBR", "United Kingdom",
                                   ifelse(dist_cepii_2_filtered$DonorName == "JPN", "Japan", dist_cepii_2_filtered$DonorName)))))

dist_cepii_2_filtered <- dist_cepii_2_filtered %>%
  dplyr::select(RecipientName, DonorName, distwces)

unique_database <- unique(CRS_Data$RecipientName)
unique_dist <- unique(dist_cepii_2_filtered$RecipientName)

in_database_not_in_dist <- setdiff(unique_database, unique_dist)

print("Values in Database but not in Distance Data:")
print(in_database_not_in_dist)

dist_cepii_2_filtered <- dist_cepii_2_filtered %>%
  mutate(RecipientName = case_when(
    RecipientName == "AFG" ~ "Afghanistan",
    RecipientName == "ALB" ~ "Albania",
    RecipientName == "DZA" ~ "Algeria",
    RecipientName == "AGO" ~ "Angola",
    RecipientName == "ARG" ~ "Argentina",
    RecipientName == "ARM" ~ "Armenia",
    RecipientName == "AZE" ~ "Azerbaijan",
    RecipientName == "BGD" ~ "Bangladesh",
    RecipientName == "BLR" ~ "Belarus",
    RecipientName == "BEN" ~ "Benin",
    RecipientName == "BOL" ~ "Bolivia",
    RecipientName == "BIH" ~ "Bosnia and Herzegovina",
    RecipientName == "BWA" ~ "Botswana",
    RecipientName == "BRA" ~ "Brazil",
    RecipientName == "BFA" ~ "Burkina Faso",
    RecipientName == "BDI" ~ "Burundi",
    RecipientName == "CPV" ~ "Cabo Verde",
    RecipientName == "KHM" ~ "Cambodia",
    RecipientName == "CMR" ~ "Cameroon",
    RecipientName == "CAF" ~ "Central African Republic",
    RecipientName == "TCD" ~ "Chad",
    RecipientName == "CHL" ~ "Chile",
    RecipientName == "CHN" ~ "China (People's Republic of)",
    RecipientName == "COL" ~ "Colombia",
    RecipientName == "COM" ~ "Comoros",
    RecipientName == "COG" ~ "Congo",
    RecipientName == "COK" ~ "Cook Islands",
    RecipientName == "CRI" ~ "Costa Rica",
    RecipientName == "HRV" ~ "Croatia",
    RecipientName == "CUB" ~ "Cuba",
    RecipientName == "CIV" ~ "Côte d'Ivoire",
    RecipientName == "PRK" ~ "Democratic People's Republic of Korea",
    RecipientName == "ZAR" ~ "Democratic Republic of the Congo",
    RecipientName == "DJI" ~ "Djibouti",
    RecipientName == "DMA" ~ "Dominica",
    RecipientName == "DOM" ~ "Dominican Republic",
    RecipientName == "ECU" ~ "Ecuador",
    RecipientName == "EGY" ~ "Egypt",
    RecipientName == "SLV" ~ "El Salvador",
    RecipientName == "GNQ" ~ "Equatorial Guinea",
    RecipientName == "SWZ" ~ "Eswatini",
    RecipientName == "ETH" ~ "Ethiopia",
    RecipientName == "FJI" ~ "Fiji",
    RecipientName == "GAB" ~ "Gabon",
    RecipientName == "GMB" ~ "Gambia",
    RecipientName == "GEO" ~ "Georgia",
    RecipientName == "GHA" ~ "Ghana",
    RecipientName == "GRD" ~ "Grenada",
    RecipientName == "GTM" ~ "Guatemala",
    RecipientName == "GIN" ~ "Guinea",
    RecipientName == "GNB" ~ "Guinea-Bissau",
    RecipientName == "HTI" ~ "Haiti",
    RecipientName == "HND" ~ "Honduras",
    RecipientName == "IND" ~ "India",
    RecipientName == "IDN" ~ "Indonesia",
    RecipientName == "IRN" ~ "Iran",
    RecipientName == "IRQ" ~ "Iraq",
    RecipientName == "JAM" ~ "Jamaica",
    RecipientName == "JOR" ~ "Jordan",
    RecipientName == "KAZ" ~ "Kazakhstan",
    RecipientName == "KEN" ~ "Kenya",
    RecipientName == "KGZ" ~ "Kyrgyzstan",
    RecipientName == "LAO" ~ "Lao People's Democratic Republic",
    RecipientName == "LBN" ~ "Lebanon",
    RecipientName == "LSO" ~ "Lesotho",
    RecipientName == "LBR" ~ "Liberia",
    RecipientName == "LBY" ~ "Libya",
    RecipientName == "MDG" ~ "Madagascar",
    RecipientName == "MWI" ~ "Malawi",
    RecipientName == "MYS" ~ "Malaysia",
    RecipientName == "MDV" ~ "Maldives",
    RecipientName == "MLI" ~ "Mali",
    RecipientName == "MRT" ~ "Mauritania",
    RecipientName == "MUS" ~ "Mauritius",
    RecipientName == "MEX" ~ "Mexico",
    RecipientName == "MDA" ~ "Moldova",
    RecipientName == "MNG" ~ "Mongolia",
    RecipientName == "YUG" ~ "Montenegro",
    RecipientName == "MAR" ~ "Morocco",
    RecipientName == "MOZ" ~ "Mozambique",
    RecipientName == "MMR" ~ "Myanmar",
    RecipientName == "NAM" ~ "Namibia",
    RecipientName == "NPL" ~ "Nepal",
    RecipientName == "NIC" ~ "Nicaragua",
    RecipientName == "NER" ~ "Niger",
    RecipientName == "NGA" ~ "Nigeria",
    RecipientName == "MKD" ~ "North Macedonia",
    RecipientName == "PAK" ~ "Pakistan",
    RecipientName == "PAN" ~ "Panama",
    RecipientName == "PNG" ~ "Papua New Guinea",
    RecipientName == "PRY" ~ "Paraguay",
    RecipientName == "PER" ~ "Peru",
    RecipientName == "PHL" ~ "Philippines",
    RecipientName == "RWA" ~ "Rwanda",
    RecipientName == "LCA" ~ "Saint Lucia",
    RecipientName == "VCT" ~ "Saint Vincent and the Grenadines",
    RecipientName == "STP" ~ "Sao Tome and Principe",
    RecipientName == "SEN" ~ "Senegal",
    RecipientName == "SYC" ~ "Seychelles",
    RecipientName == "SLE" ~ "Sierra Leone",
    RecipientName == "SOM" ~ "Somalia",
    RecipientName == "ZAF" ~ "South Africa",
    RecipientName == "LKA" ~ "Sri Lanka",
    RecipientName == "SDN" ~ "Sudan",
    RecipientName == "SUR" ~ "Suriname",
    RecipientName == "SYR" ~ "Syrian Arab Republic",
    RecipientName == "TJK" ~ "Tajikistan",
    RecipientName == "TZA" ~ "Tanzania",
    RecipientName == "THA" ~ "Thailand",
    RecipientName == "TGO" ~ "Togo",
    RecipientName == "TON" ~ "Tonga",
    RecipientName == "TTO" ~ "Trinidad and Tobago",
    RecipientName == "TUN" ~ "Tunisia",
    RecipientName == "TUR" ~ "Türkiye",
    RecipientName == "UGA" ~ "Uganda",
    RecipientName == "UKR" ~ "Ukraine",
    RecipientName == "URY" ~ "Uruguay",
    RecipientName == "UZB" ~ "Uzbekistan",
    RecipientName == "VUT" ~ "Vanuatu",
    RecipientName == "VEN" ~ "Venezuela",
    RecipientName == "VNM" ~ "Viet Nam",
    RecipientName == "WLF" ~ "Wallis and Futuna",
    RecipientName == "PAL" ~ "West Bank and Gaza Strip",
    RecipientName == "YEM" ~ "Yemen",
    RecipientName == "ZMB" ~ "Zambia",
    RecipientName == "ZWE" ~ "Zimbabwe",
    RecipientName == "ATG" ~ "Antigua and Barbuda",
    RecipientName == "BRB" ~ "Barbados",
    RecipientName == "BLZ" ~ "Belize",
    RecipientName == "BTN" ~ "Bhutan",
    RecipientName == "ERI" ~ "Eritrea",
    RecipientName == "GUY" ~ "Guyana",
    RecipientName == "MHL" ~ "Marshall Islands",
    RecipientName == "FSM" ~ "Micronesia",
    RecipientName == "KNA" ~ "Saint Kitts and Nevis",
    RecipientName == "WSM" ~ "Samoa",
    RecipientName == "SLB" ~ "Solomon Islands",
    RecipientName == "TMP" ~ "Timor-Leste",
    RecipientName == "TKM" ~ "Turkmenistan",
    RecipientName == "KIR" ~ "Kiribati",
    RecipientName == "NRU" ~ "Nauru",
    RecipientName == "NIU" ~ "Niue",
    RecipientName == "OMN" ~ "Oman",
    RecipientName == "PLW" ~ "Palau",
    RecipientName == "SAU" ~ "Saudi Arabia",
    RecipientName == "TUV" ~ "Tuvalu",
    RecipientName == "AIA" ~ "Anguilla",
    RecipientName == "SHN" ~ "Saint Helena",
    RecipientName == "TCA" ~ "Turks and Caicos Islands",
    RecipientName == "MSR" ~ "Montserrat",
    TRUE ~ RecipientName
  ))

CRS_Data <- CRS_Data %>%
  left_join(dist_cepii_2_filtered, by = c("RecipientName", "DonorName"))

# Filling in values for Serbia since in dataset Serbia and Montenegro are together.

montenegro_dist <- CRS_Data %>%
  filter(RecipientName == "Montenegro") %>%
  distinct(DonorName, distwces)

CRS_Data <- CRS_Data %>%
  left_join(
    montenegro_dist,
    by = "DonorName",
    suffix = c("", "_montenegro")
  ) %>%
  mutate(
    distwces = ifelse(
      RecipientName == "Serbia" & is.na(distwces),
      distwces_montenegro,
      distwces
    )
  ) %>%
  dplyr::select(-distwces_montenegro)


# Cost of trade ----

Cost_of_trade <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_trade_costs.csv"))

Cost_of_trade <- Cost_of_trade %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, OBS_VALUE)

Cost_of_trade <- Cost_of_trade %>%
  rename(RecipientName = `Reference area`)

Cost_of_trade <- Cost_of_trade %>%
  rename(DonorName = `Counterpart area`)

Cost_of_trade <- Cost_of_trade %>%
  rename(Year = TIME_PERIOD)

Cost_of_trade <- Cost_of_trade %>%
  rename(Cost_Trade = OBS_VALUE)

CRS_Data$Year <- as.character(CRS_Data$Year)
Cost_of_trade$Year <- as.character(Cost_of_trade$Year)

CRS_Data <- CRS_Data %>%
  left_join(Cost_of_trade, by = c("RecipientName", "DonorName", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Merch exports to the world ----

#### Recipients:

World_exports <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_goods_exports_world.csv"))

World_exports <- World_exports %>%
  mutate(world_exp = OBS_VALUE)

World_exports <- World_exports %>%
  filter(Adjustment %in% "Balanced value")

World_exports <- World_exports %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, world_exp)

unique_merged <- unique(CRS_Data$RecipientName)
unique_exp <- unique(World_exports$`Reference area`)

in_merged_not_in_exp <- setdiff(unique_merged, unique_exp)
in_exp_not_in_merged <- setdiff(unique_exp, unique_merged)

print("Values in merged data but not in export data:")
print(in_merged_not_in_exp)

print("Values in export data but not in merged data:")
print(in_exp_not_in_merged)

World_exports <- World_exports %>%
  mutate(`Reference area` = case_when(
    `Reference area` == "China (People’s Republic of)" ~ "China (People's Republic of)",
    `Reference area` == "Côte d’Ivoire" ~ "Côte d'Ivoire",
    `Reference area` == "Democratic People’s Republic of Korea" ~ "Democratic People's Republic of Korea",
    `Reference area` == "Lao People’s Democratic Republic" ~ "Lao People's Democratic Republic",
    `Reference area` == "Palestinian Authority or West Bank and Gaza Strip" ~ "West Bank and Gaza Strip",
    TRUE ~ `Reference area`
  ))

CRS_Data$Year <- as.numeric(CRS_Data$Year)
World_exports$TIME_PERIOD <- as.numeric(World_exports$TIME_PERIOD)

World_exports <- World_exports %>%
  dplyr::select(-`Counterpart area`)

CRS_Data <- CRS_Data %>%
            left_join(World_exports, by = c("RecipientName" = "Reference area", "Year" = "TIME_PERIOD"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

#### Donors:

World_exports <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_goods_exports_world.csv"))

World_exports <- World_exports %>%
  mutate(world_exp = OBS_VALUE)

World_exports <- World_exports %>%
  filter(Adjustment %in% "Balanced value")

World_exports <- World_exports %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, world_exp)

unique_merged <- unique(CRS_Data$RecipientName)
unique_exp <- unique(World_exports$`Reference area`)

in_merged_not_in_exp <- setdiff(unique_merged, unique_exp)
in_exp_not_in_merged <- setdiff(unique_exp, unique_merged)

print("Values in merged data but not in export data:")
print(in_merged_not_in_exp)

print("Values in export data but not in merged data:")
print(in_exp_not_in_merged)

CRS_Data$Year <- as.numeric(CRS_Data$Year)
World_exports$TIME_PERIOD <- as.numeric(World_exports$TIME_PERIOD)

World_exports <- World_exports %>%
  dplyr::select(-`Counterpart area`)

World_exports <- World_exports %>%
  rename(world_exp_donors = world_exp)

CRS_Data <- CRS_Data %>%
            left_join(World_exports, by = c("DonorName" = "Reference area", "Year" = "TIME_PERIOD"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Bilateral trade in services ----

TradeServices <- read_csv(here::here("data/raw/aft-bargaining-power/OECD-WTO_BATIS_BPM6_December2025_bulk.csv"))

print(unique(TradeServices$Partner))

TradeServices <- TradeServices %>%
  filter(Partner %in% c("US", "GB", "JP", "FR", "DE"))

TradeServices <- TradeServices %>%
  filter(Item_code == "S")

TradeServices <- TradeServices %>%
  dplyr::select(-c(type_Reporter, type_Partner, Item_code, type_Item, Reported_value, Final_value_methodology, Balanced_value))

TradeServices_wide <- TradeServices %>%
  pivot_wider(
    id_cols = c(Reporter, Partner, Year),
    names_from = Flow,
    values_from = Final_value,
    names_prefix = "Final_"
  )


print(unique(TradeServices_wide$Reporter))

TradeServices_wide <- TradeServices_wide %>%
  mutate(
    Reporter = case_when(
      Reporter == "AF" ~ "Afghanistan",
      Reporter == "AO" ~ "Angola",
      Reporter == "AL" ~ "Albania",
      Reporter == "AR" ~ "Argentina",
      Reporter == "AM" ~ "Armenia",
      Reporter == "AG" ~ "Antigua and Barbuda",
      Reporter == "AZ" ~ "Azerbaijan",
      Reporter == "BI" ~ "Burundi",
      Reporter == "BJ" ~ "Benin",
      Reporter == "BF" ~ "Burkina Faso",
      Reporter == "BD" ~ "Bangladesh",
      Reporter == "BH" ~ "Bahrain",
      Reporter == "BA" ~ "Bosnia and Herzegovina",
      Reporter == "BY" ~ "Belarus",
      Reporter == "BZ" ~ "Belize",
      Reporter == "BO" ~ "Bolivia",
      Reporter == "BR" ~ "Brazil",
      Reporter == "BB" ~ "Barbados",
      Reporter == "BT" ~ "Bhutan",
      Reporter == "BW" ~ "Botswana",
      Reporter == "CF" ~ "Central African Republic",
      Reporter == "CL" ~ "Chile",
      Reporter == "CN" ~ "China (People's Republic of)",
      Reporter == "CI" ~ "Côte d'Ivoire",
      Reporter == "CM" ~ "Cameroon",
      Reporter == "CD" ~ "Democratic Republic of the Congo",
      Reporter == "CG" ~ "Congo",
      Reporter == "CO" ~ "Colombia",
      Reporter == "KM" ~ "Comoros",
      Reporter == "CV" ~ "Cabo Verde",
      Reporter == "CR" ~ "Costa Rica",
      Reporter == "DJ" ~ "Djibouti",
      Reporter == "DM" ~ "Dominica", 
      Reporter == "DO" ~ "Dominican Republic",
      Reporter == "DZ" ~ "Algeria",
      Reporter == "EC" ~ "Ecuador",
      Reporter == "EG" ~ "Egypt",
      Reporter == "CU" ~ "Cuba",
      Reporter == "ER" ~ "Eritrea",
      Reporter == "ET" ~ "Ethiopia",
      Reporter == "FJ" ~ "Fiji",
      Reporter == "GA" ~ "Gabon",
      Reporter == "GE" ~ "Georgia",
      Reporter == "GH" ~ "Ghana",
      Reporter == "GN" ~ "Guinea",
      Reporter == "GM" ~ "Gambia",
      Reporter == "GW" ~ "Guinea-Bissau",
      Reporter == "GQ" ~ "Equatorial Guinea",
      Reporter == "GD" ~ "Grenada",
      Reporter == "GT" ~ "Guatemala",
      Reporter == "GY" ~ "Guyana",
      Reporter == "HN" ~ "Honduras",
      Reporter == "HT" ~ "Haiti",
      Reporter == "HR" ~ "Croatia",
      Reporter == "ID" ~ "Indonesia",
      Reporter == "IN" ~ "India",
      Reporter == "IR" ~ "Iran",
      Reporter == "IQ" ~ "Iraq",
      Reporter == "JM" ~ "Jamaica",
      Reporter == "JO" ~ "Jordan",
      Reporter == "KZ" ~ "Kazakhstan",
      Reporter == "KE" ~ "Kenya",
      Reporter == "KG" ~ "Kyrgyzstan",
      Reporter == "KH" ~ "Cambodia",
      Reporter == "KI" ~ "Kiribati",
      Reporter == "888" ~ "Kosovo",
      Reporter == "KN" ~ "Saint Kitts and Nevis",
      Reporter == "LA" ~ "Lao People's Democratic Republic",
      Reporter == "LB" ~ "Lebanon",
      Reporter == "LR" ~ "Liberia",
      Reporter == "LY" ~ "Libya",
      Reporter == "LC" ~ "Saint Lucia",
      Reporter == "LK" ~ "Sri Lanka",
      Reporter == "LS" ~ "Lesotho",
      Reporter == "MA" ~ "Morocco",
      Reporter == "MD" ~ "Moldova",
      Reporter == "MG" ~ "Madagascar",
      Reporter == "MV" ~ "Maldives",
      Reporter == "MX" ~ "Mexico",
      Reporter == "MK" ~ "North Macedonia",
      Reporter == "ML" ~ "Mali",
      Reporter == "MM" ~ "Myanmar",
      Reporter == "ME" ~ "Montenegro",
      Reporter == "MN" ~ "Mongolia",
      Reporter == "MZ" ~ "Mozambique",
      Reporter == "MR" ~ "Mauritania",
      Reporter == "MU" ~ "Mauritius",
      Reporter == "MW" ~ "Malawi",
      Reporter == "MY" ~ "Malaysia",
      Reporter == "NA" ~ "Namibia",
      Reporter == "NE" ~ "Niger",
      Reporter == "NG" ~ "Nigeria",
      Reporter == "NI" ~ "Nicaragua",
      Reporter == "NP" ~ "Nepal",
      Reporter == "OM" ~ "Oman",
      Reporter == "PK" ~ "Pakistan",
      Reporter == "PA" ~ "Panama",
      Reporter == "PE" ~ "Peru",
      Reporter == "PH" ~ "Philippines",
      Reporter == "PG" ~ "Papua New Guinea",
      Reporter == "KP" ~ "Democratic People's Republic of Korea",
      Reporter == "PY" ~ "Paraguay",
      Reporter == "RW" ~ "Rwanda",
      Reporter == "SA" ~ "Saudi Arabia",
      Reporter == "SD" ~ "Sudan",
      Reporter == "SN" ~ "Senegal",
      Reporter == "SB" ~ "Solomon Islands",
      Reporter == "SL" ~ "Sierra Leone",
      Reporter == "SV" ~ "El Salvador",
      Reporter == "SO" ~ "Somalia",
      Reporter == "ST" ~ "Sao Tome and Principe",
      Reporter == "SR" ~ "Suriname",
      Reporter == "SZ" ~ "Eswatini",
      Reporter == "SC" ~ "Seychelles",
      Reporter == "SY" ~ "Syrian Arab Republic",
      Reporter == "TD" ~ "Chad",
      Reporter == "TG" ~ "Togo",
      Reporter == "TH" ~ "Thailand",
      Reporter == "TJ" ~ "Tajikistan",
      Reporter == "TM" ~ "Turkmenistan",
      Reporter == "TL" ~ "Timor-Leste",
      Reporter == "TO" ~ "Tonga",
      Reporter == "TT" ~ "Trinidad and Tobago",
      Reporter == "TN" ~ "Tunisia",
      Reporter == "TR" ~ "Türkiye",
      Reporter == "TV" ~ "Tuvalu",
      Reporter == "TZ" ~ "Tanzania",
      Reporter == "UG" ~ "Uganda",
      Reporter == "UA" ~ "Ukraine",
      Reporter == "UY" ~ "Uruguay",
      Reporter == "UZ" ~ "Uzbekistan",
      Reporter == "VC" ~ "Saint Vincent and the Grenadines",
      Reporter == "VE" ~ "Venezuela",
      Reporter == "VN" ~ "Viet Nam",
      Reporter == "VU" ~ "Vanuatu",
      Reporter == "WS" ~ "Samoa",
      Reporter == "YE" ~ "Yemen",
      Reporter == "ZA" ~ "South Africa",
      Reporter == "ZM" ~ "Zambia",
      Reporter == "ZW" ~ "Zimbabwe",
      TRUE ~ Reporter
    ),
    Partner = case_when(
      Partner == "DE" ~ "Germany",
      Partner == "FR" ~ "France",
      Partner == "US" ~ "United States",
      Partner == "GB" ~ "United Kingdom",
      Partner == "JP" ~ "Japan",
      TRUE ~ Partner
    )
  )

TradeServices_wide <- TradeServices_wide %>%
  rename(RecipientName = Reporter)

TradeServices_wide <- TradeServices_wide %>%
  rename(DonorName = Partner)

TradeServices_wide <- TradeServices_wide %>%
  rename(FinalEXP = Final_X)

TradeServices_wide <- TradeServices_wide %>%
  rename(FinalIMP = Final_M)

CRS_Data$Year <- as.numeric(CRS_Data$Year)
TradeServices_wide$Year <- as.numeric(TradeServices_wide$Year)

CRS_Data <- CRS_Data %>%
  left_join(TradeServices_wide, by = c("RecipientName", "DonorName", "Year"))

# Bilateral trade in goods ----

TradeGoods <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_bilateral_trade_goods_recipient_exports.csv"))

TradeGoods <- TradeGoods %>%
  mutate(good_exp = OBS_VALUE)

TradeGoods <- TradeGoods %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, good_exp)

unique_merged <- unique(CRS_Data$RecipientName)
unique_exp <- unique(TradeGoods$`Reference area`)

in_merged_not_in_exp <- setdiff(unique_merged, unique_exp)
in_exp_not_in_merged <- setdiff(unique_exp, unique_merged)

print("Values in merged data but not in export data:")
print(in_merged_not_in_exp)

print("Values in export data but not in merged data:")
print(in_exp_not_in_merged)

TradeGoods <- TradeGoods %>%
  mutate(`Reference area` = case_when(
    `Reference area` == "China (People’s Republic of)" ~ "China (People's Republic of)",
    `Reference area` == "Côte d’Ivoire" ~ "Côte d'Ivoire",
    `Reference area` == "Democratic People’s Republic of Korea" ~ "Democratic People's Republic of Korea",
    `Reference area` == "Lao People’s Democratic Republic" ~ "Lao People's Democratic Republic",
    `Reference area` == "Palestinian Authority or West Bank and Gaza Strip" ~ "West Bank and Gaza Strip",
    TRUE ~ `Reference area`
  ))

CRS_Data$Year <- as.numeric(CRS_Data$Year)
TradeGoods$TIME_PERIOD <- as.numeric(TradeGoods$TIME_PERIOD)

CRS_Data <- CRS_Data %>%
            left_join(TradeGoods, by = c("RecipientName" = "Reference area", "DonorName" = "Counterpart area", "Year" = "TIME_PERIOD"))

TradeGoods2 <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_bilateral_trade_goods_recipient_imports.csv"))

TradeGoods2 <- TradeGoods2 %>%
  mutate(good_imp = OBS_VALUE)

TradeGoods2 <- TradeGoods2 %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, good_imp)

TradeGoods2 <- TradeGoods2 %>%
  mutate(`Reference area` = case_when(
    `Reference area` == "China (People’s Republic of)" ~ "China (People's Republic of)",
    `Reference area` == "Côte d’Ivoire" ~ "Côte d'Ivoire",
    `Reference area` == "Democratic People’s Republic of Korea" ~ "Democratic People's Republic of Korea",
    `Reference area` == "Lao People’s Democratic Republic" ~ "Lao People's Democratic Republic",
    `Reference area` == "Palestinian Authority or West Bank and Gaza Strip" ~ "West Bank and Gaza Strip",
    TRUE ~ `Reference area`
  ))

CRS_Data$Year <- as.numeric(CRS_Data$Year)
TradeGoods2$TIME_PERIOD <- as.numeric(TradeGoods2$TIME_PERIOD)

CRS_Data <- CRS_Data %>%
            left_join(TradeGoods2, by = c("DonorName" = "Reference area", "RecipientName" = "Counterpart area", "Year" = "TIME_PERIOD"))

CRS_Data$expshare_recipient <- CRS_Data$good_exp/CRS_Data$world_exp #Recipients' exports to donor as a share of total recipient exports

TradeGoods3 <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_donor_exports_world.csv"))

TradeGoods3 <- TradeGoods3 %>%
  mutate(goodsexp_donor = OBS_VALUE)

TradeGoods3 <- TradeGoods3 %>%
  dplyr::select(`Reference area`, `Counterpart area`, TIME_PERIOD, goodsexp_donor)

CRS_Data$Year <- as.numeric(CRS_Data$Year)
TradeGoods3$TIME_PERIOD <- as.numeric(TradeGoods3$TIME_PERIOD)

TradeGoods3 <- TradeGoods3 %>%
  dplyr::select(-`Counterpart area`)

CRS_Data <- CRS_Data %>%
            left_join(TradeGoods3, by = c("DonorName" = "Reference area", "Year" = "TIME_PERIOD"))

CRS_Data$expshare_donor <- CRS_Data$good_imp/CRS_Data$goodsexp_donor #Recipients' imports from donor as a share of total donor exports

CRS_Data <- CRS_Data %>%
  dplyr::select(-goodsexp_donor)

# Goods and services exports ----

#### Recipients:

Goods_and_services_exports <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_goods_services_exports.csv"))

Goods_and_services_exports <- Goods_and_services_exports %>%
  dplyr::select(-c(`Country Code`, `Series Name`, `Series Code`))

Goods_and_services_exports <- Goods_and_services_exports %>%
  pivot_longer(cols = !(`Country Name`),
               names_to = "Year",
               values_to = "total_exports")

# World Bank uses ".." as its missing-value marker, so this column reads in
# as character; coerce to numeric (".." -> NA) before it is used in arithmetic.
Goods_and_services_exports <- Goods_and_services_exports %>%
  mutate(total_exports = suppressWarnings(as.numeric(total_exports)))

Goods_and_services_exports <- Goods_and_services_exports %>%
  mutate(`Country Name` = case_when(
    `Country Name` == "China" ~ "China (People's Republic of)",
    `Country Name` == "Congo, Rep." ~ "Congo",
    `Country Name` == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    `Country Name` == "Korea, Dem. People's Rep." ~ "Democratic People's Republic of Korea",
    `Country Name` == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    `Country Name` == "Egypt, Arab Rep." ~ "Egypt",
    `Country Name` == "Gambia, The" ~ "Gambia",
    `Country Name` == "Iran, Islamic Rep." ~ "Iran",
    `Country Name` == "Kyrgyz Republic" ~ "Kyrgyzstan",
    `Country Name` == "Lao PDR" ~ "Lao People's Democratic Republic",
    `Country Name` == "St. Lucia" ~ "Saint Lucia",
    `Country Name` == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    `Country Name` == "Somalia, Fed. Rep." ~ "Somalia",
    `Country Name` == "Turkiye" ~ "Türkiye",
    `Country Name` == "Venezuela, RB" ~ "Venezuela",
    `Country Name` == "West Bank and Gaza" ~ "West Bank and Gaza Strip",
    `Country Name` == "Yemen, Rep." ~ "Yemen",
    `Country Name` == "Micronesia, Fed. Sts." ~ "Micronesia",
    TRUE ~ `Country Name`
  ))

CRS_Data$Year <- as.numeric(CRS_Data$Year)
Goods_and_services_exports$Year <- as.numeric(Goods_and_services_exports$Year)

CRS_Data <- CRS_Data %>%
  left_join(Goods_and_services_exports, by = c("RecipientName" = "Country Name", "Year"))

#### Donors:

Goods_and_services_exports <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_goods_services_exports.csv"))

Goods_and_services_exports <- Goods_and_services_exports %>%
  dplyr::select(-c(`Country Code`, `Series Name`, `Series Code`))

Goods_and_services_exports <- Goods_and_services_exports %>%
  pivot_longer(cols = !(`Country Name`),
               names_to = "Year",
               values_to = "total_exports_donor")

# Same ".." missing-value coercion as the recipient-side pull above.
Goods_and_services_exports <- Goods_and_services_exports %>%
  mutate(total_exports_donor = suppressWarnings(as.numeric(total_exports_donor)))

CRS_Data$Year <- as.numeric(CRS_Data$Year)
Goods_and_services_exports$Year <- as.numeric(Goods_and_services_exports$Year)

CRS_Data <- CRS_Data %>%
  left_join(Goods_and_services_exports, by = c("DonorName" = "Country Name", "Year"))

#### Asymmetry:

CRS_Data <- CRS_Data %>%
  mutate(
    recipient_dependency = (good_exp + FinalEXP) * 1e6 / total_exports,
    donor_dependency     = (good_imp + FinalIMP) * 1e6 / total_exports_donor,
    total_asym           = donor_dependency - recipient_dependency
  )

summary(CRS_Data$recipient_dependency)   # expect mostly 0–0.3, not 1e-9
summary(CRS_Data$total_asym)

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Bilateral investment treaties ----

CRS_Data$BITs <- NA

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Pakistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Malaysia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Togo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Morocco" &
              CRS_Data$Year < 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Liberia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Guinea" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Türkiye"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Cameroon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Madagascar" &
              CRS_Data$Year < 2016] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Sudan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Tunisia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Senegal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Ethiopia" &
              CRS_Data$Year < 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Niger"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Tanzania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Sierra Leone"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Central African Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Côte d'Ivoire"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Uganda"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Zambia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Chad"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Rwanda"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Indonesia" &
              CRS_Data$Year < 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Democratic Republic of the Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Gabon" &
              CRS_Data$Year < 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mauritius"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Haiti"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Yemen" &
              CRS_Data$Year < 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Egypt" &
              CRS_Data$Year < 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Jordan" &
              CRS_Data$Year < 2011] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mali"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Syrian Arab Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Benin"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Papua New Guinea"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Bangladesh"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Somalia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Lesotho"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mauritania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Panama"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Burundi"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Dominica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Saint Lucia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Saint Vincent and the Grenadines"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Nepal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Bolivia" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Montenegro"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Serbia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Guyana"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Cabo Verde"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Eswatini"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Argentina"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mongolia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Albania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Kazakhstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Jamaica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Ukraine"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Belarus"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Viet Nam"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Uzbekistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Georgia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Paraguay"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Namibia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Moldova"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Costa Rica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Peru"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Ghana"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Honduras"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "India" &
              CRS_Data$Year < 2018] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "South Africa" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Zimbabwe"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Armenia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Azerbaijan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Algeria"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Ecuador" &
              CRS_Data$Year < 2019] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Cuba"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Kenya"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Nicaragua"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Venezuela"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Lao People's Democratic Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "North Macedonia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Burkina Faso" &
              CRS_Data$Year >= 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Lebanon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Philippines"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Turkmenistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Kyrgyzstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "El Salvador"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mexico"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Gabon" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Cambodia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Sri Lanka"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Nigeria" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Botswana" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Morocco" &
              CRS_Data$Year >= 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Bosnia and Herzegovina" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Mozambique" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Thailand"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Iran"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Tajikistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Indonesia" &
              CRS_Data$Year >= 2007 & CRS_Data$Year < 2018] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Guatemala"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Angola" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "China (People's Republic of)"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Ethiopia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Libya" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Yemen" &
              CRS_Data$Year >= 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Afghanistan" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Egypt" &
              CRS_Data$Year >= 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Madagascar" &
              CRS_Data$Year >= 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Guinea" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Bahrain" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Germany" & 
              CRS_Data$RecipientName == "Jordan" &
              CRS_Data$Year >= 2010] <- 1


CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Democratic Republic of the Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Mauritius"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Idonesia" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2016] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Montenegro"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Serbia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Egypt"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Malaysia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Syrian Arab Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Jordan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Sudan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "El Salvador"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Paraguay"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Liberia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Sri Lanka"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Equatorial Guinea"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Panama"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Nepal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Pakistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Costa Rica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Yemen"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Haiti"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "China (People's Republic of)" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2011] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Bangladesh"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Bolivia" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Lao People's Democratic Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Nigeria"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Argentina"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Mongolia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Viet Nam"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Jamaica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Algeria"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Peru"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Uzbekistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Turkmenistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Ukraine"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Kyrgyzstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Ecuador" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2019] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Philippines"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Albania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "South Africa" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Armenia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Morocco"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Lebanon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Georgia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Cuba"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "India" &
              CRS_Data$Year >= 2006 & CRS_Data$Year < 2018] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Moldova"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Tunisia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "North Macedonia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Kazakhstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Nicaragua"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Honduras"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Guatemala"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Namibia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Azerbaijan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Mexico"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Dominican Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Cambodia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Venezuela"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Zambia" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Mozambique"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Tajikistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Uganda"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Iran"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Ethiopia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Madagascar"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Bosnia and Herzegovina" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Bahrain"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Libya"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Türkiye" &
              CRS_Data$Year >= 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Guinea" &
              CRS_Data$Year >= 2017] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Senegal" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "China (People's Republic of)" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Kenya" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Djibouti" &
              CRS_Data$Year >= 2010] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Iraq" &
              CRS_Data$Year >= 2016] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "France" & 
              CRS_Data$RecipientName == "Colombia" &
              CRS_Data$Year >= 2020] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Egypt"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Sri Lanka"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "China (People's Republic of)"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Türkiye"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Pakistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Bangladesh"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Mongolia" &
              CRS_Data$Year < 2017] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Viet Nam"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Cambodia" &
              CRS_Data$Year >= 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Lao People's Democratic Republic" &
              CRS_Data$Year >= 2008] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Uzbekistan" &
              CRS_Data$Year >= 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Peru" &
              CRS_Data$Year >= 2009] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Papua New Guinea" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Colombia" &
              CRS_Data$Year >= 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Iraq" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Mozambique" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Myanmar" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Kazakhstan" &
              CRS_Data$Year >= 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Ukraine" &
              CRS_Data$Year >= 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Iran" &
              CRS_Data$Year >= 2017] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Kenya" &
              CRS_Data$Year >= 2017] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Armenia" &
              CRS_Data$Year >= 2019] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Jordan" &
              CRS_Data$Year >= 2020] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Morocco" &
              CRS_Data$Year >= 2022] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Côte d'Ivoire" &
              CRS_Data$Year >= 2021] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Georgia" &
              CRS_Data$Year >= 2021] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "Japan" & 
              CRS_Data$RecipientName == "Bahrain" &
              CRS_Data$Year >= 2023] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Panama"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Senegal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Democratic Republic of the Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Morocco"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Türkiye"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Cameroon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Egypt"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Bangladesh"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Tunisia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Sri Lanka"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Argentina"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Kazakhstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Armenia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Kyrgyzstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Moldova"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Ecuador" &
              CRS_Data$Year < 2019] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Jamaica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Ukraine"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Georgia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Mongolia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Albania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Honduras"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Jordan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Azerbaijan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Bolivia" &
              CRS_Data$Year < 2013] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Mozambique"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Bahrain"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United States" & 
              CRS_Data$RecipientName == "Rwanda" &
              CRS_Data$Year >= 2012] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Egypt"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Indonesia" &
              CRS_Data$Year < 2018] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Thailand"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Jordan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Sri Lanka"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Senegal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Bangladesh"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Philippines"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Lesotho"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Papua New Guinea"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Malaysia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Paraguay"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Yemen"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Belize"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Cameroon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Saint Lucia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Panama"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Haiti"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "China (People's Republic of)"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Mauritius"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Jamaica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Dominica"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Benin"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Bolivia" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Grenada"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Tunisia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Ghana"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Congo"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Guyana"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Burundi"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Morocco"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Argentina"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Nigeria"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Türkiye"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Mongolia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Bahrain"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Ukraine"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Nepal"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Armenia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Peru"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Uzbekistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Honduras"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Tanzania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Belarus"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Colombia" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "India" &
              CRS_Data$Year < 2018] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Albania"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Ecuador" &
              CRS_Data$Year < 2019] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "South Africa" &
              CRS_Data$Year < 2015] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Pakistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Kyrgyzstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Cuba"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Turkmenistan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Georgia"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Venezuela"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Eswatini"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Lao People's Democratic Republic"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Côte d'Ivoire"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Kazakhstan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Azerbaijan"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Moldova"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Nicaragua"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Tonga"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Uganda"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Lebanon"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Kenya"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "El Salvador"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Sierra Leone"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Viet Nam"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Bosnia and Herzegovina"] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Serbia" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Mozambique" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Mexico" &
              CRS_Data$Year >= 2007] <- 1

CRS_Data$BITs[CRS_Data$DonorName == "United Kingdom" & 
              CRS_Data$RecipientName == "Colombia" &
              CRS_Data$Year >= 2014] <- 1

CRS_Data$BITs[is.na(CRS_Data$BITs)] <- 0


# World Governance Indicators ----

wgi <- read_xlsx(here::here("data/raw/aft-bargaining-power/worldbank_wgi.xlsx"))

wgi <- wgi %>%
  filter(year %in% c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023)) %>%
  dplyr::select(countryname, year, indicator, estimate)

wgi <- wgi %>%
  pivot_wider(names_from = indicator, values_from = estimate)

unique_merged <- unique(CRS_Data$RecipientName)
unique_wgi <- unique(wgi$countryname)

in_merged_not_in_wgi <- setdiff(unique_merged, unique_wgi)
in_wgi_not_in_merged <- setdiff(unique_wgi, unique_merged)

print("Values in merged data but not in WGI data:")
print(in_merged_not_in_wgi)

print("Values in WGI data but not in merged data:")
print(in_wgi_not_in_merged)

wgi <- wgi %>%
  mutate(countryname = case_when(
    countryname == "Cape Verde" ~ "Cabo Verde",
    countryname == "China" ~ "China (People's Republic of)",
    countryname == "Congo, Rep." ~ "Congo",
    countryname == "Korea, Dem. Rep." ~ "Democratic People's Republic of Korea",
    countryname == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    countryname == "Egypt, Arab Rep." ~ "Egypt",
    countryname == "Gambia, The" ~ "Gambia",
    countryname == "Iran, Islamic Rep." ~ "Iran",
    countryname == "Kyrgyz Republic" ~ "Kyrgyzstan",
    countryname == "Lao PDR" ~ "Lao People's Democratic Republic",
    countryname == "St. Lucia" ~ "Saint Lucia",
    countryname == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    countryname == "Venezuela, RB" ~ "Venezuela",
    countryname == "" ~ "Wallis and Futuna",
    countryname == "West Bank and Gaza" ~ "West Bank and Gaza Strip",
    countryname == "Yemen, Rep." ~ "Yemen",
    countryname == "Micronesia, Fed. Sts." ~ "Micronesia",
    countryname == "St. Kitts and Nevis" ~ "Saint Kitts and Nevis",
    countryname == "São Tomé and Principe" ~ "Sao Tome and Principe",
    TRUE ~ countryname
  ))

CRS_Data <- CRS_Data %>%
  left_join(wgi, by = c("RecipientName" = "countryname", "Year" = "year"))

# Economic complexity ----

eci <- read_csv(here::here("data/raw/aft-bargaining-power/atlas_eci_hs96_hs4.csv"))

eci <- eci %>%
  filter(year %in% c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023)) %>%
  dplyr::select(country_name, year, eci)

unique_merged <- unique(CRS_Data$RecipientName)
unique_eci <- unique(eci$country_name)

in_merged_not_in_eci <- setdiff(unique_merged, unique_eci)
in_eci_not_in_merged <- setdiff(unique_eci, unique_merged)

print("Values in merged data but not in ECI data:")
print(in_merged_not_in_eci)

print("Values in ECI data but not in merged data:")
print(in_eci_not_in_merged)

eci <- eci %>%
  mutate(country_name = case_when(
    country_name == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    country_name == "Republic of the Congo" ~ "Congo",
    country_name == "China" ~ "China (People's Republic of)",
    country_name == "North Korea" ~ "Democratic People's Republic of Korea",
    country_name == "Syria" ~ "Syrian Arab Republic",
    country_name == "Turkey" ~ "Türkiye",
    country_name == "Vietnam" ~ "Viet Nam",
    country_name == "Laos" ~ "Lao People's Democratic Republic",
    TRUE ~ country_name
  ))

CRS_Data <- CRS_Data %>%
  left_join(eci, by = c("RecipientName" = "country_name", "Year" = "year"))

# Natural resources rents (%GDP) ----

natrents <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_natural_resource_rents_pct_gdp.csv"))

natrents <- natrents %>%
  dplyr::select(-`Series Code`, -`Country Code`, -`Series Name`)

natrents <- natrents %>%
  rename_with(~ gsub("\\s*\\[.*\\]", "", .))

natrents <- natrents %>%
  pivot_longer(
    cols = starts_with("20"),
    names_to = "Year",
    values_to = "natural_resources"
  )

natrents <- natrents %>%
  rename(RecipientName = `Country Name`)

natrents <- natrents %>%
  filter(Year != "2005")

unique_merged <- unique(CRS_Data$RecipientName)
unique_natrents <- unique(natrents$RecipientName)

in_merged_not_in_natrents <- setdiff(unique_merged, unique_natrents)
in_natrents_not_in_merged <- setdiff(unique_natrents, unique_merged)

print("Values in merged data but not in natural rents data:")
print(in_merged_not_in_natrents)

print("Values in natural rents data but not in merged data:")
print(in_natrents_not_in_merged)

natrents <- natrents %>%
  mutate(RecipientName = case_when(
    RecipientName == "China" ~ "China (People's Republic of)",
    RecipientName == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    RecipientName == "Congo, Rep." ~ "Congo",
    RecipientName == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    RecipientName == "Egypt, Arab Rep." ~ "Egypt",
    RecipientName == "Gambia, The" ~ "Gambia",
    RecipientName == "Iran, Islamic Rep." ~ "Iran",
    RecipientName == "Korea, Dem. People's Rep." ~ "Democratic People's Republic of Korea",
    RecipientName == "Kyrgyz Republic" ~ "Kyrgyzstan",
    RecipientName == "Lao PDR" ~ "Lao People's Democratic Republic",
    RecipientName == "Micronesia, Fed. Sts." ~ "Micronesia",
    RecipientName == "St. Kitts and Nevis" ~ "Saint Kitts and Nevis",
    RecipientName == "St. Lucia" ~ "Saint Lucia",
    RecipientName == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    RecipientName == "Turkiye" ~ "Türkiye",
    RecipientName == "Venezuela, RB" ~ "Venezuela",
    RecipientName == "Vietnam" ~ "Viet Nam",
    RecipientName == "Yemen, Rep." ~ "Yemen",
    TRUE ~ RecipientName
  ))

CRS_Data$Year <- as.character(CRS_Data$Year)
natrents$Year <- as.character(natrents$Year)

CRS_Data <- CRS_Data %>%
  left_join(natrents, by = c("RecipientName", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Other AfT (by other donors) and other ODA (by partners and other donors) ----

CRS_2006 <- read_excel(here::here("data/raw/CRS/crs_2006.xlsx"))
CRS_2007 <- read_excel(here::here("data/raw/CRS/crs_2007.xlsx"))
CRS_2008 <- read_excel(here::here("data/raw/CRS/crs_2008.xlsx"))
CRS_2009 <- read_excel(here::here("data/raw/CRS/crs_2009.xlsx"))
CRS_2010 <- read_excel(here::here("data/raw/CRS/crs_2010.xlsx"))
CRS_2011 <- read_excel(here::here("data/raw/CRS/crs_2011.xlsx"))
CRS_2012 <- read_excel(here::here("data/raw/CRS/crs_2012.xlsx"))
CRS_2013 <- read_excel(here::here("data/raw/CRS/crs_2013.xlsx"))
CRS_2014 <- read_excel(here::here("data/raw/CRS/crs_2014.xlsx"))
CRS_2015 <- read_excel(here::here("data/raw/CRS/crs_2015.xlsx"))
CRS_2016 <- read_excel(here::here("data/raw/CRS/crs_2016.xlsx"))
CRS_2017 <- read_excel(here::here("data/raw/CRS/crs_2017.xlsx"))
CRS_2018 <- read_excel(here::here("data/raw/CRS/crs_2018.xlsx"))
CRS_2019 <- read_excel(here::here("data/raw/CRS/crs_2019.xlsx"))
CRS_2020 <- read_excel(here::here("data/raw/CRS/crs_2020.xlsx"))
CRS_2021 <- read_excel(here::here("data/raw/CRS/crs_2021.xlsx"))
CRS_2022 <- read_excel(here::here("data/raw/CRS/crs_2022.xlsx"))
CRS_2023 <- read_excel(here::here("data/raw/CRS/crs_2023.xlsx"))

CRS_2006 <- CRS_2006 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2007 <- CRS_2007 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2008 <- CRS_2008 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2009 <- CRS_2009 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2010 <- CRS_2010 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2011 <- CRS_2011 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2012 <- CRS_2012 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2013 <- CRS_2013 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2014 <- CRS_2014 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2015 <- CRS_2015 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2016 <- CRS_2016 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2017 <- CRS_2017 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2018 <- CRS_2018 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2019 <- CRS_2019 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2020 <- CRS_2020 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2021 <- CRS_2021 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2022 <- CRS_2022 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_2023 <- CRS_2023 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, SectorName)

CRS_Data2 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)


# Creating a recipient-specific variable with all other AfT (i.e., from all other donors)
Other_AfT <- CRS_Data2 %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants")) %>%
  group_by(RecipientName, Year) %>%
  summarise(
    Total_Disbursements = sum(USD_Disbursement, na.rm = TRUE), # Var with all AfT disbursements received by a recipient in a year
    .groups = "drop"
  )


CRS_Data$Year <- as.character(CRS_Data$Year)
Other_AfT$Year <- as.character(Other_AfT$Year)

CRS_Data <- CRS_Data %>%
  left_join(Other_AfT, by = c("RecipientName", "Year"))

CRS_Data$Other_AfT <- CRS_Data$Total_Disbursements - CRS_Data$USD_Disbursement # Var with all AfT disbursements minus by each donor per row

All_ODA <- CRS_Data2 %>%
  group_by(RecipientName, Year) %>%
  summarise(
    Total_ODA = sum(USD_Disbursement, na.rm = TRUE), # Var with all ODA disbursements received by a recipient in a year
    .groups = "drop"
  )


CRS_Data$Year <- as.character(CRS_Data$Year)
All_ODA$Year <- as.character(All_ODA$Year)

CRS_Data <- CRS_Data %>%
  left_join(All_ODA, by = c("RecipientName", "Year"))

Other_ODA <- CRS_Data2 %>%
  filter(DonorName %in% c("France", "Germany", "Japan", "United Kingdom", "United States")) %>%
  group_by(RecipientName, DonorName, Year) %>%
  summarise(
    Donor_ODA = sum(USD_Disbursement, na.rm = TRUE), # Var with all ODA disbursements received by a recipient from a donor in a year
    .groups = "drop"
  )


CRS_Data$Year <- as.character(CRS_Data$Year)
Other_ODA$Year <- as.character(Other_ODA$Year)

CRS_Data <- CRS_Data %>%
  left_join(Other_ODA, by = c("RecipientName", "DonorName", "Year"))

CRS_Data$Other_ODA <- CRS_Data$Total_ODA - CRS_Data$Donor_ODA

# Migration and refugee flows ----

foreign_pop <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_foreign_population_inflows.csv"))

asylum <- read_csv(here::here("data/raw/aft-bargaining-power/oecd_asylum_seeker_inflows.csv"))

foreign_pop <- foreign_pop %>%
  dplyr::select(`Reference area`, Citizenship, OBS_VALUE, TIME_PERIOD)

asylum <- asylum %>%
  dplyr::select(`Reference area`, Citizenship, OBS_VALUE, TIME_PERIOD)

foreign_pop <- foreign_pop %>%
  rename(RecipientName = Citizenship,
         DonorName = `Reference area`,
         Year = TIME_PERIOD,
         Foreign_pop = OBS_VALUE)

asylum <- asylum %>%
  rename(RecipientName = Citizenship,
         DonorName = `Reference area`,
         Year = TIME_PERIOD,
         Asylum_pop = OBS_VALUE)

migration <- foreign_pop %>%
  full_join(asylum, by = c("RecipientName", "DonorName", "Year"))


unique_merged <- unique(CRS_Data$RecipientName)
unique_migration <- unique(migration$RecipientName)

in_merged_not_in_migration <- setdiff(unique_merged, unique_migration)
in_migration_not_in_merged <- setdiff(unique_migration, unique_merged)

print("Values in merged data but not in migration data:")
print(in_merged_not_in_migration)

print("Values in migration data but not in merged data:")
print(in_migration_not_in_merged)

migration <- migration %>%
  mutate(RecipientName = case_when(
    RecipientName == "China (People’s Republic of)" ~ "China (People's Republic of)",
    RecipientName == "Côte d’Ivoire" ~ "Côte d'Ivoire",
    RecipientName == "Democratic People’s Republic of Korea" ~ "Democratic People's Republic of Korea",
    RecipientName == "Lao People’s Democratic Republic" ~ "Lao People's Democratic Republic",
    RecipientName == "Palestinian Authority or West Bank and Gaza Strip" ~ "West Bank and Gaza Strip",
    TRUE ~ RecipientName
  ))

CRS_Data$Year <- as.character(CRS_Data$Year)
migration$Year <- as.character(migration$Year)

CRS_Data <- CRS_Data %>%
  left_join(migration, by = c("RecipientName", "DonorName", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Value added to partner exports ----

value_added <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"))

value_added <- value_added %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2022)

value_added2 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 2)

value_added2 <- value_added2 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2021)

value_added3 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 3)

value_added3 <- value_added3 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2020)

value_added4 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 4)

value_added4 <- value_added4 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2019)

value_added5 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 5)

value_added5 <- value_added5 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2018)

value_added6 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 6)

value_added6 <- value_added6 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2017)

value_added7 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 7)

value_added7 <- value_added7 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2016)

value_added8 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 8)

value_added8 <- value_added8 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2015)

value_added9 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 9)

value_added9 <- value_added9 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2014)

value_added10 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 10)

value_added10 <- value_added10 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2013)

value_added11 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 11)

value_added11 <- value_added11 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2012)

value_added12 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 12)

value_added12 <- value_added12 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2011)

value_added13 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 13)

value_added13 <- value_added13 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2010)

value_added14 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 14)

value_added14 <- value_added14 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2009)

value_added15 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 15)

value_added15 <- value_added15 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2008)

value_added16 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 16)

value_added16 <- value_added16 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2007)

value_added17 <- read_excel(here::here("data/raw/aft-bargaining-power/value_added_exports.xlsx"), sheet = 17)

value_added17 <- value_added17 %>%
  rename(OriginVA = 1) %>%
  pivot_longer(
    cols = -OriginVA,
    names_to = "ExportingVA",
    values_to = "VA"
  ) %>%
  mutate(Year = 2006)

Value_Added_combined <- bind_rows(
  value_added, value_added2, value_added3, value_added4, 
  value_added5, value_added6, value_added7, value_added8, 
  value_added9, value_added10, value_added11, value_added12, 
  value_added13, value_added14, value_added15, value_added16,
  value_added17)


Value_Added_combined <- Value_Added_combined %>%
  filter(!(OriginVA %in% c("Rest of World", "_1") | ExportingVA %in% c("Rest of World", "_1")))

Value_Added_combined <- Value_Added_combined %>%
  filter(ExportingVA %in% c("France", "Germany", "Japan", "UK", "USA"))

Value_Added_combined <- Value_Added_combined %>%
  mutate(ExportingVA = case_when(
    ExportingVA == "UK" ~ "United Kingdom",
    ExportingVA == "US" ~ "United States",
    TRUE ~ ExportingVA
  ))

Value_Added_combined <- Value_Added_combined %>%
  rename(DonorName = ExportingVA, RecipientName = OriginVA)

Value_Added_combined <- Value_Added_combined %>%
  mutate(RecipientName = case_when(
    RecipientName == "Swaziland" ~ "Eswatini",
    RecipientName == "Cote dIvoire" ~ "Côte d'Ivoire",
    RecipientName == "Turkey" ~ "Türkiye",
    RecipientName == "Syria" ~ "Syrian Arab Republic",
    RecipientName == "DR Congo" ~ "Democratic Republic of the Congo",
    RecipientName == "Cape Verde" ~ "Cabo Verde",
    RecipientName == "Laos" ~ "Lao People's Democratic Republic",
    RecipientName == "China" ~ "China (People's Republic of)",
    RecipientName == "North Korea" ~ "Democratic People's Republic of Korea",
    RecipientName == "Antigua" ~ "Antigua and Barbuda",
    RecipientName == "TFYR Macedonia" ~ "North Macedonia",
    TRUE ~ RecipientName))

Value_Added_combined$Year <- as.character(Value_Added_combined$Year)
CRS_Data$Year <- as.character(CRS_Data$Year)

CRS_Data <- CRS_Data %>%
  left_join(Value_Added_combined, by = c("RecipientName", "DonorName", "Year"))

# Threat point donors ----

CRS_2006 <- read_excel(here::here("data/raw/CRS/crs_2006.xlsx"))
CRS_2007 <- read_excel(here::here("data/raw/CRS/crs_2007.xlsx"))
CRS_2008 <- read_excel(here::here("data/raw/CRS/crs_2008.xlsx"))
CRS_2009 <- read_excel(here::here("data/raw/CRS/crs_2009.xlsx"))
CRS_2010 <- read_excel(here::here("data/raw/CRS/crs_2010.xlsx"))
CRS_2011 <- read_excel(here::here("data/raw/CRS/crs_2011.xlsx"))
CRS_2012 <- read_excel(here::here("data/raw/CRS/crs_2012.xlsx"))
CRS_2013 <- read_excel(here::here("data/raw/CRS/crs_2013.xlsx"))
CRS_2014 <- read_excel(here::here("data/raw/CRS/crs_2014.xlsx"))
CRS_2015 <- read_excel(here::here("data/raw/CRS/crs_2015.xlsx"))
CRS_2016 <- read_excel(here::here("data/raw/CRS/crs_2016.xlsx"))
CRS_2017 <- read_excel(here::here("data/raw/CRS/crs_2017.xlsx"))
CRS_2018 <- read_excel(here::here("data/raw/CRS/crs_2018.xlsx"))
CRS_2019 <- read_excel(here::here("data/raw/CRS/crs_2019.xlsx"))
CRS_2020 <- read_excel(here::here("data/raw/CRS/crs_2020.xlsx"))
CRS_2021 <- read_excel(here::here("data/raw/CRS/crs_2021.xlsx"))
CRS_2022 <- read_excel(here::here("data/raw/CRS/crs_2022.xlsx"))
CRS_2023 <- read_excel(here::here("data/raw/CRS/crs_2023.xlsx"))

CRS_2006 <- CRS_2006 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2007 <- CRS_2007 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2008 <- CRS_2008 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2009 <- CRS_2009 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2010 <- CRS_2010 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2011 <- CRS_2011 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2012 <- CRS_2012 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2013 <- CRS_2013 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2014 <- CRS_2014 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2015 <- CRS_2015 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2016 <- CRS_2016 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2017 <- CRS_2017 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2018 <- CRS_2018 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2019 <- CRS_2019 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2020 <- CRS_2020 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2021 <- CRS_2021 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2022 <- CRS_2022 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_2023 <- CRS_2023 %>%
  dplyr::select(DonorName, RecipientName, Year, USD_Disbursement, USD_Commitment, SectorName)

CRS_Data3 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)


# New threat point option: 'Replaceability' of recipient
AfT_only <- CRS_Data3 %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants"))

donor_threat_dyadic <- AfT_only %>%
  group_by(DonorName, RecipientName, Year) %>%
  summarise(
    dyad_aft = sum(USD_Commitment, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  group_by(DonorName, Year) %>%
  mutate(
    donor_total_aft = sum(dyad_aft, na.rm = TRUE),
    donor_threat_dyad = 1 - (dyad_aft / donor_total_aft)
  ) %>%
  ungroup()



donor_threat_dyad_lag <- donor_threat_dyadic %>%
  arrange(Year) %>%
  mutate(
    donor_threat_dyad_lag = lag(donor_threat_dyad)
  ) %>%
  ungroup()


CRS_Data$Year <- as.character(CRS_Data$Year)
donor_threat_dyad_lag$Year <- as.character(donor_threat_dyad_lag$Year)

CRS_Data <- CRS_Data %>%
  left_join(
    donor_threat_dyad_lag %>%
      dplyr::select(DonorName, RecipientName, Year, donor_threat_dyad_lag),
    by = c("DonorName", "RecipientName", "Year")
  )

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Policy concessions 2 ----

baci_files <- c(                              
  here::here("data/raw/aft-bargaining-power/BACI_HS92_V202601/BACI_HS92_Y2004_V202601.csv"),
  here::here("data/raw/aft-bargaining-power/BACI_HS92_V202601/BACI_HS92_Y2005_V202601.csv")
)
cc_file    <- here::here("data/raw/aft-bargaining-power/BACI_HS92_V202601/country_codes_V202601.csv")
teti_gtap  <- here::here("data/raw/aft-bargaining-power/GTAP_vbeta1-2024-12/tariff_GTAP_88_21_vbeta1-2024-12.csv")
 
donors     <- c("FRA", "DEU", "JPN", "GBR", "USA")
diag4_year <- 2015

## GTAP 10 / GSEC3 standard ordering, merchandise sectors 1-47 (code -> number).
## Used only if the concordance file gives 3-letter codes instead of numbers.
## Positions 1-28 and 34-47 are confirmed from the GTAP 10 sector table;
## 29-33 (lea,lum,ppp,p_c,chm) follow the standard ordering — verify against
## the concordance file's own labels if it is code-based.
gtap_lookup <- tibble(
  code = c("pdr","wht","gro","v_f","osd","c_b","pfb","ocr","ctl","oap","rmk",
           "wol","frs","fsh","coa","oil","gas","omn","cmt","omt","vol","mil",
           "pcr","sgr","ofd","b_t","tex","wap","lea","lum","ppp","p_c","chm",
           "bph","rpp","nmm","i_s","nfm","fmp","ele","eeq","ome","mvh","otn",
           "omf","ely","gdt"),
  gtap = 1:47
)

# Country codes (BACI):
cc <- read_csv(cc_file, show_col_types = FALSE)
names(cc) <- tolower(names(cc))
code_col <- intersect(c("country_code", "code"), names(cc))[1]
iso3_col <- intersect(c("country_iso3", "iso_3digit_alpha", "iso3"), names(cc))[1]
stopifnot(!is.na(code_col), !is.na(iso3_col))
cc <- cc %>% transmute(i = as.integer(.data[[code_col]]), exp_iso3 = .data[[iso3_col]])
cat("[2] country codes loaded:", nrow(cc), "countries\n")

# BACI base-year weights:
## exporter x HS6, pooled across base years = each country's GLOBAL exports.
baci <- baci_files %>%
  map_dfr(~ read_csv(.x, show_col_types = FALSE, col_types = cols(
    t = col_integer(), i = col_integer(), j = col_integer(),
    k = col_character(), v = col_double(), q = col_character()
  ))) %>%
  mutate(k = str_pad(k, 6, "left", "0")) %>%
  left_join(cc, by = "i")
 
exp_prod <- baci %>%
  group_by(exp_iso3, k) %>%
  summarise(v = sum(v, na.rm = TRUE), .groups = "drop")
cat("[3] BACI loaded:", nrow(baci), "rows;",
    n_distinct(exp_prod$k), "HS6 codes;",
    sum(baci$exp_iso3 %in% donors), "donor rows\n")

# Concordance ingest + validation:
## Read everything as character first so codes keep leading zeros.
conc_file <- here::here("data/raw/aft-bargaining-power/gtap_sector_concordance_11723.xlsx")

## H0 sheet has a TWO-ROW header (row 1 = "GTAP 10"/"GTAP 11" banner,
## row 2 = real column names). skip = 1 drops the banner so the true
## header is used.
raw_conc <- read_excel(conc_file, sheet = "H0", skip = 1, col_types = "text")
cat("[4] Concordance columns:\n"); print(names(raw_conc))
cat("[4] First rows:\n");          print(head(raw_conc, 4))

## Columns set BY HAND (auto-detect is disabled below): the file gives
## 3-letter GTAP codes in two flavours -- GSEC3 (GTAP 10) and GSEC3_rev
## (GTAP 11). Using the GTAP 11 revision to match the file you downloaded.
hs6_col  <- "Code"        # HS6 code
gtap_col <- "GSEC3_rev"   # GTAP 11 mapping (switch to "GSEC3" for GTAP 10)

## --- build the clean hs6 -> gtap (integer, as character) map ------------- ##
conc0 <- raw_conc %>%
  transmute(hs6 = str_pad(str_trim(.data[[hs6_col]]), 6, "left", "0"),
            gtap_raw = str_trim(.data[[gtap_col]])) %>%
  filter(grepl("^[0-9]{6}$", hs6), !is.na(gtap_raw), gtap_raw != "")

codes_are_numeric <- mean(grepl("^[0-9]+$", conc0$gtap_raw)) > 0.9
cat("[4] GTAP column detected as",
    if (codes_are_numeric) "NUMBERS" else "3-LETTER CODES", "\n")

conc <- conc0 %>%
  mutate(gtap = if (codes_are_numeric) as.integer(gtap_raw)
                else gtap_lookup$gtap[match(tolower(gtap_raw), gtap_lookup$code)]) %>%
  filter(!is.na(gtap), gtap >= 1, gtap <= 65) %>%
  distinct(hs6, gtap) %>%
  mutate(gtap = as.character(gtap))

## each HS6 should map to exactly one GTAP sector
multi <- conc %>% count(hs6) %>% filter(n > 1)
if (nrow(multi) > 0) {
  warning(nrow(multi), " HS6 codes map to >1 GTAP sector; keeping first.")
  conc <- conc %>% group_by(hs6) %>% slice(1) %>% ungroup()
}
cat("[4] concordance rows:", nrow(conc),
    "| distinct GTAP sectors:", n_distinct(conc$gtap), "\n")

# Anchor check (does the numbering match Teti's?)
anchors <- tribble(
  ~hs6,     ~expect, ~what,
  "100190", "2",  "wheat -> wht(2)",
  "020110", "19", "bovine meat -> cmt(19)",
  "271019", "32", "refined petroleum -> p_c(32)",
  "300490", "34", "medicaments -> bph(34)  <-- GSEC2/GSEC3 discriminator",
  "610910", "28", "cotton T-shirts -> wap(28)",
  "870322", "43", "motor cars -> mvh(43)"
)
anchor_check <- anchors %>%
  left_join(conc, by = "hs6") %>%
  mutate(ok = gtap == expect)
cat("\n[4] ANCHOR CHECK (all 'ok' should be TRUE):\n")
print(anchor_check)
if (any(!anchor_check$ok %in% TRUE))
  warning("Anchor mismatch -> concordance is likely the wrong GTAP version ",
          "(GSEC2 57-sector) or wrong columns. Fix before trusting results.")
# Attach sectors to BACI + unmapped check:
exp_prod <- exp_prod %>%
  left_join(conc, by = c("k" = "hs6")) %>%
  mutate(chap = as.integer(substr(k, 1, 2)))

# hs2_to_section() (HS chapter -> HS section, e.g. ch. 1-5 -> Section I) is
# used only by the "GTAP vs section" diagnostic below and is not defined
# anywhere in this codebase. That diagnostic is skipped unless the function
# is supplied elsewhere; nothing else in the pipeline depends on `section`.
if (exists("hs2_to_section")) {
  exp_prod <- exp_prod %>% mutate(section = hs2_to_section(chap))
}

unmapped <- exp_prod %>%
  filter(exp_iso3 %in% donors) %>%
  group_by(exp_iso3) %>%
  summarise(share_value_unmapped = sum(v[is.na(gtap)]) / sum(v), .groups = "drop")
cat("\n[5] donor export value with NO GTAP mapping (should be ~0):\n")
print(unmapped)

# Share vectors (donors + world):
make_shares <- function(df, sector_col) {
  bind_rows(df %>% filter(exp_iso3 %in% donors),     # donor-specific
            df %>% mutate(exp_iso3 = "WORLD")) %>%    # all exporters pooled
    filter(!is.na(.data[[sector_col]])) %>%
    group_by(exp_iso3, sector = .data[[sector_col]]) %>%
    summarise(v = sum(v), .groups = "drop_last") %>%
    mutate(share = v / sum(v)) %>% ungroup() %>%
    dplyr::select(exp_iso3, sector, share)
}
shares_gtap <- make_shares(exp_prod, "gtap")
if ("section" %in% names(exp_prod)) shares_sec <- make_shares(exp_prod, "section")

to_matrix <- function(sh) {
  w <- sh %>% pivot_wider(names_from = exp_iso3, values_from = share,
                          values_fill = 0)
  M <- as.matrix(w[, setdiff(names(w), "sector")]); rownames(M) <- w$sector; M
}
M_gtap <- to_matrix(shares_gtap)
if (exists("shares_sec")) M_sec <- to_matrix(shares_sec)
cat("[6] share vectors built: GTAP", nrow(M_gtap), "sectors",
    if (exists("M_sec")) paste0("; Section ", nrow(M_sec), " sectors") else "(Section skipped)", "\n")

# Diagnostic 1: Concentration
diag1 <- shares_gtap %>%
  filter(exp_iso3 %in% donors) %>%
  group_by(exp_iso3) %>%
  summarise(hhi = sum(share^2), eff_n_sectors = 1 / sum(share^2),
            top5_share = sum(sort(share, decreasing = TRUE)[1:5]), .groups = "drop")
cat("\n=== DIAGNOSTIC 1: donor basket concentration (GTAP) ===\n"); print(diag1)

# cosine_dist()/l1_dist() are used by diagnostics 2-4a below (pairwise donor-
# basket comparisons) but were not defined anywhere in this codebase.
# Standard definitions, reconstructed here: cosine distance = 1 - cosine
# similarity (0 = identical direction, up to 2 = opposite); L1 distance =
# sum of absolute differences between the two share vectors.
cosine_dist <- function(x, y) 1 - sum(x * y) / (sqrt(sum(x^2)) * sqrt(sum(y^2)))
l1_dist     <- function(x, y) sum(abs(x - y))

# Diagnostic 2: Donor vs donor
## THE decisive check. High distance => tau_drt genuinely moves across donors.
pr <- combn(donors, 2)
diag2 <- tibble(d1 = pr[1, ], d2 = pr[2, ],
  cosine = map2_dbl(d1, d2, ~ cosine_dist(M_gtap[, .x], M_gtap[, .y])),
  l1     = map2_dbl(d1, d2, ~ l1_dist(M_gtap[, .x], M_gtap[, .y])))
cat("\n=== DIAGNOSTIC 2: pairwise donor distance (GTAP) ===\n"); print(diag2)

# Diagnostic 3: Donor vs world
diag3 <- tibble(donor = donors,
  cosine_vs_world = map_dbl(donors, ~ cosine_dist(M_gtap[, .x], M_gtap[, "WORLD"])),
  l1_vs_world     = map_dbl(donors, ~ l1_dist(M_gtap[, .x], M_gtap[, "WORLD"])))
cat("\n=== DIAGNOSTIC 3: donor vs world distance (GTAP) ===\n"); print(diag3)

# Diagnostic 4a: GTAP vs section
if (exists("M_sec")) {
  summarise_level <- function(M) {
    prc <- combn(donors, 2)
    c(mean_pairwise_donor_L1 = mean(map2_dbl(prc[1, ], prc[2, ],
                                             ~ l1_dist(M[, .x], M[, .y]))),
      mean_donor_vs_world_L1 = mean(map_dbl(donors, ~ l1_dist(M[, .x], M[, "WORLD"]))))
  }
  diag4a <- rbind(GTAP = summarise_level(M_gtap), Section = summarise_level(M_sec))
  cat("\n=== DIAGNOSTIC 4a: differentiation, GTAP vs Section (weights) ===\n")
  print(round(diag4a, 4))
} else {
  cat("\n=== DIAGNOSTIC 4a skipped: hs2_to_section() is not defined, so the",
      "HS-section comparison basis is unavailable ===\n")
}

# Diagnostic 4b: Spread of the assembled tau
teti <- read_csv(teti_gtap, show_col_types = FALSE) %>%
  mutate(sector = as.character(sector))           # match conc$gtap type
stopifnot(diag4_year %in% teti$year)
 
mfn <- teti %>% filter(year == diag4_year) %>%
  distinct(iso1, sector, mfn95)                   # mfn95 varies by i-sector
 
matched <- length(intersect(unique(shares_gtap$sector), unique(mfn$sector)))
cat("\n[11] GTAP sectors matched between weights and Teti:", matched,
    "(expect ~46)\n")
 
w_long <- shares_gtap %>% rename(w = share)
tau <- mfn %>%
  inner_join(w_long, by = "sector", relationship = "many-to-many") %>%
  group_by(iso1, exp_iso3) %>%
  summarise(tau = sum(w * mfn95) / sum(w), .groups = "drop")  # renormalize
 
diag4b <- tau %>%
  filter(exp_iso3 %in% donors) %>%
  group_by(iso1) %>%
  summarise(sd_across_donors = sd(tau),
            range_across_donors = max(tau) - min(tau), .groups = "drop") %>%
  summarise(median_within_recipient_donor_sd = median(sd_across_donors, na.rm = TRUE),
            mean_within_recipient_donor_sd   = mean(sd_across_donors, na.rm = TRUE),
            median_within_recipient_range    = median(range_across_donors, na.rm = TRUE))
cat("\n=== DIAGNOSTIC 4b: within-recipient cross-donor spread of tau (",
    diag4_year, ", ppt) ===\n", sep = ""); print(diag4b)
 
diag4b_net <- tau %>%
  pivot_wider(names_from = exp_iso3, values_from = tau) %>%
  mutate(across(all_of(donors), ~ .x - WORLD, .names = "net_{.col}")) %>%
  summarise(across(starts_with("net_"), ~ median(.x, na.rm = TRUE),
                   .names = "med_{.col}"))
cat("\n=== median (tau_donor - tau_world) by donor, ppt ===\n"); print(diag4b_net)
 
cat("\nDone. Read the verdict from diag2/diag3 (is it dyadic?) and diag4b ",
    "(does it survive the tariff schedule?).\n", sep = "")

# ============ tariff95 (preferential) vs mfn95 (composition), multi-year ===

## donor sector-share weights (drop WORLD; we benchmark within-basket here)
w_donor <- shares_gtap %>%
  filter(exp_iso3 %in% donors) %>%
  rename(donor = exp_iso3, w = share)        # donor, sector, w

## build per-(recipient, donor) tau for one year, both channels
build_tau_year <- function(yr) {
  mfn_rs <- teti %>% filter(year == yr) %>%
    distinct(iso1, sector, mfn95)                         # recipient-sector MFN

  eff_rds <- teti %>% filter(year == yr, iso2 %in% donors) %>%
    distinct(iso1, iso2, sector, tariff95) %>%
    rename(donor = iso2)                                  # recipient-donor-sector eff

  mfn_rs %>%
    inner_join(w_donor, by = "sector",
               relationship = "many-to-many") %>%         # + donor, w
    left_join(eff_rds, by = c("iso1", "donor", "sector")) %>%
    mutate(eff95 = coalesce(tariff95, mfn95)) %>%         # no pref row => MFN
    group_by(iso1, donor) %>%
    summarise(tau_mfn = sum(w * mfn95) / sum(w),          # composition only
              tau_eff = sum(w * eff95) / sum(w),          # composition + preference
              .groups = "drop") %>%
    mutate(pref_margin = tau_mfn - tau_eff, year = yr)    # >= 0: preference channel
}

## within-recipient cross-donor spread, per year, per channel
summarise_spread <- function(tau_df) {
  tau_df %>%
    group_by(iso1, year) %>%
    summarise(sd_mfn  = sd(tau_mfn),
              sd_eff  = sd(tau_eff),
              sd_pref = sd(pref_margin), .groups = "drop") %>%
    group_by(year) %>%
    summarise(med_sd_mfn  = median(sd_mfn,  na.rm = TRUE),   # cross-check: matches the 2015 diagnostic value above
              med_sd_eff  = median(sd_eff,  na.rm = TRUE),   # effective (incl. pref)
              med_sd_pref = median(sd_pref, na.rm = TRUE),   # preference-only spread
              .groups = "drop")
}

## run across years (auto-restricted to years present, all <= 2021)
years   <- c(2008, 2010, 2012, 2015, 2018, 2020, 2021)
years   <- years[years %in% unique(teti$year)]
tau_all <- map_dfr(years, build_tau_year)

cat("\n=== CHANNEL COMPARISON: median within-recipient cross-donor SD (ppt) ===\n")
print(summarise_spread(tau_all))

## which donors actually receive the biggest preferential margins?
cat("\n=== median preferential margin by donor (ppt), by year ===\n")
tau_all %>%
  group_by(year, donor) %>%
  summarise(med_pref_margin = median(pref_margin, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = donor, values_from = med_pref_margin) %>%
  print()
# The med_sd_mfn column reproduces the 0.446 figure for 2015 obtained in the
# diagnostic step above, confirming the refactored code is consistent.
#
# The effective-tariff channel carries real and growing dyadic signal:
# med_sd_eff runs 0.54 -> 0.66 ppt and rises monotonically, while med_sd_mfn
# is flat at ~0.44 and even drifts down slightly. Preferences are adding
# cross-donor spread on top of composition, and adding more of it every
# year; by 2021 the effective measure has ~50% more dyadic dispersion than
# the pure-composition one, consistent with preferential tariff treatment
# becoming an increasingly important source of donor-specific variation.
#
# Note where the signal actually sits, which is the important subtlety:
# med_sd_eff (~0.6) is far larger than med_sd_pref (~0.17), even though
# eff = mfn - pref by construction. This is not a contradiction: the
# effective measure's spread is still mostly inherited from the MFN
# composition channel, with the preferential margin adding a modest,
# increasing increment. So switching to tariff95 does not escape the
# compression problem, it improves on it at the margin. The clean,
# theory-relevant object is pref_margin itself, and its spread
# (med_sd_pref) is genuinely small in absolute terms (0.04 -> 0.17 ppt).
# The appropriate interpretation: the preferential channel is real and
# rising, not large.
#
# The donor-margin table behaves exactly as the theoretical framework
# predicts. France, Germany, and the UK show substantial and growing
# median preferential margins (France hits 0.82 ppt by 2021), while Japan
# sits near zero throughout (~0.01-0.09) and the US stays low (~0.04-0.08).
# This is precisely the EU-centric pattern expected for an ODA-recipient
# set: EBA, the EPAs, and EU GSP reach deep into these recipients, while
# Japanese and US preferential schemes barely touch them -- strong
# corroboration that pref_margin captures genuine, donor-specific,
# negotiated market access rather than noise, supporting a bargaining
# narrative centered on EU donors.

# ================= coverage diagnosis + balanced-dyad trend ===============

## ---- (A) is the preferential rate actually REPORTED, year by year? ------
## tariff95 varies by i-j-sector; if it's largely NA early on, eff collapses
## to mfn and pref_margin is mechanically ~0 (a data artifact, not policy).
pref_coverage <- teti %>%
  filter(iso2 %in% donors) %>%
  group_by(year) %>%
  summarise(
    n_rows        = n(),
    pref_reported = mean(!is.na(tariff95)),            # share of rows w/ a pref rate
    pref_below_mfn = mean(tariff95 < mfn95, na.rm = TRUE),  # share actually preferential
    .groups = "drop"
  )
cat("\n=== (A) preferential-rate coverage in Teti, donors only ===\n")
print(pref_coverage, n = Inf)

## same, split by donor (does early sparsity hit EU vs JPN/USA differently?)
cat("\n=== (A2) share of rows with a reported preferential rate, by donor ===\n")
teti %>%
  filter(iso2 %in% donors) %>%
  group_by(year, iso2) %>%
  summarise(pref_reported = mean(!is.na(tariff95)), .groups = "drop") %>%
  pivot_wider(names_from = iso2, values_from = pref_reported) %>%
  print(n = Inf)

## ---- (B) balanced-dyad trend: hold recipient-donor composition fixed ----
## Rebuild tau for all years, then keep ONLY (iso1, donor) dyads present in
## EVERY year. If the rise in the preferential signal is policy (deepening
## EPAs) it survives; if it was coverage thickening, it flattens.
years   <- c(2010, 2012, 2015, 2018, 2020, 2021)   # start at 2010 (see part A)
years   <- years[years %in% unique(teti$year)]
tau_all <- map_dfr(years, build_tau_year)

n_years <- length(years)
balanced_dyads <- tau_all %>%
  distinct(iso1, donor, year) %>%
  count(iso1, donor) %>%
  filter(n == n_years) %>%
  dplyr::select(iso1, donor)

tau_bal <- tau_all %>% semi_join(balanced_dyads, by = c("iso1", "donor"))

cat("\n[B] dyads total:", n_distinct(paste(tau_all$iso1, tau_all$donor)),
    "| balanced (in all", n_years, "years):", nrow(balanced_dyads), "\n")

## within-recipient cross-donor SD, balanced panel, both channels
trend_bal <- tau_bal %>%
  group_by(iso1, year) %>%
  summarise(sd_mfn = sd(tau_mfn), sd_eff = sd(tau_eff),
            sd_pref = sd(pref_margin), .groups = "drop") %>%
  group_by(year) %>%
  summarise(med_sd_mfn  = median(sd_mfn,  na.rm = TRUE),
            med_sd_eff  = median(sd_eff,  na.rm = TRUE),
            med_sd_pref = median(sd_pref, na.rm = TRUE), .groups = "drop")
cat("\n=== (B) BALANCED-DYAD channel spread (compare to full-sample table) ===\n")
print(trend_bal)

## balanced donor-margin trend (does the EU-vs-JPN/USA gap hold up?)
cat("\n=== (B2) balanced median preferential margin by donor ===\n")
tau_bal %>%
  group_by(year, donor) %>%
  summarise(med_pref = median(pref_margin, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = donor, values_from = med_pref) %>%
  print(n = Inf)

# Build the concession variable (dyad-year panel):
tariff_years <- sort(unique(teti$year))
tariff_years <- tariff_years[tariff_years >= 2006 & tariff_years <= 2021]

concession_panel <- map_dfr(tariff_years, build_tau_year) %>%
  transmute(
    recipient = iso1,
    donor,
    year,
    tau_mfn,                       # composition-only (robustness layer)
    tau_eff,                       # composition + preference (effective wall)
    pref_margin                    # negotiated, discriminatory concession (headline)
  ) %>%
  arrange(recipient, donor, year)

cat("panel rows:", nrow(concession_panel),
    "| dyads:", n_distinct(paste(concession_panel$recipient, concession_panel$donor)),
    "| years:", min(concession_panel$year), "-", max(concession_panel$year), "\n")


write_csv(concession_panel, here::here("data/processed/concession_panel_2006_2021.csv"))

# Policy concessions ----

tariffs <- read_csv(here::here("data/raw/aft-bargaining-power/gtap_tariffs_pairs_88_21_vbeta1-2024-12.csv"))

donor_iso3 <- tibble::tribble(
  ~iso2,  ~DonorName,
  "FRA",  "France",
  "DEU",  "Germany",
  "JPN",  "Japan",
  "GBR",  "United Kingdom",
  "USA",  "United States"
)

# Build the dyad-year tariff (recipient's tariff on the donor's goods)
tariff_dyad <- tariffs %>%
  inner_join(donor_iso3, by = "iso2") %>%
  filter(year >= 2006, year <= 2021) %>%
  transmute(
    recip_iso3 = iso1,
    DonorName,
    year,
    eff_tariff    = tariff,     # primary: simple-average effectively-applied
    eff_tariff_pk = tariff95,   # robustness: peak-trimmed variant
    mfn_rate      = mfn         # for the preference-margin option (step 3)
  )

# Merge onto CRS_Data (idempotent), carry 2021 -> 2022/23, build the DV
CRS_Data <- CRS_Data %>%
  dplyr::select(-any_of(c("eff_tariff", "eff_tariff_pk", "mfn_rate",
                   "trade_concession", "preference_margin"))) %>%
  filter(!str_detect(RecipientName, "regional|unspecified|Ex-Yugoslavia")) %>%
  mutate(recip_iso3 = countrycode(RecipientName, "country.name", "iso3c",
                                  custom_match = c(Kosovo = "KSV", Micronesia = "FSM")),
         Year_int   = as.integer(Year)) %>%
  filter(!is.na(recip_iso3)) %>%
  left_join(tariff_dyad, by = c("recip_iso3", "DonorName", "Year_int" = "year")) %>%
  group_by(DonorName, RecipientName) %>%
  arrange(Year_int, .by_group = TRUE) %>%
  tidyr::fill(eff_tariff, eff_tariff_pk, mfn_rate, .direction = "downup") %>%
  ungroup() %>%
  mutate(trade_concession  = -eff_tariff,
         preference_margin =  mfn_rate - eff_tariff)

# Coverage checks
covered <- unique(tariff_dyad$recip_iso3)
length(covered)
length(unique(CRS_Data$recip_iso3))
CRS_Data %>%
  mutate(cov = recip_iso3 %in% covered) %>%
  summarise(share_dyad_years = mean(cov),
            share_of_AfT     = sum(USD_Disbursement[cov], na.rm = TRUE) /
                               sum(USD_Disbursement, na.rm = TRUE))
summary(CRS_Data$eff_tariff)
mean(is.na(CRS_Data$eff_tariff))

uncovered <- setdiff(unique(CRS_Data$recip_iso3), unique(tariff_dyad$recip_iso3))
length(uncovered)

# GTD importer codes that didn't match a recipient (watch for alt codes, e.g. Kosovo = XKX)
setdiff(sort(unique(tariff_dyad$recip_iso3)), unique(CRS_Data$recip_iso3))

# top uncovered recipients by AfT
CRS_Data %>% filter(recip_iso3 %in% uncovered) %>%
  group_by(RecipientName) %>%
  summarise(AfT = sum(USD_Disbursement, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(AfT)) %>% print(n = 20)

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Total reserves in months of imports (recipient) ----

total_reserves <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_total_reserves_months_imports.csv"))

total_reserves <- total_reserves %>%
  dplyr::select(-c(`Country Code`, `Series Name`, `Series Code`))

total_reserves <- total_reserves %>%
  pivot_longer(cols = !(`Country Name`),
               names_to = "Year",
               values_to = "total_reserves")

unique_merged <- unique(CRS_Data$RecipientName)
unique_reserves <- unique(total_reserves$`Country Name`)

in_merged_not_in_reserves <- setdiff(unique_merged, unique_reserves)
in_reserves_not_in_merged <- setdiff(unique_reserves, unique_merged)

print("Values in merged data but not in reserves data:")
print(in_merged_not_in_reserves)

#print("Values in reserves data but not in merged data:")
#print(in_reserves_not_in_merged)

total_reserves <- total_reserves %>%
  mutate(`Country Name` = case_when(
    `Country Name` == "China" ~ "China (People's Republic of)",
    `Country Name` == "Congo, Rep." ~ "Congo",
    `Country Name` == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    `Country Name` == "Korea, Dem. People's Rep." ~ "Democratic People's Republic of Korea",
    `Country Name` == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    `Country Name` == "Egypt, Arab Rep." ~ "Egypt",
    `Country Name` == "Gambia, The" ~ "Gambia",
    `Country Name` == "Iran, Islamic Rep." ~ "Iran",
    `Country Name` == "Kyrgyz Republic" ~ "Kyrgyzstan",
    `Country Name` == "Lao PDR" ~ "Lao People's Democratic Republic",
    `Country Name` == "St. Lucia" ~ "Saint Lucia",
    `Country Name` == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    `Country Name` == "Somalia, Fed. Rep." ~ "Somalia",
    `Country Name` == "Turkiye" ~ "Türkiye",
    `Country Name` == "Venezuela, RB" ~ "Venezuela",
    `Country Name` == "West Bank and Gaza" ~ "West Bank and Gaza Strip",
    `Country Name` == "Yemen, Rep." ~ "Yemen",
    `Country Name` == "Micronesia, Fed. Sts." ~ "Micronesia",
    TRUE ~ `Country Name`
  ))

CRS_Data <- CRS_Data %>%
  left_join(total_reserves, by = c("RecipientName" = "Country Name", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# GDP growth (recipient) ----

GDP_growth <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_gdp_growth.csv"))

GDP_growth <- GDP_growth %>%
  dplyr::select(-c(`Country Code`, `Series Name`, `Series Code`))

GDP_growth <- GDP_growth %>%
  pivot_longer(cols = !(`Country Name`),
               names_to = "Year",
               values_to = "gdp_growth")

unique_merged <- unique(CRS_Data$RecipientName)
unique_growth <- unique(GDP_growth$`Country Name`)

in_merged_not_in_growth <- setdiff(unique_merged, unique_growth)
in_growth_not_in_merged <- setdiff(unique_growth, unique_merged)

print("Values in growth data but not in reserves data:")
print(in_merged_not_in_growth)

#print("Values in growth data but not in merged data:")
#print(in_growth_not_in_merged)

GDP_growth <- GDP_growth %>%
  mutate(`Country Name` = case_when(
    `Country Name` == "China" ~ "China (People's Republic of)",
    `Country Name` == "Congo, Rep." ~ "Congo",
    `Country Name` == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    `Country Name` == "Korea, Dem. People's Rep." ~ "Democratic People's Republic of Korea",
    `Country Name` == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    `Country Name` == "Egypt, Arab Rep." ~ "Egypt",
    `Country Name` == "Gambia, The" ~ "Gambia",
    `Country Name` == "Iran, Islamic Rep." ~ "Iran",
    `Country Name` == "Kyrgyz Republic" ~ "Kyrgyzstan",
    `Country Name` == "Lao PDR" ~ "Lao People's Democratic Republic",
    `Country Name` == "St. Lucia" ~ "Saint Lucia",
    `Country Name` == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    `Country Name` == "Somalia, Fed. Rep." ~ "Somalia",
    `Country Name` == "Turkiye" ~ "Türkiye",
    `Country Name` == "Venezuela, RB" ~ "Venezuela",
    `Country Name` == "West Bank and Gaza" ~ "West Bank and Gaza Strip",
    `Country Name` == "Yemen, Rep." ~ "Yemen",
    `Country Name` == "Micronesia, Fed. Sts." ~ "Micronesia",
    TRUE ~ `Country Name`
  ))

CRS_Data <- CRS_Data %>%
  left_join(GDP_growth, by = c("RecipientName" = "Country Name", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# External debt stocks (recipient) ----

external_debt <- read_csv(here::here("data/raw/aft-bargaining-power/worldbank_external_debt_stocks.csv"))

external_debt <- external_debt %>%
  dplyr::select(-c(`Country Code`, `Series Name`, `Series Code`))

external_debt <- external_debt %>%
  pivot_longer(cols = !(`Country Name`),
               names_to = "Year",
               values_to = "external_debt")

unique_merged <- unique(CRS_Data$RecipientName)
unique_debt <- unique(external_debt$`Country Name`)

in_merged_not_in_debt <- setdiff(unique_merged, unique_debt)
in_debt_not_in_merged <- setdiff(unique_debt, unique_merged)

print("Values in debt data but not in reserves data:")
print(in_merged_not_in_debt)

#print("Values in debt data but not in merged data:")
#print(in_debt_not_in_merged)

external_debt <- external_debt %>%
  mutate(`Country Name` = case_when(
    `Country Name` == "China" ~ "China (People's Republic of)",
    `Country Name` == "Congo, Rep." ~ "Congo",
    `Country Name` == "Cote d'Ivoire" ~ "Côte d'Ivoire",
    `Country Name` == "Korea, Dem. People's Rep." ~ "Democratic People's Republic of Korea",
    `Country Name` == "Congo, Dem. Rep." ~ "Democratic Republic of the Congo",
    `Country Name` == "Egypt, Arab Rep." ~ "Egypt",
    `Country Name` == "Gambia, The" ~ "Gambia",
    `Country Name` == "Iran, Islamic Rep." ~ "Iran",
    `Country Name` == "Kyrgyz Republic" ~ "Kyrgyzstan",
    `Country Name` == "Lao PDR" ~ "Lao People's Democratic Republic",
    `Country Name` == "St. Lucia" ~ "Saint Lucia",
    `Country Name` == "St. Vincent and the Grenadines" ~ "Saint Vincent and the Grenadines",
    `Country Name` == "Somalia, Fed. Rep." ~ "Somalia",
    `Country Name` == "Turkiye" ~ "Türkiye",
    `Country Name` == "Venezuela, RB" ~ "Venezuela",
    `Country Name` == "West Bank and Gaza" ~ "West Bank and Gaza Strip",
    `Country Name` == "Yemen, Rep." ~ "Yemen",
    `Country Name` == "Micronesia, Fed. Sts." ~ "Micronesia",
    TRUE ~ `Country Name`
  ))

CRS_Data <- CRS_Data %>%
  left_join(external_debt, by = c("RecipientName" = "Country Name", "Year"))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

# Filtering out non-ODA eligible countries ----

oda_eligible <- c("Afghanistan", "Angola", "Bangladesh", "Benin", "Burkina Faso", "Burundi", "Cambodia", "Central African Republic", "Chad", "Comoros", "Democratic Republic of the Congo", "Djibouti", "Eritrea", "Ethiopia", "Gambia", "Guinea", "Guinea-Bissau", "Haiti", "Kiribati", "Lao People's Democratic Republic", "Lesotho", "Liberia", "Madagascar", "Malawi", "Mali", "Mauritania", "Mozambique", "Myanmar", "Nepal", "Niger", "Rwanda", "Sao Tome and Principe", "Senegal", "Sierra Leone", "Solomon Islands", "Somalia", "South Sudan", "Sudan", "Tanzania", "Timor-Leste", "Togo", "Tuvalu", "Uganda", "Yemen", "Zambia", "Democratic People's Republic of Korea", "Syrian Arab Republic", "Algeria", "Bhutan", "Bolivia", "Cabo Verde", "Cameroon", "Congo", "Côte d'Ivoire", "Egypt", "Eswatini", "Ghana", "Honduras", "India", "Iran", "Jordan", "Kenya", "Kyrgyzstan", "Lebanon", "Micronesia", "Mongolia", "Morocco", "Nicaragua", "Pakistan", "Papua New Guinea", "Philippines", "Samoa", "Sri Lanka", "Tajikistan", "Tokelau", "Tunisia", "Ukraine", "Uzbekistan", "Vanuatu", "Viet Nam", "Zimbabwe", "Albania", "Argentina", "Armenia", "Azerbaijan", "Belarus", "Belize", "Bosnia and Herzegovina", "Botswana", "Brazil", "China (People's Republic of)", "Colombia", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "Ecuador", "El Salvador", "Equatorial Guinea", "Fiji", "Gabon", "Georgia", "Grenada", "Guatemala", "Guyana", "Indonesia", "Iraq", "Jamaica", "Kazakhstan", "Kosovo", "Libya", "Malaysia", "Maldives", "Marshall Islands", "Mauritius", "Mexico", "Moldova", "Montenegro", "Montserrat", "Namibia", "Nauru", "Niue", "North Macedonia", "Palau", "Panama", "Paraguay", "Peru", "Saint Helena", "Saint Lucia", "Saint Vincent and the Grenadines", "Serbia", "South Africa", "Suriname", "Thailand", "Tonga", "Türkiye", "Turkmenistan", "Venezuela", "Wallis and Futuna", "West Bank and Gaza Strip", "Nigeria")

oda_eligible <- sort(oda_eligible)
print(oda_eligible)

non_eligible <- CRS_Data %>%
  filter(!RecipientName %in% oda_eligible) %>%
  distinct(RecipientName)

non_eligible

CRS_Data <- CRS_Data %>%
  filter(RecipientName %in% oda_eligible)

print(unique(CRS_Data$RecipientName))

write_xlsx(CRS_Data, here::here("data/processed/CRS_Data.xlsx"))

number_recipients <- unique(CRS_Data$RecipientName)
length(number_recipients)
