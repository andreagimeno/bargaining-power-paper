# 02_descriptive_stats.R
#
# Descriptive numbers used in the paper text: aid modality shares, top-5
# donor shares of AfT, and the modality-by-year figure. Reads the raw CRS
# files directly (independent of 01_build_dataset.R's output).
#
# Input:  data/raw/CRS/, data/raw/aft-bargaining-power/CRS by modality.xlsx
# Output: output/figures/modality_plot.png

source(here::here("code/00_packages.R"))


CRS_2006 <- read_excel(here::here("data/raw/CRS/CRS 2006.xlsx"))
CRS_2007 <- read_excel(here::here("data/raw/CRS/CRS 2007.xlsx"))
CRS_2008 <- read_excel(here::here("data/raw/CRS/CRS 2008.xlsx"))
CRS_2009 <- read_excel(here::here("data/raw/CRS/CRS 2009.xlsx"))
CRS_2010 <- read_excel(here::here("data/raw/CRS/CRS 2010.xlsx"))
CRS_2011 <- read_excel(here::here("data/raw/CRS/CRS 2011.xlsx"))
CRS_2012 <- read_excel(here::here("data/raw/CRS/CRS 2012.xlsx"))
CRS_2013 <- read_excel(here::here("data/raw/CRS/CRS 2013.xlsx"))
CRS_2014 <- read_excel(here::here("data/raw/CRS/CRS 2014.xlsx"))
CRS_2015 <- read_excel(here::here("data/raw/CRS/CRS 2015.xlsx"))
CRS_2016 <- read_excel(here::here("data/raw/CRS/CRS 2016.xlsx"))
CRS_2017 <- read_excel(here::here("data/raw/CRS/CRS 2017.xlsx"))
CRS_2018 <- read_excel(here::here("data/raw/CRS/CRS 2018.xlsx"))
CRS_2019 <- read_excel(here::here("data/raw/CRS/CRS 2019.xlsx"))
CRS_2020 <- read_excel(here::here("data/raw/CRS/CRS 2020.xlsx"))
CRS_2021 <- read_excel(here::here("data/raw/CRS/CRS 2021.xlsx"))
CRS_2022 <- read_excel(here::here("data/raw/CRS/CRS 2022.xlsx"))
CRS_2023 <- read_excel(here::here("data/raw/CRS/CRS 2023.xlsx"))

CRS_2006 <- CRS_2006 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2007 <- CRS_2007 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2008 <- CRS_2008 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2009 <- CRS_2009 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2010 <- CRS_2010 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2011 <- CRS_2011 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2012 <- CRS_2012 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2013 <- CRS_2013 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2014 <- CRS_2014 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2015 <- CRS_2015 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2016 <- CRS_2016 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2017 <- CRS_2017 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2018 <- CRS_2018 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2019 <- CRS_2019 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2020 <- CRS_2020 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2021 <- CRS_2021 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2022 <- CRS_2022 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_2023 <- CRS_2023 %>%
  dplyr::select(DonorName, Year, USD_Disbursement, SectorName, Aid_T)

CRS_Data4 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)

CRS_Data4 <- CRS_Data4 %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants")) %>%
  group_by(Year) %>%
  summarise(
    USD_Disbursement = sum(USD_Disbursement, na.rm = TRUE),
    .groups = "drop"
  )

CRS_Data5 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)

CRS_Data5 <- CRS_Data5 %>%
  group_by(Year) %>%
  summarise(
    USD_Disbursement = sum(USD_Disbursement, na.rm = TRUE),
    .groups = "drop"
  )

total_2006 <- CRS_Data4 %>%
  filter(Year == "2006") %>%
  summarise(total = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total)

total_2023 <- CRS_Data4 %>%
  filter(Year == "2023") %>%
  summarise(total = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total)

percent_increase <- ((total_2023 - total_2006) / total_2006) * 100

total_2006
total_2023
percent_increase

total_2006 <- CRS_Data5 %>%
  filter(Year == "2006") %>%
  summarise(total = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total)

total_2023 <- CRS_Data5 %>%
  filter(Year == "2023") %>%
  summarise(total = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total)

total_2006
total_2023

percent_increase2006 <- (23045.06 * 100)/172756.1
percent_increase2023 <- (101190.7 * 100)/410443.7

