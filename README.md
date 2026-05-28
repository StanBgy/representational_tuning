# Representational Tuning Paper

[![DOI](https://img.shields.io/badge/DOI-coming%20soon-red)](add link when available)

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