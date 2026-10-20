# EHUNAM dataset

**EHUNAM** is a WiFi Channel State Information (CSI) dataset for human and machine sensing:
people counting (PC), human activity recognition (HAR), machine recognition (MR) and machine activity recognition (MAR).

[![Paper](https://img.shields.io/badge/Scientific%20Data-10.1038%2Fs41597--025--06238--4-blue)](https://doi.org/10.1038/s41597-025-06238-4)
[![Data](https://img.shields.io/badge/figshare-10.6084%2Fm9.figshare.28541225-orange)](https://doi.org/10.6084/m9.figshare.28541225)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

## Overview

- **23 days** of measurements in **8 environments**, including an industrial scenario
- **21 people** and **9 machines**, which can also perform activities simultaneously
- Several device configurations (NICs, CSI extractors, bands and bandwidths)
- Validated with a CNN for PC, HAR and MAR (multiclass and multilabel): over 90% accuracy in most cases

## Download

The dataset is open access on figshare: https://doi.org/10.6084/m9.figshare.28541225

| File | Size | Content |
|---|---|---|
| `EHUNAM.zip` | ~78 GB | CSI measurements, one `.mat` file per capture |
| `Summary.xlsx` / `Summary.mat` | < 1 MB | One row per capture: application, environment, people, machines, activity, NIC, band, bandwidth, channel, number of CSI samples, date… |

## Quick start (Python)

Use `Summary.xlsx` to select the captures you need, then load the corresponding `.mat` files:

```python
import pandas as pd
from scipy.io import loadmat

summary = pd.read_excel("Summary.xlsx")
print(summary[["File", "Application", "Enviroment", "NIC", "BW", "Band", "N_CSI"]].head())

# Example: human activity recognition captures in the classroom
# Applications: PC, HAR, MAR, MR, PC+MAR and E
subset = summary[(summary["Application"] == "HAR") & (summary["Enviroment"] == "Classroom")]

mat = loadmat(f"EHUNAM/{subset.iloc[0]['File']}")
print([k for k in mat if not k.startswith("__")])  # variables stored in the capture
```

> If a file was saved in MATLAB v7.3 format, `loadmat` will fail: open it with `h5py` instead.

## Pre-processing used in the paper

1. **Remove null and pilot subcarriers**, which carry no information about the propagation channel: see [`Subcarrier.m`](Subcarrier.m).
2. **CSI phase processing**, as described in *Channel phase processing in wireless networks for human activity recognition*, Internet of Things 24 (2023). DOI: [10.1016/j.iot.2023.100960](https://doi.org/10.1016/j.iot.2023.100960)

## Citation

If you use EHUNAM, please cite:

```bibtex
@article{dearmas2025ehunam,
  title   = {EHUNAM, a WiFi CSI-based dataset for human and machine sensing},
  author  = {de Armas, Elizabet and D{\'i}az, Guillermo and Sobr{\'o}n, Iker and Eizmendi, I{\~n}aki and Landa, Iratxe and V{\'e}lez, Manuel and Mat{\'i}as, Jose Mar{\'i}a},
  journal = {Scientific Data},
  volume  = {12},
  year    = {2025},
  doi     = {10.1038/s41597-025-06238-4}
}
```

## License

The dataset is distributed under the [Creative Commons Attribution 4.0 (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) license.
