#!/bin/bash
eval "$(pyenv init -)" &&
eval "$(pyenv virtualenv-init -)" &&
pyenv virtualenv 3.8 jupyter &&
pyenv activate jupyter &&
pip install ipykernel && 
#conda install -n notebook_env nb_conda_kernels 
python -m ipykernel install --name=py3.8 --display-name="Python 3.8"
