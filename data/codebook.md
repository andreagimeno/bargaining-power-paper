# Codebook — analysis panel

Documents the key variables in the recipient-donor-year panel as it exists at
the point the SUR model is estimated in `code/03_analysis.Rmd` (built on top
of `data/processed/CRS_Data.xlsx`, which itself is the output of
`code/01_build_dataset.R`). Raw pass-through columns from CRS/WDI/etc. (e.g.
`DonorName`, `SectorName`) keep their source names and aren't repeated here —
this covers the *constructed* variables, where the definition isn't obvious
from the column name alone.

## Identifiers

| Variable | Meaning |
|---|---|
| `DonorName`, `RecipientName`, `Year` | CRS donor, recipient, and calendar year |
| `Year_int`, `Year_f` | `Year` as integer / as a factor (year fixed effects) |
| `dyad_id` | `"<DonorName> <RecipientName>"` — the donor-recipient dyad, the clustering unit |

## Outcome variables (the three negotiation outcomes)

| Variable | Meaning |
|---|---|
| `flow_log` | `log1p(USD_Disbursement)`, floored at 0 — aid size |
| `ChannelBalance` | Design/delivery-channel command (bounded share; see "Zero-handling" note in `code/01_build_dataset.R`) |
| `trade_concession` / `preference_margin` | Policy concession; `preference_margin = -eff_tariff` (the donor's effective tariff preference extended to the recipient) |

## Bargaining power construct (`alpha`)

Built in `code/03_analysis.Rmd`, section "Equal weighting (formative) construct
building." `alpha` is a formative, equal-weighted composite of four
oriented, re-standardised dimensions (higher = higher **recipient** power):

| Variable | Dimension | Built from (oriented so + = more recipient power) |
|---|---|---|
| `s_urgency_core` | Recipient economic urgency/crisis | `total_reserves_lag` (+), `gdp_growth_lag` (+), `external_debt_lag` (−, debt = distress) |
| `s_urgency_ext` | Urgency, robustness variant | as above, plus `eci_lag` (+) and `Cost_Trade_inv_lag` (+) |
| `s_geo` | Geopolitical stake (donor interest → worse donor outside option) | `log_Foreign` (+), `agree` (UN voting agreement, +), `proximity` (+), `col_history` (+) |
| `s_comm` | Commercial asymmetric dependence | `total_asym_lag` (+), `VA_share_lag` (+) |
| `s_inst` | Institutional capacity (reflective WGI block) | `cc`, `ge`, `pv`, `rq` (WGI control of corruption / govt effectiveness / political stability / regulatory quality) |
| `alpha_core` | **Primary bargaining-power index** | equal-weight mean of `s_urgency_core`, `s_geo`, `s_comm`, `s_inst` |
| `alpha_ext` | Robustness variant | equal-weight mean using `s_urgency_ext` instead of `s_urgency_core` |
| `n_dims_core` / `n_dims_ext` | Coverage | count of the 4 dimensions non-missing for that row (estimation sample requires `== 4`) |
| `alpha_z` | Standardised `alpha_core`, as entered in the SUR/bootstrap regressions | |

Each `dim_*` (pre-restandardisation) and `z_*` (individual oriented z-scores,
e.g. `z_reserves`, `z_growth`, `z_debt`, `z_foreign`, `z_agree`, `z_prox`,
`z_col`, `z_asym`, `z_vashare`, `z_cc`, `z_ge`, `z_pv`, `z_rq`) are
intermediate steps kept in the panel for transparency/diagnostics.

## Threat points (outside options)

| Variable | Meaning |
|---|---|
| `log_Other_AfT_lag` → `dR_z` | Recipient's threat point: lagged log AfT received from *other* donors (standardised) |
| `donor_threat_dyad_lag` → `dD_z` | Donor's threat point: lagged "replaceability" of the recipient to this donor (standardised) |

## Notes

- All `*_lag` variables are one-period lags within `(DonorName, RecipientName)`, computed after `arrange(..., Year_int)`.
- `total_reserves_lag` and `external_debt_lag` are winsorised at the 99th percentile (`winsor_top()` in `code/03_analysis.Rmd`) before entering `alpha`.
- The estimation sample for the SUR model (`est` in `code/03_analysis.Rmd`) additionally requires `n_dims_core == 4` and non-missing outcomes/threat points — see the "SUR specification" chunk for the exact filter.
