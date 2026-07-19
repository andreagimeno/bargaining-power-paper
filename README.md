# Aid for Trade and Donor–Recipient Bargaining Power

Data-construction and analysis workflow for paper by Andrea Gimeno Solaz with working title
"Beyond the aid-for-policy bargain: recipient bargaining power in the age of project-based aid".
Abstract: Project-based lending has overtaken general budget support as the dominant aid modality,
with Aid for Trade disbursements alone more than quadrupling since 2006 to nearly a quarter of total development aid.
Nevertheless, bargaining in bilateral aid negotiations is still understood as a single exchange of money for policy.
This paper develops an alternative extended framework which shows bargaining operates across three key stakes at once:
flow size, policy concessions and project design and implementation command. Using a dyadic panel of the five largest
bilateral Aid for Trade donors and every aid-eligible recipient country between 2006 and 2023, the paper constructs a
Nash-bargaining measure of relative bargaining power and estimates its effect on all three negotiation outcomes jointly.
Bargaining power shapes the three outcomes simultaneously, but its effect is the cleanest on project design and implementation
control, the dimension conventional models omit entirely. A one-standard deviation increase in recipient bargaining power
relative to the donor is found to shift Aid for Trade project delivery roughly 22% towards recipient-controlled channels.
Recipients also secure larger Aid for Trade flows as their bargaining position strengthens, and these two gains bundle
together rather than trade off. For recipient governments, design and implementation control, not aid volume, is the
most reliable channel for converting bargaining strength into control over the aid relations they enter. Retaining
trade policy space, by contrast, is shown to require a more specific asset, namely commercial leverage over the donor,
rather than overall bargaining strength alone.



## Repository structure

```
.
├── code/
│   ├── 00_packages.R          # single source of truth for package dependencies
│   ├── 01_build_dataset.R     # data build: CRS + covariates -> data/processed/CRS_Data.xlsx
│   ├── 02_descriptive_stats.R # descriptive numbers/figure used in the paper text
│   └── 03_analysis.Rmd        # construct building, SUR model, bootstrap, figures, robustness
├── data/
│   ├── codebook.md            # variable definitions for the analysis panel
│   ├── raw/                   # source datasets, as downloaded (gitignored, see below)
│   └── processed/             # intermediate/derived files written by 01 and 03 (gitignored)
├── output/
│   └── figures/                # figures saved by 02 and 03 (gitignored)
└── bargaining-power-paper.Rproj
```

## Data

```
data/raw/
├── CRS/
│   └── crs_2006.xlsx ... crs_2023.xlsx                        # OECD DAC Creditor Reporting System, one file per year
│       (crs_2002_2003.xlsx, crs_2004_2005.xlsx are older bundled extracts, unused by the current workflow)
└── aft-bargaining-power/
    ├── un_voting_agreement_scores_2024-06.csv                 # Bailey/Strezhnev/Voeten UN General Assembly voting agreement scores
    ├── cow_country_codes.csv                                  # Correlates of War country code list
    ├── cepii_geodist.xls                                      # CEPII GeoDist bilateral distance/colonial-ties data
    ├── oecd_trade_costs.csv                                   # OECD Data Explorer: bilateral trade costs
    ├── oecd_goods_exports_world.csv                           # OECD Data Explorer: merchandise exports to the world
    ├── OECD-WTO_BATIS_BPM6_December2025_bulk.csv              # OECD-WTO Balanced Trade in Services (BATIS)
    ├── oecd_bilateral_trade_goods_recipient_exports.csv
    ├── oecd_bilateral_trade_goods_recipient_imports.csv
    ├── oecd_donor_exports_world.csv                           # OECD Data Explorer
    ├── worldbank_goods_services_exports.csv                   # World Bank WDI
    ├── worldbank_wgi.xlsx                                     # World Bank Worldwide Governance Indicators
    ├── atlas_eci_hs96_hs4.csv                                 # Economic Complexity Index (Harvard Growth Lab / Atlas of Economic Complexity)
    ├── worldbank_natural_resource_rents_pct_gdp.csv           # World Bank WDI
    ├── oecd_foreign_population_inflows.csv                    # OECD International Migration Database
    ├── oecd_asylum_seeker_inflows.csv                         # OECD International Migration Database
    ├── value_added_exports.xlsx                               # value added in exports (multi-sheet; source not otherwise confirmed)
    ├── worldbank_total_reserves_months_imports.csv            # World Bank WDI
    ├── worldbank_gdp_growth.csv                                # World Bank WDI
    ├── worldbank_external_debt_stocks.csv                     # World Bank WDI
    ├── gtap_sector_concordance_11723.xlsx                     # GTAP Resource Library: HS6 -> GTAP sector concordance, sheet "H0"
    ├── gtap_tariffs_pairs_88_21_vbeta1-2024-12.csv            # GTAP-family bilateral tariffs
    ├── BACI_HS92_V202601/                                     # CEPII BACI bilateral trade data (HS92), by year
    │   ├── BACI_HS92_Y2004_V202601.csv
    │   ├── BACI_HS92_Y2005_V202601.csv
    │   └── country_codes_V202601.csv
    └── GTAP_vbeta1-2024-12/                                   # GTAP tariff data
        └── tariff_GTAP_88_21_vbeta1-2024-12.csv
```

Filenames follow a `<source>_<content>_<vintage-if-any>` convention (lowercase,
underscores, no spaces/special characters) — except for `BACI_HS92_V202601/` and
`GTAP_vbeta1-2024-12/`, whose files keep the exact names CEPII/GTAP distribute
them under, since those already encode an official release version that matters
for verifying you're using the right vintage.

`data/processed/` and `output/figures/` start empty and are populated by running
the code (e.g. `CRS_Data.xlsx`, `concession_panel_2006_2021.csv`, `modality_plot.png`).
See `data/codebook.md` for what the constructed variables in the final panel mean.

## Running the workflow

1. Open `bargaining-power-paper.Rproj` in RStudio (this makes the project root
   resolvable via the `here` package, which all file paths rely on).
2. Make sure `data/raw/` is populated as above.
3. Run in order:
   - `code/01_build_dataset.R` — builds `data/processed/CRS_Data.xlsx`
   - `code/02_descriptive_stats.R` — independent of step 1; produces the paper's descriptive numbers/figure
   - `code/03_analysis.Rmd` — reads `data/processed/CRS_Data.xlsx`, runs the models, knit for the full output

Each script sources `code/00_packages.R` itself, so they can be run standalone
once `data/raw/` and (for step 3) `data/processed/CRS_Data.xlsx` exist.

### Packages

All three scripts depend on `here`, `dplyr`, `ggplot2`, `tidyr`, `writexl`, `readr`,
`readxl`, `stringr`, `purrr`, `lubridate`, `psych`, `naniar`, `performance`,
`lavaan`, `semPlot`, `semTools`, `mice`, `Matrix`, `seminr`, `systemfit`,
`ggridges`, `DiagrammeR`, `DiagrammeRsvg`, `magrittr`, `xml2`, `plm`,
`multiwayvcov`, `sandwich`, `MASS`, `fixest`, `msm`, `marginaleffects`,
`patchwork`, `interactions`, `RColorBrewer`, `effects`, and `countrycode`
— see `code/00_packages.R` for the full list.
