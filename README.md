# Aid for Trade and Donor–Recipient Bargaining Power

Data-construction and analysis workflow for a paper studying how donor–recipient
bargaining power (UN voting alignment, colonial history, trade dependence, tariff
concessions, migration ties, threat points, etc.) shapes the allocation of
Aid for Trade (AfT). The workflow merges OECD DAC Creditor Reporting System (CRS)
aid data with a range of trade, political, and economic datasets into a
recipient-donor-year panel, then runs the paper's regressions and figures.

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

The workflow used to be a single 4,800-line notebook. It's now split into a
build stage and an analysis stage — see "Running the workflow" below — which
is the convention expected by most journal replication-package standards
(e.g. the AEA Data and Code Availability Standard): data construction is
reproducible independently of the modeling, and each script states its
inputs/outputs at the top.

## Data

`data/raw/` and `data/processed/` are **not tracked in git** — several of the raw
files are tens or hundreds of megabytes (a few are multiple gigabytes), well past
what a git repo should hold. The workflow expects the following layout under
`data/raw/`:

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

> **Note:** `02_descriptive_stats.R` used to depend on a separately-downloaded
> OECD file, `CRS by modality.xlsx`, for one chart (total ODA disbursements by
> aid modality and year). That file was lost and isn't reproducible from a
> clean OECD re-download with certainty, so the chart is now built directly
> from `data/raw/CRS/` via the `Aid_T` -> modality-category crosswalk instead
> — no external dependency for that chart anymore.

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

A natural next step for reproducibility is to pin these with
[`renv`](https://rstudio.github.io/renv/) (`renv::init()`), which isn't set up yet.
