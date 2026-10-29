#!/usr/bin/env bash
set -euo pipefail

# Directory where this script lives (resolves symlinks, works from any cwd)
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj01/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj01/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj02/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj02/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj03/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj03/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj04/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj04/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj05/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj05/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj06/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj06/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj07/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj07/nativesurface/betas_fithrf_GLMdenoise_RR"
aws s3 sync --no-sign-request s3://natural-scenes-dataset/nsddata_betas/ppdata/subj08/nativesurface/betas_fithrf_GLMdenoise_RR "$SCRIPT_DIR/data/NSD/nsddata_betas/ppdata/subj08/nativesurface/betas_fithrf_GLMdenoise_RR"

