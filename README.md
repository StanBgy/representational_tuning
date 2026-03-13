# Representational Tuning Paper


This is the repository for the code of the Representational Tuning Paper, available here [add link when available]


Full scripts to install the dependencies and setup of the file systems will be provided soon. 



## Dependencies and installation.

There are many dependencies for running this project, all being listed under the `environment.yml` file. I strongly suggest using Conda and set up an environment based on that file: all the dependencies are managed, including the more obscure NSD-related libraries. 

Otherwise, the main dependencies are: 
```
numpy==1.26.0
pandas==2.0.3
nibabel==5.1.0
matplotlib==3.8.0
scikit-learn==1.3.2
scipy==1.11.4
pycocotools==2.0.7
h5py==3.10.0
threadpoolctl==3.2.0  # for full brain analysis
```

You also need nsd_access: https://github.com/tknapen/nsd_access

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

The main folder contains the environment script, as well as `create_files.sh` , which can be used to create the files system by running 

```
chmod +x create_files.sh
./create_files.sh
```

Then, the code is stored into `src`, with utils storing utility files, including the config `config.py` and the gaussian functions `rf_gaussians`. The `matlab` folder contains output needs for the matlab anaylsis (see the matlab repo), the `R` folder the code and output of the Von Moses analysis. the `nsddatapaper_rsa` folder contains a (slightly) modified version of the nsd paper's code to access the data, to fix some errors. The `rotation` folder contains the optimal rotations for the MDS within-subject aligment. 

The `data` folder stores the data, with the `conditions` folder being for the csv that stores each conditions seen by each participants, necessary to make our train/test split. The mask folder store the ROI masks made to separate our visual field maps, and then the nsddata folder stores the data extracted from the NDS dataset. The project folder stores our results, organized by each steps. These data and projects folder are available at [TODO]



## Usage

The pipeline goes as follows: 

`load_betas.py` loads the data, `create_rdm.py` creates both the RDM and the MDS, `noise_ceilling.py` calculate the noise ceilling of each voxel, `apply_rotation.py` rotates the MDSs, `fit_params_inverse.py` does the gaussian fitting, and `create_models_bestroi.py` creates the visual system models. 
Finally, `export_to_corticalsurface.ipynb` exports the data from the visual system models to neuroimaging data, that can be used in matlab to make the projections (used for the main figures) I also added the `distances_mds.py` function here to compute the distances after fitting. 

The `main.py` script runs everything in one go, and is the suggested manner to replicate our results. Nevertheless, it is possible to run these script separately. For that, either comment out the ones you don't want in the `main.py` file or call the function in script individually. 

### Full brain

A note on the full brain analysis: 
Due to the size of the data, we did not store in the output on FigShare. If you have the NSD data installed and everything runs, you can replicate the full brain outputs, by running the scripts that have the `fullbrain` mention, or just `main_full.py`. However, the amount of data that is loaded during these steps is huge. I tried my best to chunk the data and use smart memory allocation, but doing these steps require enourmous amounts of RAM, the computer used for this project had 128GB (a small fortune in the current economy). Note that the time to run this part of the experiment is also extremely lengths, since all voxels are fitted twelves times. This means around 3 millions Gaussians need to be fitted for each participants. 

## Notebooks 

The repository contains many notebooks that we used to run some analysis, sometimes before doing the voxel fitting (e.g.: the `flips.ipynb` was used to find which MDS to rotate to). The most important notebooks are `export_to_corticalsurface.ipynb`, as mentioned above, and `compute_correlations.ipynb`, which deals with the correlation between cortical surface and MDS distances. This require the distances on the cortical surface (`meshes_and_distances.m`) and on the MDS (`distances_mds.py`) to be computed. The `matlab.ipynb` exports the data from fitted models to csv, to then be used in matlab for our statistical analyses. The `new_angle.ipynb` is used to find the new optimal rotation angle for each ROI for their `x0` and `y0` fitted positions. 
### matlab

The matlab code can be found in the matlab repository. I decided to separate them due to the large amount of dependencies required to run the matlab code. The `matlab` folder in this repo contains the data used then in th matlab analysis script, to run our ANOVA tests and create the graphs used in the manuscript. It is mainly used to make the projections on the cortical surface ( `drawrois.m`), calculating the distances between voxels on the cortical surface (`meshes_and_distances.m`) and do the ANOVA tests (` analysis.m`)

 

## Getting the data

The Data can be directly obtained from the author's AWS server: https://natural-scenes-dataset.s3.amazonaws.com/index.html. We used the 'nativesurface' betas, and within that the denoised betas (betas_fithrf_GLMdenoise_RR). I would suggest setting up an aws account to directly download all the necessary data from the command line. For all subject, the dataset is quite large so I would suggest saving a lot of space for it. 

To obtain the annotation of the images, there is a function in the `nsda.py` script of the nsd_access libraries, which can download the annotaitons automaticaly. (download_coco_annotation_file). This script contains many helper function which can be useful for further analysis. We also add these under the `condition`folder in `data` 