percent_increase2006
percent_increase2023

# Percent of AfT in 2023 that is project-based:

CRS_Data6 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)

CRS_Data6 <- CRS_Data6 %>%
  filter(SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants"))# %>%
#  filter(Year %in% "2023")

sum(is.na(CRS_Data6$Aid_T))
nrow(CRS_Data6)

CRS_Data6 <- CRS_Data6 %>%
  group_by(Year, Aid_T) %>%
  summarise(
    USD_Disbursement = sum(USD_Disbursement, na.rm = TRUE),
    .groups = "drop"
  )

CRS_Data6 <- CRS_Data6 %>%
    mutate(Aid_T=replace_na(Aid_T, "Not defined"))

print(unique(CRS_Data6$Aid_T))

CRS_Data6 <- CRS_Data6 %>%
  mutate(Aid_T = case_when(
    Aid_T == "A02" ~ "Budget support",
    Aid_T == "B01" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "C01" ~ "Project-type interventions",
    Aid_T == "D02" ~ "Experts and other technical assistance",
    Aid_T == "E01" ~ "Scholarships and student costs in donor countries",
    Aid_T == "B03" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "B04" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "D01" ~ "Experts and other technical assistance",
    Aid_T == "G01" ~ "Administrative costs not included elsewhere",
    Aid_T == "H01" ~ "Other in-donor expenditures",
    Aid_T == "E02" ~ "Scholarships and student costs in donor countries",
    Aid_T == "A01" ~ "Budget support",
    Aid_T == "B031" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "B032" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "B033" ~ "Core contributions and pooled programmes and funds",
    Aid_T == "B05" ~ "Core contributions and pooled programmes and funds",
    TRUE ~ Aid_T
  ))      

bar_colors <- c(
  "Budget support" = "#ACD4EC",
  "Core contributions and pooled programmes and funds" = "#6E9FC6",
  "Project-type interventions" = "#d6604d",
  "Experts and other technical assistance" = "#4D7EAB",
  "Scholarships and student costs in donor countries" = "#2E5B88",
  "Not defined" = "lightgrey",
  "Administrative costs not included elsewhere" = "#B9DDF1",
  "Other in-donor expenditures" = "#CFDCEF"
)  

modality_plot <- ggplot(CRS_Data6,
                    aes(x = Year, y = USD_Disbursement, fill = Aid_T)) +
                    geom_col(position = "stack") +
                    scale_fill_manual(values = bar_colors) +
                    labs(
                      x = "",
                      y = "Total ODA disbursements (USD)",
                      fill = "",
                      title = "Total ODA disbursements by modality and year"
                    ) +
                    theme_minimal()

ggsave(
  here::here("output/figures/modality_plot.png"),
  modality_plot,
  width  = 13,
  height = 9,
  dpi    = 400
)

modality_plot <- ggplot(aes(x = Year, y = ))

# Total AfT in 2023:
total_aft_2023 <- 3046.92289 + 12194.25748 + 413.99074 + 1878.08738 + 246.66033 + 660.42240 + 135.82669 + 66.20454 + 79615.50447 + 169.36709 + 1185.62570 + 43.19297 + 16.30620 + 15.42903 + 4.02969

total_aft_2023_withNA <- 3046.92289 + 12194.25748 + 413.99074 + 1878.08738 + 246.66033 + 660.42240 + 135.82669 + 66.20454 + 79615.50447 + 169.36709 + 1185.62570 + 43.19297 + 16.30620 + 15.42903 + 4.02969 + 1498.85596

# Percent that is project-based:
(79615.50447/total_aft_2023)*100
(79615.50447/total_aft_2023_withNA)*100

CRS_Data7 <- bind_rows(CRS_2006, CRS_2007, CRS_2008, CRS_2009, CRS_2010, CRS_2011, CRS_2012, CRS_2013, CRS_2014, CRS_2015, CRS_2016, CRS_2017, CRS_2018, CRS_2019, CRS_2020, CRS_2021, CRS_2022, CRS_2023)

aft_2023 <- CRS_Data7 %>%
  filter(
    Year == 2023,
    SectorName %in% c("III.1.a. Agriculture", "II.1. Transport & Storage", "III.3.a. Trade Policies & Regulations", "II.4. Banking & Financial Services", "III.1.b. Forestry", "II.2. Communications", "II.3.b. Energy generation, renewable sources", "II.5. Business & Other Services", "III.2.a. Industry", "III.1.c. Fishing", "III.3.b. Tourism", "III.2.b. Mineral Resources & Mining", "II.3.c. Energy generation, non-renewable sources", "II.3.a. Energy Policy", "II.3.e. Nuclear energy plants", "III. Production Sectors", "II. Economic Infrastructure & Services", "III.2.c. Construction", "III.1. Agriculture, Forestry, Fishing", "II.3. Energy", "III.2. Industry, Mining, Construction", "II.3.d. Hybrid energy plants"
    )
  )


top_donors <- c("France", "Germany", "Japan", "United Kingdom", "United States")

# Percent of total AfT disbursed by top 5 donors:
aft_total_2023 <- aft_2023 %>%
  summarise(total_aft = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total_aft)

aft_top5_2023 <- aft_2023 %>%
  filter(DonorName %in% top_donors) %>%
  summarise(top5_aft = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(top5_aft)

pct_total_aft_top5 <- 100 * aft_top5_2023 / aft_total_2023
print(pct_total_aft_top5)

bilateral_donors <- c("Belgium", "Netherlands", "Luxembourg", "Austria", "Japan", "Italy", "Finland", "Germany", "Slovak Republic", "Portugal", "Poland", "United States", "Canada", "Greece", "Norway", "Estonia", "Lithuania", "Switzerland", "Malta", "Türkiye", "United Arab Emirates", "United Kingdom", "Kazakhstan", "France", "Korea", "New Zealand", "Denmark", "Iceland", "Ireland", "Hungary", "Spain", "Sweden", "Czechia", "Australia", "Israel", "Slovenia", "Liechtenstein", "Chinese Taipei", "Azerbaijan", "Kuwait", "Monaco", "Bulgaria", "Saudi Arabia", "Qatar", "Romania", "Latvia", "Croatia")

aft_bilateral_2023 <- aft_2023 %>%
  filter(DonorName %in% bilateral_donors)

aft_bilateral_total <- aft_bilateral_2023 %>%
  summarise(total_bilateral = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(total_bilateral)

aft_bilateral_top5 <- aft_bilateral_2023 %>%
  filter(DonorName %in% top_donors) %>%
  summarise(top5_bilateral = sum(USD_Disbursement, na.rm = TRUE)) %>%
  pull(top5_bilateral)

pct_bilateral_aft_top5 <- 100 * aft_bilateral_top5 / aft_bilateral_total

print(pct_bilateral_aft_top5)

# Increase of project-based aid relative to other modalities:
CRS_by_modality <- read_excel(here::here("data/raw/aft-bargaining-power/CRS by modality.xlsx"))

CRS_by_modality <- CRS_by_modality %>%
  select(Modality7, TIME_PERIOD, OBS_VALUE)

CRS_by_modality <- CRS_by_modality %>%
  mutate(Modality7 = case_when(
    Modality7 == "Other in-donor expenditures" ~ "Other",
    Modality7 == "Scholarships and student costs in donor countries" ~ "Other",
    Modality7 == "Administrative costs not included elsewhere" ~ "Other",
    TRUE ~ Modality7
  ))

oda_by_year_modality <- CRS_by_modality %>%
  group_by(TIME_PERIOD, Modality7) %>%
  summarise(
    total_oda = sum(OBS_VALUE, na.rm = TRUE),
    .groups = "drop"
  )

bar_colors <- c(
  "Budget support" = "#03045e",
  "Core contributions and pooled programmes and funds" = "#0077b6",
  "Debt relief" = "#00b4d8",
  "Experts and other technical assistance" = "#90e0ef",
  "Other" = "#caf0f8",
  "Project-type interventions" = "lightgrey"
)

ggplot(oda_by_year_modality,
       aes(x = TIME_PERIOD, y = total_oda, fill = Modality7)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = bar_colors) +
  labs(
    x = "",
    y = "Total ODA disbursements (USD)",
    fill = "",
    title = "Total ODA disbursements by modality and year"
  ) +
  theme_minimal()
