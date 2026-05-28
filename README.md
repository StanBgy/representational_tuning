# Representational Tuning Paper

[![DOI](https://img.shields.io/badge/DOI-coming%20soon-red)](add%20link%20when%20available)

This repository contains the code for the Representational Tuning Paper. For questions or issues, contact: s.r.bergey@tilburguniversity.edu

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation Guide](#installation-guide)
3. [Demo](#demo)
4. [Instructions for Use](#instructions-for-use)
5. [File Organization](#file-organization)
6. [Reproduction Instructions](#reproduction-instructions)
7. [License](#license)
8. [Citation](#citation)

---

## System Requirements

### Hardware Requirements

- **Standard analysis (ROI-based)**: 32GB RAM recommended
- **Full brain analysis**: 128GB RAM (tested with 128GB)
- **Storage**: ~500GB free space for NSD dataset + outputs

### Operating Systems Tested

- Ubuntu 20.04 LTS ✅
- macOS 15.2 (Sequoia) ✅
- (Windows not tested, but may work via WSL)

### Software Dependencies

All dependencies are managed via Conda. The full environment is specified in `environment.yml`. Key dependencies include:

| Package | Version |
|---------|---------|
| Python | 3.10.13 |
| numpy | 1.26.0 |
| pandas | 2.0.3 |
| nibabel | 5.1.0 |
| matplotlib | 3.8.0 |
| scikit-learn | 1.3.2 |
| scipy | 1.11.4 |
| pycocotools | 2.0.7 |
| h5py | 3.10.0 |
| threadpoolctl | 3.2.0 |
| nilearn | 0.10.2 |
| joblib | 1.3.2 |

### External Dependencies

- **NSD access library**: [https://github.com/tknapen/nsd_access](https://github.com/tknapen/nsd_access)

---

## Installation Guide

### Step 1: Install Conda

If you don't have Conda installed, download Miniconda or Anaconda from [https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)

### Step 2: Create the environment

```bash
conda env create -f environment.yml
conda activate RTM
```

### Step 3: Install the NSD access library

```bash
pip install git+https://github.com/tknapen/nsd_access.git
```

### Step 4: Set up the repository structure

```bash
chmod +x create_files.sh
./create_files.sh
```

### Step 5: Install the package locally (optional)

```bash
python setup.py install
```

### Typical install time

Less than 5 minutes on a standard desktop computer (depending on internet speed for downloading dependencies).

---

## Demo

A quick demo using Subject 1 only is built into `main.py` to verify the pipeline works before running the full analysis.

### What the demo does

- Runs the complete pipeline on Subject 1 data only
- Generates all expected outputs in the `projects/` folder

### Instructions to run demo

Simply run the main script with the demo flag:

```bash
python src/main.py --demo True
```


### Expected run time for demo

~About half a day on a standard desktop computer (16GB RAM, standard SSD, fast CPU)

> **Note:** The demo uses real NSD data. If you haven't downloaded the NSD dataset yet, the demo will fail. See [Reproduction Instructions](#reproduction-instructions) for data access.

---

## Instructions for Use

### Running the full pipeline (all subjects)

To run the complete analysis on all 8 subjects:

```bash
python src/main.py
```

This sequentially executes:

1. `load_betas.py` – Load NSD beta weights
2. `create_rdm.py` – Create RDMs and MDS representationl spaces
3. `noise_ceiling.py` – Compute noise ceiling per voxel
4. `apply_rotation.py` – Rotate MDSs for alignment
5. `fit_params_inverse.py` – Fit Gaussian tuning parameters
6. `create_models_bestroi.py` – Create visual system models

### Running individual scripts

Comment out unwanted steps in `main.py` or run scripts directly:

```bash
python src/load_betas.py
python src/create_rdm.py
# etc.
```

### Full brain analysis

To run the full brain analysis (all voxels, all participants):

```bash
python src/main_full.py
```

> **Note:** This requires 128GB RAM and substantial runtime (see [Reproduction Instructions](#reproduction-instructions) below).

### Notebooks for downstream analysis

| Notebook | Purpose |
|----------|---------|
| `export_to_corticalsurface.ipynb` | Export fitted models to cortical surface |
| `compute_correlations.ipynb` | Correlate cortical surface with MDS distances |
| `new_angle.ipynb` | Find optimal rotation angles per ROI |
| `matlab.ipynb` | Export data for MATLAB statistical tests |

### MATLAB code

The MATLAB code for ANOVA tests and cortical projections is maintained separately due to dependencies. The `matlab/` folder contains the outputs of the `matlab.ipynb` notebook, not the code itself. The code can be found at the follow repository: 

There, the important files are: 

- `drawrois.m` – Projections on cortical surface
- `meshes_and_distances.m` – Cortical surface distances, needed to compute the correlations
- `analysis.m` – ANOVA and other statistical tests, and figure creation

## R Analysis

The Bayesian isotropy test on preferred angles is implemented in `src/R/R_bayesian_newest.R`.
It computes Bayes Factors (BF) in favor of a von Mises distribution (non-uniform preferred angles)
over a uniform distribution, using a conjugate prior via the `BayesCircIsotropy` package.

### Dependencies

Install the required R packages once:

```r
install.packages(c('R.matlab', 'REdaS', 'tidyr', 'dplyr', 'readr'))

# In case BayesCircIsotropy is not on CRAN — install from GitHub:
# install.packages('remotes')
remotes::install_github("keesmulder/BayesCircIsotropy")
```

### Input

The script reads `angle_roi_unfinished.csv` from the working directory. This file is generated
by the main Python pipeline (`src/main.py`). Make sure to run that first.

### Running the script

Open `src/R/R_bayesian_newest.R` in RStudio or run from the terminal:

```bash
Rscript src/R/R_bayesian_newest.R
```

> **Note:** Run this from the `src/R/` directory, or update the `read_csv` path at the top of
> the script to point to the correct location of `angle_roi_unfinished.csv`.

### Output

Results are saved to `BF_angluar_test_preferedxy.csv` with columns:

| Column | Description |
|--------|-------------|
| `rois` | ROI name |
| `pH0`  | Posterior probability of uniform distribution |
| `pHa`  | Posterior probability of von Mises distribution |
| `BF`   | Bayes Factor in favor of von Mises (Ha) |

---

## File Organization

```
representational-tuning/
├── README.md
├── create_files.sh
├── environment.yml
├── src/
│   ├── main.py
│   ├── main_full.py
│   ├── load_betas.py
│   ├── create_rdm.py
│   ├── noise_ceiling.py
│   ├── apply_rotation.py
│   ├── fit_params_inverse.py
│   ├── create_models_bestroi.py
│   ├── distances_mds.py
│   ├── matlab/
│   ├── R/
│   │   └── R_bayesian_newest.R
│   ├── utils/
│   │   ├── utils.py
│   │   └── rf_gaussians.py
│   ├── nsddatapaper_rsa/   # Modified NSD paper code
│   └── rotations/           # MDS rotation CSVs
├── data/
│   ├── conditions/          # Train/test split CSVs
│   ├── mask/                # ROI masks
│   └── nsddata/             # NSD data for cortical projections (surface data and cortical projection outputs) 
│   └── NSD/                 # NSD dataset (external, should contains the betas (nsdadata-betas) and the conditions (ppdata, the responses.tsv files for each subject)
└── projects/
    ├── betas/
    ├── distances/
    ├── fits/
    ├── MDS/
    ├── noise_ceiling/
    ├── results/
    ├── serialised_models/
    └── spatial_responses/
```

---

## Reproduction Instructions

### Obtaining the NSD dataset

The Natural Scenes Dataset is available from the authors' AWS server:
[https://natural-scenes-dataset.s3.amazonaws.com/index.html](https://natural-scenes-dataset.s3.amazonaws.com/index.html)

We used nativesurface betas → denoised betas (`betas_fithrf_GLMdenoise_RR`). An AWS account is recommended for command-line download. Then, the `get_betas` function for the nsd library will extract the betas, done in `load_betas.py`. The data itself, and the annotations, should be placed in `data/NSD/nsddata`.

Image annotations can be downloaded via the NSD access library:

```python
from nsd_access import NSDAccess
nsd = NSDAccess('/path/to/nsddata')
nsd.download_coco_annotation_file()
```

### Expected runtime for full reproduction

| Analysis | Time | Hardware |
|----------|------|----------|
| ROI-based analysis (per participant) | ~12 hours | 32GB RAM |
| ROI-based analysis (8 participants) | ~4 days total | 32GB RAM |
| Full brain analysis (per participant) | ~1 week | 128GB RAM |

> **Note:** Full brain analysis fits ~3 million Gaussians per participant (12 fits × ~250K voxels).

### Reproducing figures from the paper

1. Run `src/main.py` to generate all fitted models
2. Run `export_to_corticalsurface.ipynb` to export to cortical surface
3. Run MATLAB `analysis.m` for statistical tests and figure generation. Some extra information were added to the figures in Adobe Illustrator based on the outputs of the statistical test.

---

## License

This software is released under the MIT License.

Copyright (c) 2025 Stan Bergey

---

## Citation

If you use this code in your research, please cite:

> Coming Soon [DOI coming soon]
