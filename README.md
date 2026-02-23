# Representational Tuning Paper


This is the repository for the code of the Representational Tuning Paper, available here [add link when available]


Full scripts to install the dependencies and setup of the file systems will be provided soon. 



## Dependencies and installation.

There are many dependencies for running this project, all being listed under the `environment.yml` file. I strongly suggest using Conda and set up an environment based on that file: all the dependencies are managed, including the more obscure NSD-related libraries. 
Once done, run (in your environment).


Then, run """python setup.py install""" to setup the repository and ensure all files can communicate with each other (might not be necessary). 


## File Organization. 

The code is organized as follows: 

```

representational-tuning
│   README.md
│   create_files.sh
│   environment.yml
│   
└───src
│   │   main.py
│   │   load_betas.py
│   │   ...
│   └───matlab
│   └───nsdatapaper_rsa
│   └───R
│       │   R_baytesian_newest.R
│       │   ... 
│   └───utils
│       │   utils.py
│       │   rf_gaussians.py
│       │   ....
│   └───rotations
│       │   subj01_rotations_df.csv
│       │   subj02_rotations_df.csv
│       │   ....
└───data
│   └───conditions
│   └───mask
│   └───nsdata
│   └───nsdata
│        └───freesurfer
└───projects
│   └───betas
│   └───distances
│   └───fits
│   └───MDS
│   └───noise_ceilling
│   └───results
│   └───serialised_models
│   └───spatial responses
```

The main folder contains the environment script, as well as `create_files.sh` , which can be used to create the the files system by running 

```
chmod +x create_files.sh
./create_files.sh
```

Then, the code is stored into `src`, with utils storing utiliary files, including the config `config.py` and the gaussian functions `rf_gaussians`. The data folder stores the data, with the conditions folder being for the csv that stores each conditions seen by each paricipants, necessary to make our train/test split. The mask folder store the ROI masks made to separate our visual field maps, and then the nsddata folder stores the data extracted from the NDS dataset. The project folder stores our results, organized by each steps. These data and projects folder are availabe at [TODO]


## Usage

The pipeline goes as follows: 

`load_betas.py` loads the data, `create_rdm.py` creates both the RDM and the MDS, `apply_rotation.py` rotates the MDSs, `fit_params_inverse.py` does the gaussian fitting, and `create_models_bestroi.py` creates the visual system models. 
Finally, `export_to_corticalsurface.ipynb` exports the data from the visual system models to neuroimaging data, that can be used in matlab to make the project. I also added the `distances_mds.py` function here to compute the distances after fitting. 

Finally, the `main.py` script runs everything in one go. 

## Notebooks 

The repository contains many notebooks that we used to run some anaylsis, sometimes before doing the voxel fitting (e.g.: the `flips.ipynb` was used to find which MDS to rotate to. It is not needed for running the rest anaylsis, but 
anyone is free to check what we did or used it on new data). The most important notebooks are `export_to_corticalsurface.ipynb`, as mentieened above, and `compute_correlations.ipynb`, which deals with the correlation between cortical surface
and MDS distances. This require the distances on the cortical surface (`meshes_and_distances.m`) and on the MDS (`distances_mds.py`) to be computed. 

### matlab

The matlab code can be found in the matlab repository. I decided to separate them due to the large amount of dependencies required to run the matlab code. The `matlab` folder in this repo contains the data used then in th
matlab analysis script, to run our ANOVA tests and create the graphs used in the manuscript. It is mainly used to make the projections on the cortical surface ( `drawrois.m`), calculating the distances between voxels on the cortical surface (`meshes_and_distances.m`) and do the ANOVA tests (` analysis.m`)

Some dependencies are needed to run this code, and will be added very soon 

I go to the store yesterday 

## Getting the data

The Data can be directly obtained from the author's AWS server: https://natural-scenes-dataset.s3.amazonaws.com/index.html. We used the 'nativesurface' betas, and within that the denoised betas (betas_fithrf_GLMdenoise_RR). I would suggest
setting up an aws account to directly download all the necessary data from the command line. For all subject, the dataset is quite large so I would suggest saving a lot of space for it. 

To obtain the annotation of the images, there is a function in the `nsda.py` script of the nsd_access libraries, which can download the annotaitons automaticaly. (download_coco_annotation_file). This script contains many helper function which can be useful for further analysis. 

Lastly, due to Github size limitation, this repo do not contains the mask or all the result of our computation. If anyone is interested in looking at them or using the ROI masks we used, feel free to reach out
