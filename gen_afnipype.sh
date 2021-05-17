#!/bin/sh

set -e

generate_docker() {
  docker run --rm repronim/neurodocker:0.7.0 generate docker \
    --base=debian:stretch --pkg-manager=apt \
    --neurodebian \
          os_codename='stretch' \
          server='usa-ca' \
          full=True \
    --install vim python connectome-workbench \
    --user=root \
    --afni version=latest method=binaries \
    --user=neuro \
    --miniconda \
          conda_install='python=3.9 matplotlib numpy pandas scikit-learn nilearn scipy seaborn traits' \
          pip_install='nibabel nipype' \
          create_env="neuro_py39" \
          activate=true
}

generate_singularity() {
  docker run --rm repronim/neurodocker:0.7.0 generate singularity \
    --base=debian:stretch --pkg-manager=apt \
    --neurodebian \
          os_codename='stretch' \
          server='usa-ca' \
          full=True \
    --install vim python connectome-workbench \
    --user=root \
    --afni version=latest method=binaries \
    --user=neuro \
    --miniconda \
          conda_install='python=3.9 matplotlib numpy pandas scikit-learn nilearn scipy seaborn traits' \
          pip_install='nibabel nipype' \
          create_env="neuro_py39" \
          activate=true
}

generate_singularity > Singularity
generate_docker > Dockerfile
