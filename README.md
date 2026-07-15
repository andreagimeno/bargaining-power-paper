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
├── Final full workflow.Rmd   # full pipeline: data build -> panel -> models -> figures
├── data/
│   ├── raw/                  # source datasets, as downloaded (gitignored, see below)
│   └── processed/            # intermediate/derived files written by the workflow (gitignored)
├── output/
│   └── figures/              # figures saved by the workflow (gitignored)
└── bargaining-power-paper.Rproj
```

## Data

`data/raw/` and `data/processed/` are **not tracked in git** — several of the raw
files are tens or hundreds of megabytes (a few are multiple gigabytes), well past
what a git repo should hold. The workflow expects the following layout under
`data/raw/`:

```
data/raw/
├── CRS/
│   └── CRS 2006.xlsx ... CRS 2023.xlsx      # OECD DAC Creditor Reporting System, one file per year
└── aft-bargaining-power/
    ├── AgreementScoresAll_Jun2024.csv       # UN General Assembly voting agreement scores
    ├── COW-country-codes.csv                # Correlates of War country code list
    ├── dist_cepii 2.xls                     # CEPII GeoDist bilateral distance/colonial-ties data
    ├── Cost of trade.csv                    # bilateral trade costs
    ├── Goods exports to the world.csv       # merchandise exports to the world
    ├── OECD-WTO_BATIS_BPM6_December2025_bulk.csv   # OECD-WTO Balanced Trade in Services (BATIS)
    ├── Bilateral trade in goods (recipient exports).csv
    ├── Bilateral trade in goods (recipient imports).csv
    ├── Donors exports to world.csv
    ├── Goods and services exports.csv
    ├── wgidataset.xlsx                      # World Bank Worldwide Governance Indicators
    ├── complexity_eci_a_hs96_hs4.csv        # Economic Complexity Index (Growth Lab / Atlas of Economic Complexity)
    ├── Natural resources rents (%GDP).csv   # World Bank WDI
    ├── Inflows of foreign population.csv    # OECD International Migration Database
    ├── Inflows of asylum seekers.csv        # OECD/UNHCR
    ├── Value Added.xlsx                     # value added in exports (multi-sheet)
    ├── Total reserves in months of imports.csv   # World Bank WDI
    ├── GDP growth.csv                       # World Bank WDI
    ├── External debt stocks.csv             # World Bank WDI
    ├── 11723.xlsx                           # concessions data, sheet "H0"
    ├── tariffsPairs_88_21_vbeta1-2024-12.csv
    ├── CRS by modality.xlsx                 # CRS disbursements by aid modality
    ├── BACI_HS92_V202601/                   # CEPII BACI bilateral trade data (HS92), by year
    │   ├── BACI_HS92_Y2004_V202601.csv
    │   ├── BACI_HS92_Y2005_V202601.csv
    │   └── country_codes_V202601.csv
    └── GTAP_vbeta1-2024-12/                 # GTAP tariff data
        └── tariff_GTAP_88_21_vbeta1-2024-12.csv
```

> **Note:** `CRS by modality.xlsx` was referenced by the workflow but wasn't found
> among the files moved into this repo — it will need to be re-obtained/placed at
> `data/raw/aft-bargaining-power/CRS by modality.xlsx` before that section of the
> `.Rmd` can run.

`data/processed/` and `output/figures/` start empty and are populated by running
the workflow (e.g. `CRS_Data.xlsx`, `concession_panel_2006_2021.csv`,
`modality_plot.png`).

## Running the workflow

1. Open `bargaining-power-paper.Rproj` in RStudio (this makes the project root
   resolvable via the `here` package, which all file paths in the `.Rmd` rely on).
2. Make sure `data/raw/` is populated as above.
3. Run `Final full workflow.Rmd` chunk by chunk, or knit it end to end.

### Packages

The workflow relies on `here`, `dplyr`, `ggplot2`, `tidyr`, `writexl`, `readr`,
`readxl`, `stringr`, `purrr`, `lubridate`, `psych`, `naniar`, `performance`,
`lavaan`, `semPlot`, `semTools`, `mice`, `Matrix`, `seminr`, `systemfit`,
`ggridges`, `DiagrammeR`, `DiagrammeRsvg`, `magrittr`, `xml2`, `plm`,
`multiwayvcov`, `sandwich`, `MASS`, `fixest`, `msm`, `marginaleffects`,
`patchwork`, `interactions`, `RColorBrewer`, `effects`, and `countrycode`.

A natural next step for reproducibility is to pin these with
[`renv`](https://rstudio.github.io/renv/) (`renv::init()`), which isn't set up yet.
