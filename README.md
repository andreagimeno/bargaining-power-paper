# Aid for Trade and Donor–Recipient Bargaining Power

This is the replication package for my paper, "Beyond the aid-for-policy
bargain: recipient bargaining power in the age of project-based aid", which
studies how donor–recipient bargaining power (UN voting alignment, colonial
history, trade dependence, tariff concessions, migration ties, threat
points, etc.) shapes the allocation of Aid for Trade (AfT). The workflow
merges OECD DAC Creditor Reporting System (CRS) aid data with a range of
trade, political, and economic datasets into a recipient-donor-year panel,
then runs the paper's regressions and figures. This document explains how
the repository is organized and how to reproduce the results from raw data.

**Abstract:** Project-based lending has overtaken general budget support as the dominant aid modality,
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

The build stage and the analysis stage are separate scripts (see "Running
the workflow" below), following the convention expected by most journal
replication-package standards (e.g. the AEA Data and Code Availability
Standard): data construction is reproducible independently of the modeling,
and each script states its inputs/outputs at the top.

## Data

I do not track `data/raw/` or `data/processed/` in git — several of the raw
files are tens or hundreds of megabytes (a few are multiple gigabytes), well
past what a git repo should hold. To reproduce the build, populate
`data/raw/` with the following layout:

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
    ├── value_added_exports.xlsx                               # World Bank WITS, Export Value Added (EVAD) country stats: https://wits.worldbank.org/analyticaldata/evad-countrystats.aspx (multi-sheet, one sheet per year)
    ├── worldbank_total_reserves_months_imports.csv            # World Bank WDI
    ├── worldbank_gdp_growth.csv                                # World Bank WDI
    ├── worldbank_external_debt_stocks.csv                     # World Bank WDI
    └── gtap_tariffs_pairs_88_21_vbeta1-2024-12.csv            # Teti (2024) Global Tariff Database: bilateral (importer-exporter-year) applied/MFN tariffs
```

I follow a `<source>_<content>_<vintage-if-any>` filename convention
(lowercase, underscores, no spaces/special characters) throughout.

> **Note on the modality chart:** the `02_descriptive_stats.R` chart of total
> ODA disbursements by aid modality and year is built directly from
> `data/raw/CRS/` via the `Aid_T` -> modality-category crosswalk, with no
> external dependency beyond the CRS files already listed above.

> **Note on the trade-concession measure:** the policy-concession variable
> (`preference_margin` / `trade_concession`) is built from genuinely dyadic
> (importer-exporter-year) tariff pairs in Teti's (2024) Global Tariff
> Database — `preference_margin` is the recipient's MFN rate minus the rate
> it actually applies to the donor, and `trade_concession` is the negative
> of the effectively-applied rate itself (a robustness variant; see
> `data/codebook.md`). Both are derived from the single file
> `gtap_tariffs_pairs_88_21_vbeta1-2024-12.csv` listed above.

> **Note on the commercial dependency measure:** `s_comm` (see
> `data/codebook.md`) combines two sub-components. `total_asym` (net trade
> dependence) is built from bilateral goods trade (OECD BIMTS,
> `oecd_bilateral_trade_goods_recipient_exports.csv` /
> `_imports.csv`) and bilateral services trade (OECD-WTO BaTiS,
> `OECD-WTO_BATIS_BPM6_December2025_bulk.csv`), each scaled by the
> recipient's and donor's total goods-and-services exports (World Bank WDI,
> `worldbank_goods_services_exports.csv`). `VA_share` (recipient
> value-added content in the donor's exports) is built from
> `value_added_exports.xlsx`, sourced from the World Bank's World
> Integrated Trade Solution (WITS) Export Value Added (EVAD) country
> statistics (https://wits.worldbank.org/analyticaldata/evad-countrystats.aspx),
> scaled by the donor's total exports from the same WDI file.

`data/processed/` and `output/figures/` start empty and are populated by
running the code (e.g. `CRS_Data.xlsx`, `modality_plot.png`). See
`data/codebook.md` for definitions of the constructed variables in the final
panel.

## Running the workflow

1. Open `bargaining-power-paper.Rproj` in RStudio (this makes the project
   root resolvable via the `here` package, which all file paths rely on).
2. Populate `data/raw/` as described above.
3. Run in order:
   - `code/01_build_dataset.R` — builds `data/processed/CRS_Data.xlsx`
   - `code/02_descriptive_stats.R` — independent of step 1; produces the paper's descriptive numbers/figure
   - `code/03_analysis.Rmd` — reads `data/processed/CRS_Data.xlsx`, runs the models, knit for the full output

Each script sources `code/00_packages.R` itself, so they can be run
standalone once `data/raw/` and (for step 3) `data/processed/CRS_Data.xlsx`
exist.

### Packages

All three scripts depend on `here`, `dplyr`, `ggplot2`, `tidyr`, `writexl`, `readr`,
`readxl`, `stringr`, `purrr`, `lubridate`, `psych`, `naniar`, `performance`,
`lavaan`, `semPlot`, `semTools`, `mice`, `Matrix`, `seminr`, `systemfit`,
`ggridges`, `DiagrammeR`, `DiagrammeRsvg`, `magrittr`, `xml2`, `plm`,
`multiwayvcov`, `sandwich`, `MASS`, `fixest`, `msm`, `marginaleffects`,
`patchwork`, `interactions`, `RColorBrewer`, `effects`, and `countrycode`
— see `code/00_packages.R` for the full list.

Package versions are pinned with [`renv`](https://rstudio.github.io/renv/):
after opening `bargaining-power-paper.Rproj`, run `renv::restore()` to
install the exact versions recorded in `renv.lock`.

## Questions

If anything here is unclear or a reviewer needs help reproducing a specific
table or figure, please reach out — I'm happy to walk through any part of
the pipeline.
