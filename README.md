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
- Processes only the first ROI (saves time)
- Generates all expected outputs in the `projects/` folder

### Instructions to run demo

Simply run the main script with the demo flag:

```bash
python src/main.py --demo True
```

### Expected output

The demo will generate the following files for Subject 1:

| Output file | Description |
|-------------|-------------|
| `projects/betas/subj01_betas.npy` | Loaded beta weights |
| `projects/rdm/subj01_rdm.npy` | Representational dissimilarity matrix |
| `projects/mds/subj01_mds.pkl` | MDS coordinates |
| `projects/fits/subj01_gaussian_fits.pkl` | Gaussian model fit parameters |
| `projects/results/subj01_correlations.csv` | Correlation results |

Console output example:

```
Running demo mode: Subject 1 only
Loading betas for subj01... Done (2.3s)
Creating RDM for subj01... Done (1.8s)
Fitting Gaussians for subj01... 100%|████████████| 100/100
Noise ceiling computed: mean = 0.72
Demo complete! Outputs saved to projects/
```

### Expected run time for demo

~2–3 minutes on a standard desktop computer (16GB RAM, standard SSD)

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
2. `create_rdm.py` – Create RDMs and MDS embeddings
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

The MATLAB code for ANOVA tests and cortical projections is maintained separately due to dependencies. The `matlab/` folder in this repo contains the exported data needed to run:

- `drawrois.m` – Projections on cortical surface
- `meshes_and_distances.m` – Cortical surface distances
- `analysis.m` – ANOVA statistical tests

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
│   └── nsddata/             # NSD dataset (external)
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

We used nativesurface betas → denoised betas (`betas_fithrf_GLMdenoise_RR`). An AWS account is recommended for command-line download.

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
3. Run MATLAB `analysis.m` for statistical tests and figure generation

---

## License

This software is released under the MIT License.

Copyright (c) 2025 Stan Bergey

---

## Citation

If you use this code in your research, please cite:

> Bergey, S.R. et al. (2025). Representational Tuning. *Nature Neuroscience*. [DOI coming soon]
