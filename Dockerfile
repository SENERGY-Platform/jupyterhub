FROM quay.io/jupyterhub/k8s-singleuser-sample:3.3.6

USER root 
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

ENV PATH="/home/jovyan/miniconda3/bin:${PATH}"
ARG PATH="/home/jovyan/miniconda3/bin:${PATH}"


RUN conda --version

RUN pip install ipykernel

RUN conda init bash \
    && exec bash \
    && conda create --name py3.8 python=3.8.16 \ 
    && conda activate py3.8 \
    && python -m ipykernel install --user --name=py3.8

USER jovyan